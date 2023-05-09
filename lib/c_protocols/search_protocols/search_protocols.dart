import 'package:bldrs/a_models/m_search/search_model.dart';
import 'package:bldrs/c_protocols/search_protocols/search_ldb_ops.dart';
import 'package:bldrs/c_protocols/search_protocols/search_real_ops.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';

/// => TAMAM
class SearchProtocols {
  // -----------------------------------------------------------------------------

  const SearchProtocols();

  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<SearchModel> compose({
    @required SearchModel searchModel,
    @required String userID,
  }) async {
    SearchModel _output;

    if (searchModel != null && userID != null){

      _output = await SearchRealOps.create(
          searchModel: searchModel,
          userID: userID,
      );

      await SearchLDBOps.insert(
          searchModel: _output,
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<SearchModel>> fetchAll({
    @required String userID,
  }) async {
    List<SearchModel> _output = [];

    if (userID != null){

    _output = await SearchLDBOps.readAll();

    if (Mapper.checkCanLoopList(_output) == false){

      _output = await SearchRealOps.readAll(
          userID: userID,
      );

      await SearchLDBOps.insertAll(
          searchModels: _output,
      );

    }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipe({
    @required String modelID,
    @required String userID,
  }) async {

    if (modelID != null){

      await Future.wait(<Future>[

        SearchRealOps.delete(
          modelID: modelID,
          userID: userID,
        ),

        SearchLDBOps.delete(
          modelID: modelID,
        ),

      ]);

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeAllUserSearches({
    @required String userID,
  }) async {

    if (userID != null){

      await Future.wait(<Future>[

        SearchRealOps.deleteAllUserSearches(
          userID: userID,
        ),

        SearchLDBOps.deleteAllUserSearches(),

      ]);

    }

  }
  // -----------------------------------------------------------------------------
}
