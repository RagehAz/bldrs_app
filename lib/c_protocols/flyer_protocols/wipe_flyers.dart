import 'dart:async';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/c_protocols/review_protocols/a_reviews_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/fire/ops/flyer_fire_ops.dart';
import 'package:bldrs/e_db/ldb/ops/bz_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/flyer_ldb_ops.dart';
import 'package:bldrs/e_db/real/ops/bz_record_real_ops.dart';
import 'package:bldrs/e_db/real/ops/city_phids_real_ops.dart';
import 'package:bldrs/e_db/real/ops/flyer_record_real_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WipeFlyerProtocols {
// -----------------------------------------------------------------------------

  const WipeFlyerProtocols();

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<BzModel> wipeFlyer({
    @required BuildContext context,
    @required FlyerModel flyerModel,
    @required BzModel bzModel,
    @required bool showWaitDialog,
    @required bool isDeletingBz,
  }) async {
    blog('WipeFlyerProtocols.wipeFlyer : START');

    BzModel _updatedBzModel = bzModel;

    if (flyerModel != null && bzModel != null){

      if (showWaitDialog == true){
        unawaited(WaitDialog.showWaitDialog(
          context: context,
          loadingVerse: xPhrase(context, '##Deleting flyer'),
        ));
      }

      await Future.wait(<Future>[

        ReviewProtocols.wipeAllFlyerReviews(
          context: context,
          flyerID: flyerModel.id,
          isDeletingFlyer: true,
          bzID: bzModel.id,
          isDeletingBz: isDeletingBz,
        ),

        FlyerRecordRealOps.deleteAllFlyerCountersAndRecords(
          context: context,
          flyerID: flyerModel.id,
        ),

        BzRecordRealOps.incrementBzCounter(
          context: context,
          bzID: bzModel.id,
          field: 'allSlides',
          incrementThis: - flyerModel.slides.length,
        ),

        CityPhidsRealOps.incrementFlyerCityChainUsage(
          context: context,
          flyerModel: flyerModel,
          isIncrementing: false,
        ),

    ]);

      _updatedBzModel = await FlyerFireOps.deleteFlyerOps(
        context: context,
        flyerModel: flyerModel,
        bzModel: bzModel,
        bzFireUpdateOps: true,
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

    }

    blog('WipeFlyerProtocols.wipeFlyer : END');
    return _updatedBzModel;
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT : TASK : NEED CLOUD FUNCTION
  static Future<BzModel> wipeMultipleFlyers({
    @required BuildContext context,
    @required BzModel bzModel,
    @required List<FlyerModel> flyers,
    @required bool showWaitDialog,
    @required bool updateBzEveryWhere,
    @required bool isDeletingBz,
  }) async {
    blog('WipeFlyerProtocols.wipeMultipleFlyers : START');

    BzModel _bzModel = bzModel;

    if (Mapper.checkCanLoopList(flyers) == true && bzModel != null){

      final List<String> _flyersIDs = FlyerModel.getFlyersIDsFromFlyers(flyers);

      if (showWaitDialog == true){
        unawaited(WaitDialog.showWaitDialog(
          context: context,
          loadingVerse: xPhrase(context, '##Deleting flyers'),
        ));
      }

      await Future.wait(<Future>[

        ReviewProtocols.wipeMultipleFlyersReviews(
          context: context,
          flyersIDs: _flyersIDs,
          isDeletingFlyer: true,
          isDeletingBz: isDeletingBz,
          bzID: bzModel.id,
        ),

        FlyerRecordRealOps.deleteMultipleFlyersCountersAndRecords(
          context: context,
          flyersIDs: _flyersIDs,
        ),

        CityPhidsRealOps.incrementFlyersCityChainUsage(
          context: context,
          flyersModels: flyers,
          isIncrementing: false,
        ),

      ]);

      /// FIRE DELETION
      _bzModel = await FlyerFireOps.deleteMultipleBzFlyers(
        context: context,
        flyersToDelete: flyers,
        bzModel: bzModel,
        updateBzFireOps: updateBzEveryWhere,
      );

      if (isDeletingBz == false){
        await BzRecordRealOps.incrementBzCounter(
          context: context,
          bzID: _bzModel.id,
          field: 'allSlides',
          incrementThis: - FlyerModel.getNumberOfFlyersSlides(flyers),
        );
      }

      /// FLYER LDB DELETION
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
      final bool _thisBzIsTheActiveBz = _bzzProvider.myActiveBz?.id == _bzModel.id;
      final bool _shouldUpdateMyActiveBz = updateBzEveryWhere == true && _thisBzIsTheActiveBz == true;


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
