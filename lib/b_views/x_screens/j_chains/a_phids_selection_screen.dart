import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/b_views/x_screens/g_bz/e_flyer_maker/d_spec_picker_screen.dart';
import 'package:bldrs/b_views/x_screens/j_chains/controllers/a_phid_selection_screen_controllers.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/chains_drawer/parts/chain_expander/d_chain_son_starter.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/page_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/specs/pickers_group.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

/// TASK : SHOULD MERGE THIS WITH SPECS SELECTION SCREEN
class PhidsSelectionScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const PhidsSelectionScreen({
    @required this.specsPickers,
    @required this.onlyUseCityChains,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<SpecPicker> specsPickers;
  final bool onlyUseCityChains;
  /// --------------------------------------------------------------------------
  @override
  State<PhidsSelectionScreen> createState() => _PhidsSelectionScreenState();
  /// --------------------------------------------------------------------------
}

class _PhidsSelectionScreenState extends State<PhidsSelectionScreen> {
// -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false);
  final ValueNotifier<List<Chain>> _foundChains = ValueNotifier<List<Chain>>(<Chain>[]);
  // final List<Chain> _chains = <Chain>[];
  final List<String> _selectedPhids = <String>[];
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
  Future<void> goToKeywordsScreen({
    @required BuildContext context,
    @required SpecPicker specPicker,
  }) async {

    final String _phid = await Nav.goToNewScreen(
      context: context,
      transitionType: Nav.superHorizontalTransition(context),
      screen: SpecPickerScreen(
        specPicker: specPicker,
        showInstructions: false,
        inSelectionMode: false,
      ),
    );

    blog('selected this phid : $_phid');

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
      searchController: TextEditingController(),
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
            return ValueListenableBuilder(
                valueListenable: _foundChains,
                builder: (_, List<Chain> chains, Widget child){

                  Chain.blogChains(chains);

                  return PageBubble(
                      screenHeightWithoutSafeArea: _screenHeight,
                      appBarType: AppBarType.search,
                      child: ChainSonStarter(
                        son: chains,
                        sonWidth: BldrsAppBar.width(context),
                        onPhidTap: (String phid) => onSelectPhid(
                          phid: phid,
                        ),
                        selectedPhids: _selectedPhids,
                        initiallyExpanded: true,
                      ),
                  );

                }
            );
          }

          else {

            final List<String> _theGroupsIDs = SpecPicker.getGroupsFromSpecsPickers(
              specsPickers: widget.specsPickers,
            );

            return ListView.builder(
                itemCount: _theGroupsIDs.length,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(
                  top: Stratosphere.bigAppBarStratosphere,
                  bottom: Ratioz.horizon,
                ),
                itemBuilder: (BuildContext ctx, int index) {

                  final String _groupID = _theGroupsIDs[index];

                  final List<SpecPicker> _pickersOfThisGroup = SpecPicker.getSpecsPickersByGroupID(
                    specsPickers: widget.specsPickers,
                    groupID: _groupID,
                  );

                  return SpecsPickersGroup(
                    title: _groupID.toUpperCase(),
                    allSelectedSpecs: ValueNotifier(null),
                    groupPickers: _pickersOfThisGroup,
                    onPickerTap: (SpecPicker picker) => goToKeywordsScreen(
                      context: context,
                      specPicker: picker,
                    ),
                    onDeleteSpec: (List<SpecModel> specs){
                      SpecModel.blogSpecs(specs);
                    },
                  );

                }
            );
          }

        },
      ),
    );

  }
}
