import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:flutter/material.dart';

class StatsLine extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const StatsLine({
    required this.icon,
    required this.verse,
    this.bigIcon = false,
    this.onTap,
    this.width,
    this.color,
    this.maxWidth,
    super.key
  });
  /// --------------------------------------------------------------------------
  final String? icon;
  final bool bigIcon;
  final Verse verse;
  final Function? onTap;
  final double? width;
  final Color? color;
  final double? maxWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // const String _spaces = '   ';
    final double _height = onTap == null ? 30 : 50;

    return Container(
      width: width,
      alignment: BldrsAligners.superCenterAlignment(context),
      child: BldrsBox(
        height: _height,
        width: width,
        maxWidth: maxWidth,
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
