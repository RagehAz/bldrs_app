import 'package:bldrs/a_models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/pages_parts/info_page_parts/review_user_label.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart' as TextChecker;
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ReviewCreator extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ReviewCreator({
    @required this.width,
    @required this.corners,
    @required this.userModel,
    @required this.superFlyer,
    @required this.reloadReviews,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final double width;
  final double corners;
  final UserModel userModel;
  final SuperFlyer superFlyer;
  final Function reloadReviews;

  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final bool _reviewControllerHasValue =
        TextChecker.textControllerIsEmpty(superFlyer.rec.reviewController) ==
            false;

    return GestureDetector(
      onTap: superFlyer.rec.onEditReview,
      child: Container(
        width: width,
        margin: const EdgeInsets.only(bottom: Ratioz.appBarMargin),
        decoration: BoxDecoration(
          color: Colorz.white10,
          borderRadius: Borderers.superBorderAll(context, corners),
          border: Border.all(width: 0.5, color: Colorz.white80),
        ),
        child: Column(
          children: <Widget>[
            /// USER LABEL
            ReviewUserLabel(
              tinyUser: userModel,
              hasEditButton: false,
              onReviewOptions: null,
            ),

            /// REVIEW BODY
            Container(
              width: width,
              padding: const EdgeInsets.all(Ratioz.appBarMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /// REVIEW TEXT
                  if (_reviewControllerHasValue == false)
                    const SuperVerse(
                      verse: 'Add your review on this flyer ...',
                      size: 1,
                      centered: false,
                      maxLines: 3,
                      color: Colorz.white200,
                      italic: true,
                      labelColor: Colorz.white10,
                      weight: VerseWeight.regular,
                    ),

                  /// REVIEW TIME
                  if (_reviewControllerHasValue == true)
                    SuperVerse(
                      verse: Timers.stringOnDateMonthYear(
                          context: context, time: DateTime.now()),
                      size: 1,
                      color: Colorz.white125,
                      centered: false,
                      weight: VerseWeight.thin,
                      italic: true,
                    ),

                  /// REVIEW TEXT
                  if (_reviewControllerHasValue == true)
                    SuperVerse(
                      verse: superFlyer.rec.reviewController.text.trim(),
                      centered: false,
                      maxLines: 2,
                      color: Colorz.yellow255,
                      italic: true,
                    ),

                  /// ADD REVIEW BUTTON
                  if (_reviewControllerHasValue == true)
                    Container(
                      width: width,
                      height: 40,
                      margin: const EdgeInsets.only(top: Ratioz.appBarPadding),
                      alignment: Aligners.superInverseCenterAlignment(context),
                      child: DreamBox(
                        height: 40,
                        verse: 'Add Review',
                        verseScaleFactor: 0.6,
                        color: Colorz.yellow255,
                        verseColor: Colorz.black255,
                        verseShadow: false,
                        onTap: () {
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
