import 'package:basics/helpers/classes/files/filers.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';

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

  /// CONSTANTS

  // --------------------
  static const String populationsFilePath = 'assets/zoning/cities_data/populations.json';
  static const String positionsFilePath = 'assets/zoning/cities_data/positions.json';
  static const String citiesFilesDirectory = 'assets/cities';
  // --------------------
  static String getCountryCitiesJsonFilePath(String countryID){
    return '$citiesFilesDirectory/$countryID.json';
  }
  // ---------------------------------------------------------------------------

  /// READ CITIES

  // --------------------
  /// TASK : TEST ME
  static Future<Map<String, dynamic>?> readCountryCitiesJson({
    required String? countryID,
  }) async {
    Map<String, dynamic>? _output;

    if (countryID != null){

      _output = await Filers.readLocalJSON(
        path: getCountryCitiesJsonFilePath(countryID),
      );

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<Map<String, dynamic>?> readCountriesCitiesJsonsMap({
    required List<String> countriesIDs,
  }) async {
    Map<String, dynamic>? _output;

    if (Mapper.checkCanLoopList(countriesIDs) == true){

      _output = {};

      await Future.wait(<Future>[

        ...List.generate(countriesIDs.length, (index){

          final String _countryID = countriesIDs[index];

          return readCountryCitiesJson(
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
  /// TASK : TEST ME
  static Future<Map<String, dynamic>?> readCountriesCitiesJsonsMapOneByOne({
    required List<String> countriesIDs,
  }) async {
    Map<String, dynamic>? _output;

    if (Mapper.checkCanLoopList(countriesIDs) == true){

      _output = {};

      for (final String countryID in countriesIDs){

        final Map<String, dynamic>? citiesMap = await readCountryCitiesJson(
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
  /// TASK : TEST ME
  static Future<Map<String, dynamic>?> readCitiesPopulationsJson() async {
    return Filers.readLocalJSON(
      path: populationsFilePath,
    );
  }
  // --------------------
  /// TASK : TEST ME
  static Future<Map<String, dynamic>?> readCitiesPositionsJson() async {
    return Filers.readLocalJSON(
        path: positionsFilePath,
    );
  }
  // ---------------------------------------------------------------------------
}
