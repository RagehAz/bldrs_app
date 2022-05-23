import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/sizing/super_positioned.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class EditorConfirmButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const EditorConfirmButton({
    @required this.onTap,
    @required this.firstLine,
    this.secondLine,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onTap;
  final String firstLine;
  final String secondLine;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SuperPositioned(
      key: const ValueKey<String>('EditorConfirmButton'),
      enAlignment: Alignment.bottomLeft,
      child: DreamBox(
        height: 50,
        color: Colorz.yellow255,
        verseColor: Colorz.black230,
        verseWeight: VerseWeight.black,
        verseItalic: true,
        verse: firstLine,
        secondLine: secondLine,
        secondLineColor: Colorz.black255,
        verseScaleFactor: 0.7,
        margins: const EdgeInsets.all(10),
        onTap: onTap,
      ),
    );

  }
}
