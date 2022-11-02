import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class StatsLine extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const StatsLine({
    @required this.icon,
    @required this.verse,
    this.iconSizeFactor = 0.7,
    this.verseScaleFactor = 0.85,
    this.onTap,
    this.bubbleWidth,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String icon;
  final double iconSizeFactor;
  final double verseScaleFactor;
  final Verse verse;
  final Function onTap;
  final double bubbleWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // const String _spaces = '   ';
    final double _height = onTap == null ? 25 : 40;

    return Container(
      width: bubbleWidth,
      alignment: Aligners.superCenterAlignment(context),
      child: DreamBox(
        height: _height,
        width: bubbleWidth,
        icon: icon,
        verse: verse,
        verseWeight: VerseWeight.thin,
        verseItalic: true,
        iconSizeFactor: iconSizeFactor,
        verseScaleFactor: verseScaleFactor,
        corners: _height * 0.15,
        bubble: false,
        color: onTap == null ? null : Colorz.white20,
        verseMaxLines: 1,
        verseCentered: false,
        onTap: onTap,
      ),

    );

  }
  /// --------------------------------------------------------------------------
}
