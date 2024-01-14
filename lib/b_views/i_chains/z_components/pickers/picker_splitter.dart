import 'package:basics/helpers/maps/mapper.dart';
import 'package:bldrs/a_models/c_chain/c_picker_model.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/b_views/i_chains/z_components/specs/picker_group/b_pickers_group_headline.dart';
import 'package:bldrs/b_views/i_chains/z_components/specs/picker_group/cc_spec_picker_tile.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class PickerSplitter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PickerSplitter({
    required this.picker,
    required this.onPickerTap,
    required this.allSelectedSpecs,
    required this.onDeleteSpec,
    required this.onSelectedSpecTap,
    this.searchText,
    this.width,
    super.key
  });
  /// --------------------------------------------------------------------------
  final PickerModel? picker;
  final List<SpecModel> allSelectedSpecs;
  final Function onPickerTap;
  final Function({required SpecModel? value, required SpecModel? unit})? onSelectedSpecTap;
  final Function({required SpecModel? value, required SpecModel? unit})? onDeleteSpec;
  final ValueNotifier<String?>? searchText;
  final double? width;
/// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// HEADLINE
    if (Mapper.boolIsTrue(picker?.isHeadline) == true){

      return PickersGroupHeadline(
        width: width,
        headline: Verse(
          id: picker?.chainID,
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
        width: width,
        onTap: onPickerTap,
        picker: picker,
        pickerSelectedSpecs: _pickerSelectedSpecs,
        onDeleteSpec: onDeleteSpec,
        onSpecTap: onSelectedSpecTap,
        searchText: searchText,
      );

    }

  }
  /// --------------------------------------------------------------------------
}
