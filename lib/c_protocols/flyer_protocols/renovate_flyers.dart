

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/c_protocols/note_protocols.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/e_db/fire/ops/flyer_ops.dart';
import 'package:bldrs/e_db/ldb/ops/flyer_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RenovateFlyerProtocols {
// -----------------------------------------------------------------------------

  RenovateFlyerProtocols();

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> renovate({
    @required BuildContext context,
    @required FlyerModel newFlyer,
    @required FlyerModel oldFlyer,
    @required BzModel bzModel,
    @required bool sendFlyerUpdateNoteToItsBz,
    @required bool updateFlyerLocally,
  }) async {
    /// NOTES : UPDATE FIRE OPS + SEND NOTE TO BZ
    blog('RenovateFlyerProtocols.renovate : START');

    /// FIRE BASE --------------------------------------
    final FlyerModel _uploadedFlyer = await FlyerFireOps.updateFlyerOps(
        context: context,
        newFlyer: newFlyer,
        oldFlyer: oldFlyer,
        bzModel: bzModel
    );

    if (sendFlyerUpdateNoteToItsBz == true){
      await NoteProtocol.sendFlyerUpdateNoteToItsBz(
        context: context,
        bzModel: bzModel,
        flyerID: _uploadedFlyer.id,
      );
    }

    /// NO NEED TO UPDATE FLYER LOCALLY
    if (updateFlyerLocally == true){
      await updateLocally(
        context: context,
        flyerModel: _uploadedFlyer,
        notify: true,
      );
    }

    blog('RenovateFlyerProtocols.renovate : END');
  }
// ----------------------------------
  static Future<void> updateLocally({
    @required BuildContext context,
    @required FlyerModel flyerModel,
    @required bool notify,
  }) async {
    blog('RenovateFlyerProtocols.updateLocally : START');

    if (flyerModel != null){

      await FlyerLDBOps.insertFlyer(flyerModel);

      final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
      _flyersProvider.updateFlyerInAllProFlyers(
          flyerModel: flyerModel,
          notify: notify
      );

    }

    blog('RenovateFlyerProtocols.updateLocally : END');
  }
}
