import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class ReviewTextsColumn extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ReviewTextsColumn({
    @required this.isCreatorMode,
    @required this.name,
    @required this.timeStamp,
    @required this.text,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool isCreatorMode;
  final String name;
  final DateTime timeStamp;
  final String text;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _isSpecialReview = text == 'Super cool';

    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        /// USER NAME
        SuperVerse(
          verse: Verse(
            text: name,
            translate: false,
          ),
        ),

        /// TIME
        if (isCreatorMode == false)
          SuperVerse(
            verse: Verse(
              text: Timers.calculateSuperTimeDifferenceString(
                from: timeStamp,
                to: DateTime.now(),
              ),
              translate: false,
            ),
            weight: VerseWeight.thin,
            italic: true,
            color: Colorz.white200,
            scaleFactor: 0.9,
          ),

        /// TEXT
        if (isCreatorMode == false)
          SuperVerse(
            verse: Verse(
              text: text,
              translate: false,
            ),
            maxLines: 100,
            centered: false,
            weight: _isSpecialReview ? VerseWeight.bold : VerseWeight.thin,
            scaleFactor: 1.1,
            italic: _isSpecialReview,
            color: _isSpecialReview ? Colorz.yellow255 : Colorz.white255,
          ),

      ],
    );
  }
  /// --------------------------------------------------------------------------
}
