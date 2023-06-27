import 'package:bldrs/a_models/f_flyer/sub/review_model.dart';
import 'package:bldrs/c_protocols/recorder_protocols/recorder_protocols.dart';
import 'package:fire/super_fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:flutter/material.dart';

class WipeReviewProtocols {
  // -----------------------------------------------------------------------------

  const WipeReviewProtocols();

  // -----------------------------------------------------------------------------

  /// WIPE REVIEW

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeSingleReview({
    required ReviewModel reviewModel,
    required String bzID,
  }) async {
    /// 1. delete sub doc (fire/flyers/flyerID/reviews/reviewID)
    /// 2. delete reviewAgrees node (real/agreesOnReviews/reviewID)
    /// 3. decrement flyer counter field (real/countingFlyers/flyerID/reviews)
    /// 4. decrement bzz counter field (real/countingBzz/bzID/allReviews)

    if (
        reviewModel != null &&
        bzID != null &&
        Authing.userHasID() == true
    ) {

      await Future.wait(<Future>[

        /// DELETE REVIEW SUB DOC
        Fire.deleteDoc(
          coll: FireColl.flyers,
          doc: reviewModel.flyerID,
          subColl: FireSubColl.flyers_flyer_reviews,
          subDoc: reviewModel.id,
        ),

        /// DELETE REVIEW AGREES
        Real.deletePath(
          pathWithDocName: RealPath.agrees_bzID_flyerID_reviewID(
            bzID: bzID,
            flyerID: reviewModel.flyerID,
            reviewID: reviewModel.id,
          ),
        ),

        /// DECREMENT BZ & FLYER COUNTERS
        RecorderProtocols.onWipeReview(
          flyerID: reviewModel.flyerID,
          bzID: bzID,
        ),

      ]);
    }
  }
  // -----------------------------------------------------------------------------

  /// WIPE FLYER

  // --------------------
  /// TASK : TEST ME
  static Future<void> onWipeFlyer({
    required String flyerID,
    required String bzID,
  }) async {

    if (flyerID != null){

      /// DELETE REVIEWS SUB COLL
      await Fire.deleteColl(
        coll: FireColl.flyers,
        doc: flyerID,
        subColl: FireSubColl.flyers_flyer_reviews,
      );

      /// DELETE FLYER AGREES
      await Real.deletePath(
        pathWithDocName: RealPath.agrees_bzID_flyerID(
            bzID: bzID,
            flyerID: flyerID,
        ),
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// WIPE BZ

  // --------------------
  /// TASK : TEST ME
  static Future<void> onWipeBz({
    required List<String> flyersIDs,
    required String bzID,
  }) async {

    if (bzID != null){

      await Future.wait(<Future>[

        /// WIPE ALL REVIEWS OF ALL FLYERS
        if (Mapper.checkCanLoopList(flyersIDs) == true)
          ...List.generate(flyersIDs.length, (index) {
            return Fire.deleteColl(
              coll: FireColl.flyers,
              doc: flyersIDs[index],
              subColl: FireSubColl.flyers_flyer_reviews,
            );
          }),

        /// WIPE ALL AGREES OF THIS BZ
        Real.deletePath(
          pathWithDocName: RealPath.agrees_bzID(
            bzID: bzID,
          ),
        ),

      ]);
    }


  }

// -----------------------------------------------------------------------------
}
