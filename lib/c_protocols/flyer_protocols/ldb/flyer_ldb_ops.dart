import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/review_model.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:basics/ldb/methods/ldb_ops.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
/// => TAMAM
class FlyerLDBOps {
  // -----------------------------------------------------------------------------

  const FlyerLDBOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertFlyer(FlyerModel? flyerModel) async {
    // blog('FlyerLDBOps.insertFlyer : START');

    await LDBOps.insertMap(
      docName: LDBDoc.flyers,
      primaryKey: LDBDoc.getPrimaryKey(LDBDoc.flyers),
      input: flyerModel?.toMap(toJSON: true),
    );

    // blog('FlyerLDBOps.insertFlyer : END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertFlyers(List<FlyerModel>? flyers) async {

    if (Lister.checkCanLoopList(flyers) == true){

      await LDBOps.insertMaps(
        docName: LDBDoc.flyers,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.flyers),
        inputs: FlyerModel.cipherFlyers(
          flyers: flyers,
          toJSON: true,
        ),
        // allowDuplicateIDs: false,
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerModel?> readFlyer(String? flyerID) async {

    final Map<String, dynamic>? _map = await LDBOps.searchFirstMap(
      sortFieldName: 'id',
      searchFieldName: 'id',
      searchValue: flyerID,
      docName: LDBDoc.flyers,
    );

    final FlyerModel? _flyer = FlyerModel.decipherFlyer(
      map: _map,
      fromJSON: true,
    );

    return  _flyer;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<FlyerModel>> readFlyers(List<String>? flyersIDs) async {

    List<FlyerModel>? _flyers = <FlyerModel>[];

    if (Lister.checkCanLoopList(flyersIDs) == false){
      return <FlyerModel>[];
    }
    else {

      final List<Map<String, dynamic>> _maps = await LDBOps.readMaps(
        ids: flyersIDs!,
        docName: LDBDoc.flyers,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.flyers),
      );

      _flyers = FlyerModel.decipherFlyers(
        maps: _maps,
        fromJSON: true,
      );

    }

    return _flyers;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateFlyer(FlyerModel flyer) async {

    await LDBOps.insertMap(
      docName: LDBDoc.flyers,
      primaryKey: LDBDoc.getPrimaryKey(LDBDoc.flyers),
      input: flyer.toMap(toJSON: true),
    );

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteFlyers (List<String>? flyersIDs) async {

    await LDBOps.deleteMaps(
      docName: LDBDoc.flyers,
      primaryKey: LDBDoc.getPrimaryKey(LDBDoc.flyers),
      ids: flyersIDs,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeOut() async {

    await LDBOps.deleteAllMapsAtOnce(docName: LDBDoc.flyers);

  }
  // -----------------------------------------------------------------------------

  /// FLYER MAKER SESSION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> saveFlyerMakerSession({
    required DraftFlyer? draftFlyer,
  }) async {

    if (draftFlyer != null){

      await LDBOps.insertMap(
        docName: LDBDoc.flyerMaker,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.flyerMaker),
        input: DraftFlyer.draftToLDB(draftFlyer),
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<DraftFlyer?> loadFlyerMakerSession({
    required String? flyerID,
    required String? bzID,
  }) async {
    DraftFlyer? _draft;

    final List<Map<String, dynamic>> _maps = await LDBOps.readMaps(
      ids: flyerID == null ? [] : <String>[flyerID],
      docName: LDBDoc.flyerMaker,
      primaryKey: LDBDoc.getPrimaryKey(LDBDoc.flyerMaker),
    );

    if (Lister.checkCanLoopList(_maps) == true){

      final Map<String, dynamic>? _map = Mapper.getMapFromMapsByID(
        maps: _maps,
        id: bzID,
        idFieldName: 'bzID',
      );

      _draft = DraftFlyer.draftFromLDB(_map);
    }

    return _draft;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteFlyerMakerSession({
    required String? flyerID,
  }) async {

    await LDBOps.deleteMap(
      objectID: flyerID,
      docName: LDBDoc.flyerMaker,
      primaryKey: LDBDoc.getPrimaryKey(LDBDoc.flyerMaker),
    );

  }
  // -----------------------------------------------------------------------------

  /// FLYER REVIEW SESSION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> saveReviewSession({
    required ReviewModel? review,
  }) async {

    if (review != null){

      await LDBOps.insertMap(
        docName: LDBDoc.reviewEditor,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.reviewEditor),
        input: review.toMap(toJSON: true, includeID: true),
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ReviewModel?> loadReviewSession({
    required String? reviewID,
  }) async {
    ReviewModel? _review;

    final List<Map<String, dynamic>> _maps = await LDBOps.readMaps(
      ids: reviewID == null ? [] : <String>[reviewID],
      docName: LDBDoc.reviewEditor,
      primaryKey: LDBDoc.getPrimaryKey(LDBDoc.reviewEditor),
    );

    if (Lister.checkCanLoopList(_maps) == true){
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
    required String reviewID,
  }) async {

    await LDBOps.deleteMap(
      objectID: reviewID,
      docName: LDBDoc.reviewEditor,
      primaryKey: LDBDoc.getPrimaryKey(LDBDoc.reviewEditor),
    );

  }
  // -----------------------------------------------------------------------------
}
