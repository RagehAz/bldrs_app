import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/m_search/search_model.dart';
import 'package:bldrs/c_protocols/search_protocols/search_ldb_ops.dart';
import 'package:bldrs/c_protocols/search_protocols/search_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
/// => TAMAM
class SearchProtocols {
  // -----------------------------------------------------------------------------

  const SearchProtocols();

  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<SearchModel?> compose({
    required SearchModel? searchModel,
    required String? userID,
  }) async {
    SearchModel? _output;

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
    required String? userID,
  }) async {
    List<SearchModel> _output = [];

    if (userID != null){

    _output = await SearchLDBOps.readAll();

    if (Lister.checkCanLoopList(_output) == false){

      _output = await SearchRealOps.readAll(
          userID: userID,
      );

      await SearchLDBOps.insertAll(
          searchModels: _output,
      );

    }

    }

    return _completeSearchesZoneModels(_output);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<SearchModel>> _completeSearchesZoneModels(List<SearchModel>? searches) async {
    final List<SearchModel> _output = [];

    if (Lister.checkCanLoopList(searches) == true){

      for (final SearchModel model in searches!){

        if (model.zone == null){
          _output.add(model);
        }

        else {

          final ZoneModel? _zone = await ZoneProtocols.completeZoneModel(
            invoker: 'SearchProtocols._completeSearchesZoneModels',
            incompleteZoneModel: model.zone,
          );

          final SearchModel _search = model.copyWith(
            zone: _zone,
          );

          _output.add(_search);

        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> renovate({
    required SearchModel? searchModel,
    required String? userID,
  }) async {

    if (searchModel != null && searchModel.id != null && userID != null){

      await Future.wait(<Future>[

        SearchRealOps.update(
          searchModel: searchModel,
          userID: userID,
        ),

        SearchLDBOps.insert(
          searchModel: searchModel,
        ),

      ]);

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipe({
    required String? modelID,
    required String? userID,
  }) async {

    if (modelID != null && userID != null){

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
    required String? userID,
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
