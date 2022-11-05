import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/c_protocols/flyer_protocols/fire/flyer_fire_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/ldb/flyer_ldb_ops.dart';
import 'package:bldrs/c_protocols/bz_protocols/real/bz_record_real_ops.dart';
import 'package:bldrs/c_protocols/chain_protocols/real/city_phids_real_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

/*

protocol level ops

 - create -> compose
 - read -> fetch
 - update -> renovate
 - delete -> wipe

 */

class ComposeFlyerProtocols {
  // -----------------------------------------------------------------------------

  const ComposeFlyerProtocols();

  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> compose({
    @required BuildContext context,
    @required FlyerModel flyerToPublish,
    @required BzModel bzModel,
  }) async {
    blog('ComposeFlyerProtocol.compose : START');

    /// TASK : FIX FLYER ID ISSUE BEFORE UPLOAD AND UPDATE ALL SLIDES PATHS

    /// FIRE BASE --------------------------------------
    final Map<String, dynamic> _uploadedFlyerAndBz = await FlyerFireOps.createFlyerOps(
        context: context,
        draftFlyer: flyerToPublish,
        bzModel: bzModel
    );
    // final BzModel _uploadedBz = _uploadedFlyerAndBz['bz'];
    final FlyerModel _uploadedFlyer = _uploadedFlyerAndBz['flyer'];

    /// LDB --------------------------------------
    await FlyerLDBOps.insertFlyer(_uploadedFlyer);

    /// NOTE : no proFlyerOps needed, bzModel will update and stream will rebuild active bz flyers

    await BzRecordRealOps.incrementBzCounter(
      bzID: _uploadedFlyer.bzID,
      field: 'allSlides',
      incrementThis: _uploadedFlyer.slides.length,
    );

    await CityPhidsRealOps.incrementFlyerCityChainUsage(
        context: context,
        flyerModel: _uploadedFlyer,
        isIncrementing: true
    );

    blog('ComposeFlyerProtocol.compose : END');
  }
  // -----------------------------------------------------------------------------
}
