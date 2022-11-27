import 'package:bldrs/a_models/d_zone/a_zoning/zone_level.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/d_zone/c_city/district_model.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:flutter/material.dart';

class DistrictRealOps {
  // -----------------------------------------------------------------------------

  const DistrictRealOps();

  // -----------------------------------------------------------------------------

  /// READ DISTRICTS LEVELS

  // --------------------
  /// TASK : TEST ME
  static Future<ZoneLevel> readDistrictsLevels(String cityID) async {
    ZoneLevel _output;

    if (TextCheck.isEmpty(cityID) == false){

      final String countryID = CityModel.getCountryIDFromCityID(cityID);

      final dynamic _dynamic = await Real.readPath(
        path: '${RealColl.zones}/${RealDoc.zones_districtsLevels}/$countryID/$cityID',
      );

      final Map<String, dynamic> _map = Mapper.getMapFromInternalHashLinkedMapObjectObject(
        internalHashLinkedMapObjectObject: _dynamic,
      );

      _output = ZoneLevel.decipher(_map);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// READ DISTRICT MODEL

  // --------------------
  /// TASK : TEST ME
  static Future<DistrictModel> readDistrict(String districtID) async {
    DistrictModel _output;

    if (TextCheck.isEmpty(districtID) == false){

      final String _countryID  = DistrictModel.getCountryIDFromDistrictID(districtID);
      final String _cityID     = DistrictModel.getCityIDFromDistrictID(districtID);

      final Object _districtMap = await Real.readPath(
        path: '${RealColl.zones}/${RealDoc.zones_cities}/$_countryID/$_cityID/$districtID',
      );

      final Map<String, dynamic> _map = Mapper.getMapFromInternalHashLinkedMapObjectObject(
        internalHashLinkedMapObjectObject: _districtMap,
      );

      _output = DistrictModel.decipherDistrict(
        map: _map,
        districtID: districtID,
      );

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<List<DistrictModel>> readDistricts({
    @required List<String> districtsIDs,
  }) async {
    final List<DistrictModel> _output = [];

    if (Mapper.checkCanLoopList(districtsIDs) == true){

      await Future.wait(<Future>[

        ...List.generate(districtsIDs.length, (index){

          final String _districtID = districtsIDs[index];

          return readDistrict(_districtID).then((DistrictModel _district){

            if (_district != null){
              _output.add(_district);
            }

          });

        }),

      ]);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// READ CITY DISTRICTS

  // --------------------
  /// TASK : TEST ME
  static Future<List<DistrictModel>> readCityDistricts(String cityID) async {

    final String _countryID = CityModel.getCountryIDFromCityID(cityID);

    final Object _objects = await Real.readPath(
      path: '${RealColl.zones}/${RealDoc.zones_districts}/$_countryID/$cityID',
    );

    final List<Map<String, dynamic>> _maps = Mapper.getMapsFromInternalHashLinkedMapObjectObject(
      internalHashLinkedMapObjectObject: _objects,
    );

    return DistrictModel.decipherDistrictsMaps(_maps);
  }
  // -----------------------------------------------------------------------------

  /// READ COUNTRY DISTRICTS

  // --------------------
  /// TASK : WRITE MEeeee
  static Future<List<DistrictModel>> readCountryDistricts(String countryID) async {

  }
  // -----------------------------------------------------------------------------
}
