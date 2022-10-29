import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/review_model.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/buttons/review_bubble_button.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/structure/a_review_box.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/structure/review_bubble_box.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/variants/bb_reply_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/auth_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class ReviewViewBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ReviewViewBubble({
    @required this.pageWidth,
    @required this.onReviewUserBalloonTap,
    @required this.reviewModel,
    @required this.flyerModel,
    @required this.isAgreed,
    @required this.onReviewOptionsTap,
    @required this.onBzReplyOverReview,
    @required this.onReviewAgreeTap,
    @required this.onReplyOptionsTap,
    Key key
  }) : super(key: key);
  // --------------------------------------------------------------------------
  final double pageWidth;
  final ValueChanged<UserModel> onReviewUserBalloonTap;
  final ReviewModel reviewModel;
  final FlyerModel flyerModel;
  final bool isAgreed;
  final Function onReviewOptionsTap;
  final Function onBzReplyOverReview;
  final Function onReviewAgreeTap;
  final Function onReplyOptionsTap;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final bool _imReviewCreator = reviewModel?.userID == AuthFireOps.superUserID();
    // --------------------
    final bool _imAuthorInFlyerBz = AuthorModel.checkImAuthorInBzOfThisFlyer(
      context: context,
      flyerModel: flyerModel,
    );
    // --------------------
    final double _textBubbleWidth = ReviewBox.getTextBubbleWidth(
      pageWidth: pageWidth,
    );
    // --------------------
    final double _clearWidth = ReviewBubbleBox.clearWidth(
      balloonWidth: _textBubbleWidth,
    );
    // --------------------
    final bool _isSpecialReview = reviewModel.text == 'Super cool';
    // --------------------
    return ReviewBox(
      pageWidth: pageWidth,
      userID: reviewModel.userID,
      onReviewUserBalloonTap: onReviewUserBalloonTap,
      builder: (UserModel userModel){

        return Column(
          children: <Widget>[

            /// REVIEW TEXT
            ReviewBubbleBox(
              width: _textBubbleWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  /// USER NAME
                  SuperVerse(
                    verse: Verse(
                      text: userModel?.name,
                      translate: false,
                    ),
                  ),

                  /// TIME
                    SuperVerse(
                      verse: Verse(
                        text: Timers.calculateSuperTimeDifferenceString(
                          from: reviewModel.time,
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
                    SuperVerse(
                      verse: Verse.plain(reviewModel.text),
                      maxLines: 100,
                      centered: false,
                      weight: _isSpecialReview ? VerseWeight.bold : VerseWeight.thin,
                      scaleFactor: 1.1,
                      italic: _isSpecialReview,
                      color: _isSpecialReview ? Colorz.yellow255 : Colorz.white255,
                    ),

                  /// SEPARATOR LINE
                  SeparatorLine(
                      width: _clearWidth,
                      color: Colorz.white50,
                      withMargins: true,
                    ),

                  /// (MORE - REPLY - AGREE ) BUTTONS
                    SizedBox(
                      width: _clearWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[

                          /// MORE BUTTON
                          if (_imReviewCreator == true)
                            ReviewBubbleButton(
                              count: null,
                              isOn: false,
                              phid: null,
                              icon: Iconz.more,
                              onTap: onReviewOptionsTap,
                            ),

                          /// EXPANDER
                          if (_imReviewCreator == true)
                            const Expander(),

                          /// REPLY
                          if (_imAuthorInFlyerBz == true)
                            ReviewBubbleButton(
                              icon: Iconz.balloonSpeaking,
                              phid: 'phid_reply',
                              count: null,
                              isOn: false,
                              onTap: onBzReplyOverReview,
                            ),

                          /// SPACER
                          if (_imAuthorInFlyerBz == true)
                            const SizedBox(width: ReviewBox.spacer,),

                          /// AGREED
                          ReviewBubbleButton(
                            icon: Iconz.sexyStar,
                            count: reviewModel.agrees,
                            isOn: isAgreed,
                            phid: isAgreed == true ? 'phid_agreed' : 'phid_agree',
                            onTap: onReviewAgreeTap,
                          ),

                        ],
                      ),
                    ),

                ],
              ),
            ),

            /// SPACER
            const SizedBox(
              width: ReviewBox.spacer,
              height: ReviewBox.spacer * 0.25,
            ),

            /// BZ REPLY BUBBLE
            if (TextCheck.isEmpty(reviewModel?.reply) == false)
              BzReplyBubble(
                boxWidth: _textBubbleWidth,
                reviewModel: reviewModel,
                flyerModel: flyerModel,
                onReplyOptionsTap: onReplyOptionsTap,
              ),

          ],
        );

      },
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
