import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/e_db/fire/ops/flyer_ops.dart';
import 'package:bldrs/e_db/ldb/ops/flyer_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// PROTOCOLS ARE SET OF OPS CALLED BY CONTROLLERS TO LAUNCH FIRE OPS AND LDB OPS.

class FlyerProtocol {

  FlyerProtocol();

// -----------------------------------------------------------------------------

  /// CREATE

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> createFlyerByActiveBzProtocol({
    @required BuildContext context,
    @required FlyerModel flyerToPublish,
  }) async {

    final BzModel _bzModel = BzzProvider.proGetActiveBzModel(
      context: context,
      listen: false,
    );
    blog('bz flyers IDs before upload : ${_bzModel.flyersIDs}');

    /// FIRE BASE --------------------------------------
    final Map<String, dynamic> _uploadedFlyerAndBz = await FlyerFireOps.createFlyerOps(
        context: context,
        draftFlyer: flyerToPublish,
        bzModel: _bzModel
    );
    // final BzModel _uploadedBz = _uploadedFlyerAndBz['bz'];
    final FlyerModel _uploadedFlyer = _uploadedFlyerAndBz['flyer'];

    /// LDB --------------------------------------
    await FlyerLDBOps.insertFlyer(_uploadedFlyer);

    /// PRO --------------------------------------
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    _bzzProvider.setActiveBzFlyers(
      flyers: <FlyerModel>[..._bzzProvider.myActiveBzFlyers, _uploadedFlyer],
      notify: false,
    );
    blog('onPublish flyer : myActiveBzFlyers on provider updated');

  }
// -----------------------------------------------------------------------------

/// UPDATE

// ----------------------------------
  static Future<void> updateFlyerProtocol() async {

  }
// -----------------------------------------------------------------------------

/// DELETE

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteSingleFlyerByActiveBzProtocol({
    @required BuildContext context,
    @required FlyerModel flyer,
    @required bool showWaitDialog,
  }) async {

    if (showWaitDialog == true){
      unawaited(WaitDialog.showWaitDialog(
        context: context,
        loadingPhrase: 'Deleting flyer',
        canManuallyGoBack: false,
      ));
    }

    /// DELETE FLYER OPS ON FIREBASE
    final BzModel _bzModel = BzzProvider.proGetActiveBzModel(
      context: context,
      listen: false,
    );

    await FlyerFireOps.deleteFlyerOps(
      context: context,
      flyerModel: flyer,
      bzModel: _bzModel,
      bzFireUpdateOps: true,
    );

    /// DELETE FLYER ON LDB
    await FlyerLDBOps.deleteFlyers(<String>[flyer.id]);

    /// REMOVE FLYER FROM FLYERS PROVIDER
    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
    _flyersProvider.removeFlyerFromProFlyers(
      flyerID: flyer.id,
      notify: true,
    );

    if (showWaitDialog == true){
      WaitDialog.closeWaitDialog(context);
    }

  }
// ----------------------------------
  static Future<void> deleteMultipleFlyersByActiveBzProtocol({
    @required BuildContext context,
    @required List<FlyerModel> flyers,
  }) async {

  }
// -----------------------------------------------------------------------------
}
