import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/c_controllers/g_bz_controllers/a_bz_profile/a_my_bz_screen_controllers.dart';
import 'package:bldrs/c_protocols/user_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/ops/flyer_ops.dart';
import 'package:bldrs/e_db/ldb/ops/bz_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/flyer_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// -----------------------------------------------------------------------------
/// PROTOCOLS ARE SET OF OPS CALLED BY CONTROLLERS TO LAUNCH FIRE OPS AND LDB OPS.
// -----------------------------------------------------------------------------
class BzProtocol {

  BzProtocol();

// -----------------------------------------------------------------------------

  /// CREATE

// ----------------------------------
  static Future<void> createBzProtocol() async {

  }
// -----------------------------------------------------------------------------

  /// UPDATE

// ----------------------------------
  static Future<void> updateBzProtocol() async {

  }

  // -------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> myActiveBzLocalUpdateProtocol({
    @required BuildContext context,
    @required BzModel newBzModel,
    @required BzModel oldBzModel,
  }) async {

    /// LOCAL UPDATE PROTOCOL
    /// is to update my-active-bz-model in PRO and LDB in case of model changes


    final bool _areTheSame = BzModel.checkBzzAreIdentical(
      bz1: newBzModel,
      bz2: oldBzModel,
    );

    blog('myActiveBzLocalUpdateProtocol : bzz are identical : $_areTheSame');

    /// UPDATE BZ MODEL EVERYWHERE
    if (_areTheSame == false){

      /// SET UPDATED BZ MODEL LOCALLY ( USER BZZ )
      final BzModel _finalBz = await completeBzZoneModel(
        context: context,
        bzModel: newBzModel,
      );

      /// OVERRIDE BZ ON LDB
      await BzLDBOps.updateBzOps(
        bzModel: _finalBz,
      );

      // if (context != null){

      final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);

      /// UPDATE MY BZZ
      _bzzProvider.updateBzInMyBzz(
        modifiedBz: _finalBz,
        notify: false,
      );

      /// UPDATE ACTIVE BZ
      _bzzProvider.setActiveBz(
        bzModel: _finalBz,
        notify: true,
      );

      blog('myActiveBzLocalUpdateProtocol : my active bz updated in PRO & LDB');

      // }
    }

  }

// -----------------------------------------------------------------------------

  /// DELETE

// ----------------------------------
  static Future<void> deleteBzProtocol() async {

  }
// ----------------------------------
  static Future<BzModel> deleteMultipleBzFlyersProtocol({
    @required BuildContext context,
    @required BzModel bzModel,
    @required List<FlyerModel> flyers,
    @required bool showWaitDialog,
    @required bool updateBzEveryWhere,
  }) async {

    BzModel _bzModel = bzModel;

    if (checkCanLoopList(flyers) == true && bzModel != null){

      if (showWaitDialog == true){
        unawaited(WaitDialog.showWaitDialog(
          context: context,
          loadingPhrase: 'Deleting flyers',
          canManuallyGoBack: false,
        ));
      }

      /// FIRE DELETION
      _bzModel = await FlyerFireOps.deleteMultipleBzFlyers(
        context: context,
        flyersToDelete: flyers,
        bzModel: bzModel,
        updateBzFireOps: updateBzEveryWhere,
      );

      /// FLYER LDB DELETION
      final List<String> _flyersIDs = FlyerModel.getFlyersIDsFromFlyers(flyers);
      await FlyerLDBOps.deleteFlyers(_flyersIDs);

      /// BZ LDB UPDATE
      if (updateBzEveryWhere == true){
        await BzLDBOps.updateBzOps(
            bzModel: _bzModel
        );
      }

      /// FLYER PRO DELETION
      final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
      _flyersProvider.removeFlyersFromProFlyers(
        flyersIDs: _flyersIDs,
        notify: true,
      );

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

      if (showWaitDialog == true){
        WaitDialog.closeWaitDialog(context);
      }

    }

    return _bzModel;
  }
// ----------------------------------
  static Future<void> myBzGotDeletedAndIShouldDeleteAllMyBzRelatedData({
    @required BuildContext context,
    @required String bzID,
  }) async {

    /// so I had this bzID in my bzIDs and I still have its old model
    /// scattered around in pro, ldb & fire

    /// DELETE LDB BZ MODEL

    /// DELETE LDB BZ FLYERS

    /// DELETE PRO BZ MODEL

    /// DELETE PRO BZ FLYERS

    /// DELETE MY AUTHOR PIC ON FIRE STORAGE

    /// DELETE BZID FROM MY BZZ IDS THEN UPDATE MY USER MODEL EVERY WHERE PROTOCOL
    final UserModel _myUserModel = UsersProvider.proGetMyUserModel(
        context: context,
        listen: false,
    );
    final UserModel _updatedUserModel = UserModel.removeBzIDFromMyBzzIDs(
      userModel: _myUserModel,
      bzIDToRemove: bzID,
    );
    await UserProtocol.updateMyUserEverywhereProtocol(
      context: context,
      userModel: _updatedUserModel,
    );
  }
// -----------------------------------------------------------------------------
}
