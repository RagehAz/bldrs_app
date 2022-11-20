import 'package:bldrs/a_models/d_zone/zone_model.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_colls.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/cupertino.dart';

class CensusRealOps {
  // -----------------------------------------------------------------------------

  const CensusRealOps();

  // -----------------------------------------------------------------------------
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
  void f(){}
}
