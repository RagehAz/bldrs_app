import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/models/flag_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/g_statistics/census/census_model.dart';
import 'package:fire/super_fire.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:basics/ldb/methods/ldb_ops.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
/// => TAMAM
class CensusRealOps {
  // -----------------------------------------------------------------------------

  const CensusRealOps();

  // -----------------------------------------------------------------------------

  /// READ PLANET CENSUS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CensusModel?> readPlanetCensus() async {
    CensusModel? _output = CensusModel.createEmptyModel(
      id: Flag.planetID,
    );

    final Object? _object = await Real.readPath(
      path: '${RealColl.statistics}/${RealDoc.statistics_planet}',
    );

    if (_object != null){

      final Map<String, dynamic>? _map = Mapper.getMapFromIHLMOO(
        ihlmoo: _object,
      );

      if (_map != null){
        _output = CensusModel.decipher(
          map: _map,
          id: Flag.planetID,
        );
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// READ COUNTRY / COUNTRIES CENSUS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<CensusModel>> readAllCountriesCensuses() async {

    List<CensusModel> _output = [];

    final Object _objects = await Real.readPath(
      path: '${RealColl.statistics}/${RealDoc.statistics_countries}',
    );

    final List<Map<String, dynamic>> _maps = Mapper.getMapsFromIHLMOO(
      ihlmoo: _objects,
      // addChildrenIDs: true, // DEFAULT
    );

    if (Lister.checkCanLoopList(_maps) == true){

      _output = CensusModel.decipherCensuses(_maps);

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CensusModel?> readCountryCensus({
    required String? countryID,
  }) async {
    CensusModel? _output = CensusModel.createEmptyModel(
      id: countryID,
    );

    if (countryID != null){

      final Object? _object = await Real.readPath(
          path: '${RealColl.statistics}/${RealDoc.statistics_countries}/$countryID',
      );

      if (_object != null){

        final Map<String, dynamic>? _map = Mapper.getMapFromIHLMOO(
          ihlmoo: _object,
        );

        if (_map != null){
          _output = CensusModel.decipher(
            map: _map,
            id: countryID,
          );
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// READ CITY / CITIES CENSUS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<CensusModel>> readCitiesOfCountryCensus({
    required String? countryID,
  }) async {
    List<CensusModel> _output = <CensusModel>[];

    if (countryID != null){

      final Object _objects = await Real.readPath(
        path: '${RealColl.statistics}/${RealDoc.statistics_cities}/$countryID',
      );

      final List<Map<String, dynamic>> _maps = Mapper.getMapsFromIHLMOO(
        ihlmoo: _objects,
        // addChildrenIDs: true, // DEFAULT
      );

      if (Lister.checkCanLoopList(_maps) == true){
        _output = CensusModel.decipherCensuses(_maps);
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CensusModel?> readCityCensus({
    required String? cityID,
  }) async {
    CensusModel? _output = CensusModel.createEmptyModel(
      id: cityID,
    );

    if (cityID != null){

      final String? _countryID = CityModel.getCountryIDFromCityID(cityID);
      final Object? _object = await Real.readPath(
          path: '${RealColl.statistics}/${RealDoc.statistics_cities}/$_countryID/$cityID',
      );

      if (_object != null){

        final Map<String, dynamic>? _map = Mapper.getMapFromIHLMOO(
          ihlmoo: _object,
        );

        if (_map != null){
          _output = CensusModel.decipher(
            map: _map,
            id: cityID,
          );
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateAllCensus({
    required Map<String, dynamic>? map,
    required ZoneModel? zoneModel,
  }) async {

    if (map != null){

      final Map<String, dynamic>? _map = Mapper.cleanNullPairs(
        map: map,
      );
      final Map<String, int> _upload = CensusModel.completeMapForIncrementation(_map);

      await Future.wait(<Future>[

        /// UPDATE PLANET
        Real.incrementDocFields(
          coll: RealColl.statistics,
          doc: RealDoc.statistics_planet,
          incrementationMap: _upload,
          isIncrementing: true,
        ),

        /// UPDATE COUNTRY
        if (zoneModel?.countryID != null)
        Real.incrementDocFields(
          coll: RealColl.statistics,
          doc: '${RealDoc.statistics_countries}/${zoneModel!.countryID}',
          incrementationMap: _upload,
          isIncrementing: true,
        ),

        /// UPDATE CITY
        if (zoneModel?.countryID != null && zoneModel?.cityID != null)
          Real.incrementDocFields(
            coll: RealColl.statistics,
            doc: '${RealDoc.statistics_cities}/${zoneModel!.countryID}/${zoneModel.cityID}',
            incrementationMap: _upload,
            isIncrementing: true,
          ),

      ]);

      /// DELETE LDB CENSUSES
      final List<String> _idsToDeleteInLDB = <String>[
        Flag.planetID,
      ];

      if (zoneModel?.countryID != null){
        _idsToDeleteInLDB.add(zoneModel!.countryID);
      }

      if (zoneModel?.countryID != null && zoneModel?.cityID != null){
        _idsToDeleteInLDB.add(zoneModel!.cityID!);
      }

      await LDBOps.deleteMaps(
        docName: LDBDoc.census,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.census),
        ids: _idsToDeleteInLDB,
      );

    }

  }
  // -----------------------------------------------------------------------------
}
