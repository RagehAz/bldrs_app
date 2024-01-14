import 'package:bldrs/a_models/m_search/search_model.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:fire/super_fire.dart';
import 'package:basics/helpers/maps/mapper.dart';
/// => TAMAM
class SearchRealOps {
  // -----------------------------------------------------------------------------

  const SearchRealOps();

  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<SearchModel?> create({
    required SearchModel? searchModel,
    required String? userID,
  }) async {
    SearchModel? _output;

    if (searchModel != null && userID != null) {

      Map<String, dynamic>? _maw = SearchModel.cipher(
          searchModel: searchModel,
        );

      _maw = Mapper.cleanNullPairs(map: _maw);

      final Map<String, dynamic>? uploaded = await Real.createDocInPath(
        pathWithoutDocName: RealPath.searches_userID(userID: userID),
        map: _maw,
      );

      _output = SearchModel.decipher(
        map: uploaded,
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<SearchModel>> readAll({
    required String? userID,
  }) async {
    List<SearchModel> _output = [];

    if (userID != null){

      final List<Map<String, dynamic>> _maps = await Real.readPathMaps(
          realQueryModel: RealQueryModel(
            path: RealPath.searches_userID(userID: userID),
            limit: 50,
            orderType: RealOrderType.byKey,
            fieldNameToOrderBy: 'time',
            // readFromBeginningOfOrderedList: true,
          ),
      );

      _output = SearchModel.decipherSearches(
        maps: _maps,
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> update({
    required SearchModel? searchModel,
    required String? userID,
  }) async {

    if (searchModel != null && searchModel.id != null && userID != null){

      await Real.updateDocInPath(
        path: RealPath.searches_userID_searchID(
          userID: userID,
          searchID: searchModel.id!,
        ),
        map: SearchModel.cipher(
          searchModel: searchModel,
        ),
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> delete({
    required String? userID,
    required String? modelID,
  }) async {

    await Real.deletePath(
        pathWithDocName: '${RealColl.searches}/$userID/$modelID',

    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteAllUserSearches({
    required String? userID,
  }) async {

    if (userID != null){

      await Real.deletePath(
          pathWithDocName: '${RealColl.searches}/$userID',
      );

    }

  }
  // -----------------------------------------------------------------------------
}
