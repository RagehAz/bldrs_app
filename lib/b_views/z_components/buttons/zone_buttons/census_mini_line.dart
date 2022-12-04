import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:flutter/material.dart';

class CensusMiniLine extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const CensusMiniLine({
    @required this.width,
    @required this.number,
    @required this.icon,
    this.height = 30,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final double height;
  final double width;
  final int number;
  final String icon;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DreamBox(
      height: height,
      width: width,
      icon: icon,
      iconSizeFactor: 0.6,
      verseCentered: false,
      verseWeight: VerseWeight.thin,
      bubble: false,
      verse: Verse.plain(Numeric.formatNumToCounterCaliber(context, number)),
    );

  }
// -----------------------------------------------------------------------------
}
