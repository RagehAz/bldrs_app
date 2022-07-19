import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/c_protocols/note_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/e_db/fire/ops/flyer_ops.dart';
import 'package:bldrs/e_db/ldb/ops/bz_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/flyer_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// PROTOCOLS ARE SET OF OPS CALLED BY CONTROLLERS TO LAUNCH ( FIRE - LDB - PRO ) OPS.

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

    blog('FlyerProtocol.createFlyerByActiveBzProtocol : START');

    final BzModel _bzModel = BzzProvider.proGetActiveBzModel(
      context: context,
      listen: false,
    );

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

    blog('FlyerProtocol.createFlyerByActiveBzProtocol : END');

  }
// -----------------------------------------------------------------------------

/// UPDATE

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateFlyerByActiveBzProtocol({
    @required BuildContext context,
    @required FlyerModel flyerToPublish,
    @required FlyerModel oldFlyer,
  }) async {

    blog('FlyerProtocol.updateFlyerByActiveBzProtocol : START');

    final BzModel _bzModel = BzzProvider.proGetActiveBzModel(
      context: context,
      listen: false,
    );
    blog('FlyerProtocol.updateFlyerByActiveBzProtocol : bz flyers IDs before upload : ${_bzModel.flyersIDs}');

    /// FIRE BASE --------------------------------------
    final FlyerModel _uploadedFlyer = await FlyerFireOps.updateFlyerOps(
        context: context,
        newFlyer: flyerToPublish,
        oldFlyer: oldFlyer,
        bzModel: _bzModel
    );

    await NoteProtocol.sendFlyerUpdateNoteToItsBz(
        context: context,
        bzModel: _bzModel,
        flyerID: _uploadedFlyer.id,
    );

    // /// LDB - PRO
    // await localFlyerUpdateProtocol(
    //   context: context,
    //   flyerModel: _uploadedFlyer,
    //   notify: true,
    //   insertInActiveBzFlyersIfAbsent: true,
    // );

    blog('FlyerProtocol.updateFlyerByActiveBzProtocol : END');

  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> localFlyerUpdateProtocol({
    @required BuildContext context,
    @required FlyerModel flyerModel,
    @required bool insertInActiveBzFlyersIfAbsent,
    @required bool notify,
  }) async {

    blog('FlyerProtocol.localFlyerUpdateProtocol : START');

    if (flyerModel != null){

      await FlyerLDBOps.insertFlyer(flyerModel);

      final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
      _flyersProvider.updateFlyerInAllProFlyers(
          flyerModel: flyerModel,
          notify: notify
      );

      final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
      final BzModel _activeBz = _bzzProvider.myActiveBz;
      if (_activeBz?.id == flyerModel.bzID){
        _bzzProvider.updateFlyerInActiveBzFlyers(
          flyer: flyerModel,
          notify: notify,
          insertIfAbsent: insertInActiveBzFlyersIfAbsent,
        );
      }

    }

    blog('FlyerProtocol.localFlyerUpdateProtocol : END');

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

    blog('FlyerProtocol.deleteSingleFlyerByActiveBzProtocol : START');

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

    blog('FlyerProtocol.deleteSingleFlyerByActiveBzProtocol : END');

  }
// ----------------------------------
  static Future<BzModel> deleteMultipleBzFlyersProtocol({
    @required BuildContext context,
    @required BzModel bzModel,
    @required List<FlyerModel> flyers,
    @required bool showWaitDialog,
    @required bool updateBzEveryWhere,
  }) async {

    blog('FlyerProtocol.deleteMultipleBzFlyersProtocol : START');

    BzModel _bzModel = bzModel;

    if (Mapper.checkCanLoopList(flyers) == true && bzModel != null){

      if (showWaitDialog == true){
        unawaited(WaitDialog.showWaitDialog(
          context: context,
          loadingPhrase: 'Deleting flyers',
          canManuallyGoBack: false,
        ));
      }

      blog('FlyerProtocol.starting deleteMultipleBzFlyersProtocol');

      /// FIRE DELETION
      _bzModel = await FlyerFireOps.deleteMultipleBzFlyers(
        context: context,
        flyersToDelete: flyers,
        bzModel: bzModel,
        updateBzFireOps: updateBzEveryWhere,
      );

      blog('FlyerProtocol.starting deleteMultipleBzFlyersProtocol 2');


      /// FLYER LDB DELETION
      final List<String> _flyersIDs = FlyerModel.getFlyersIDsFromFlyers(flyers);
      await FlyerLDBOps.deleteFlyers(_flyersIDs);

      blog('FlyerProtocol.starting deleteMultipleBzFlyersProtocol 3');

      /// BZ LDB UPDATE
      if (updateBzEveryWhere == true){
        await BzLDBOps.updateBzOps(
            bzModel: _bzModel
        );
      }

      blog('FlyerProtocol.starting deleteMultipleBzFlyersProtocol 4');

      /// FLYER PRO DELETION
      final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
      _flyersProvider.removeFlyersFromProFlyers(
        flyersIDs: _flyersIDs,
        notify: true,
      );

      blog('FlyerProtocol.starting deleteMultipleBzFlyersProtocol 5');

      /// BZ PRO UPDATE
      final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
      final bool _shouldUpdateMyActiveBz =
          updateBzEveryWhere == true
              &&
              _bzzProvider.myActiveBz.id == _bzModel.id;

      _bzzProvider.removeFlyersFromActiveBzFlyers(
        flyersIDs: _flyersIDs,
        notify: !_shouldUpdateMyActiveBz,
      );

      /// BZ PRO UPDATE
      if (_shouldUpdateMyActiveBz == true){
        _bzzProvider.setActiveBz(
          bzModel: _bzModel,
          notify: true,
        );
      }

      blog('FlyerProtocol.starting deleteMultipleBzFlyersProtocol 6');

      if (showWaitDialog == true){
        WaitDialog.closeWaitDialog(context);
      }

    }

    blog('FlyerProtocol.deleteMultipleBzFlyersProtocol : END');

    return _bzModel;
  }
// -----------------------------------------------------------------------------
}
