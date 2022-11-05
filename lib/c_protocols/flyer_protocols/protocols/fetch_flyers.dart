import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/fire/flyer_fire_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/ldb/flyer_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';

class FetchFlyerProtocols {
  // -----------------------------------------------------------------------------

  const FetchFlyerProtocols();

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerModel> fetchFlyer({
    @required BuildContext context,
    @required String flyerID,
  }) async {

    FlyerModel _flyer = await FlyerLDBOps.readFlyer(flyerID);

    if (_flyer != null){
      // blog('fetchFlyerByID : ($flyerID) FlyerModel FOUND in LDB');
    }

    else {

      _flyer = await FlyerFireOps.readFlyerOps(
        flyerID: flyerID,
      );

      if (_flyer != null){
        // blog('fetchFlyerByID : ($flyerID) FlyerModel FOUND in FIRESTORE and inserted in LDB');
        await FlyerLDBOps.insertFlyer(_flyer);
      }

    }

    // if (_flyer == null){
    // blog('fetchFlyerByID : ($flyerID) FlyerModel NOT FOUND');
    // }

    if (_flyer != null){
      _flyer = _flyer.copyWith(
        zone: await ZoneProtocols.completeZoneModel(
            context: context,
            incompleteZoneModel: _flyer.zone,
        ),
      );
    }

    return _flyer;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<FlyerModel>> fetchFlyers({
    @required BuildContext context,
    @required List<String> flyersIDs,
  }) async {
    // blog('FetchFlyerProtocol.fetchFlyersByIDs : START');

    final List<FlyerModel> _flyers = <FlyerModel>[];

    if (Mapper.checkCanLoopList(flyersIDs)){

      await Future.wait(<Future>[

        ...List.generate(flyersIDs.length, (index){

          return fetchFlyer(
            context: context,
            flyerID: flyersIDs[index],
          ).then((FlyerModel flyer){

            _flyers.add(flyer);

          });

      }),

      ]);

    }

    // blog('FetchFlyerProtocol.fetchFlyersByIDs : END');
    return _flyers;
  }
// -----------------------------------------------------------------------------
}
