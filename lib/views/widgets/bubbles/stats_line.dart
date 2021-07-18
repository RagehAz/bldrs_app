import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class StatsLine extends StatelessWidget {
  final String icon;
  final String verse;
  final Function onTap;

  StatsLine({
    @required this.icon,
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
      iconSizeFactor: 0.7,
      verseScaleFactor: 0.85,
      corners: _height * 0.15,
      bubble: false,
      color: onTap == null ? null : Colorz.White20,
      onTap: onTap,
    );
    ;
  }
}
