import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/b_views/i_chains/z_components/specs/picker_group/b_pickers_group_headline.dart';
import 'package:bldrs/b_views/i_chains/z_components/specs/picker_group/cc_spec_picker_tile.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class PickerSplitter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PickerSplitter({
    @required this.picker,
    @required this.onTap,
    @required this.allSelectedSpecs,
    @required this.onDeleteSpec,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final PickerModel picker;
  final Function onTap;
  final List<SpecModel> allSelectedSpecs;
  final ValueChanged<List<SpecModel>> onDeleteSpec;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// HEADLINE
    if (picker.isHeadline == true){

      return PickersGroupHeadline(
        headline: Verse(
          text: picker.chainID,
          translate: true,
          casing: Casing.upperCase,
        ),
      );

      /// TASK TEST THIS
      // return PickerHeadlineTile(
      //   picker: picker,
      //   // secondLine: ,
      //   // onTap: ,
      // );

    }

    /// PICKER TILE
    else {

      final List<SpecModel> _pickerSelectedSpecs = SpecModel.getSpecsBelongingToThisPicker(
        specs: allSelectedSpecs,
        picker: picker,
      );

      return PickerTile(
        onTap: onTap,
        picker: picker,
        pickerSelectedSpecs: _pickerSelectedSpecs,
        onDeleteSpec: onDeleteSpec,
      );

    }

  }
  /// --------------------------------------------------------------------------
}
