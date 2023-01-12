import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/d_zone/c_city/district_model.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/real/d_district_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/staging_protocols/ldb/stages_ldb_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/staging_protocols/real/staging_real_ops.dart';
import 'package:mapper/mapper.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class StagingProtocols {
  // -----------------------------------------------------------------------------

  const StagingProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Staging> resetDistrictsStaging({
    @required String cityID,
  }) async {

    Staging _stages;

    if (cityID != null){

      final List<DistrictModel> _districts = await DistrictRealOps.readCityDistricts(
        cityID: cityID,
      );

      if (Mapper.checkCanLoopList(_districts) == false){
        blog('resetDistrictsStages : no districts found for city ( $cityID )');
      }

      else {


        final List<String> _districtsIDs = DistrictModel.getDistrictsIDs(_districts);
        _stages = Staging(
            id: cityID,
            emptyStageIDs: _districtsIDs,
            bzzStageIDs: null,
            flyersStageIDs: null,
            publicStageIDs: null
        );

        await StagingProtocols.renovateDistrictsStaging(
          newStaging: _stages,
        );

      }

    }

    return _stages;
  }
  // -----------------------------------------------------------------------------

  /// FETCH COUNTRIES STAGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Staging> fetchCountriesStaging() async {

    Staging _output = await StagingLDBOps.readStaging(
        id: Staging.countriesStagingId,
    );

    if (_output == null){

      _output = await StagingRealOps.readCountriesStaging();

      if (_output != null){
        await StagingLDBOps.insertStaging(staging: _output,);
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Staging> refetchCountiesStaging() async {

    await StagingLDBOps.deleteStaging(id: Staging.countriesStagingId);

    final Staging _output = await fetchCountriesStaging();

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// FETCH CITIES STAGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Staging> fetchCitiesStaging({
    @required String countryID,
  }) async {
    Staging _output;

    if (countryID != null){

      _output = await StagingLDBOps.readStaging(id: countryID,);

      if (_output == null){

        _output = await StagingRealOps.readCitiesStaging(countryID: countryID,);

        if (_output != null){
          await StagingLDBOps.insertStaging(staging: _output,);
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Staging> refetchCitiesStaging({
    @required String countryID,
  }) async {
    Staging _output;

    if (countryID != null){

      await StagingLDBOps.deleteStaging(id: countryID,);

      _output = await fetchCitiesStaging(countryID: countryID,);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// FETCH CITIES STAGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Staging> fetchDistrictsStaging({
    @required String cityID,
  }) async {
    Staging _output;

    if (cityID != null){

      _output = await StagingLDBOps.readStaging(id: cityID);

      if (_output == null){

        _output = await StagingRealOps.readDistrictsStaging(cityID: cityID);

        if (_output != null){
          await StagingLDBOps.insertStaging(staging: _output,);
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Staging> refetchDistrictsStaging({
    @required String cityID,
  }) async {
    Staging _output;

    if (cityID != null){

      await StagingLDBOps.deleteStaging(id: cityID);

      _output = await fetchDistrictsStaging(cityID: cityID);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  /// TASK : TEST ME
  static Future<void> renovateCountriesStaging({
    @required Staging newStaging,
  }) async {

    if (newStaging != null){

      await Future.wait(<Future>[

        /// REAL
        StagingRealOps.updateCountriesStaging(
          newStaging: newStaging,
        ),

        /// LDB
        StagingLDBOps.insertStaging(
          staging: newStaging,
        ),

      ]);

    }

  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> renovateCitiesStaging({
    @required Staging newStaging,
  }) async {

    if (newStaging != null){

      await Future.wait(<Future>[

        /// REAL
        StagingRealOps.updateCitiesStaging(
            citiesStages: newStaging,
        ),

        /// LDB
        StagingLDBOps.insertStaging(
            staging: newStaging,
        ),

      ]);

    }

  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> renovateDistrictsStaging({
    @required Staging newStaging,
  }) async {

    if (newStaging != null){

      await Future.wait(<Future>[

        /// REAL
        StagingRealOps.updateDistrictsStaging(
          districtsStaging: newStaging,
        ),

        /// LDB
        StagingLDBOps.insertStaging(
          staging: newStaging,
        ),

      ]);

    }

  }
  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------
  /// TASK : TEST ME
  static Future<void> removeCityFromStages({
    @required String cityID,
  }) async {

    if (cityID != null){

      final Staging _oldCitiesStaging = await StagingProtocols.fetchCitiesStaging(
        countryID: CityModel.getCountryIDFromCityID(cityID),
      );

      if (_oldCitiesStaging != null){

        final Staging _new = Staging.removeIDFromStaging(
          staging: _oldCitiesStaging,
          id: cityID,
        );

        await StagingProtocols.renovateCitiesStaging(
          newStaging: _new,
        );

      }



    }

  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> removeDistrictFromStages({
    @required String districtID,
  }) async {

    if (districtID != null){

      final Staging _oldDistrictsStaging = await fetchDistrictsStaging(
          cityID: DistrictModel.getCityIDFromDistrictID(districtID),
      );

      if (_oldDistrictsStaging != null){

        final Staging _new = Staging.removeIDFromStaging(
          staging: _oldDistrictsStaging,
          id: districtID,
        );

        await StagingProtocols.renovateDistrictsStaging(
          newStaging: _new,
        );

      }

    }

  }
  // -----------------------------------------------------------------------------
}
