import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DialogButton({
    required this.verse,
    this.verseColor = Colorz.white255,
    this.width = 100,
    this.color,
    this.onTap,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Verse? verse;
  final Color verseColor;
  final double? width;
  final Color? color;
  final Function? onTap;
  static const double height = 50;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return BldrsBox(
      height: height,
      width: width ?? 100,
      margins: const EdgeInsets.all(Ratioz.appBarPadding),
      verse: verse,
      verseWeight: VerseWeight.black,
      verseItalic: true,
      verseMaxLines: 2,
      verseColor: verseColor,
      color: color,
      verseScaleFactor: 0.6,
      onTap: onTap,
    );
  }
  /// --------------------------------------------------------------------------
}
