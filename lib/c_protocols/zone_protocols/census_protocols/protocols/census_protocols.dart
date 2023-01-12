import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/c_protocols/zone_protocols/census_protocols/ldb/census_ldb_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/census_protocols/real/census_real_ops.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:mapper/mapper.dart';
import 'package:flutter/material.dart';

class CensusProtocols {
  // -----------------------------------------------------------------------------

  const CensusProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------

  // -----------------------------------------------------------------------------

  /// FETCH PLANET CENSUS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CensusModel> fetchPlanetCensus() async {

    CensusModel _output = await CensusLDBOps.readCensus(
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
    @required List<String> countriesIDs,
  }) async {
    final List<CensusModel> _output = [];

    if (Mapper.checkCanLoopList(countriesIDs) == true){

      await Future.wait(<Future>[

        ...List.generate(countriesIDs.length, (index){

          return fetchCountryCensus(
              countryID: countriesIDs[index],
          ).then((CensusModel census){

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

    if (Mapper.checkCanLoopList(_output) == true){

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
  static Future<CensusModel> fetchCountryCensus({
    @required String countryID,
  }) async {
    CensusModel _output;

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
  static Future<CensusModel> refetchCountryCensus({
    @required String countryID,
  }) async {
    CensusModel _output;

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
  /// TASK : TEST ME
  static Future<List<CensusModel>> fetchCitiesCensuses({
    @required List<String> citiesIDs,
  }) async {
    final List<CensusModel> _output = <CensusModel>[];

    if (Mapper.checkCanLoopList(citiesIDs) == true){

      await Future.wait(<Future>[

        ...List.generate(citiesIDs.length, (index){

          return fetchCityCensus(
              cityID: citiesIDs[index],
          ).then((CensusModel census){

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
  /// TASK : TEST ME
  static Future<List<CensusModel>> refetchAllAvailableCitiesOfCountryCensuses({
    @required String countryID,
  }) async {
    List<CensusModel> _output = [];

    if (countryID != null){

      _output = await CensusRealOps.readCitiesOfCountryCensus(
          countryID: countryID,
      );

      if (Mapper.checkCanLoopList(_output) == true){

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
  /// TASK : TEST ME
  static Future<CensusModel> fetchCityCensus({
    @required String cityID,
  }) async {
    CensusModel _output;

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
  /// TASK : TEST ME
  static Future<CensusModel> refetchCityCensus({
    @required String cityID,
  }) async {
    CensusModel _output;

    if (cityID != null){

      await CensusLDBOps.deleteCensus(id: cityID);

      _output = await fetchCityCensus(cityID: cityID);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// FETCH DISTRICTS CENSUSES

  // --------------------
  /// TASK : TEST ME
  static Future<List<CensusModel>> fetchDistrictsCensuses({
    @required List<String> districtsIDs,
  }) async {
    final List<CensusModel> _output = <CensusModel>[];

    if (Mapper.checkCanLoopList(districtsIDs) == true){

      await Future.wait(<Future>[

        ...List.generate(districtsIDs.length, (index){

          return fetchDistrictCensus(
            districtID: districtsIDs[index],
          ).then((CensusModel census){

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
  /// TASK : TEST ME
  static Future<List<CensusModel>> refetchAllAvailableDistrictsOfCityCensuses({
    @required String cityID,
  }) async {
    List<CensusModel> _output = <CensusModel>[];

    if (cityID != null){

      _output = await CensusRealOps.readDistrictsOfCityCensus(
          cityID: cityID
      );

      if (Mapper.checkCanLoopList(_output) == true){

        await CensusLDBOps.insertCensuses(
            censuses: _output,
        );

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// FETCH DISTRICT CENSUS

  // --------------------
  /// TASK : TEST ME
  static Future<CensusModel> fetchDistrictCensus({
    @required String districtID,
  }) async {
    CensusModel _output;

    if (districtID != null){

      _output = await CensusLDBOps.readCensus(
          id: districtID,
      );

      if (_output == null){

        _output = await CensusRealOps.readDistrictCensus(
            districtID: districtID
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
  /// TASK : TEST ME
  static Future<CensusModel> refetchDistrictCensus({
    @required String districtID,
  }) async {
    CensusModel _output;

    if (districtID != null){

      await CensusLDBOps.deleteCensus(id: districtID);

      _output = await fetchDistrictCensus(
          districtID: districtID
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  static Future<void> renovateZoneCensuses({
    @required ZoneModel zoneModel,
  }) async {

  }
  // -----------------------------------------------------------------------------
  void f(){}
}
