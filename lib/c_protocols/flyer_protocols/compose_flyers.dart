import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/e_db/fire/ops/flyer_ops.dart';
import 'package:bldrs/e_db/fire/ops/record_ops.dart';
import 'package:bldrs/e_db/ldb/ops/flyer_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

/*

protocol level ops

 - create -> compose
 - read -> fetch
 - update -> renovate
 - delete -> wipe

 */

class ComposeFlyerProtocol {
// -----------------------------------------------------------------------------

  ComposeFlyerProtocol();

// -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> compose({
    @required BuildContext context,
    @required FlyerModel flyerToPublish,
    @required BzModel bzModel,
  }) async {

    blog('ComposeFlyerProtocol.compose : START');

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

    await RecordRealOps.incrementBzCounter(
      context: context,
      bzID: _uploadedFlyer.bzID,
      field: 'allSlides',
      incrementThis: _uploadedFlyer.slides.length,
    );

    blog('ComposeFlyerProtocol.compose : END');
  }
// -----------------------------------------------------------------------------

}
