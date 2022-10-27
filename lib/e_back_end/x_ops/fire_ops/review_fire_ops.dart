import 'package:bldrs/a_models/f_flyer/sub/review_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_colls.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReviewFireOps {
  // -----------------------------------------------------------------------------

  const ReviewFireOps();

  // -----------------------------------------------------------------------------

  /// PATH

  // --------------------
  /// TESTED : WORKS PERFECT
  static String createRealPath(String flyerID){
    return '/${RealColl.reviews}/$flyerID';
  }
  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ReviewModel> createReview({
    @required String text,
    @required String flyerID,
  }) async {

    final ReviewModel _review = ReviewModel.createNewReview(
      text: text,
      flyerID: flyerID,
    );

    final DocumentReference<Object> _ref = await Fire.createSubDoc(
      collName: FireColl.flyers,
      docName: flyerID,
      subCollName: FireSubColl.flyers_flyer_reviews,
      input: _review.toMap(),
    );

    return _review.copyWith(id: _ref?.id);
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateReview({
    @required ReviewModel reviewModel,
  }) async {

    await Fire.updateSubDoc(
      collName: FireColl.flyers,
      docName: reviewModel.flyerID,
      subCollName: FireSubColl.flyers_flyer_reviews,
      subDocName: reviewModel.id,
      input: reviewModel.toMap(),
    );

  }
  // -----------------------------------------------------------------------------
}
