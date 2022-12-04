import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/cupertino.dart';
/// => TAMAM
class CensusRealOps {
  // -----------------------------------------------------------------------------

  const CensusRealOps();

  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<CensusModel>> readCountriesCensus() async {

    List<CensusModel> _output = [];

    final Object _objects = await Real.readPath(
        path: '${RealColl.statistics}/${RealDoc.statistics_countries}',
    );

    final List<Map<String, dynamic>> _maps = Mapper.getMapsFromIHLMOO(
      ihlmoo: _objects,
      // addChildrenIDs: true, // DEFAULT
    );

    if (Mapper.checkCanLoopList(_maps) == true){

      _output = CensusModel.decipherCensuses(_maps);

    }

    CensusModel.blogCensuses(
      censuses: _output,
    );

    return _output;
  }
  // --------------------
  /// TASK : WRITE ME
  static Future<List<CensusModel>> readCitiesCensus({
    @required String countryID,
  }) async {


  }
  // --------------------
  /// TASK : WRITE ME
  static Future<List<CensusModel>> readDistrictsCensus({
    @required String cityID,
  }) async {

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

      Map<String, dynamic> _map = Mapper.cleanNullPairs(map);
      _map = CensusModel.completeMapForIncrementation(_map);

      await Future.wait(<Future>[

        /// UPDATE PLANET
        Real.updateDoc(
          collName: RealColl.statistics,
          docName: RealDoc.statistics_planet,
          map: _map,
        ),

        /// UPDATE COUNTRY
        if (zoneModel.countryID != null)
        Real.updateDoc(
          collName: RealColl.statistics,
          docName: '${RealDoc.statistics_countries}/${zoneModel.countryID}',
          map: _map,
        ),

        /// UPDATE CITY
        if (zoneModel.cityID != null)
          Real.updateDoc(
          collName: RealColl.statistics,
          docName: '${RealDoc.statistics_cities}/${zoneModel.cityID}',
          map: _map,
        ),

        /// UPDATE DISTRICT
        if (zoneModel.districtID != null)
          Real.updateDoc(
            collName: RealColl.statistics,
            docName: '${RealDoc.statistics_districts}/${zoneModel.districtID}',
            map: _map,
          ),

      ]);

    }

  }
  // -----------------------------------------------------------------------------
}
