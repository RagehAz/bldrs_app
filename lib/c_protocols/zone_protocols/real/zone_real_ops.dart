import 'package:bldrs/a_models/d_zone/a_zoning/zone_level.dart';
import 'package:bldrs/a_models/d_zone/zz_old/city_model.dart';
import 'package:bldrs/a_models/d_zone/zz_old/country_model.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:flutter/material.dart';

class ZoneRealOps {
  // -----------------------------------------------------------------------------

  const ZoneRealOps();

  // -----------------------------------------------------------------------------

  /// READ COUNTRIES LEVELS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ZoneLevel> readCountriesLevels() async {

    final dynamic _dynamic = await Real.readPath(
      path: '${RealColl.zones}/${RealDoc.zones_countriesLevels}',
    );

    final Map<String, dynamic> _map = Mapper.getMapFromInternalHashLinkedMapObjectObject(
      internalHashLinkedMapObjectObject: _dynamic,
    );

    return ZoneLevel.decipher(_map);
  }
  // -----------------------------------------------------------------------------

  /// READ CITIES LEVELS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ZoneLevel> readCitiesLevels(String countryID) async {
    ZoneLevel _output;

    if (TextCheck.isEmpty(countryID) == false){

      final dynamic _dynamic = await Real.readPath(
        path: '${RealColl.zones}/${RealDoc.zones_citiesLevels}/$countryID',
      );

      final Map<String, dynamic> _map = Mapper.getMapFromInternalHashLinkedMapObjectObject(
        internalHashLinkedMapObjectObject: _dynamic,
      );

      _output = ZoneLevel.decipher(_map);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// READ COUNTRY MODEL

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CountryModel> readCountry({
    @required String countryID,
  }) async {
    CountryModel _output;

    final ZoneLevel _citiesIDs = await readCitiesLevels(countryID);

    if (_citiesIDs != null){
      _output = CountryModel(
        id: countryID,
        citiesIDs: _citiesIDs,
      );
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// READ CITY MODEL

  // --------------------
  /// TASK : TEST ME
  static Future<CityModel> readCity({
    @required String countryID,
    @required String cityID,
  }) async {
    CityModel _output;

    if (countryID != null && cityID != null){

      final Object _cityMap = await Real.readPath(
        path: '${RealColl.zones}/${RealDoc.zones_cities}/$countryID/$cityID',
      );

      final Map<String, dynamic> _map = Mapper.getMapFromInternalHashLinkedMapObjectObject(
        internalHashLinkedMapObjectObject: _cityMap,
      );


      _output = CityModel.decipherCity(
        map: _map,
        fromJSON: true,
        cityID: cityID,
      );

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<List<CityModel>> readCountryCities({
    @required String countryID,
  }) async {
    // final List<CityModel> _output = [];

    final Object _citiesMap = await Real.readPath(
      path: '${RealColl.zones}/${RealDoc.zones_cities}/$countryID',
    );

    final List<Map<String, dynamic>> _maps = Mapper.getMapsFromInternalHashLinkedMapObjectObject(
      internalHashLinkedMapObjectObject: _citiesMap,
    );

    Mapper.blogMaps(_maps, invoker: 'readCountryCities');


    return CityModel.decipherCities(maps: _maps, fromJSON: true,);

  }
  // -----------------------------------------------------------------------------
  void f(){}
}
