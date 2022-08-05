import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class ReviewBubbleButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ReviewBubbleButton({
    @required this.verse,
    @required this.icon,
    @required this.onTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String verse;
  final String icon;
  final Function onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return DreamBox(
      height: 30,
      icon: icon,
      verse: verse,
      verseWeight: VerseWeight.thin,
      iconSizeFactor: 0.6,
      bubble: false,
      color: Colorz.white20,
      onTap: onTap,
    );
  }
}
