import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/ldb/methods/ldb_ops.dart';
import 'package:bldrs/a_models/m_search/search_model.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
/// => TAMAM
class SearchLDBOps{
  // -----------------------------------------------------------------------------

  const SearchLDBOps();

  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insert({
    required SearchModel? searchModel,
  }) async {

    if (searchModel != null && searchModel.id != null){

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
    required List<SearchModel> searchModels,
  }) async {

    if (Lister.checkCanLoop(searchModels) == true){

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

    final List<SearchModel> _output = SearchModel.decipherSearches(
      maps: _maps,
    );

    return SearchModel.sortByDate(models: _output);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> delete({
    required String? modelID,
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
