

import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/c_protocols/zone_protocols/staging_protocols/ldb/stages_ldb_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/staging_protocols/real/a_countries_stages_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/staging_protocols/real/b_cities_stages_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/staging_protocols/real/b_districts_stages_real_ops.dart';
import 'package:flutter/material.dart';

class StagingProtocols {
  // -----------------------------------------------------------------------------

  const StagingProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  ///
  // -----------------------------------------------------------------------------

  /// FETCH COUNTRIES STAGING

  // --------------------
  ///
  static Future<Staging> fetchCountriesStaging() async {

    Staging _output = await StagingLDBOps.readStaging(
        id: Staging.countriesStagingId,
    );

    if (_output == null){

      _output = await CountriesStagesRealOps.readCountriesStaging();

      if (_output != null){
        await StagingLDBOps.insertStaging(staging: _output,);
      }

    }

    return _output;
  }
  // --------------------
  ///
  static Future<Staging> refetchCountiesStaging() async {

    await StagingLDBOps.deleteStaging(id: Staging.countriesStagingId);

    final Staging _output = await fetchCountriesStaging();

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// FETCH CITIES STAGING

  // --------------------
  ///
  static Future<Staging> fetchCitiesStaging({
    @required String countryID,
  }) async {
    Staging _output;

    if (countryID != null){

      _output = await StagingLDBOps.readStaging(id: countryID,);

      if (_output == null){

        _output = await CitiesStagesRealOps.readCitiesStaging(countryID: countryID,);

        if (_output != null){
          await StagingLDBOps.insertStaging(staging: _output,);
        }

      }

    }

    return _output;
  }
  // --------------------
  ///
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
  ///
  static Future<Staging> fetchDistrictsStaging({
    @required String cityID,
  }) async {
    Staging _output;

    if (cityID != null){

      _output = await StagingLDBOps.readStaging(id: cityID);

      if (_output == null){

        _output = await DistrictsStagesRealOps.readDistrictsStaging(cityID: cityID);

        if (_output != null){
          await StagingLDBOps.insertStaging(staging: _output,);
        }

      }

    }

    return _output;
  }
  // --------------------
  ///
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
  ///
  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------
  ///
  // -----------------------------------------------------------------------------
  void f(){}
}
