import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/x_dashboard/zzz_exotic_methods/exotic_methods.dart';
import 'package:flutter/material.dart';

class ExoticCensus {
  // -----------------------------------------------------------------------------

  const ExoticCensus();

  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  static const String _realDocName = 'app/all_censuses';
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _updateAllCensusForDBCountOps({
    @required Map<String, dynamic> map,
    @required ZoneModel zoneModel,
  }) async {

    if (map != null && zoneModel != null){

      Map<String, dynamic> _map = Mapper.cleanNullPairs(map);
      _map = CensusModel.completeMapForIncrementation(_map);

      await Future.wait(<Future>[

        /// UPDATE PLANET
        Real.updateDoc(
          collName: _realDocName,
          docName: RealDoc.statistics_planet,
          map: _map,
        ),

        /// UPDATE COUNTRY
        if (zoneModel.countryID != null)
          Real.updateDoc(
            collName: _realDocName,
            docName: '${RealDoc.statistics_countries}/${zoneModel.countryID}',
            map: _map,
          ),

        /// UPDATE CITY
        if (zoneModel.countryID != null && zoneModel.cityID != null)
          Real.updateDoc(
            collName: _realDocName,
            docName: '${RealDoc.statistics_cities}/${zoneModel.countryID}/${zoneModel.cityID}',
            map: _map,
          ),

        /// UPDATE DISTRICT
        if (zoneModel.countryID != null && zoneModel.cityID != null && zoneModel.districtID != null)
          Real.updateDoc(
            collName: _realDocName,
            docName: '${RealDoc.statistics_districts}/${zoneModel.countryID}/${zoneModel.cityID}/${zoneModel.districtID}',
            map: _map,
          ),

      ]);

    }

  }
  // -----------------------------------------------------------------------------
  /// WORKS GOOD
  static Future<void> scanEntireDatabaseToCreateCensuses() async {

    /// SUPER FUCKING DANGEROUS
    ///
    await ExoticMethods.readAllUserModels(
      limit: 100,
      onRead: (int index, UserModel user) async {

        /// INCREMENT USER CENSUS
        await _updateAllCensusForDBCountOps(
          zoneModel: user.zone,
          map: CensusModel.createUserCensusMap(
            userModel: user,
            isIncrementing: true,
          ),
        );

        blog('onReadUser index: $index, done');


      },
    );

    await ExoticMethods.readAllBzzModels(
      limit: 100,
      onRead: (int index, BzModel bz) async {

        /// INCREMENT USER CENSUS
        await _updateAllCensusForDBCountOps(
          zoneModel: bz.zone,
          map: CensusModel.createBzCensusMap(
            bzModel: bz,
            isIncrementing: true,
          ),
        );

      },
    );

    await ExoticMethods.readAllFlyers(
      limit: 200,
      onRead: (int index, FlyerModel flyer) async {

        /// INCREMENT FLYER CENSUS
        await _updateAllCensusForDBCountOps(
          zoneModel: flyer.zone,
          map: CensusModel.createFlyerCensusMap(
            flyerModel: flyer,
            isIncrementing: true,
          ),
        );

        blog('onReadFlyer index: $index, done');

      },
    );

  }
  // -----------------------------------------------------------------------------
}
