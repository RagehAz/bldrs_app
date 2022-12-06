import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/c_protocols/census_protocols/protocols/census_protocols.dart';
import 'package:bldrs/c_protocols/census_protocols/real/census_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/real/staging/a_countries_stages_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/real/staging/b_cities_stages_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/real/staging/b_districts_stages_real_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
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


class ZoneStageLeveller {

  // -----------------------------------------------------------------------------

  const ZoneStageLeveller();

  // -----------------------------------------------------------------------------
  static Future<void> levelUpZonesOnComposeBzFromHiddenToInactive({
    @required BzModel bzModel,
  }) async {

    /// NOTE : WHEN BZ IS COMPOSED
    /// ALL BZ ZONES SHOULD BECOME INACTIVE

    if (bzModel != null){

      final ZoneStages _countriesStage = await CountriesStagesRealOps.readCountriesStages();
      final ZoneStages _citiesStage = await CitiesStagesRealOps.readCitiesStages(
        countryID: bzModel.zone.countryID,
      );
      final ZoneStages _districtsStage = await DistrictsStagesRealOps.readDistrictsStages(
        cityID: bzModel.zone.cityID,
      );

      final StageType _countryStage = _countriesStage?.getStageTypeByID(bzModel.zone.countryID);
      final StageType _cityStage = _citiesStage?.getStageTypeByID(bzModel.zone.cityID);
      final StageType _districtStage = _districtsStage?.getStageTypeByID(bzModel.zone.districtID);

      blog('countryStage : $_countryStage | cityStage : $_cityStage | districtStage : $_districtStage');

      /// LEVEL UP COUNTRY
      if (_countryStage == StageType.emptyStage){

      }

      /// LEVEL UP CITY

      /// LEVEL UP DISTRICT

    }

    else {
      blog('fromHiddenToInactiveOnComposeBz : no bzModel given here');
    }

  }
  // -----------------------------------------------------------------------------
  static Future<void> levelUpZone({
    @required ZoneModel zoneModel,
  }) async {


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
  static Future<void> _levelUpCountry({
    @required String countryID
  }) async {

    if (countryID != null){

      final ZoneStages _countriesStage = await CountriesStagesRealOps.readCountriesStages();

      final StageType _countryStageType = _countriesStage?.getStageTypeByID(countryID);

      /// WHEN PUBLIC STAGE NO LEVEL UP WILL BE AVAILABLE
      if (_countryStageType != StageType.publicStage){

        final CensusModel _countryCensus = await CensusRealOps.readCountryCensus(
            countryID: countryID
        );

        /// WHEN IS EMPTY STAGE
        if (_countryStageType == StageType.emptyStage){

        }

        /// WHEN IS BZZ STAGE
        else if (_countryStageType == StageType.bzzStage){

        }

        /// WHEN IS FLYERS STAGE
        else if (_countryStageType == StageType.flyersStage){

        }




      }

    }

  }
  // --------------------
  static Future<void> _levelUpCity({
    @required String cityID
  }) async {

  }
  // --------------------
  static Future<void> _levelUpDistrict({
    @required String districtID,
  }) async {

  }
  // -----------------------------------------------------------------------------
  static bool shouldLevelEmptyStageToBzzStage(){

  }
  static bool shouldLevelBzzStageToFlyersStage(){

  }
  static bool shouldLevelFlyersStageToPublicStage(){

  }
  // -----------------------------------------------------------------------------
  void f(){}
}
