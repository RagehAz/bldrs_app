import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/foundation/ldb_ops.dart' as LDBOps;
import 'package:flutter/material.dart';

class FlyerLDBOps {

  FlyerLDBOps();

// -----------------------------------------------------------------------------

/// CREATE

// ----------------------------------------
  /// TESTED :
  static Future<void> insertFlyer(FlyerModel flyerModel) async {
        
    await LDBOps.insertMap(
        docName: LDBDoc.flyers,
        input: flyerModel.toMap(toJSON: true),
    );
    
  }
// ----------------------------------------
  /// TESTED :
  static Future<void> insertFlyers(List<FlyerModel> flyers) async {
    
    await LDBOps.insertMaps(
      docName: LDBDoc.flyers,
      inputs: FlyerModel.cipherFlyers(
          flyers: flyers,
          toJSON: true,
      ),
    );
    
  }
// -----------------------------------------------------------------------------

/// READ

// ----------------------------------------
  /// TESTED :
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
// ----------------------------------------
  /// TESTED :
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

// ----------------------------------------
  /// TESTED :
  static Future<void> updateFlyer(FlyerModel flyer) async {

    await LDBOps.insertMap(
        docName: LDBDoc.flyers,
        input: flyer.toMap(toJSON: true),
    );

  }
// -----------------------------------------------------------------------------

/// DELETE

// ----------------------------------------
  /// TESTED :
  static Future<void> deleteFlyers (List<String> flyersIDs) async {

    await LDBOps.deleteMaps(
      docName: LDBDoc.flyers,
      ids: flyersIDs,
    );

  }
// ----------------------------------------
  static Future<void> wipeOut(BuildContext context) async {

    await LDBOps.deleteAllMapsAtOnce(docName: LDBDoc.flyers);

  }
// -----------------------------------------------------------------------------
}
