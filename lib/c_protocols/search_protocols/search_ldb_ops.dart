import 'package:bldrs/a_models/m_search/search_model.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:flutter/material.dart';
import 'package:ldb/ldb.dart';
import 'package:mapper/mapper.dart';
/// => TAMAM
class SearchLDBOps{
  // -----------------------------------------------------------------------------

  const SearchLDBOps();

  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insert({
    @required SearchModel searchModel,
  }) async {

    if (searchModel != null){

      await LDBOps.insertMap(
        docName: LDBDoc.searches,
        primaryKey: 'id',
        input: SearchModel.cipher(
          searchModel: searchModel,
        ),
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertAll({
    @required List<SearchModel> searchModels,
  }) async {

    if (Mapper.checkCanLoopList(searchModels) == true){

      await LDBOps.insertMaps(
          docName: LDBDoc.searches,
          primaryKey: 'id',
          inputs: SearchModel.cipherSearches(
            models: searchModels,
          ),
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<SearchModel>> readAll() async {

    final List<Map<String, dynamic>> _maps = await LDBOps.readAllMaps(
        docName: LDBDoc.searches,
    );

    return SearchModel.decipherSearches(
      maps: _maps,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> delete({
    @required String modelID,
  }) async {

    if (modelID != null){

      await LDBOps.deleteMap(
        objectID: modelID,
        docName: LDBDoc.searches,
        primaryKey: 'id',
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteAllUserSearches() async {

    await LDBOps.deleteAllMapsAtOnce(
      docName: LDBDoc.searches,
    );

  }
  // -----------------------------------------------------------------------------
}
