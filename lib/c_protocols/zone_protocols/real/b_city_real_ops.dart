import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class CityRealOps {
  // -----------------------------------------------------------------------------

  const CityRealOps();

  // -----------------------------------------------------------------------------

  /// READ CITY MODEL

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CityModel> readCity({
    @required String countryID,
    @required String cityID,
  }) async {
    CityModel _output;

    if (countryID != null && cityID != null){

      final Object _cityMap = await Real.readPath(
        path: '${RealColl.zones}/${RealDoc.zones_cities}/$countryID/$cityID',
      );

      final Map<String, dynamic> _map = Mapper.getMapFromIHLMOO(
        ihlmoo: _cityMap,
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
  /// TESTED : WORKS PERFECT
  static Future<List<CityModel>> readCities({
    @required List<String> citiesIDs,
  }) async {
    final List<CityModel> _output = [];

    if (Mapper.checkCanLoopList(citiesIDs) == true){

      await Future.wait(<Future>[

        ...List.generate(citiesIDs.length, (index){

          final String _cityID = citiesIDs[index];
          final String _countryID = CityModel.getCountryIDFromCityID(_cityID);

          return readCity(
            countryID: _countryID,
            cityID: _cityID,
          ).then((CityModel _cityModel){

            if (_cityModel != null){
              _output.add(_cityModel);
            }

          });

        }),

      ]);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// READ COUNTRIES CITIES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<CityModel>> readCountryCities({
    @required String countryID,
  }) async {

    final Object _citiesMap = await Real.readPath(
      path: '${RealColl.zones}/${RealDoc.zones_cities}/$countryID',
    );

    final List<Map<String, dynamic>> _maps = Mapper.getMapsFromIHLMOO(
      ihlmoo: _citiesMap,
    );

    return CityModel.decipherCities(
      maps: _maps,
      fromJSON: true,
    );

  }
  // -----------------------------------------------------------------------------
}
