import 'package:bldrs/a_models/flyer/sub/review_model.dart';
import 'package:bldrs/a_models/secondary_models/record_model.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/e_db/real/foundation/real.dart';
import 'package:bldrs/e_db/real/foundation/real_colls.dart';
import 'package:bldrs/e_db/real/ops/record_ops.dart';
import 'package:bldrs/e_db/real/ops/review_ops.dart';
import 'package:flutter/material.dart';

class ReviewProtocols {
// -----------------------------------------------------------------------------

  ReviewProtocols();

// -----------------------------------------------------------------------------

  /// COMPOSE

// ---------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<ReviewModel> composeReview({
    @required BuildContext context,
    @required String text,
    @required String flyerID,
}) async {

    final ReviewModel _uploadedReview = await ReviewFireOps.createReview(
        context: context,
        text: text,
        flyerID: flyerID,
    );

    await RecordRealOps.createRecord(
        context: context,
        record: RecordModel.createCreateReviewRecord(
            userID: AuthFireOps.superUserID(),
            flyerID: flyerID,
            text: text,
        ),
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
  static Future<bool> fetchIsAlreadyAgreed({
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

  static Future<void> wipeSingleReview({
    @required BuildContext context,
    @required ReviewModel reviewModel,
  }) async {

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

      ]);

    }

  }
// -----------------------------------------------------------------------------
}
