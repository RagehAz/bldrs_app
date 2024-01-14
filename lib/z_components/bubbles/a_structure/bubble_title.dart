import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class BubbleTitle extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BubbleTitle({
    required this.titleVerse,
    this.centered = false,
    this.redDot = false,
    this.titleColor = Colorz.white255,
    this.titleScaleFactor = 1,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Verse titleVerse;
  final bool redDot;
  final bool centered;
  final Color titleColor;
  final double titleScaleFactor;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.only(
          bottom: Ratioz.appBarMargin,
          left: Ratioz.appBarPadding,
          right: Ratioz.appBarPadding
      ),
      child: BldrsText(
        verse: titleVerse,
        redDot: redDot,
        centered: centered,
        color: titleColor,
        italic: true,
        scaleFactor: titleScaleFactor,
      ),
    );

  }
/// --------------------------------------------------------------------------
}
