import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:flutter/material.dart';

class AuthorCardDetail extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AuthorCardDetail({
    @required this.icon,
    @required this.verse,
    @required this.boxWidth,
    this.iconColor,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String icon;
  final String verse;
  final double boxWidth;
  final Color iconColor;
  /// --------------------------------------------------------------------------
  static const double height = 30;
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DreamBox(
      height: height,
      width: boxWidth,
      icon: icon,
      iconColor: iconColor,
      verse: verse,
      iconSizeFactor: 0.7,
      bubble: false,
      verseWeight: VerseWeight.thin,
      verseShadow: false,
      verseCentered: false,
    );

  }
}
