import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:flutter/material.dart';

class SlideHeadline extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlideHeadline({
    @required this.flyerBoxWidth,
    @required this.verse,
    @required this.verseSize,
    @required this.verseColor,
    @required this.tappingVerse,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final String verse;
  final dynamic verseColor;
  final int verseSize;
  final Function tappingVerse;
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
        child: SuperVerse(
          verse: verse,
          color: verseColor,
          shadow: true,
          size: verseSize,
          maxLines: 3,
        ),
      ),
    );

  }
}
