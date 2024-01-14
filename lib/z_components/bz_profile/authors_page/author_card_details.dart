import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class AuthorCardDetail extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AuthorCardDetail({
    required this.icon,
    required this.verse,
    required this.boxWidth,
    required this.bubble,
    this.iconColor,
    this.onTap,
    super.key
  });
  /// --------------------------------------------------------------------------
  final String icon;
  final Verse verse;
  final double boxWidth;
  final Color? iconColor;
  final Function? onTap;
  final bool bubble;
  /// --------------------------------------------------------------------------
  static const double height = 30;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return BldrsBox(
      onTap: onTap,
      height: bubble == true ? height * 1.5 : height,
      margins: EdgeInsets.symmetric(vertical: bubble == true ? 2.5 : 0),
      width: boxWidth,
      icon: icon,
      iconSizeFactor: bubble == true ? 0.5 : 0.7,
      verseScaleFactor: bubble == true ? 0.9/0.5 : 0.9/0.7,
      iconColor: iconColor,
      verse: verse,
      bubble: bubble,
      verseWeight: VerseWeight.thin,
      // verseShadow: false,
      verseCentered: false,
    );

  }
  // -----------------------------------------------------------------------------
}
