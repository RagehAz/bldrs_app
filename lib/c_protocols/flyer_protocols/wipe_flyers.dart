import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/e_db/fire/ops/flyer_ops.dart';
import 'package:bldrs/e_db/fire/ops/record_ops.dart';
import 'package:bldrs/e_db/ldb/ops/bz_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/flyer_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WipeFlyerProtocols {
// -----------------------------------------------------------------------------

  WipeFlyerProtocols();

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeFlyer({
    @required BuildContext context,
    @required FlyerModel flyerModel,
    @required BzModel bzModel,
    @required bool showWaitDialog,
  }) async {
    blog('WipeFlyerProtocols.wipeFlyer : START');

    if (showWaitDialog == true){
      unawaited(WaitDialog.showWaitDialog(
        context: context,
        loadingPhrase: 'Deleting flyer',
        canManuallyGoBack: false,
      ));
    }

    await FlyerFireOps.deleteFlyerOps(
      context: context,
      flyerModel: flyerModel,
      bzModel: bzModel,
      bzFireUpdateOps: true,
    );

    await RecordRealOps.incrementBzCounter(
      context: context,
      bzID: bzModel.id,
      field: 'allSlides',
      incrementThis: - flyerModel.slides.length,
    );

    /// DELETE FLYER ON LDB
    await FlyerLDBOps.deleteFlyers(<String>[flyerModel.id]);

    /// REMOVE FLYER FROM FLYERS PROVIDER
    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
    _flyersProvider.removeFlyerFromProFlyers(
      flyerID: flyerModel.id,
      notify: true,
    );

    if (showWaitDialog == true){
      WaitDialog.closeWaitDialog(context);
    }

    blog('WipeFlyerProtocols.wipeFlyer : END');
  }
// ----------------------------------
  static Future<BzModel> wipeMultipleFlyers({
    @required BuildContext context,
    @required BzModel bzModel,
    @required List<FlyerModel> flyers,
    @required bool showWaitDialog,
    @required bool updateBzEveryWhere,
  }) async {
    blog('WipeFlyerProtocols.wipeMultipleFlyers : START');

    BzModel _bzModel = bzModel;

    if (Mapper.checkCanLoopList(flyers) == true && bzModel != null){

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

      await RecordRealOps.incrementBzCounter(
        context: context,
        bzID: _bzModel.id,
        field: 'allSlides',
        incrementThis: - FlyerModel.getNumberOfFlyersSlides(flyers),
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

    blog('WipeFlyerProtocols.wipeMultipleFlyers : END');

    return _bzModel;
  }
// ----------------------------------
}
