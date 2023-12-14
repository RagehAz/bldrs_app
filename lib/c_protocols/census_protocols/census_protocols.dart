import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:bldrs/a_models/g_statistics/census/census_model.dart';
import 'package:bldrs/c_protocols/census_protocols/census_ldb_ops.dart';
import 'package:bldrs/c_protocols/census_protocols/census_real_ops.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
/// => TAMAM
class CensusProtocols {
  // -----------------------------------------------------------------------------

  const CensusProtocols();

  // -----------------------------------------------------------------------------

  /// FETCH PLANET CENSUS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CensusModel?> fetchPlanetCensus() async {

    CensusModel? _output = await CensusLDBOps.readCensus(
        id: RealDoc.statistics_planet,
    );

    if (_output == null){

      _output = await CensusRealOps.readPlanetCensus();

      if (_output != null){

          await CensusLDBOps.insertCensus(
              census: _output,
          );

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// FETCH COUNTRIES CENSUSES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<CensusModel>> fetchCountriesCensusesByIDs({
    required List<String>? countriesIDs,
  }) async {
    final List<CensusModel> _output = [];

    if (Lister.checkCanLoopList(countriesIDs) == true){

      await Future.wait(<Future>[

        ...List.generate(countriesIDs!.length, (index){

          return fetchCountryCensus(
              countryID: countriesIDs[index],
          ).then((CensusModel? census){

            if (census != null){
              _output.add(census);
            }
          });

        }),

      ]);

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<CensusModel>> refetchAllAvailableCountriesCensuses() async {

    final List<CensusModel> _output = await CensusRealOps.readAllCountriesCensuses();

    if (Lister.checkCanLoopList(_output) == true){

      await CensusLDBOps.insertCensuses(
        censuses: _output,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// FETCH COUNTRY CENSUS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CensusModel?> fetchCountryCensus({
    required String? countryID,
  }) async {
    CensusModel? _output;

    if (countryID != null){

      _output = await CensusLDBOps.readCensus(
          id: countryID,
      );

      if (_output == null){

        _output = await CensusRealOps.readCountryCensus(
            countryID: countryID,
        );

        if (_output != null){

          await CensusLDBOps.insertCensus(
            census: _output,
          );

        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CensusModel?> refetchCountryCensus({
    required String? countryID,
  }) async {
    CensusModel? _output;

    if (countryID != null){

      await CensusLDBOps.deleteCensus(id: countryID);

      _output = await fetchCountryCensus(
          countryID: countryID,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// FETCH CITIES CENSUSES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<CensusModel>> fetchCitiesCensuses({
    required List<String>? citiesIDs,
  }) async {
    final List<CensusModel> _output = <CensusModel>[];

    if (Lister.checkCanLoopList(citiesIDs) == true){

      await Future.wait(<Future>[

        ...List.generate(citiesIDs!.length, (index){

          return fetchCityCensus(
              cityID: citiesIDs[index],
          ).then((CensusModel? census){

            if (census != null){
              _output.add(census);
            }

          });

        }),

      ]);

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<CensusModel>> refetchAllAvailableCitiesOfCountryCensuses({
    required String? countryID,
  }) async {
    List<CensusModel> _output = [];

    if (countryID != null){

      _output = await CensusRealOps.readCitiesOfCountryCensus(
          countryID: countryID,
      );

      if (Lister.checkCanLoopList(_output) == true){

        await CensusLDBOps.insertCensuses(
            censuses: _output,
        );

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// FETCH CITY CENSUS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CensusModel?> fetchCityCensus({
    required String? cityID,
  }) async {
    CensusModel? _output;

    if (cityID != null){

      _output = await CensusLDBOps.readCensus(id: cityID);

      if (_output == null){

        _output = await CensusRealOps.readCityCensus(
            cityID: cityID,
        );

        if (_output != null){

          await CensusLDBOps.insertCensus(
              census: _output,
          );

        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CensusModel?> refetchCityCensus({
    required String? cityID,
  }) async {
    CensusModel? _output;

    if (cityID != null){

      await CensusLDBOps.deleteCensus(id: cityID);

      _output = await fetchCityCensus(cityID: cityID);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
