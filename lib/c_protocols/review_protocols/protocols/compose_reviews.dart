import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/review_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/real/flyer_record_real_ops.dart';
import 'package:bldrs/c_protocols/note_protocols/note_events/z_note_events.dart';
import 'package:bldrs/c_protocols/review_protocols/fire/review_fire_ops.dart';
import 'package:bldrs/c_protocols/review_protocols/protocols/renovate_reviews.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:flutter/material.dart';

class ComposeReviewProtocols {
  // -----------------------------------------------------------------------------

  const ComposeReviewProtocols();

  // -----------------------------------------------------------------------------

  /// REVIEW

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ReviewModel> composeReview({
    @required BuildContext context,
    @required ReviewModel reviewModel,
    @required String bzID,
  }) async {

    /// 1. create sub doc (fire/flyers/flyerID/reviews/reviewID)
    /// 2. increment flyer counter field (real/countingFlyers/flyerID/reviews)
    /// 3. increment bzz counter field (real/countingBzz/bzID/allReviews)

    ReviewModel _uploadedReview;

    await Future.wait(<Future>[

      ReviewFireOps.createReview(
        reviewModel: reviewModel,
      ).then((ReviewModel reviewModel){
        _uploadedReview = reviewModel;
      }),

      FlyerRecordRealOps.reviewCreation(
        reviewModel: reviewModel,
        bzID: bzID,
      ),

      NoteEvent.sendFlyerReceivedNewReviewByMe(
        context: context,
        text: reviewModel.text,
        flyerID: reviewModel.flyerID,
        bzID: bzID,
      ),

    ]);


    return _uploadedReview;
  }
  // -----------------------------------------------------------------------------

  /// REPLY

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> composeReviewReply({
    @required BuildContext context,
    @required String bzID,
    @required ReviewModel updatedReview,
  }) async {

    final UserModel _myUserModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    final bool _imAuthorOfThisBz = AuthorModel.checkUserIsAuthorInThisBz(
      bzID: bzID,
      userModel: _myUserModel,
    );

    if (_imAuthorOfThisBz == true){

      final BzModel _bzModel = await BzProtocols.fetch(
        context: context,
        bzID: bzID,
      );

      await Future.wait(<Future>[

        RenovateReviewProtocols.renovateReview(
          reviewModel: updatedReview,
        ),

        NoteEvent.sendFlyerReviewReceivedBzReply(
          context: context,
          reply: updatedReview.reply,
          bzModel: _bzModel,
          reviewCreatorID: updatedReview.userID,
        ),

      ]);

    }

  }
  // -----------------------------------------------------------------------------
}
