import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/review_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/z_note_events.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/auth_fire_ops.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_colls.dart';
import 'package:bldrs/e_back_end/x_ops/real_ops/bz_record_real_ops.dart';
import 'package:bldrs/e_back_end/x_ops/real_ops/flyer_record_real_ops.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/review_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';

class ReviewProtocols {
  // -----------------------------------------------------------------------------

  const ReviewProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ReviewModel> composeReview({
    @required BuildContext context,
    @required String text,
    @required String flyerID,
    @required String bzID,
  }) async {

    /// 1. create sub doc (fire/flyers/flyerID/reviews/reviewID)
    /// 2. increment flyer counter field (real/countingFlyers/flyerID/reviews)
    /// 3. increment bzz counter field (real/countingBzz/bzID/allReviews)

    ReviewModel _uploadedReview;

    await Future.wait(<Future>[

      ReviewFireOps.createReview(
        text: text,
        flyerID: flyerID,
      ).then((ReviewModel uploadedReview){
        _uploadedReview = uploadedReview;
    }),

      FlyerRecordRealOps.reviewCreation(
        review: text,
        flyerID: flyerID,
        bzID: bzID,
      ),

      NoteEvent.sendFlyerReceivedNewReviewByMe(
        context: context,
        text: text,
        flyerID: flyerID,
        bzID: bzID,
      ),

    ]);


    return _uploadedReview;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ReviewModel> composeReviewReply({
    @required BuildContext context,
    @required String reply,
    @required String bzID,
    @required ReviewModel reviewModel,
  }) async {

    ReviewModel _updated = reviewModel.copyWith();

    final UserModel _myUserModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    final bool _imAuthorOfThisBz = AuthorModel.checkUserIsAuthorInThisBz(
      bzID: bzID,
      userModel: _myUserModel,
    );

    if (_imAuthorOfThisBz == true){

      _updated = reviewModel.copyWith(
        reply: reply,
        replyAuthorID: AuthFireOps.superUserID(),
        replyTime: DateTime.now(),
      );

      final BzModel _bzModel = await BzProtocols.fetch(
        context: context,
        bzID: bzID,
      );

      await Future.wait(<Future>[

        ReviewProtocols.renovateReview(
          reviewModel: _updated,
        ),

        NoteEvent.sendFlyerReviewReceivedBzReply(
          context: context,
          reply: reply,
          bzModel: _bzModel,
          reviewCreatorID: reviewModel.userID,
        ),

      ]);

    }

    return _updated;
  }
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> renovateReview({
    @required ReviewModel reviewModel,
  }) async {

    if (reviewModel != null){

      await ReviewFireOps.updateReview(
        reviewModel: reviewModel,
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// REVIEW AGREE

  // --------------------
  ///
  static Future<ReviewModel> agreeOnReview({
    @required ReviewModel reviewModel,
    @required bool isAlreadyAgreed,
  }) async {

    final ReviewModel _updated = ReviewModel.incrementAgrees(
      reviewModel: reviewModel,
      isIncrementing: !isAlreadyAgreed,
    );

    await ReviewProtocols.renovateReview(
      reviewModel: _updated,
    );

    /// remove user ID from (review agrees list)
    if (isAlreadyAgreed == true){
      await Real.deleteField(
        collName: RealColl.agreesOnReviews,
        docName: reviewModel.id,
        fieldName: AuthFireOps.superUserID(),
      );
    }
    /// add user id to (review agrees list)
    else {
      await Real.updateDocField(
        collName: RealColl.agreesOnReviews,
        docName: reviewModel.id,
        fieldName: AuthFireOps.superUserID(),
        value: true,
      );
    }

    return _updated;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> fetchIsAgreed({
    @required String reviewID,
  }) async {

    bool _output = false;

    final dynamic _result = await Real.readPath(
      path: '${RealColl.agreesOnReviews}/$reviewID/${AuthFireOps.superUserID()}',
    );

    if (_result == true){
      _output = true;
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeSingleReview({
    @required ReviewModel reviewModel,
    @required String bzID,
  }) async {

    /// 1. delete sub doc (fire/flyers/flyerID/reviews/reviewID)
    /// 2. delete reviewAgrees node (real/agreesOnReviews/reviewID)
    /// 3. decrement flyer counter field (real/countingFlyers/flyerID/reviews)
    /// 4. decrement bzz counter field (real/countingBzz/bzID/allReviews)

    if (reviewModel != null){

      await Future.wait(<Future>[

        /// DELETE REVIEW SUB DOC
        Fire.deleteSubDoc(
          collName: FireColl.flyers,
          docName: reviewModel.flyerID,
          subCollName: FireSubColl.flyers_flyer_reviews,
          subDocName: reviewModel.id,
        ),

        /// DELETE REVIEW AGREES
        Real.deleteDoc(
          collName: RealColl.agreesOnReviews,
          docName: reviewModel.id,
        ),

        FlyerRecordRealOps.reviewDeletion(
          flyerID: reviewModel.flyerID,
          bzID: bzID,
        ),

      ]);

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeAllFlyerReviews({
    @required BuildContext context,
    @required String flyerID,
    @required String bzID,
    @required bool isDeletingFlyer,
    @required bool isDeletingBz,
  }) async {

    // ---
    /// TASK : NEED CLOUD FUNCTION
    // ---
    /// 1. delete sub collection (fire/flyers/flyerID/reviews)
    /// 2. delete reviewAgrees node (real/agreesOnReviews/reviewID)
    /// 3. decrement flyer counter field (real/countingFlyers/flyerID/reviews) if not deleting flyer
    /// 4. decrement bzz counter field (real/countingBzz/bzID/allReviews) if not deleting bz
    // ---

    int _numberOfReviews = 0;

    /// 1. DELETE SUB COLL
    await Fire.deleteSubCollection(
        context: context,
        collName: FireColl.flyers,
        docName: flyerID,
        subCollName: FireSubColl.flyers_flyer_reviews,
        onDeleteSubDoc: (String reviewID) async {

          _numberOfReviews++;

          await Future.wait(<Future>[

            /// 2. DELETE REVIEW AGREES
            Real.deleteDoc(
              collName: RealColl.agreesOnReviews,
              docName: reviewID,
            ),

            /// 3. DELETE OR DECREMENT FLYER COUNTER
            // if (isDeletingFlyer == true) // => flyer counter will be deleted in wipeFlyerOps

            /// 4. DELETE OR DECREMENT BZ COUNTER
            // if (isDeletingBz == true) // => bz counter will be deleted in wipeBzOps

          ]);


          /// 3 - 4 : DECREMENTING FLYER & BZ COUNTERS IF NOT WIPING THEM OUT
          await Future.wait(<Future>[

            if (isDeletingFlyer == false)
              FlyerRecordRealOps.incrementFlyerCounter(
                flyerID: flyerID,
                field: 'reviews',
                incrementThis: -_numberOfReviews,
              ),

            if (isDeletingBz == false)
              BzRecordRealOps.incrementBzCounter(
                bzID: bzID,
                field: 'allReviews',
                incrementThis: -_numberOfReviews,
              ),

          ]);

        }
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT : TASK : NEED CLOUD FUNCTION
  static Future<void> wipeMultipleFlyersReviews({
    @required BuildContext context,
    @required List<String> flyersIDs,
    @required String bzID,
    @required bool isDeletingFlyer,
    @required bool isDeletingBz,
  }) async {

    if (Mapper.checkCanLoopList(flyersIDs) == true){

      await Future.wait(<Future>[

        ...List.generate(flyersIDs.length, (index) => wipeAllFlyerReviews(
          context: context,
          flyerID: flyersIDs[index],
          bzID: bzID,
          isDeletingBz: isDeletingBz,
          isDeletingFlyer: isDeletingFlyer,
        )),

      ]);

    }

  }
  // -----------------------------------------------------------------------------
}
