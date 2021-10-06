import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/sub/slide_model.dart';
import 'package:bldrs/providers/local_db/sql_db/sql_db.dart';
import 'package:bldrs/providers/local_db/sql_db/sql_column.dart';
import 'package:bldrs/providers/local_db/sql_db/sql_table.dart';
import 'package:flutter/material.dart';

class FlyerSQLdb{
  final String tableName;
  final SQLTable flyersTable;
  final SQLTable slidesTable;

  FlyerSQLdb({
    @required this.tableName,
    @required this.flyersTable,
    @required this.slidesTable,
});
// -----------------------------------------------------------------------------
  static String _slidesTableName(String LDBName){
    return '${LDBName}_slides';
  }
// -----------------------------------------------------------------------------
  static Future<FlyerSQLdb> createFlyersSQLdb({BuildContext context, String LDBName}) async {

    /// 1 - CREATE FLYERS LDB
    final List<SQLColumn> _FlyersColumns = FlyerModel.createFlyersLDBColumns();
    final SQLTable _flyers = await SQLdb.createAndSetSQLdb(
      context: context,
      tableName: LDBName,
      columns: _FlyersColumns,
    );

    /// 2 - CREATE SLIDES SLAVE LDB FOR PREVIOUS FLYERS LDB
    final List<SQLColumn> _slidesColumns = SlideModel.createSlidesLDBColumns();
    final SQLTable _slides = await SQLdb.createAndSetSQLdb(
      context: context,
      tableName: _slidesTableName(LDBName),
      columns: _slidesColumns,
    );

    /// 3 - COMBINE FLYERS AND SLIDES LDBs  AND RETURN
    final FlyerSQLdb _flyersLDB = FlyerSQLdb(
      tableName: LDBName,
      flyersTable: _flyers,
      slidesTable: _slides,
    );

    print('flyer LDB created : ${LDBName}');

    return _flyersLDB;
  }
// -----------------------------------------------------------------------------
  static Future<List<FlyerModel>> readFlyers({BuildContext context, FlyerSQLdb flyersLDB}) async {

    final List<Map<String, Object>> _sqlFlyersMaps = await SQLdb.readRaw(
      context: context,
      table: flyersLDB.flyersTable,
    );

    final List<Map<String, Object>> _sqlSlidesMaps = await SQLdb.readRaw(
      context: context,
      table: flyersLDB.slidesTable,
    );

    final List<SlideModel> _allSlides = await SlideModel.sqlDecipherSlides(maps: _sqlSlidesMaps);

    final List<FlyerModel> _allFlyers = await FlyerModel.sqlDecipherFlyers(
      sqlFlyersMaps: _sqlFlyersMaps,
      allSlides: _allSlides,
    );

    print('reading flyers LDB : ${flyersLDB.tableName}');
    return _allFlyers;
  }
// -----------------------------------------------------------------------------
  static Future<void> deleteFlyersSQLdb({BuildContext context, FlyerSQLdb flyersLDB}) async {

    await SQLdb.deleteDB(
      context: context,
      table: flyersLDB.slidesTable,
    );

    await SQLdb.deleteDB(
      context: context,
      table: flyersLDB.flyersTable,
    );

    print('Deleted flyers LDB : ${flyersLDB.tableName}');
  }
// -----------------------------------------------------------------------------
  static Future<void> insertFlyer({FlyerSQLdb flyersLDB, FlyerModel flyer}) async {

    /// inset sql slides
    for (SlideModel slide in flyer.slides){

      final Map<String, Object> _sqlSlideMap = await SlideModel.sqlCipherSlide(
        slide: slide,
        flyerID: flyer.flyerID,
      );
      await SQLdb.insert(
        table: flyersLDB.slidesTable,
        input: _sqlSlideMap,
      );
    }

    /// insert sql flyer
    final Map<String, Object> _sqlFlyerMap = await FlyerModel.sqlCipherFlyer(flyer);
    await SQLdb.insert(
      table: flyersLDB.flyersTable,
      input: _sqlFlyerMap,
    );

    print('flyer : ${flyer.flyerID} : added to : ${flyersLDB.tableName} : LDB');
  }
// -----------------------------------------------------------------------------
  static Future<List<SlideModel>> _getSlidesFromSQLdb({FlyerSQLdb flyersLDB, String flyerID, int numberOfSlides}) async {

    final List<String> _slidesIDs = SlideModel.generateSlidesIDs(
      flyerID: flyerID,
      numberOfSlides: numberOfSlides,
    );

    final List<Map<String,Object>> _allSlidesMaps = <Map<String,Object>>[];
    for (String slideID in _slidesIDs){

      final List<Map<String,Object>> _slideMapInAList = await SQLdb.getData(
        table: flyersLDB.slidesTable,
        key: 'slideID',
        value: slideID,
      );

      _allSlidesMaps.addAll(_slideMapInAList);

    }

    final List<SlideModel> _flyerSlides = await SlideModel.sqlDecipherSlides(maps: _allSlidesMaps);

    return _flyerSlides;
  }
// -----------------------------------------------------------------------------
  static Future<FlyerModel> readAFlyerFromSQLdb({FlyerSQLdb flyersLDB, String flyerID}) async {
    FlyerModel _flyer;

    final List<Map<String,Object>> _flyerMapInAList = await SQLdb.getData(
      table: flyersLDB.flyersTable,
      key: 'flyerID',
      value: flyerID,
    );

    if (_flyerMapInAList != null && _flyerMapInAList.length > 0){

      final Map<String, Object> _flyerMap = _flyerMapInAList[0];

      final List<SlideModel> _flyerSlides = await _getSlidesFromSQLdb(
        flyerID: flyerID,
        flyersLDB: flyersLDB,
        numberOfSlides: _flyerMap['numberOfSlides'],
      );

      _flyer = await FlyerModel.sqlDecipherFlyer(
        flyerMap: _flyerMap,
        slides: _flyerSlides,
      );

    }

    print('readAFlyerFromLDB : _flyerMapInAList.length : ${_flyerMapInAList.length} : _flyerMapInAList : ${_flyerMapInAList}');

    return _flyer;
  }
// -----------------------------------------------------------------------------
  static Future<void> deleteFlyerFromSQLdb({FlyerSQLdb flyersLDB, String flyerID}) async {

    final FlyerModel _flyer = await readAFlyerFromSQLdb(
      flyersLDB: flyersLDB,
      flyerID: flyerID,
    );

    final List<String> _slidesIDs = SlideModel.generateSlidesIDs(
      flyerID: flyerID,
      numberOfSlides: _flyer.slides.length,
    );

    for (String slideID in _slidesIDs){

      await SQLdb.deleteRowsByKeyAndValue(
        table: flyersLDB.slidesTable,
        key: 'slideID',
        value: slideID,
      );

    }

    await SQLdb.deleteRowsByKeyAndValue(
      table: flyersLDB.flyersTable,
      key: 'flyerID',
      value: flyerID,
    );

    print('Deleted flyer : flyerID : $flyerID : slidesIDs : ${_slidesIDs}');

  }
// -----------------------------------------------------------------------------

}