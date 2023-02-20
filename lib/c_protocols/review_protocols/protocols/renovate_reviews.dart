import 'package:bldrs/a_models/f_flyer/sub/review_model.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/c_protocols/review_protocols/fire/review_fire_ops.dart';
import 'package:real/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class RenovateReviewProtocols {
  // -----------------------------------------------------------------------------

  const RenovateReviewProtocols();

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
  /// TESTED : WORKS PERFECT
  static Future<ReviewModel> agreeOnReview({
    @required ReviewModel reviewModel,
    @required bool isAgreed,
  }) async {

    ReviewModel _output = reviewModel;

    if (reviewModel != null && isAgreed != null){

      /// AGREE : was false and to be true
      if (isAgreed == false){
        _output = await _addAgree(
          reviewModel: reviewModel,
        );
      }

      /// REMOVE AGREE : was true and to be false
      else {
        _output = await _removeAgree(
          reviewModel: reviewModel,
        );
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ReviewModel> _addAgree({
    @required ReviewModel reviewModel,
  }) async {

    /// UPDATE MODEL
    final ReviewModel _updated = ReviewModel.incrementAgrees(
      reviewModel: reviewModel,
      isIncrementing: true,
    );

    /// FIRE AND REAL UPDATES
    await Future.wait(<Future>[

      /// RENOVATE FIRE DOC
      renovateReview(
        reviewModel: _updated,
      ),

      /// ADD MY ID IN REVIEW AGREES LIST
      Real.updateDocField(
          collName: RealColl.agreesOnReviews,
        docName: '${reviewModel.flyerID}/${reviewModel.id}',
        fieldName: AuthFireOps.superUserID(),
          value: true,
      ),

    ]);

    return _updated;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ReviewModel> _removeAgree({
    @required ReviewModel reviewModel,
  }) async {

    blog('_removeAgree : START');

    /// UPDATE MODEL
    final ReviewModel _updated = ReviewModel.incrementAgrees(
      reviewModel: reviewModel,
      isIncrementing: false,
    );

    /// FIRE AND REAL UPDATES
    await Future.wait(<Future>[

      /// RENOVATE FIRE DOC
      renovateReview(
        reviewModel: _updated,
      ),

      /// REMOVE ID IN REVIEW AGREES LIST
      Real.deleteField(
        collName: RealColl.agreesOnReviews,
        docName: '${reviewModel.flyerID}/${reviewModel.id}',
        fieldName: AuthFireOps.superUserID(),
      ),

    ]);

    blog('_removeAgree : end');

    return _updated;
  }
  // -----------------------------------------------------------------------------
}
