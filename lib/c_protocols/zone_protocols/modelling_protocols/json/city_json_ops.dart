import 'package:basics/bldrs_theme/assets/planet/paths.dart';
import 'package:basics/helpers/classes/files/filers.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/models/phrase_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';

/// => TAMAM
class CityJsonOps{
  // ---------------------------------------------------------------------------

  const CityJsonOps();

  // ---------------------------------------------------------------------------

  /// NOTICE

  // --------------------
  /// country IDs in three letters
  /// countries IDs are like : 'egy' for Egypt, 'usa' for United States of America
  /// USA states are treated as countries
  /// states IDs work as countries IDs
  /// states IDs are like : 'us_al' for Alabama, 'us_ca' for California
  /// so will always call a countryID or stateID as ( countryID )
  // ---------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CityModel?> readCity({
    required String cityID,
  }) async {
    CityModel? _output;

    final String? _countryID = CityModel.getCountryIDFromCityID(cityID);

    if (_countryID != null){

      final Map<String, dynamic>? _countryCities = await _readCountryCitiesJson(
        countryID: _countryID,
      );

      if (_countryCities != null){

        final Map<String, dynamic>? _cityMap = _countryCities[cityID];

        _output  = CityModel(
          cityID: cityID,
          phrases: Phrase.decipherCityJsonMap(
            cityJsonMap: _cityMap,
            cityID: cityID,
          ),
          // position: null,
          // population: 0,
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT : reads Cities From Several Countries
  static Future<List<CityModel>> readCities({
    required List<String> citiesIDs,
  }) async {
    final List<CityModel> _output = [];

    if (Lister.checkCanLoop(citiesIDs) == true){

      final List<String> _countriesIDs = CityModel.getCountriesIDsFromCitiesIDs(
        citiesIDs: citiesIDs,
      );

      for (final String countryID in _countriesIDs){

        final List<String> _countryCitiesIDs = CityModel.getCitiesIDsFromCitiesIDsByCountryID(
          countryID: countryID,
          citiesIDs: citiesIDs,
        );

        final List<CityModel> _citiesOfCountry = await readCountryCities(
          countryID: countryID,
          citiesIDs: _countryCitiesIDs,
        );

        _output.addAll(_citiesOfCountry);

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT : read Cities From One Country
  static Future<List<CityModel>> readCountryCities({
    required String? countryID,
    List<String>? citiesIDs,
  }) async {
    List<CityModel> _output = [];

    if (citiesIDs == null){
      _output = await _readAllCountryCities(
        countryID: countryID,
      );
    }
    else {
      _output = await _readSomeCountryCities(
        countryID: countryID,
        citiesIDs: citiesIDs,
      );
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<CityModel>> _readSomeCountryCities({
    required String? countryID,
    required List<String> citiesIDs,
  }) async {
    final List<CityModel> _output = [];

    if (countryID != null && Lister.checkCanLoop(citiesIDs) == true){

      final Map<String, dynamic>? _countryCities = await _readCountryCitiesJson(
        countryID: countryID,
      );

      if (_countryCities != null){

        for (final String cityID in citiesIDs){

          final Map<String, dynamic> _cityMap = _countryCities[cityID];

          final CityModel _model  = CityModel(
            cityID: cityID,
            phrases: Phrase.decipherCityJsonMap(
              cityJsonMap: _cityMap,
              cityID: cityID,
            ),
            // position: null,
            // population: 0,
          );

          _output.add(_model);

        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<CityModel>> _readAllCountryCities({
    required String? countryID,
  }) async {
    final List<CityModel> _output = [];

    if (countryID != null){

      final Map<String, dynamic>? _countryCities = await _readCountryCitiesJson(
        countryID: countryID,
      );

      if (_countryCities != null){

        final List<String> citiesIDs = _countryCities.keys.toList();

        for (final String cityID in citiesIDs){

          final Map<String, dynamic> _cityMap = _countryCities[cityID];

          final CityModel _model  = CityModel(
            cityID: cityID,
            phrases: Phrase.decipherCityJsonMap(
              cityJsonMap: _cityMap,
              cityID: cityID,
            ),
            // position: null,
            // population: 0,
          );

          _output.add(_model);

        }

      }

    }

    return _output;
  }
  // ---------------------------------------------------------------------------

  /// FOUNDATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>?> _readCountryCitiesJson({
    required String? countryID,
  }) async {
    Map<String, dynamic>? _output;

    if (countryID != null){

      _output = await Filers.readLocalJSON(
        path: WorldZoningPaths.getCountryCitiesJsonFilePath(countryID),
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>?> readCountriesCitiesJsonsMap({
    required List<String> countriesIDs,
  }) async {
    Map<String, dynamic>? _output;

    if (Lister.checkCanLoop(countriesIDs) == true){

      _output = {};

      await Future.wait(<Future>[

        ...List.generate(countriesIDs.length, (index){

          final String _countryID = countriesIDs[index];

          return _readCountryCitiesJson(
            countryID:_countryID,
          ).then((Map<String, dynamic>? citiesMap){

            if (citiesMap != null){
              _output = Mapper.insertPairInMap(
                  map: _output,
                  key: _countryID,
                  value: citiesMap,
                  overrideExisting: true,
              );
            }

          });

        }),

      ]);

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>?> readCountriesCitiesJsonsMapOneByOne({
    required List<String> countriesIDs,
  }) async {
    Map<String, dynamic>? _output;

    if (Lister.checkCanLoop(countriesIDs) == true){

      _output = {};

      for (final String countryID in countriesIDs){

        final Map<String, dynamic>? citiesMap = await _readCountryCitiesJson(
          countryID:countryID,
        );

        if (citiesMap != null){
          _output = Mapper.insertPairInMap(
            map: _output,
            key: countryID,
            value: citiesMap,
            overrideExisting: true,
          );
        }

      }

    }

    return _output;
  }
  // ---------------------------------------------------------------------------

  /// READ POPULATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>?> readCitiesPopulationsJson() async {
    return Filers.readLocalJSON(
      path: WorldZoningPaths.populationsFilePath,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>?> readCitiesPositionsJson() async {
    return Filers.readLocalJSON(
        path: WorldZoningPaths.positionsFilePath,
    );
  }
  // ---------------------------------------------------------------------------
}
