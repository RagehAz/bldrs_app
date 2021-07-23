import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class SlideTitle extends StatelessWidget {
  final double flyerZoneWidth;
  final String verse;
  final dynamic verseColor;
  final int verseSize;
  final Function tappingVerse;

  SlideTitle({
    @required this.flyerZoneWidth,
    @required this.verse,
    @required this.verseSize,
    @required this.verseColor,
    @required this.tappingVerse,
  });

  @override
  Widget build(BuildContext context) {

    print('slide title verse is : $verse');

    double _titleTopMargin = flyerZoneWidth * 0.3;

    // --- FLYER TITLE
    return GestureDetector(
      onTap: tappingVerse,
      child: Container(
          width: flyerZoneWidth,
          height: flyerZoneWidth*0.4,
          // color: Colorz.BloodTest,
          margin: EdgeInsets.only(top: _titleTopMargin),
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
