import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/super_fire/super_fire.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:ldb/ldb.dart';
import 'package:mapper/mapper.dart';
import 'package:flutter/cupertino.dart';
/// => TAMAM
class CensusRealOps {
  // -----------------------------------------------------------------------------

  const CensusRealOps();

  // -----------------------------------------------------------------------------

  /// READ PLANET CENSUS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CensusModel> readPlanetCensus() async {
    CensusModel _output;

    final Object _object = await Real.readPath(
      path: RealPath.getCensusPathOfPlanet,
    );

    if (_object != null){

      final Map<String, dynamic> _map = Mapper.getMapFromIHLMOO(
        ihlmoo: _object,
      );

      if (_map != null){
        _output = CensusModel.decipher(
          map: _map,
          id: 'planet',
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
      path: RealPath.getCensusesPathOfAllCountries(),
    );

    final List<Map<String, dynamic>> _maps = Mapper.getMapsFromIHLMOO(
      ihlmoo: _objects,
      // addChildrenIDs: true, // DEFAULT
    );

    if (Mapper.checkCanLoopList(_maps) == true){

      _output = CensusModel.decipherCensuses(_maps);

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CensusModel> readCountryCensus({
    @required String countryID,
  }) async {
    CensusModel _output;

    if (countryID != null){

      final Object _object = await Real.readPath(
          path: RealPath.getCensusPathOfCountry(countryID: countryID),
      );

      if (_object != null){

        final Map<String, dynamic> _map = Mapper.getMapFromIHLMOO(
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
    @required String countryID,
  }) async {
    List<CensusModel> _output = <CensusModel>[];

    if (countryID != null){

      final Object _objects = await Real.readPath(
        path: RealPath.getCensusesPathOfCities(countryID: countryID),
      );

      final List<Map<String, dynamic>> _maps = Mapper.getMapsFromIHLMOO(
        ihlmoo: _objects,
        // addChildrenIDs: true, // DEFAULT
      );

      if (Mapper.checkCanLoopList(_maps) == true){
        _output = CensusModel.decipherCensuses(_maps);
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CensusModel> readCityCensus({
    @required String cityID,
  }) async {
    CensusModel _output;

    if (cityID != null){

      final Object _object = await Real.readPath(
          path: RealPath.getCensusPathOfCity(cityID: cityID),
      );

      if (_object != null){

        final Map<String, dynamic> _map = Mapper.getMapFromIHLMOO(
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
    @required Map<String, dynamic> map,
    @required ZoneModel zoneModel,
  }) async {

    if (map != null && zoneModel != null){

      Map<String, dynamic> _map = Mapper.cleanNullPairs(
        map: map,
      );
      _map = CensusModel.completeMapForIncrementation(_map);

      await Future.wait(<Future>[

        /// UPDATE PLANET
        Real.updateDocInPath(
          path: RealPath.getCensusPathOfPlanet,
          map: _map,
        ),

        /// UPDATE COUNTRY
        if (zoneModel.countryID != null)
        Real.updateDocInPath(
          path: RealPath.getCensusPathOfCountry(countryID: zoneModel.countryID),
          map: _map,
        ),

        /// UPDATE CITY
        if (zoneModel.countryID != null && zoneModel.cityID != null)
          Real.updateDocInPath(
            path: RealPath.getCensusPathOfCity(cityID: zoneModel.cityID),
            map: _map,
        ),

      ]);

      /// DELETE LDB CENSUSES
      final List<String> _idsToDeleteInLDB = <String>[
        CensusModel.planetID,
        zoneModel.countryID,
        zoneModel.cityID,
      ];

      await LDBOps.deleteMaps(
        docName: LDBDoc.census,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.census),
        ids: _idsToDeleteInLDB,
      );

    }

  }
  // -----------------------------------------------------------------------------
}
