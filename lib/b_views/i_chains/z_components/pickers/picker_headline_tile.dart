import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:bldrs/a_models/c_chain/c_picker_model.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class PickerHeadlineTile extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PickerHeadlineTile({
    required this.picker,
    this.onTap,
    this.secondLine,
    super.key
  });
  
  final PickerModel picker;
  final Verse? secondLine;
  final Function? onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {


    return Align(
      key: ValueKey<String>('${picker.chainID}'),
      alignment: Alignment.centerLeft,
      child: BldrsBox(
        height: 40,
        verse: Verse(
          id: picker.chainID,
          translate: true,
          casing: Casing.upperCase,
        ),
        secondLine: secondLine,
        margins: 10,
        verseScaleFactor: 0.65,
        verseItalic: true,
        bubble: false,
        color: Colorz.yellow125,
        verseCentered: false,
        onTap: onTap,
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
