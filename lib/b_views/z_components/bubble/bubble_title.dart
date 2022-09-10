import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class BubbleTitle extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BubbleTitle({
    @required this.title,
    this.centered = false,
    this.redDot = false,
    this.titleColor = Colorz.white255,
    this.titleScaleFactor = 1,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String title;
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
        verse: title,
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
