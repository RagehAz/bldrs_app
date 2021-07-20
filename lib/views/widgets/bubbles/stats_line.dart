import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class StatsLine extends StatelessWidget {
  final String icon;
  final double iconSizeFactor;
  final double verseScaleFactor;
  final String verse;
  final Function onTap;

  StatsLine({
    @required this.icon,
    this.iconSizeFactor = 0.7,
    this.verseScaleFactor = 0.85,
    @required this.verse,
    this.onTap,
});


  @override
  Widget build(BuildContext context) {

    const String _spaces = '   ';
    double _height = onTap == null ? 25 : 40;

    return DreamBox(
      height: _height,
      icon: icon,
      verse: '$_spaces$verse',
      verseWeight: VerseWeight.thin,
      verseItalic: true,
      iconSizeFactor: iconSizeFactor,
      verseScaleFactor: verseScaleFactor,
      corners: _height * 0.15,
      bubble: false,
      color: onTap == null ? null : Colorz.White20,
      onTap: onTap,
    );

  }
}
