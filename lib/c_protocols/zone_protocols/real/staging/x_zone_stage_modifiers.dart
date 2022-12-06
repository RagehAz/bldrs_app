import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/d_zone/c_city/district_model.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/c_protocols/census_protocols/real/census_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/real/staging/a_countries_stages_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/real/staging/b_cities_stages_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/real/staging/b_districts_stages_real_ops.dart';
import 'package:flutter/material.dart';

/*

when to level up a zone

  --------------------------------------

  - emptyStage ---> bzzStage
    => when a user create a new bz on the zone
    => Census.totalBzzCount = 1

  - emptyStage <--- bzzStage
    => Census.totalBzzCount = 0

  --------------------------------------

  - bzzStage ---> flyersStage
    => Census.totalFlyersCount >= 100

  - bzzStage <--- flyersStage
    => Census.totalFlyersCount = 0

  --------------------------------------

  - flyersStage ---> publicStage
    => Census.totalFlyersCount >= 500

  - flyersStage <--- publicStage
    => Census.totalFlyersCount < 500

  --------------------------------------

*/


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
  /// TASK : TEST ME
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
  /// TASK : TEST ME
  static Future<void> _levelUpCountry({
    @required String countryID,
  }) async {

    /// NOTE : THIS METHOD IS CALLED AFTER UPDATING CENSUS

    if (countryID != null){

      final ZoneStages _countriesStage = await CountriesStagesRealOps.readCountriesStages();
      final StageType _countryStageType = _countriesStage?.getStageTypeByID(countryID);

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
              await ZoneProtocols.updateCountryStage(
                countryID: countryID,
                newType: StageType.bzzStage,
              );
            }

          }
          // -------------------->
          /// WHEN IS BZZ STAGE
          else if (_countryStageType == StageType.bzzStage){

            if (_shouldLevelBzzToFlyersStage(_countryCensus) == true){
              await ZoneProtocols.updateCountryStage(
                countryID: countryID,
                newType: StageType.flyersStage,
              );
            }

          }
          // -------------------->
          /// WHEN IS FLYERS STAGE
          else if (_countryStageType == StageType.flyersStage){

            if (_shouldLevelFlyersToPublicStage(_countryCensus) == true){
              await ZoneProtocols.updateCountryStage(
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
  /// TASK : TEST ME
  static Future<void> _levelUpCity({
    @required String cityID,
  }) async {

    /// NOTE : THIS METHOD IS CALLED AFTER UPDATING CENSUS

    if (cityID != null){

      final String _countryID = CityModel.getCountryIDFromCityID(cityID);
      final ZoneStages _citiesStages = await CitiesStagesRealOps.readCitiesStages(countryID: _countryID);
      final StageType _cityStageType = _citiesStages?.getStageTypeByID(cityID);

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
              await ZoneProtocols.updateCityStage(
                cityID: cityID,
                newType: StageType.bzzStage,
              );
            }

          }
          // -------------------->
          /// WHEN IS BZZ STAGE
          else if (_cityStageType == StageType.bzzStage){

            if (_shouldLevelBzzToFlyersStage(_cityCensus) == true){
              await ZoneProtocols.updateCityStage(
                cityID: cityID,
                newType: StageType.flyersStage,
              );
            }

          }
          // -------------------->
          /// WHEN IS FLYERS STAGE
          else if (_cityStageType == StageType.flyersStage){

            if (_shouldLevelFlyersToPublicStage(_cityCensus) == true){
              await ZoneProtocols.updateCityStage(
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
  static Future<void> _levelUpDistrict({
    @required String districtID,
  }) async {

    /// NOTE : THIS METHOD IS CALLED AFTER UPDATING CENSUS

    if (districtID != null){

      final String _cityID = DistrictModel.getCityIDFromDistrictID(districtID);
      final ZoneStages _districtsStages = await DistrictsStagesRealOps.readDistrictsStages(cityID: _cityID);
      final StageType _districtStageType = _districtsStages?.getStageTypeByID(districtID);

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
              await ZoneProtocols.updateDistrictStage(
                districtID: districtID,
                newType: StageType.bzzStage,
              );
            }

          }
          // -------------------->
          /// WHEN IS BZZ STAGE
          else if (_districtStageType == StageType.bzzStage){

            if (_shouldLevelBzzToFlyersStage(_districtCensus) == true){
              await ZoneProtocols.updateDistrictStage(
                districtID: districtID,
                newType: StageType.flyersStage,
              );
            }

          }
          // -------------------->
          /// WHEN IS FLYERS STAGE
          else if (_districtStageType == StageType.flyersStage){

            if (_shouldLevelFlyersToPublicStage(_districtCensus) == true){
              await ZoneProtocols.updateDistrictStage(
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
  /// TASK : TEST ME
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
  /// TASK : TEST ME
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
  /// TASK : TEST ME
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