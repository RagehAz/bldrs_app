import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/sub/slide_model.dart';
import 'package:bldrs/providers/local_db/models/ldb.dart';
import 'package:bldrs/providers/local_db/models/ldb_column.dart';
import 'package:bldrs/providers/local_db/models/ldb_table.dart';
import 'package:flutter/material.dart';

class FlyersLDB{
  final String tableName;
  final LDBTable flyersTable;
  final LDBTable slidesTable;

  FlyersLDB({
    @required this.tableName,
    @required this.flyersTable,
    @required this.slidesTable,
});
// -----------------------------------------------------------------------------
  static String _slidesTableName(String tableName){
    return '${tableName}_slides';
  }
// -----------------------------------------------------------------------------
  static Future<FlyersLDB> createFlyersLDB({BuildContext context, String LDBName}) async {

    /// 1 - CREATE FLYERS LDB
    final List<LDBColumn> _FlyersColumns = FlyerModel.createFlyersLDBColumns();
    final LDBTable _flyers = await LDB.createAndSetLDB(
      context: context,
      tableName: LDBName,
      columns: _FlyersColumns,
    );

    /// 2 - CREATE SLIDES SLAVE LDB FOR PREVIOUS FLYERS LDB
    final List<LDBColumn> _slidesColumns = SlideModel.createSlidesLDBColumns();
    final LDBTable _slides = await LDB.createAndSetLDB(
      context: context,
      tableName: _slidesTableName(LDBName),
      columns: _slidesColumns,
    );

    /// 3 - COMBINE FLYERS AND SLIDES LDBs  AND RETURN
    final FlyersLDB _flyersLDB = FlyersLDB(
      tableName: LDBName,
      flyersTable: _flyers,
      slidesTable: _slides,
    );

    print('flyer LDB created : ${LDBName}');

    return _flyersLDB;
  }
// -----------------------------------------------------------------------------
  static Future<List<FlyerModel>> readFlyersLDB({BuildContext context, FlyersLDB flyersLDB}) async {

    List<Map<String, Object>> _sqlFlyersMaps = await LDB.readRawFromLDB(
      context: context,
      table: flyersLDB.flyersTable,
    );

    List<Map<String, Object>> _sqlSlidesMaps = await LDB.readRawFromLDB(
      context: context,
      table: flyersLDB.flyersTable,
    );

    final List<SlideModel> _allSlides = SlideModel.sqlDecipherSlides(maps: _sqlSlidesMaps);

    final List<FlyerModel> _allFlyers = FlyerModel.sqlDecipherFlyers(
      sqlFlyersMaps: _sqlFlyersMaps,
      allSlides: _allSlides,
    );

    print('reading flyers LDB : ${flyersLDB.tableName}');
    return _allFlyers;
  }
// -----------------------------------------------------------------------------
  static Future<void> deleteFlyersLDB({BuildContext context, FlyersLDB flyersLDB}) async {

    await LDB.deleteLDB(
      context: context,
      table: flyersLDB.slidesTable,
    );

    await LDB.deleteLDB(
      context: context,
      table: flyersLDB.flyersTable,
    );

    print('Deleted flyers LDB : ${flyersLDB.tableName}');
  }
// -----------------------------------------------------------------------------
  static Future<void> insertFlyerToLDB({FlyersLDB flyersLDB, FlyerModel flyer}) async {

    /// inset sql slides
    for (SlideModel slide in flyer.slides){
      final Map<String, Object> _sqlSlideMap = SlideModel.sqlCipherSlide(
        slide: slide,
        flyerID: flyer.flyerID,
      );
      await LDB.insert(
        table: flyersLDB.slidesTable,
        input: _sqlSlideMap,
      );
    }

    /// insert sql flyer
    final Map<String, Object> _sqlFlyerMap = FlyerModel.sqlCipherFlyerModel(flyer);
    await LDB.insert(
      table: flyersLDB.flyersTable,
      input: _sqlFlyerMap,
    );

    print('flyer : ${flyer.flyerID} : added to : ${flyersLDB.tableName} : LDB');
  }
// -----------------------------------------------------------------------------
  static Future<FlyerModel> readFlyerFromLDB({FlyersLDB flyersLDB, String flyerID}) async {

    print('3ala allah 7kaytak');

    return null;
  }
// -----------------------------------------------------------------------------
  static Future<void> updateFlyerInLDB({FlyersLDB flyersLDB, String oldFlyerID, FlyerModel newFlyer}) async {

    print('3ala allah 7kaytak');

    return null;
  }
// -----------------------------------------------------------------------------
  static Future<void> deleteFlyerFromLDB({FlyersLDB flyersLDB, String flyerID}) async {

    print('3ala allah 7kaytak');

    return null;
  }
// -----------------------------------------------------------------------------

}