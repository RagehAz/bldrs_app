import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class BubbleTitle extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BubbleTitle({
    @required this.titleVerse,
    this.centered = false,
    this.redDot = false,
    this.titleColor = Colorz.white255,
    this.titleScaleFactor = 1,
    Key key
  }) : super(key: key);
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
      child: SuperVerse(
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
