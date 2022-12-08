import 'package:bldrs/a_models/d_zone/b_country/country_model.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/ldb/a_country_ldb_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/real/a_country_real_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class CountryProtocols {
  // -----------------------------------------------------------------------------

  const CountryProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  /// => COUNTRIES ARE HARD CODED IN (allFLags)
  // -----------------------------------------------------------------------------

  /// FETCH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CountryModel> fetchCountry({
    @required String countryID,
  }) async {

    CountryModel _output;

    if (countryID != null){

      _output = await CountryLDBOps.readCountry(countryID);

      if (_output != null){
        // blog('fetchCountry : ($countryID) CountryModel FOUND in LDB');
      }

      else {

        _output = await CountryRealOps.readCountry(
          countryID: countryID,
        );

        if (_output != null){
          // blog('fetchCountry : ($countryID) CountryModel FOUND in FIRESTORE and inserted in LDB');

          await CountryLDBOps.insertCountry(_output);

        }

      }

      // if (_output == null){
      //   blog('fetchCountry : ($countryID) CountryModel NOT FOUND');
      // }


    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CountryModel> refetchCountry({
    @required String countryID,
  }) async {
    CountryModel _output;

    if (countryID != null){

      await CountryLDBOps.deleteCountry(countryID);

      _output = await fetchCountry(countryID: countryID);

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<CountryModel>> fetchCountries({
    @required List<String> countriesIDs,
  }) async {
    final List<CountryModel> _output = <CountryModel>[];

    if (Mapper.checkCanLoopList(countriesIDs) == true){

      await Future.wait(<Future>[

        ...List.generate(countriesIDs.length, (index){

          return fetchCountry(
            countryID: countriesIDs[index],
          ).then((CountryModel country){
            if (country != null){
              _output.add(country);
            }
          });

        }),

      ]);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
/// => COUNTRIES ARE HARD CODED IN (allFLags)
  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------
/// => COUNTRIES ARE HARD CODED IN (allFLags)
  // -----------------------------------------------------------------------------
}
