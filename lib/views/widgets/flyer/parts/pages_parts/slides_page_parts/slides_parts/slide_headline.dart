import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class SlideHeadline extends StatelessWidget {
  final double flyerBoxWidth;
  final String verse;
  final dynamic verseColor;
  final int verseSize;
  final Function tappingVerse;

  SlideHeadline({
    @required this.flyerBoxWidth,
    @required this.verse,
    @required this.verseSize,
    @required this.verseColor,
    @required this.tappingVerse,
  });

  @override
  Widget build(BuildContext context) {

    // print('slide title verse is : $verse');

    double _headlineTopMargin = flyerBoxWidth * 0.3;

    // --- FLYER TITLE
    return GestureDetector(
      onTap: tappingVerse,
      child: Container(
          width: flyerBoxWidth,
          height: flyerBoxWidth*0.4,
          // color: Colorz.BloodTest,
          margin: EdgeInsets.only(top: _headlineTopMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SuperVerse(
                verse: verse,
                color: verseColor,
                italic: false,
                shadow: true,
                weight: VerseWeight.bold,
                size: verseSize,
                centered: true,
                designMode: false,
                maxLines: 3,
              ),
            ],
          ),
        ),
    );
  }
}
