import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class SlideHeadline extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlideHeadline({
    @required this.flyerBoxWidth,
    @required this.verse,
    this.tappingVerse,
    this.verseColor = Colorz.white255,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final String verse;
  final Function tappingVerse;
  final Color verseColor;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // print('slide title verse is : $verse');

    final double _headlineTopMargin = flyerBoxWidth * 0.3;

    /// FLYER TITLE
    return GestureDetector(
      onTap: tappingVerse,
      child: Container(
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
          size: 4,
          scaleFactor: flyerBoxWidth * 0.005,
          maxLines: 3,
        ),
      ),
    );

  }
}
