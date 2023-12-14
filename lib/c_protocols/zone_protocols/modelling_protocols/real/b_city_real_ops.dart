import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:fire/super_fire.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';

/// => TAMAM
class CityRealOps {
  // -----------------------------------------------------------------------------

  const CityRealOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> createCity({
    required CityModel? cityModel
  }) async {

    if (cityModel != null){

      final String? _countryID = cityModel.getCountryID();

      await Real.createDocInPath(
        pathWithoutDocName: '${RealColl.zones}/${RealDoc.zones_cities}/$_countryID',
        doc: cityModel.cityID,
        map: cityModel.toMap(
          toJSON: true,
          toLDB: false,
        ),
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// READ CITY MODEL

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CityModel?> readCityX({
    required String? countryID,
    required String? cityID,
  }) async {
    CityModel? _output;

    if (countryID != null && cityID != null){

      final Object? _cityMap = await Real.readPath(
        path: '${RealColl.zones}/${RealDoc.zones_cities}/$countryID/$cityID',
      );

      final Map<String, dynamic>? _map = Mapper.getMapFromIHLMOO(
        ihlmoo: _cityMap,
      );


      _output = CityModel.decipherCity(
        map: _map,
        fromJSON: true,
        cityID: cityID,
        fromLDB: false,
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<CityModel>> readCitiesX({
    required List<String> citiesIDs,
  }) async {
    final List<CityModel> _output = [];

    if (Lister.checkCanLoop(citiesIDs) == true){

      await Future.wait(<Future>[

        ...List.generate(citiesIDs.length, (index){

          final String _cityID = citiesIDs[index];
          final String? _countryID = CityModel.getCountryIDFromCityID(_cityID);

          return readCityX(
            countryID: _countryID,
            cityID: _cityID,
          ).then((CityModel? _cityModel){

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
  static Future<List<CityModel>> readCountryCitiesX({
    required String countryID,
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
      fromLDB: false,
    );

  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateCity({
    required CityModel newCity
  }) async {

    await createCity(cityModel: newCity);

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteCity({
  required String? cityID,
  }) async {

    if (cityID != null){

      final String? _countryID = CityModel.getCountryIDFromCityID(cityID);

      await Real.deletePath(
          pathWithDocName: '${RealColl.zones}/${RealDoc.zones_cities}/$_countryID/$cityID',
      );

    }

  }
  // -----------------------------------------------------------------------------
}
