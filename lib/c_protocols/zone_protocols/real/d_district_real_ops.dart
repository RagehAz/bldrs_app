import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/d_zone/c_city/district_model.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class DistrictRealOps {
  // -----------------------------------------------------------------------------

  const DistrictRealOps();

  // -----------------------------------------------------------------------------

  /// CREATE DISTRICT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> createDistrict({
    @required DistrictModel district,
  }) async {

    /// TASK : ASSERT THAT DISTRICT ID IS CORRECT AND HAS TWO + +
    /// TASK : ASSERT THAT MAP HAS NO 'id' FIELD

    if (district != null){

      final String _countryID = DistrictModel.getCountryIDFromDistrictID(district.id);
      final String _cityID = DistrictModel.getCityIDFromDistrictID(district.id);

      await Real.createDocInPath(
          pathWithoutDocName: '${RealColl.zones}/${RealDoc.zones_districts}/$_countryID/$_cityID',
          docName: district.id,
          addDocIDToOutput: false,
          map: district.toMap(
            toJSON: true,
            toLDB: false,
          ),
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// READ DISTRICT MODEL

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<DistrictModel> readDistrict({
  @required String districtID,
  }) async {
    DistrictModel _output;

    if (TextCheck.isEmpty(districtID) == false){

      final String _countryID  = DistrictModel.getCountryIDFromDistrictID(districtID);
      final String _cityID     = DistrictModel.getCityIDFromDistrictID(districtID);

      final Object _districtMap = await Real.readPath(
        path: '${RealColl.zones}/${RealDoc.zones_districts}/$_countryID/$_cityID/$districtID',
      );

      final Map<String, dynamic> _map = Mapper.getMapFromIHLMOO(
        ihlmoo: _districtMap,
      );

      _output = DistrictModel.decipherDistrict(
        map: _map,
        districtID: districtID,
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<DistrictModel>> readDistricts({
    @required List<String> districtsIDs,
  }) async {
    final List<DistrictModel> _output = [];

    if (Mapper.checkCanLoopList(districtsIDs) == true){

      await Future.wait(<Future>[

        ...List.generate(districtsIDs.length, (index){

          final String _districtID = districtsIDs[index];

          return readDistrict(
            districtID: _districtID,
          ).then((DistrictModel _district){

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
  /// TESTED : WORKS PERFECT
  static Future<List<DistrictModel>> readCityDistricts({
  @required String cityID,
  }) async {

    final String _countryID = CityModel.getCountryIDFromCityID(cityID);

    final Object _objects = await Real.readPath(
      path: '${RealColl.zones}/${RealDoc.zones_districts}/$_countryID/$cityID',
    );

    final List<Map<String, dynamic>> _maps = Mapper.getMapsFromIHLMOO(
      ihlmoo: _objects,
    );

    return DistrictModel.decipherDistrictsMaps(_maps);
  }
  // -----------------------------------------------------------------------------

  /// READ COUNTRY DISTRICTS

  // --------------------
  /// TESTED : WORKS PERFECT : TOO EXPENSIVE BIG COUNTRIES
  static Future<List<DistrictModel>> readCountryDistricts(String countryID) async {
    final List<DistrictModel> _output = [];

    if (TextCheck.isEmpty(countryID) == false){

      final Object object = await Real.readPath(
          path: '${RealColl.zones}/${RealDoc.zones_districts}/$countryID'
      );

      if (object != null){

        final List<Map<String, dynamic>> citiesMaps = Mapper.getMapsFromIHLMOO(
          ihlmoo: object,
          addChildrenIDs: false,
        );

        for (final Map<String, dynamic> cityMap in citiesMaps){

          final List<String> _districtsIDs = cityMap.keys.toList();

          for (int i = 0; i < _districtsIDs.length; i++){

            final String _districtID = _districtsIDs[i];

            final Map<String, dynamic> _districtMap = cityMap[_districtID];

            final DistrictModel _district = DistrictModel.decipherDistrict(
              map: _districtMap,
              districtID: _districtID,
            );

            _output.add(_district);

          }

      }


      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
