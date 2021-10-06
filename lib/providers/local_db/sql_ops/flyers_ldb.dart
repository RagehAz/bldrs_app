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
  static String _slidesTableName(String LDBName){
    return '${LDBName}_slides';
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

    final List<Map<String, Object>> _sqlFlyersMaps = await LDB.readRawFromLDB(
      context: context,
      table: flyersLDB.flyersTable,
    );

    final List<Map<String, Object>> _sqlSlidesMaps = await LDB.readRawFromLDB(
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

      final Map<String, Object> _sqlSlideMap = await SlideModel.sqlCipherSlide(
        slide: slide,
        flyerID: flyer.flyerID,
      );
      await LDB.insert(
        table: flyersLDB.slidesTable,
        input: _sqlSlideMap,
      );
    }

    /// insert sql flyer
    final Map<String, Object> _sqlFlyerMap = await FlyerModel.sqlCipherFlyer(flyer);
    await LDB.insert(
      table: flyersLDB.flyersTable,
      input: _sqlFlyerMap,
    );

    print('flyer : ${flyer.flyerID} : added to : ${flyersLDB.tableName} : LDB');
  }
// -----------------------------------------------------------------------------
  static Future<List<SlideModel>> _getSlidesFromLDB({FlyersLDB flyersLDB, String flyerID, int numberOfSlides}) async {

    final List<String> _slidesIDs = SlideModel.generateSlidesIDs(
      flyerID: flyerID,
      numberOfSlides: numberOfSlides,
    );

    final List<Map<String,Object>> _allSlidesMaps = <Map<String,Object>>[];
    for (String slideID in _slidesIDs){

      final List<Map<String,Object>> _slideMapInAList = await LDB.getData(
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
  static Future<FlyerModel> readAFlyerFromLDB({FlyersLDB flyersLDB, String flyerID}) async {
    FlyerModel _flyer;

    final List<Map<String,Object>> _flyerMapInAList = await LDB.getData(
      table: flyersLDB.flyersTable,
      key: 'flyerID',
      value: flyerID,
    );

    if (_flyerMapInAList != null && _flyerMapInAList.length > 0){

      final Map<String, Object> _flyerMap = _flyerMapInAList[0];

      final List<SlideModel> _flyerSlides = await _getSlidesFromLDB(
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
  static Future<void> deleteFlyerFromLDB({FlyersLDB flyersLDB, String flyerID}) async {

    final FlyerModel _flyer = await readAFlyerFromLDB(
      flyersLDB: flyersLDB,
      flyerID: flyerID,
    );

    final List<String> _slidesIDs = SlideModel.generateSlidesIDs(
      flyerID: flyerID,
      numberOfSlides: _flyer.slides.length,
    );

    for (String slideID in _slidesIDs){

      await LDB.deleteRowsByKeyAndValue(
        table: flyersLDB.slidesTable,
        key: 'slideID',
        value: slideID,
      );

    }

    await LDB.deleteRowsByKeyAndValue(
      table: flyersLDB.flyersTable,
      key: 'flyerID',
      value: flyerID,
    );

    print('Deleted flyer : flyerID : $flyerID : slidesIDs : ${_slidesIDs}');

  }
// -----------------------------------------------------------------------------

}