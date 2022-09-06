import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/e_db/fire/ops/flyer_fire_ops.dart';
import 'package:bldrs/e_db/ldb/ops/flyer_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
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
        context: context,
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

    return _flyer;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<FlyerModel>> fetchFlyers({
    @required BuildContext context,
    @required List<String> flyersIDs,
  }) async {
    blog('FetchFlyerProtocol.fetchFlyersByIDs : START');

    final List<FlyerModel> _flyers = <FlyerModel>[];

    if (Mapper.checkCanLoopList(flyersIDs)){

      for (final String flyerID in flyersIDs){

        final FlyerModel _flyer = await fetchFlyer(
          context: context,
          flyerID: flyerID,
        );

        if (_flyer != null){

          _flyers.add(_flyer);

        }

      }

    }

    blog('FetchFlyerProtocol.fetchFlyersByIDs : START');
    return _flyers;
  }
// -----------------------------------------------------------------------------
}
