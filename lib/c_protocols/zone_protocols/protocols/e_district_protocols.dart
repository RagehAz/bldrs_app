import 'package:bldrs/a_models/d_zone/a_zoning/zone_level.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/d_zone/c_city/district_model.dart';
import 'package:bldrs/c_protocols/zone_protocols/ldb/c_district_ldb_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/d_city_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/real/d_district_real_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:flutter/material.dart';

class DistrictProtocols {
  // -----------------------------------------------------------------------------

  const DistrictProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  ///
  // -----------------------------------------------------------------------------

  /// FETCH DISTRICTS

  // --------------------
  /// TASK : TEST ME
  static Future<DistrictModel> fetchDistrict({
    @required String districtID,
  }) async {

    DistrictModel _districtModel = await DistrictLDBOps.readDistrict(districtID);

    if (_districtModel != null){
      // blog('fetchCity : ($cityID) CityModel FOUND in LDB');
    }

    else {

      _districtModel = await DistrictRealOps.readDistrict(districtID);

      if (_districtModel != null){
        // blog('fetchCity : ($cityID) CityModel FOUND in FIRESTORE and inserted in LDB');

        await DistrictLDBOps.insertDistrict(_districtModel);

      }

    }

    if (_districtModel == null){
      // blog('fetchCity : ($cityID) CityModel NOT FOUND');
    }

    return _districtModel;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<List<DistrictModel>> fetchDistricts({
    @required List<String> districtsIDs,
    ValueChanged<DistrictModel> onDistrictRead,
  }) async {
    final List<DistrictModel> _output = <DistrictModel>[];

    if (Mapper.checkCanLoopList(districtsIDs) == true){

      await Future.wait(<Future>[

        ...List.generate(districtsIDs.length, (index) {

          return fetchDistrict(
            districtID: districtsIDs[index],
          ).then((DistrictModel district) {

            if (district != null) {

              _output.add(district);

              if (onDistrictRead != null) {
                onDistrictRead(district);
              }

            }

          });
        }),

      ]);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// FETCH CITY DISTRICTS

  // --------------------
  /// TASK : TEST ME
  static Future<List<DistrictModel>> fetchCityDistrictsByLevel({
    @required String cityID,
    /// If cityLevel is null, then all cities will be returned
    ZoneLevelType districtLevel,
  }) async {
    List<DistrictModel> _output = <DistrictModel>[];

    if (TextCheck.isEmpty(cityID) == false){

      /// SHOULD FETCH ALL DISTRICTS
      if (districtLevel == null){
        _output = await fetchDistrictsFromAllOfCity(cityID: cityID);
      }

      /// SHOULD FETCH ONLY DISTRICTS OF THIS LEVEL
      else {

        final ZoneLevel _districtsIDs = await DistrictRealOps.readDistrictsLevels(cityID);

        _output = await fetchDistrictsFromSomeOfCity(
          districtsIDsOfThisCity: _districtsIDs?.getIDsByLevel(districtLevel),
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<List<DistrictModel>> fetchDistrictsFromAllOfCity({
    @required String cityID,
  }) async {
    List<DistrictModel> _output = <DistrictModel>[];

    if (TextCheck.isEmpty(cityID) == false){

      _output = await DistrictRealOps.readCityDistricts(cityID);

      if (Mapper.checkCanLoopList(_output) == true){
        await DistrictLDBOps.insertDistricts(_output);
      }

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<List<DistrictModel>> fetchDistrictsFromSomeOfCity({
    @required List<String> districtsIDsOfThisCity,
  }) async {
    List<DistrictModel> _output = <DistrictModel>[];

    if (Mapper.checkCanLoopList(districtsIDsOfThisCity) == true){

      final List<DistrictModel> _ldbDistricts = await DistrictLDBOps.readDistricts(districtsIDsOfThisCity);

      if (_ldbDistricts.length == districtsIDsOfThisCity.length){
        _output = _ldbDistricts;
      }

      else {

        /// ADD FOUND DISTRICTS
        _output.addAll(_ldbDistricts);

        /// COLLECT NOT FOUND DISTRICTS
        final List<String> _districtsIDsToReadFromReal = <String>[];
        for (final String districtID in districtsIDsOfThisCity){
          final bool _wasInLDB = DistrictModel.checkDistrictsIncludeDistrictID(_ldbDistricts, districtID);
          if (_wasInLDB == false){
            _districtsIDsToReadFromReal.add(districtID);
          }
        }

        /// READ REMAINING CITIES FROM REAL
        final List<DistrictModel> _remainingDistricts = await DistrictRealOps.readDistricts(
          districtsIDs: _districtsIDsToReadFromReal,
        );

        if (Mapper.checkCanLoopList(_remainingDistricts) == true){
          await DistrictLDBOps.insertDistricts(_remainingDistricts);
          _output.addAll(_remainingDistricts);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// FETCH COUNTRY DISTRICTS

  // --------------------
  /// TASK : TEST ME
  static Future<List<DistrictModel>> fetchDistrictsFromAllOfCountryOneByOne(String countryID) async {
    final List<DistrictModel> _output = <DistrictModel>[];

    if (TextCheck.isEmpty(countryID) == false){

      final List<CityModel> _countryCities = await CityProtocols.fetchCitiesFromAllOfCountry(
        countryID: countryID,
      );

      if (Mapper.checkCanLoopList(_countryCities) == true){

        for (final CityModel city in _countryCities){

          final List<DistrictModel> _cityDistricts = await fetchDistrictsFromAllOfCity(
            cityID: city.cityID,
          );

          if (Mapper.checkCanLoopList(_cityDistricts) == true){
            _output.addAll(_cityDistricts);
          }

        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  ///
  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------
  ///
  // -----------------------------------------------------------------------------
}
