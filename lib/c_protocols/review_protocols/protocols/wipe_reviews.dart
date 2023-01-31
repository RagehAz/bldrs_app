import 'package:bldrs/a_models/f_flyer/sub/review_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/real/bz_record_real_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/real/flyer_record_real_ops.dart';
import 'package:fire/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:mapper/mapper.dart';
import 'package:flutter/material.dart';

class WipeReviewProtocols {
  // -----------------------------------------------------------------------------

  const WipeReviewProtocols();
  // -----------------------------------------------------------------------------

  /// WIPE REVIEW

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
          docName: '${reviewModel.flyerID}/${reviewModel.id}',
        ),

        FlyerRecordRealOps.reviewDeletion(
          flyerID: reviewModel.flyerID,
          bzID: bzID,
        ),

      ]);

    }

  }
  // -----------------------------------------------------------------------------

  /// WIPE REVIEWS

  // --------------------
  /// TASK : TEST ME
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
    /// 2. delete reviewAgrees node (real/agreesOnReviews/flyerID)
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
        numberOfIterations: 1000,
        numberOfReadsPerIteration: 5,
        onDeleteSubDoc: (String reviewID) async {
          _numberOfReviews++;
        }
    );

    /// 2. DELETE REVIEW AGREES
    if (isDeletingFlyer == true){
      await Real.deleteDoc(
        collName: RealColl.agreesOnReviews,
        docName: flyerID,
      );
    }

    /// 3 - 4 : DECREMENTING FLYER & BZ COUNTERS IF NOT WIPING THEM OUT
    await Future.wait(<Future>[

      /// 3. DECREMENT FLYER COUNTER
      // if (isDeletingFlyer == true) // => flyer counter will be deleted in wipeFlyerOps
      if (isDeletingFlyer == false)
        FlyerRecordRealOps.incrementFlyerCounter(
          flyerID: flyerID,
          field: 'reviews',
          incrementThis: -_numberOfReviews,
        ),

      /// 4. DECREMENT BZ COUNTER
      // if (isDeletingBz == true) // => bz counter will be deleted in wipeBzOps
      if (isDeletingBz == false)
        BzRecordRealOps.incrementBzCounter(
          bzID: bzID,
          field: 'allReviews',
          incrementThis: -_numberOfReviews,
        ),

    ]);


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

        ...List.generate(flyersIDs.length, (index){

          return wipeAllFlyerReviews(
            context: context,
            flyerID: flyersIDs[index],
            bzID: bzID,
            isDeletingBz: isDeletingBz,
            isDeletingFlyer: isDeletingFlyer,
          );

        }),

      ]);

    }

  }
  // -----------------------------------------------------------------------------
}
