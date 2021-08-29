import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/text_checkers.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/models/user/tiny_user.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/info_page_parts/review_user_label.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ReviewCreator extends StatelessWidget {
  final double width;
  final double corners;
  final TinyUser tinyUser;
  final SuperFlyer superFlyer;
  final Function reloadReviews;

  const ReviewCreator({
    @required this.width,
    @required this.corners,
    @required this.tinyUser,
    @required this.superFlyer,
    @required this.reloadReviews,
  });

  @override
  Widget build(BuildContext context) {

    bool _reviewControllerHasValue = TextChecker.textControllerHasNoValue(superFlyer.rec.reviewController) == false;

    return GestureDetector(
      onTap: superFlyer.rec.onEditReview,
      child: Container(
        width: width,
        margin: EdgeInsets.only(bottom: Ratioz.appBarMargin),
        decoration: BoxDecoration(
          color: Colorz.White10,
          borderRadius: Borderers.superBorderAll(context, corners),
          border: Border.all(width: 0.5, color: Colorz.White80),
        ),
        child: Column(

          children: <Widget>[

            /// USER LABEL
            ReviewUserLabel(
              tinyUser: tinyUser,
              hasEditButton: false,
              onReviewOptions: null,
            ),

            /// REVIEW BODY
            Container(
              width: width,
              padding: EdgeInsets.all(Ratioz.appBarMargin),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  /// REVIEW TEXT
                  if (_reviewControllerHasValue == false)
                  SuperVerse(
                    verse: 'Add your review on this flyer ...',
                    size: 1,
                    centered: false,
                    maxLines: 3,
                    color: Colorz.White200,
                    italic: true,
                    labelColor: Colorz.White10,
                    weight: VerseWeight.regular,
                  ),

                  /// REVIEW TIME
                  if (_reviewControllerHasValue == true)
                  SuperVerse(
                    verse: Timers.stringOnDateMonthYear(context: context, time: DateTime.now()),
                    size: 1,
                    color: Colorz.White125,
                    centered: false,
                    weight: VerseWeight.thin,
                    italic: true,
                  ),

                  /// REVIEW TEXT
                  if (_reviewControllerHasValue == true)
                  SuperVerse(
                    verse: superFlyer.rec.reviewController.text.trim(),
                    size: 2,
                    centered: false,
                    maxLines: 2,
                    color: Colorz.Yellow255,
                    italic: true,
                  ),

                  /// ADD REVIEW BUTTON
                  if (_reviewControllerHasValue == true)
                  Container(
                    width: width,
                    height: 40,
                    margin: EdgeInsets.only(top: Ratioz.appBarPadding),
                    alignment: Aligners.superInverseCenterAlignment(context),
                    child: DreamBox(
                      height: 40,
                      verse: 'Add Review',
                      verseScaleFactor: 0.6,
                      color: Colorz.Yellow255,
                      verseColor: Colorz.Black255,
                      verseShadow: false,
                      verseWeight: VerseWeight.bold,
                      onTap: (){

                        superFlyer.rec.onSubmitReview();

                        reloadReviews();

                      },
                    ),
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}