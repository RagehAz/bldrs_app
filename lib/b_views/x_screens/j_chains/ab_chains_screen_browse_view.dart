import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/specs/pickers_group.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ChainsScreenBrowseView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainsScreenBrowseView({
    @required this.specsPickers,
    @required this.onPickerTap,
    @required this.onDeleteSpec,
    @required this.selectedSpecs,
    @required this.refinedSpecsPickers,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<SpecPicker> specsPickers;
  final ValueChanged<SpecPicker> onPickerTap;
  final ValueChanged<List<SpecModel>> onDeleteSpec;
  final ValueNotifier<List<SpecModel>> selectedSpecs;
  final ValueNotifier<List<SpecPicker>> refinedSpecsPickers;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// WHEN PICKERS ARE PROVIDED
    if (Mapper.checkCanLoopList(specsPickers) == true){

      return ValueListenableBuilder(
          valueListenable: refinedSpecsPickers,
          builder: (_, List<SpecPicker> refinedPickers, Widget childB){

            final List<String> _theGroupsIDs = SpecPicker.getGroupsFromSpecsPickers(
              specsPickers: refinedPickers,
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
                    specsPickers: refinedPickers,
                    groupID: _groupID,
                  );

                  return SpecsPickersGroup(
                    title: _groupID.toUpperCase(),
                    selectedSpecs: selectedSpecs,
                    groupPickers: _pickersOfThisGroup,
                    onPickerTap: onPickerTap,
                    onDeleteSpec: onDeleteSpec,
                  );

                }
            );

          }
      );
      /*
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
              specsPickers: specsPickers,
              groupID: _groupID,
            );

            return SpecsPickersGroup(
              title: _groupID.toUpperCase(),
              selectedSpecs: selectedSpecs,
              groupPickers: _pickersOfThisGroup,
              onPickerTap: onPickerTap,
              onDeleteSpec: onDeleteSpec,
            );

          }
      );
       */
    }

    /// WHEN NO PICKERS THERE
    else {

      return Center(
        child: Container(
          width: Scale.superScreenWidth(context),
          height: Scale.superScreenHeight(context),
          padding: Scale.superMargins(margins: 20),
          child: const SuperVerse(
            verse: 'No Available Flyers in This City yet',
            weight: VerseWeight.black,
            italic: true,
            size: 3,
            maxLines: 3,
            margin: Ratioz.appBarMargin,
          ),
        ),
      );

  }

  }
}
