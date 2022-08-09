import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/specs/pickers_group.dart';
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
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<SpecPicker> specsPickers;
  final ValueChanged<SpecPicker> onPickerTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// WHEN PICKERS ARE PROVIDED
    if (Mapper.checkCanLoopList(specsPickers) == true){

      final List<String> _theGroupsIDs = SpecPicker.getGroupsFromSpecsPickers(
        specsPickers: specsPickers,
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
              specsPickers: specsPickers,
              groupID: _groupID,
            );

            return SpecsPickersGroup(
              title: _groupID.toUpperCase(),
              allSelectedSpecs: ValueNotifier(null),
              groupPickers: _pickersOfThisGroup,
              onPickerTap: onPickerTap,
              onDeleteSpec: (List<SpecModel> specs){
                SpecModel.blogSpecs(specs);
              },
            );

          }
      );
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
