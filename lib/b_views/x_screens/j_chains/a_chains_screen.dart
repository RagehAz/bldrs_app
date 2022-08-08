import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/b_views/x_screens/j_chains/aa_chains_screen_search_view.dart';
import 'package:bldrs/b_views/x_screens/j_chains/ab_chains_screen_browse_view.dart';
import 'package:bldrs/b_views/x_screens/j_chains/controllers/a_chains_screen_controllers.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:flutter/material.dart';

/// TASK : SHOULD MERGE THIS WITH SPECS SELECTION SCREEN
class ChainsScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ChainsScreen({
    @required this.specsPickers,
    @required this.onlyUseCityChains,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<SpecPicker> specsPickers;
  final bool onlyUseCityChains;
  /// --------------------------------------------------------------------------
  @override
  State<ChainsScreen> createState() => _ChainsScreenState();
  /// --------------------------------------------------------------------------
}

class _ChainsScreenState extends State<ChainsScreen> {
// -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false);
  final ValueNotifier<List<Chain>> _foundChains = ValueNotifier<List<Chain>>(<Chain>[]);
  // final List<Chain> _chains = <Chain>[];
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
    super.dispose();
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
      ),
      onSearchSubmit: (String text) => onChainsSearchSubmitted(
        text: text,
        isSearching: _isSearching,
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

            return ChainsScreenSearchView(
              screenHeight: _screenHeight,
              foundChains: _foundChains,
              selectedPhids: _selectedPhids,
            );

          }

          else {

            return ChainsScreenBrowseView(
              specsPickers: widget.specsPickers,
            );

          }

        },
      ),
    );

  }
}
