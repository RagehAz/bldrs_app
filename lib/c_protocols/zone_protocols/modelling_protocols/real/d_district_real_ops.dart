import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/d_zone/c_city/district_model.dart';
import 'package:real/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
import 'package:stringer/stringer.dart';
/// => TAMAM
class DistrictRealOps {
  // -----------------------------------------------------------------------------

  const DistrictRealOps();

  // -----------------------------------------------------------------------------

  /// DISTRICT PATH

  // --------------------
  /// TESTED : WORKS PERFECT
  static String _getDistrictPath({
    @required String districtID,
    @required bool withDocName,
  }){
    String _output;

    if (districtID != null){

      final String _countryID = DistrictModel.getCountryIDFromDistrictID(districtID);
      final String _cityID = DistrictModel.getCityIDFromDistrictID(districtID);

      if (withDocName == true){
        _output = '${RealColl.zones}/${RealDoc.zones_districts}/$_countryID/$_cityID/$districtID';
      }

      else {
        _output = '${RealColl.zones}/${RealDoc.zones_districts}/$_countryID/$_cityID';
      }

    }
    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String _getCityDistrictsPath({
    @required String cityID,
  }){
    String _output;

    if (cityID != null){
      final String _countryID = CityModel.getCountryIDFromCityID(cityID);
      _output = '${RealColl.zones}/${RealDoc.zones_districts}/$_countryID/$cityID';
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String _getCountryDistrictsPath({
    @required String countryID,
  }){
    String _output;

    if (countryID != null){
      _output = '${RealColl.zones}/${RealDoc.zones_districts}/$countryID';
    }

    return _output;
  }

  // -----------------------------------------------------------------------------

  /// CREATE DISTRICT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> createDistrict({
    @required DistrictModel district,
  }) async {

    if (district != null){

      await Real.createDocInPath(
          pathWithoutDocName: _getDistrictPath(districtID: district.id, withDocName: false),
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

      final Object _districtMap = await Real.readPath(
        path: _getDistrictPath(districtID: districtID, withDocName: true),
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


    final Object _objects = await Real.readPath(
      path: _getCityDistrictsPath(cityID: cityID),
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
          path: _getCountryDistrictsPath(countryID: countryID),
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

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateDistrict({
    @required DistrictModel newDistrict,
  }) async {

    await createDistrict(district: newDistrict);

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteDistrict({
    @required String districtID,
  }) async {

    if (districtID != null){

      await Real.deletePath(
        pathWithDocName: _getDistrictPath(districtID: districtID, withDocName: true),
      );

    }

  }
  // -----------------------------------------------------------------------------
}
