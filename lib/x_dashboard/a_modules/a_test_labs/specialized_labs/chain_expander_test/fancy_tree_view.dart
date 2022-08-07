import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/b_views/x_screens/g_bz/e_flyer_maker/d_spec_picker_screen.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/specs/pickers_group.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class KeywordSelectionScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const KeywordSelectionScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
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

    final Chain _keywordsChain = ChainsProvider.proGetKeywordsChain(
        context: context,
        getRefinedCityChain: false,
        listen: true,
    );

    final List<SpecPicker> _specsPickers = SpecPicker.getMajorKeywords();
    final List<String> _theGroupsIDs = SpecPicker.getGroupsFromSpecsPickers(
      specsPickers: _specsPickers,
    );

    return MainLayout(
      hasKeyboard: false,
      skyType: SkyType.black,
      appBarType: AppBarType.search,
      sectionButtonIsOn: false,
      pageTitle: 'Select Keyword',
      zoneButtonIsOn: false,
      pyramidsAreOn: true,
      pyramidType: PyramidType.crystalYellow,
      onSearchChanged: (String value) => blog('typing : $value'),
      onSearchSubmit: (String value) => blog('searching : $value'),
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
      ListView.builder(
          itemCount: _theGroupsIDs.length,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(
            top: Stratosphere.bigAppBarStratosphere,
            bottom: Ratioz.horizon,
          ),
          itemBuilder: (BuildContext ctx, int index) {

            final String _groupID = _theGroupsIDs[index];

            final List<SpecPicker> _pickersOfThisGroup = SpecPicker.getSpecsPickersByGroupID(
              specsPickers: _specsPickers,
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
      ),
    );

  }

}
