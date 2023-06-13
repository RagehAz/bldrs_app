import 'package:bldrs/a_models/f_flyer/sub/review_model.dart';
import 'package:fire/super_fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class ReviewFireOps {
  // -----------------------------------------------------------------------------

  const ReviewFireOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ReviewModel> createReview({
    @required ReviewModel reviewModel,
  }) async {

    assert(reviewModel != null,'review model is null');
    assert(reviewModel.flyerID != null, 'review flyerID is null');

    final String _reviewID = await Fire.createDoc(
      coll: FireColl.flyers,
      doc: reviewModel.flyerID,
      subColl: FireSubColl.flyers_flyer_reviews,
      input: reviewModel.toMap(),
    );

    return reviewModel.copyWith(id: _reviewID);
  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ReviewModel> readReview({
    @required String flyerID,
    @required String reviewID,
  }) async {
    ReviewModel _output;

    if (reviewID != null){

      final Map<String, dynamic> _map = await Fire.readDoc(
          coll: FireColl.flyers,
          doc: flyerID,
          subColl: FireSubColl.flyers_flyer_reviews,
          subDoc: reviewID,
      );

      _output = ReviewModel.decipherReview(
        map: _map,
        reviewID: reviewID,
        fromJSON: false,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
  /*
  /// TESTED : WORKS PERFECT
  static Future<List<ReviewModel>> readAllFlyerReviews({
    @required BuildContext context,
    @required String flyerID,
  }) async {

    // final List<dynamic> _maps = await Fire.readSubCollectionDocs(
    //   context: context,
    //   collName: FireColl.flyers,
    //   docName: flyerID,
    //   subCollName: FireSubColl.flyers_flyer_reviews,
    //   addDocsIDs: true,
    //   orderBy: 'reviewID',
    //   limit: 10,
    //
    //   /// task : paginate in flyer reviews
    // );
    //
    // final List<ReviewModel> _reviews = ReviewModel.decipherReviews(maps: _maps, fromJSON: false);
    // return _reviews;

    return null;
  }
   */
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateReview({
    @required ReviewModel reviewModel,
  }) async {

    await Fire.updateDoc(
      coll: FireColl.flyers,
      doc: reviewModel.flyerID,
      subColl: FireSubColl.flyers_flyer_reviews,
      subDoc: reviewModel.id,
      input: reviewModel.toMap(),
    );

  }
  // -----------------------------------------------------------------------------
}
