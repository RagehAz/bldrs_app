import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class StatsLine extends StatelessWidget {
  final String icon;
  final double iconSizeFactor;
  final double verseScaleFactor;
  final String verse;
  final Function onTap;
  final double bubbleWidth;

  const StatsLine({
    @required this.icon,
    @required this.verse,
    this.iconSizeFactor = 0.7,
    this.verseScaleFactor = 0.85,
    this.onTap,
    this.bubbleWidth,
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    const String _spaces = '   ';
    final double _height = onTap == null ? 25 : 40;

    return Container(
      width: bubbleWidth,
      alignment: Aligners.superCenterAlignment(context),
      child: DreamBox(
        height: _height,
        icon: icon,
        verse: '$_spaces$verse',
        verseWeight: VerseWeight.thin,
        verseItalic: true,
        iconSizeFactor: iconSizeFactor,
        verseScaleFactor: verseScaleFactor,
        corners: _height * 0.15,
        bubble: false,
        color: onTap == null ? null : Colorz.white20,
        onTap: onTap,
      ),
    );

  }
}
