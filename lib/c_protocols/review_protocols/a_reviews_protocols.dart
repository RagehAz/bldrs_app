import 'package:bldrs/a_models/flyer/sub/review_model.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/e_db/real/foundation/real.dart';
import 'package:bldrs/e_db/real/foundation/real_colls.dart';
import 'package:bldrs/e_db/real/ops/bz_record_ops.dart';
import 'package:bldrs/e_db/real/ops/flyer_record_ops.dart';
import 'package:bldrs/e_db/real/ops/review_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';

class ReviewProtocols {
// -----------------------------------------------------------------------------

  const ReviewProtocols();

// -----------------------------------------------------------------------------

  /// COMPOSE

// ---------------------------------------
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

    final ReviewModel _uploadedReview = await ReviewFireOps.createReview(
        context: context,
        text: text,
        flyerID: flyerID,
    );

    await FlyerRecordOps.reviewCreation(
      context: context,
      review: text,
      flyerID: flyerID,
      bzID: bzID,
    );

    return _uploadedReview;
  }
// -----------------------------------------------------------------------------

  /// RENOVATE

// ---------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> renovateReview({
    @required BuildContext context,
    @required ReviewModel reviewModel,
  }) async {

    if (reviewModel != null){

      await ReviewFireOps.updateReview(
        context: context,
        reviewModel: reviewModel,
      );

    }

  }
// -----------------------------------------------------------------------------

  /// REVIEW AGREE

// ---------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<ReviewModel> agreeOnReview({
    @required BuildContext context,
    @required ReviewModel reviewModel,
    @required bool isAlreadyAgreed,
  }) async {

    final ReviewModel _updated = ReviewModel.incrementAgrees(
      reviewModel: reviewModel,
      isIncrementing: !isAlreadyAgreed,
    );

    await ReviewProtocols.renovateReview(
      context: context,
      reviewModel: _updated,
    );

    /// remove user ID from (review agrees list)
    if (isAlreadyAgreed == true){
      await Real.deleteField(
          context: context,
          collName: RealColl.agreesOnReviews,
          docName: reviewModel.id,
          fieldName: AuthFireOps.superUserID(),
      );
    }
    /// add user id to (review agrees list)
    else {
      await Real.updateDocField(
          context: context,
          collName: RealColl.agreesOnReviews,
          docName: reviewModel.id,
          fieldName: AuthFireOps.superUserID(),
          value: true,
      );
    }

    return _updated;
  }
// ---------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> fetchIsAgreed({
    @required BuildContext context,
    @required String reviewID,
  }) async {

    bool _output = false;

    final dynamic _result = await Real.readPath(
      context: context,
      path: '${RealColl.agreesOnReviews}/$reviewID/${AuthFireOps.superUserID()}',
    );

    if (_result == true){
      _output = true;
    }

    return _output;
  }
// -----------------------------------------------------------------------------

  /// WIPE

// ---------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeSingleReview({
    @required BuildContext context,
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
          context: context,
          collName: FireColl.flyers,
          docName: reviewModel.flyerID,
          subCollName: FireSubColl.flyers_flyer_reviews,
          subDocName: reviewModel.id,
        ),

        /// DELETE REVIEW AGREES
        Real.deleteDoc(
          context: context,
          collName: RealColl.agreesOnReviews,
          docName: reviewModel.id,
        ),

        FlyerRecordOps.reviewDeletion(
            context: context,
            flyerID: reviewModel.flyerID,
            bzID: bzID,
        ),

      ]);

    }

  }
// ---------------------------------------
  /// TESTED : WORKS PERFECT : TASK : NEED CLOUD FUNCTION
  static Future<void> wipeAllFlyerReviews({
    @required BuildContext context,
    @required String flyerID,
    @required String bzID,
    @required bool isDeletingFlyer,
    @required bool isDeletingBz,
  }) async {

    /// 1. delete sub collection (fire/flyers/flyerID/reviews)
    /// 2. delete reviewAgrees node (real/agreesOnReviews/reviewID)
    /// 3. decrement flyer counter field (real/countingFlyers/flyerID/reviews) if not deleting flyer
    /// 4. decrement bzz counter field (real/countingBzz/bzID/allReviews) if not deleting bz

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
            context: context,
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
            FlyerRecordOps.incrementFlyerCounter(
              context: context,
              flyerID: flyerID,
              field: 'reviews',
              incrementThis: -_numberOfReviews,
            ),

          if (isDeletingBz == false)
            BzRecordOps.incrementBzCounter(
              context: context,
              bzID: bzID,
              field: 'allReviews',
              incrementThis: -_numberOfReviews,
            ),

        ]);

      }
    );

  }
// ---------------------------------------
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
