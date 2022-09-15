import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class PickerHeadlineTile extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PickerHeadlineTile({
    @required this.picker,
    this.onTap,
    this.secondLine,
    Key key
  }) : super(key: key);

  final PickerModel picker;
  final Verse secondLine;
  final Function onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Align(
      key: ValueKey<String>(picker.chainID),
      alignment: Alignment.centerLeft,
      child: DreamBox(
        height: 40,
        verse: Verse(
          text: picker.chainID,
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
