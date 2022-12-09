import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/d_zone/c_city/district_model.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/c_protocols/zone_protocols/census_protocols/real/census_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/staging_protocols/real/a_countries_stages_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/staging_protocols/real/b_cities_stages_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/staging_protocols/real/b_districts_stages_real_ops.dart';
import 'package:flutter/material.dart';

/*

when to level up a zone

  --------------------------------------

  - emptyStage ---> bzzStage
    => when a user create a new bz on the zone
    => Census.totalBzzCount = 1

  --------------------------------------

  - bzzStage ---> flyersStage
    => Census.totalFlyersCount >= 100

  --------------------------------------

  - flyersStage ---> publicStage
    => Census.totalFlyersCount >= 500

  --------------------------------------

*/

/// => TAMAM
class ZoneLeveller {
    // -----------------------------------------------------------------------------

  const ZoneLeveller();

  // -----------------------------------------------------------------------------
  static const int minBzzToGoFromEmptyToBzzStage = 0;
  static const int minFlyersToGoFromBzzToFlyersStage = 100;
  static const int minFlyersToGoFromFlyersToPublicStage = 500;
  // -----------------------------------------------------------------------------

  /// LEVELLERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> levelUpZone({
    @required ZoneModel zoneModel,
  }) async {

    /// NOTE : THIS METHOD IS CALLED AFTER UPDATING CENSUS

    if (zoneModel != null){

      await Future.wait(<Future>[

        _levelUpCountry(
          countryID: zoneModel.countryID,
        ),

        _levelUpCity(
          cityID: zoneModel.cityID,
        ),

        _levelUpDistrict(
          districtID: zoneModel.districtID,
        ),

      ]);

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _levelUpCountry({
    @required String countryID,
  }) async {

    /// NOTE : THIS METHOD IS CALLED AFTER UPDATING CENSUS

    if (countryID != null){

      final Staging _countriesStage = await CountriesStagesRealOps.readCountriesStaging();
      final StageType _countryStageType = _countriesStage?.getTypeByID(countryID);

      /// WHEN PUBLIC STAGE NO LEVEL UP WILL BE AVAILABLE
      if (_countryStageType != null && _countryStageType != StageType.publicStage){

        final CensusModel _countryCensus = await CensusRealOps.readCountryCensus(
            countryID: countryID,
        );

        if (_countryCensus != null){
          // -------------------->
          /// WHEN IS EMPTY STAGE
          if (_countryStageType == StageType.emptyStage){

            /// LEVEL UP COUNTRY ON BZ COMPOSE WHEN CENSUS IS ZERO
            if (_shouldLevelEmptyToBzzStage(_countryCensus) == true){
              await ZoneProtocols.updateCountryStageType(
                countryID: countryID,
                newType: StageType.bzzStage,
              );
            }

          }
          // -------------------->
          /// WHEN IS BZZ STAGE
          else if (_countryStageType == StageType.bzzStage){

            if (_shouldLevelBzzToFlyersStage(_countryCensus) == true){
              await ZoneProtocols.updateCountryStageType(
                countryID: countryID,
                newType: StageType.flyersStage,
              );
            }

          }
          // -------------------->
          /// WHEN IS FLYERS STAGE
          else if (_countryStageType == StageType.flyersStage){

            if (_shouldLevelFlyersToPublicStage(_countryCensus) == true){
              await ZoneProtocols.updateCountryStageType(
                countryID: countryID,
                newType: StageType.publicStage,
              );
            }

          }
          // -------------------->
        }

      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _levelUpCity({
    @required String cityID,
  }) async {

    /// NOTE : THIS METHOD IS CALLED AFTER UPDATING CENSUS

    if (cityID != null){

      final String _countryID = CityModel.getCountryIDFromCityID(cityID);
      final Staging _citiesStages = await CitiesStagesRealOps.readCitiesStaging(countryID: _countryID);
      final StageType _cityStageType = _citiesStages?.getTypeByID(cityID);

      /// WHEN PUBLIC STAGE NO LEVEL UP WILL BE AVAILABLE
      if (_cityStageType != null && _cityStageType != StageType.publicStage){

        final CensusModel _cityCensus = await CensusRealOps.readCityCensus(
          cityID: cityID,
        );

        if (_cityCensus != null){
          // -------------------->
          /// WHEN IS EMPTY STAGE
          if (_cityStageType == StageType.emptyStage){

            /// LEVEL UP COUNTRY ON BZ COMPOSE WHEN CENSUS IS ZERO
            if (_shouldLevelEmptyToBzzStage(_cityCensus) == true){
              await ZoneProtocols.updateCityStageType(
                cityID: cityID,
                newType: StageType.bzzStage,
              );
            }

          }
          // -------------------->
          /// WHEN IS BZZ STAGE
          else if (_cityStageType == StageType.bzzStage){

            if (_shouldLevelBzzToFlyersStage(_cityCensus) == true){
              await ZoneProtocols.updateCityStageType(
                cityID: cityID,
                newType: StageType.flyersStage,
              );
            }

          }
          // -------------------->
          /// WHEN IS FLYERS STAGE
          else if (_cityStageType == StageType.flyersStage){

            if (_shouldLevelFlyersToPublicStage(_cityCensus) == true){
              await ZoneProtocols.updateCityStageType(
                cityID: cityID,
                newType: StageType.publicStage,
              );
            }

          }
          // -------------------->
        }

      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _levelUpDistrict({
    @required String districtID,
  }) async {

    /// NOTE : THIS METHOD IS CALLED AFTER UPDATING CENSUS

    if (districtID != null){

      final String _cityID = DistrictModel.getCityIDFromDistrictID(districtID);
      final Staging _districtsStages = await DistrictsStagesRealOps.readDistrictsStaging(cityID: _cityID);
      final StageType _districtStageType = _districtsStages?.getTypeByID(districtID);

      /// WHEN PUBLIC STAGE NO LEVEL UP WILL BE AVAILABLE
      if (_districtStageType != null && _districtStageType != StageType.publicStage){

        final CensusModel _districtCensus = await CensusRealOps.readDistrictCensus(
          districtID: districtID,
        );

        if (_districtCensus != null){
          // -------------------->
          /// WHEN IS EMPTY STAGE
          if (_districtStageType == StageType.emptyStage){

            /// LEVEL UP COUNTRY ON BZ COMPOSE WHEN CENSUS IS ZERO
            if (_shouldLevelEmptyToBzzStage(_districtCensus) == true){
              await ZoneProtocols.updateDistrictStageType(
                districtID: districtID,
                newType: StageType.bzzStage,
              );
            }

          }
          // -------------------->
          /// WHEN IS BZZ STAGE
          else if (_districtStageType == StageType.bzzStage){

            if (_shouldLevelBzzToFlyersStage(_districtCensus) == true){
              await ZoneProtocols.updateDistrictStageType(
                districtID: districtID,
                newType: StageType.flyersStage,
              );
            }

          }
          // -------------------->
          /// WHEN IS FLYERS STAGE
          else if (_districtStageType == StageType.flyersStage){

            if (_shouldLevelFlyersToPublicStage(_districtCensus) == true){
              await ZoneProtocols.updateDistrictStageType(
                districtID: districtID,
                newType: StageType.publicStage,
              );
            }

          }
          // -------------------->
        }

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool _shouldLevelEmptyToBzzStage(CensusModel census){

    if (
        census != null &&
        census.totalBzz > minBzzToGoFromEmptyToBzzStage
    ){
      return true;
    }

    else {
      return false;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool _shouldLevelBzzToFlyersStage(CensusModel census){

    if (
        census != null &&
        census.totalFlyers >= minFlyersToGoFromBzzToFlyersStage
    ){
      return true;
    }

    else {
      return false;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool _shouldLevelFlyersToPublicStage(CensusModel census){

    if (
        census != null &&
        census.totalFlyers >= minFlyersToGoFromFlyersToPublicStage
    ){
      return true;
    }

    else {
      return false;
    }

  }
  // -----------------------------------------------------------------------------
}
