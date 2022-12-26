import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrscolors/bldrscolors.dart';
import 'package:flutter/material.dart';

class CensusLineUnit extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const CensusLineUnit({
    @required this.width,
    @required this.number,
    @required this.icon,
    @required this.isActive,
    this.height = 30,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final double height;
  final double width;
  final int number;
  final String icon;
  final bool isActive;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DreamBox(
      isDeactivated: !isActive,
      height: height,
      width: width,
      icon: icon,
      color: Colorz.white10,
      iconSizeFactor: 0.6,
      verseWeight: VerseWeight.thin,
      bubble: false,
      verse: Verse.plain(Numeric.formatNumToCounterCaliber(context, number)),
    );

  }
// -----------------------------------------------------------------------------
}
