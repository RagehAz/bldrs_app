import 'package:bldrs/super_fire/super_fire.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/review_model.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/buttons/review_bubble_button.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/review_bubble/a_review_box.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/review_bubble/bb_reply_bubble.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/review_bubble/review_bubble_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_timers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:scale/scale.dart';
import 'package:stringer/stringer.dart';

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
    @required this.onReplyBzBalloonTap,
    @required this.isSpecial,
    Key key
  }) : super(key: key);
  // --------------------------------------------------------------------------
  final double pageWidth;
  final ReviewModel reviewModel;
  final FlyerModel flyerModel;
  final bool isAgreed;
  final Function onReviewOptionsTap;
  final Function onBzReplyOverReview;
  final Function onReviewAgreeTap;
  final Function onReplyOptionsTap;
  final ValueChanged<UserModel> onReviewUserBalloonTap;
  final ValueChanged<BzModel> onReplyBzBalloonTap;
  final bool isSpecial;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final bool _imReviewCreator = reviewModel?.userID == OfficialAuthing.getUserID();
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
              isSpecialReview: isSpecial,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  /// USER NAME
                  BldrsText(
                    verse: Verse(
                      id: userModel?.name,
                      translate: false,
                    ),
                  ),

                  /// TIME
                    BldrsText(
                      verse: Verse(
                        id: BldrsTimers.calculateSuperTimeDifferenceString(
                          context: context,
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
                    BldrsText(
                      verse: Verse.plain(reviewModel.text),
                      maxLines: 100,
                      centered: false,
                      weight: isSpecial ? VerseWeight.bold : VerseWeight.thin,
                      scaleFactor: 1.1,
                      italic: isSpecial,
                      color: isSpecial ? Colorz.yellow255 : Colorz.white255,
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
                onReplyBzBalloonTap: onReplyBzBalloonTap,
                isSpecialReview: isSpecial,
              ),

          ],
        );

      },
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
