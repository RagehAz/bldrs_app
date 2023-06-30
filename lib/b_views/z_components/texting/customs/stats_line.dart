import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:flutter/material.dart';

class StatsLine extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const StatsLine({
    required this.icon,
    required this.verse,
    this.bigIcon = false,
    this.onTap,
    this.bubbleWidth,
    this.color,
    super.key
  });
  /// --------------------------------------------------------------------------
  final String icon;
  final bool bigIcon;
  final Verse verse;
  final Function onTap;
  final double bubbleWidth;
  final Color color;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // const String _spaces = '   ';
    final double _height = onTap == null ? 30 : 50;

    return Container(
      width: bubbleWidth,
      alignment: BldrsAligners.superCenterAlignment(context),
      child: BldrsBox(
        height: _height,
        width: bubbleWidth,
        icon: icon,
        verse: verse,
        verseWeight: VerseWeight.thin,
        verseItalic: true,
        iconSizeFactor: bigIcon == true ? 1 : 0.8,
        verseScaleFactor: bigIcon == true ? 1 : 1 / 0.8,
        corners: _height * 0.15,
        bubble: false,
        color: onTap == null ? color : Colorz.white20,
        verseCentered: false,
        onTap: onTap,
        margins: const EdgeInsets.only(bottom: 2),
      ),

    );

  }
  /// --------------------------------------------------------------------------
}
