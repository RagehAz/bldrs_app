import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/c_protocols/note_protocols/note_events/z_note_events.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/flyer_protocols/provider/flyers_provider.dart';
import 'package:bldrs/c_protocols/flyer_protocols/fire/flyer_fire_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/ldb/flyer_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RenovateFlyerProtocols {
  // -----------------------------------------------------------------------------

  const RenovateFlyerProtocols();

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> renovate({
    @required BuildContext context,
    @required FlyerModel newFlyer,
    @required FlyerModel oldFlyer,
    @required BzModel bzModel,
    @required bool sendFlyerUpdateNoteToItsBz,
    @required bool updateFlyerLocally,
    @required bool resetActiveBz,
  }) async {

    assert(
    (resetActiveBz == true && updateFlyerLocally == true) || (resetActiveBz == false)
    , 'RenovateFlyerProtocols renovate : CAN NOT resetActiveBz IF updateFlyerLocally is false');

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
      await NoteEvent.sendFlyerUpdateNoteToItsBz(
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
        notifyFlyerPro: true,
        resetActiveBz: resetActiveBz,
      );
    }

    blog('RenovateFlyerProtocols.renovate : END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateLocally({
    @required BuildContext context,
    @required FlyerModel flyerModel,
    @required bool notifyFlyerPro,
    @required bool resetActiveBz,
  }) async {
    blog('RenovateFlyerProtocols.updateLocally : START');

    if (flyerModel != null){

      await FlyerLDBOps.insertFlyer(flyerModel);

      final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
      _flyersProvider.updateFlyerInAllProFlyers(
          flyerModel: flyerModel,
          notify: notifyFlyerPro
      );

      if (resetActiveBz == true){
        BzzProvider.resetActiveBz(context);
      }

    }

    blog('RenovateFlyerProtocols.updateLocally : END');
  }
// --------------------
}
