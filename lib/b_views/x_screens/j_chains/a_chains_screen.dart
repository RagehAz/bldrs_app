import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/b_views/x_screens/g_bz/e_flyer_maker/d_spec_picker_screen.dart';
import 'package:bldrs/b_views/x_screens/j_chains/aaX_chain_view_searching.dart';
import 'package:bldrs/b_views/x_screens/j_chains/aa_chains_screen_search_view.dart';
import 'package:bldrs/b_views/x_screens/j_chains/ab_chains_screen_browse_view.dart';
import 'package:bldrs/b_views/x_screens/j_chains/controllers/b_chains_search_controller.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';

/// TASK : SHOULD MERGE THIS WITH SPECS SELECTION SCREEN
class ChainsScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ChainsScreen({
    @required this.specsPickers,
    @required this.onlyUseCityChains,
    @required this.isMultipleSelectionMode,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<SpecPicker> specsPickers;
  final bool onlyUseCityChains;
  final bool isMultipleSelectionMode;
  /// --------------------------------------------------------------------------
  @override
  State<ChainsScreen> createState() => _ChainsScreenState();
  /// --------------------------------------------------------------------------
}

class _ChainsScreenState extends State<ChainsScreen> {
// -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false); /// tamam disposed
  // final List<Chain> _chains = <Chain>[];
  final ValueNotifier<List<Chain>> _foundChains = ValueNotifier<List<Chain>>(<Chain>[]); /// tamam disposed
  final ValueNotifier<List<String>> _foundPhids = ValueNotifier(<String>[]); /// tamam disposed
  final List<String> _selectedPhids = <String>[];
  final TextEditingController _searchTextController = TextEditingController();
// -----------------------------------------------------------------------------
  @override
  void initState() {

    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _isSearching.dispose();
    _foundChains.dispose();
    _foundPhids.dispose();
    _searchTextController.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  Future<void> _onPickerTap(SpecPicker picker) async {

    final dynamic _result = await Nav.goToNewScreen(
      context: context,
      transitionType: Nav.superHorizontalTransition(context),
      screen: SpecPickerScreen(
        specPicker: picker,
        onlyUseCityChains: true,//widget.onlyUseCityChains,
        showInstructions: widget.isMultipleSelectionMode,
        isMultipleSelectionMode:  widget.isMultipleSelectionMode,
      ),
    );

    if (_result != null){

      /// WHILE SELECTING MULTIPLE PHIDS
      if (widget.isMultipleSelectionMode == true){

        final List<String> _phids = _result;

      }

      /// WHILE SELECTING ONLY ONE PHID
      else {
        Nav.goBack(context, passedData: _result);
      }

    }

  }
// -----------------------------------------------------------------------------
  Future<void> _onSelectPhid(String phid) async {

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// JUST TO CHECK IF CHAINS ARE LOADED OR NOT YET
    final Chain _keywordsChain = ChainsProvider.proGetKeywordsChain(
        context: context,
        getRefinedCityChain: widget.onlyUseCityChains,
        listen: true,
    );

    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);

    return MainLayout(
      hasKeyboard: false,
      skyType: SkyType.black,
      appBarType: AppBarType.search,
      sectionButtonIsOn: false,
      pageTitle: 'Select Keyword',
      zoneButtonIsOn: false,
      pyramidsAreOn: true,
      pyramidType: PyramidType.crystalYellow,
      onSearchChanged: (String text) => onChainsSearchChanged(
        text: text,
        isSearching: _isSearching,
        chains: <Chain>[_keywordsChain],
        foundChains: _foundChains,
        foundPhids: ValueNotifier([]),
      ),
      onSearchSubmit: (String text) => onChainsSearchSubmitted(
        text: text,
        isSearching: _isSearching,
        foundChains: _foundChains,
        chains: <Chain>[_keywordsChain],
      ),
      searchController: _searchTextController,
      searchHint: 'Search keywords',
      layoutWidget: _keywordsChain == null ?

      /// WHILE LOADING CHAIN
      const Center(
        child: WidgetFader(
          fadeType: FadeType.repeatAndReverse,
          child: SuperVerse(
            verse: 'Loading\n Please Wait',
            weight: VerseWeight.black,
            maxLines: 2,
          ),
        ),
      )
          :
      /// AFTER CHAIN IS LOADED
      ValueListenableBuilder<bool>(
        valueListenable: _isSearching,
        child: Container(),
        builder: (_, bool isSearching, Widget child){

          if (isSearching == true){

            /// OLD METHOD - NEED CHECK
            return ChainViewSearching(
              foundChains: _foundChains,
              foundPhids: _foundPhids,
            );

            /// NEW METHOD - NEED CHECK
            return ChainsScreenSearchView(
              screenHeight: _screenHeight,
              foundChains: _foundChains,
              selectedPhids: _selectedPhids,
              isMultipleSelectionMode: widget.isMultipleSelectionMode,
              onSelectPhid: _onSelectPhid,
            );

          }

          else {

            final List<SpecPicker> _specPickers = SpecPicker.createPickersForChainK(
              context: context,
              chainK: _keywordsChain,
            );

            // return ChainViewBrowsing(bubbleWidth: Scale.superScreenWidth(context));

            return ChainsScreenBrowseView(
              specsPickers: _specPickers,
              onPickerTap: _onPickerTap,
            );

          }

        },
      ),
    );

  }
}
