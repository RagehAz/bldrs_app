import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class TileButton extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const TileButton({
    this.height,
    this.width,
    this.color = Colorz.white10,
    this.onTap,
    this.icon,
    this.verse,
    this.secondLine,
    this.iconSizeFactor = 1,
    this.margins,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final Verse verse;
  final Verse secondLine;
  final double height;
  final double width;
  final Color color;
  final Function onTap;
  final String icon;
  final double iconSizeFactor;
  final dynamic margins;
  // -----------------------------------------------------------------------------
  static const double defaultHeight = 40;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DreamBox(
      width: width,
      height: height ?? defaultHeight,
      icon: icon,
      verse: verse,
      verseCentered: false,
      secondLine: secondLine,
      secondLineScaleFactor: 1.2,
      verseScaleFactor: 0.7,
      secondVerseMaxLines: 1,
      bubble: false,
      color: color,
      onTap: onTap,
      margins: Scale.superMargins(
          margins: margins ?? const EdgeInsets.symmetric(vertical: 5),
      ),
      iconSizeFactor: iconSizeFactor,
    );

  }
  // -----------------------------------------------------------------------------
}
