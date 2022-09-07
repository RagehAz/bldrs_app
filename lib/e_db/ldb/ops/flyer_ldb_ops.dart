import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/review_model.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_doc.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class FlyerLDBOps {
  // -----------------------------------------------------------------------------

  const FlyerLDBOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertFlyer(FlyerModel flyerModel) async {
    blog('FlyerLDBOps.insertFlyer : START');

    await LDBOps.insertMap(
      docName: LDBDoc.flyers,
      input: flyerModel.toMap(toJSON: true),
    );

    blog('FlyerLDBOps.insertFlyer : END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertFlyers(List<FlyerModel> flyers) async {

    if (Mapper.checkCanLoopList(flyers) == true){

      await LDBOps.insertMaps(
        docName: LDBDoc.flyers,
        inputs: FlyerModel.cipherFlyers(
          flyers: flyers,
          toJSON: true,
        ),
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerModel> readFlyer(String flyerID) async {

    final Map<String, dynamic> _map = await LDBOps.searchFirstMap(
      fieldToSortBy: 'id',
      searchField: 'id',
      searchValue: flyerID,
      docName: LDBDoc.flyers,
    );

    final FlyerModel _flyer = FlyerModel.decipherFlyer(
      map: _map,
      fromJSON: true,
    );

    return  _flyer;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<FlyerModel>> readFlyers(List<String> flyersIDs) async {

    final List<Map<String, dynamic>> _maps = await LDBOps.readMaps(
      ids: flyersIDs,
      docName: LDBDoc.flyers,
    );

    final List<FlyerModel> _flyers = FlyerModel.decipherFlyers(
      maps: _maps,
      fromJSON: true,
    );

    return _flyers;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateFlyer(FlyerModel flyer) async {

    await LDBOps.insertMap(
      docName: LDBDoc.flyers,
      input: flyer.toMap(toJSON: true),
    );

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteFlyers (List<String> flyersIDs) async {

    await LDBOps.deleteMaps(
      docName: LDBDoc.flyers,
      ids: flyersIDs,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeOut(BuildContext context) async {

    await LDBOps.deleteAllMapsAtOnce(docName: LDBDoc.flyers);

  }
  // -----------------------------------------------------------------------------

  /// FLYER MAKER SESSION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> saveFlyerMakerSession({
    @required FlyerModel flyerModel,
  }) async {

    if (flyerModel != null){

      await LDBOps.insertMap(
        docName: LDBDoc.flyerMaker,
        input: flyerModel.toMap(toJSON: true),
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerModel> loadFlyerMakerSession({
    @required String flyerID,
  }) async {
    FlyerModel _flyer;

    final List<Map<String, dynamic>> _maps = await LDBOps.readMaps(
      ids: <String>[flyerID],
      docName: LDBDoc.flyerMaker,
    );

    if (Mapper.checkCanLoopList(_maps) == true){
      _flyer = FlyerModel.decipherFlyer(
        map: _maps.first,
        fromJSON: true,
      );
    }

    return _flyer;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteFlyerMakerSession({
    @required String flyerID,
  }) async {

    await LDBOps.deleteMap(
      objectID: flyerID,
      docName: LDBDoc.flyerMaker,
    );

  }
  // -----------------------------------------------------------------------------

  /// FLYER REVIEW SESSION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> saveReviewSession({
    @required ReviewModel review,
  }) async {

    if (review != null){

      await LDBOps.insertMap(
        docName: LDBDoc.reviewEditor,
        input: review.toMap(toJSON: true, includeID: true),
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ReviewModel> loadReviewSession({
    @required String reviewID,
  }) async {
    ReviewModel _review;

    final List<Map<String, dynamic>> _maps = await LDBOps.readMaps(
      ids: <String>[reviewID],
      docName: LDBDoc.reviewEditor,
    );

    if (Mapper.checkCanLoopList(_maps) == true){
      _review = ReviewModel.decipherReview(
        map: _maps.first,
        fromJSON: true,
        reviewID: reviewID,
      );
    }

    return _review;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteReviewSession({
    @required String reviewID,
  }) async {

    await LDBOps.deleteMap(
      objectID: reviewID,
      docName: LDBDoc.reviewEditor,
    );

  }
  // -----------------------------------------------------------------------------
}
