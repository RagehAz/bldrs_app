import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/c_protocols/zone_protocols/real/staging/a_countries_stages_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/real/staging/b_cities_stages_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/real/staging/b_districts_stages_real_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

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
      if (_countryStage == StageType.hidden){

      }

      /// LEVEL UP CITY

      /// LEVEL UP DISTRICT

    }

    else {
      blog('fromHiddenToInactiveOnComposeBz : no bzModel given here');
    }

  }
  // -----------------------------------------------------------------------------
}
