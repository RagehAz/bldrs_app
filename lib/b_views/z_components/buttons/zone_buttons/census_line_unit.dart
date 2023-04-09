import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
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

    return BldrsBox(
      isDisabled: !isActive,
      height: height,
      width: width,
      icon: icon,
      color: Colorz.white10,
      iconSizeFactor: 0.6,
      verseScaleFactor: 0.9/0.6,
      verseWeight: VerseWeight.thin,
      bubble: false,
      verse: Verse.plain(counterCaliber(context, number)),
    );

  }
// -----------------------------------------------------------------------------
}
