import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class SlideHeadline extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlideHeadline({
    @required this.flyerBoxWidth,
    @required this.verse,
    this.verseColor = Colorz.white255,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final Verse verse;
  final Color verseColor;
  /// --------------------------------------------------------------------------
  static const headlineScaleFactor = 0.004;
  static const headlineSize = 4;
  // --------------------
  @override
  Widget build(BuildContext context) {

    final double _headlineTopMargin = flyerBoxWidth * 0.3;

    /// FLYER TITLE
    return Container(
      width: flyerBoxWidth,
      height: flyerBoxWidth,
      // color: Colorz.BloodTest,
      margin: EdgeInsets.only(top: _headlineTopMargin),
      alignment: Alignment.topCenter,
      padding: EdgeInsets.symmetric(horizontal: flyerBoxWidth * 0.05),
      child: SuperVerse(
        verse: verse,
        color: verseColor,
        shadow: true,
        size: headlineSize,
        scaleFactor: flyerBoxWidth * headlineScaleFactor,
        maxLines: 3,
      ),
    );

  }
// -----------------------------------------------------------------------------
}
