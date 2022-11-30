import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/d_zone/c_city/district_model.dart';
import 'package:bldrs/c_protocols/zone_protocols/real/d_district_real_ops.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class DistrictsStagesRealOps {
  /// --------------------------------------------------------------------------

  const DistrictsStagesRealOps();
  // -----------------------------------------------------------------------------

  /// COMPOSE / RESET

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ZoneStages> resetDistrictsStages({
    @required String cityID,
  }) async {

    ZoneStages _stages;

    if (cityID != null){

      final List<DistrictModel> _districts = await DistrictRealOps.readCityDistricts(
        cityID: cityID,
      );

      if (Mapper.checkCanLoopList(_districts) == false){
        blog('resetDistrictsStages : no districts found for city ( $cityID )');
      }

      else {

        final String _countryID = CityModel.getCountryIDFromCityID(cityID);

        final List<String> _districtsIDs = DistrictModel.getDistrictsIDs(_districts);

        _stages = ZoneStages(
            hidden: _districtsIDs,
            inactive: null,
            active: null,
            public: null
        );

        await Real.createDocInPath(
          pathWithoutDocName: '${RealColl.zones}/${RealDoc.zones_districtsStages}/$_countryID',
          docName: cityID,
          addDocIDToOutput: false,
          map: _stages.toMap(),
        );

      }

    }

    return _stages;
  }
  // -----------------------------------------------------------------------------

  /// READ DISTRICTS STAGES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ZoneStages> readDistrictsStages({
    @required String cityID,
  }) async {
    ZoneStages _output;

    if (TextCheck.isEmpty(cityID) == false){

      final String countryID = CityModel.getCountryIDFromCityID(cityID);

      final dynamic _dynamic = await Real.readPath(
        path: '${RealColl.zones}/${RealDoc.zones_districtsStages}/$countryID/$cityID',
      );

      final Map<String, dynamic> _map = Mapper.getMapFromIHLMOO(
        ihlmoo: _dynamic,
      );

      _output = ZoneStages.decipher(_map);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ZoneStages> updateDistrictStage({
    @required String districtID,
    @required StageType newType,
  }) async {

    ZoneStages _output;

    if (districtID != null && newType != null){

      final String _countryID = DistrictModel.getCountryIDFromDistrictID(districtID);
      final String _cityID = DistrictModel.getCityIDFromDistrictID(districtID);

      final ZoneStages _districtsStages = await readDistrictsStages(
        cityID: _cityID,
      );

      _output = ZoneStages.insertIDToZoneStages(
        zoneStages: _districtsStages,
        id: districtID,
        newType: newType,
      );

      await Real.createDocInPath(
        pathWithoutDocName: '${RealColl.zones}/${RealDoc.zones_districtsStages}/$_countryID',
        docName: _cityID,
        addDocIDToOutput: false,
        map: _output.toMap(),
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
  void f(){}
  // -----------------------------------------------------------------------------
}
