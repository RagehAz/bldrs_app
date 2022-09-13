import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:flutter/material.dart';

class AuthorCardDetail extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AuthorCardDetail({
    @required this.icon,
    @required this.verse,
    @required this.boxWidth,
    @required this.bubble,
    this.iconColor,
    this.onTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String icon;
  final Verse verse;
  final double boxWidth;
  final Color iconColor;
  final Function onTap;
  final bool bubble;
  /// --------------------------------------------------------------------------
  static const double height = 30;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DreamBox(
      onTap: onTap,
      height: bubble == true ? height * 1.5 : height,
      margins: EdgeInsets.symmetric(vertical: bubble == true ? 2.5 : 0),
      width: boxWidth,
      icon: icon,
      iconSizeFactor: bubble == true ? 0.5 : 0.7,
      verseScaleFactor: bubble == true ? 1.3 : 1,
      iconColor: iconColor,
      verse: verse,
      bubble: bubble,
      verseWeight: VerseWeight.thin,
      verseShadow: false,
      verseCentered: false,
    );

  }
  // -----------------------------------------------------------------------------
}
