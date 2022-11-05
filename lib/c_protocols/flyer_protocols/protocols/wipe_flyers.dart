import 'dart:async';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/review_protocols/protocols/a_reviews_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/flyer_protocols/provider/flyers_provider.dart';
import 'package:bldrs/c_protocols/flyer_protocols/fire/flyer_fire_ops.dart';
import 'package:bldrs/c_protocols/bz_protocols/ldb/bz_ldb_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/ldb/flyer_ldb_ops.dart';
import 'package:bldrs/c_protocols/bz_protocols/real/bz_record_real_ops.dart';
import 'package:bldrs/c_protocols/chain_protocols/real/city_phids_real_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/real/flyer_record_real_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WipeFlyerProtocols {
  // -----------------------------------------------------------------------------

  const WipeFlyerProtocols();

  // --------------------
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
          loadingVerse: const Verse(
            text: 'phid_deleting_flyer',
            translate: true,
          ),
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
          flyerID: flyerModel.id,
        ),

        BzRecordRealOps.incrementBzCounter(
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

      /// DELETE FLYERS LOCALLY
      await deleteFlyersLocally(
        context: context,
        flyersIDs: <String>[flyerModel.id],
      );

      if (showWaitDialog == true){
        await WaitDialog.closeWaitDialog(context);
      }

    }

    blog('WipeFlyerProtocols.wipeFlyer : END');
    return _updatedBzModel;
  }
  // --------------------
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
          loadingVerse: const Verse(
            text: 'phid_deleting_flyers',
            translate: true,
          ),
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
          bzID: _bzModel.id,
          field: 'allSlides',
          incrementThis: - FlyerModel.getNumberOfFlyersSlides(flyers),
        );
      }

      /// BZ LDB UPDATE
      if (updateBzEveryWhere == true){
        await BzLDBOps.updateBzOps(
            bzModel: _bzModel
        );
      }

      /// DELETE FLYERS LOCALLY
      await deleteFlyersLocally(
        context: context,
        flyersIDs: _flyersIDs,
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
        await WaitDialog.closeWaitDialog(context);
      }

    }

    blog('WipeFlyerProtocols.wipeMultipleFlyers : END');
    return _bzModel;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteFlyersLocally({
    @required BuildContext context,
    @required List<String> flyersIDs,
  }) async {

    /// FLYER LDB DELETION
    await FlyerLDBOps.deleteFlyers(flyersIDs);

    /// FLYER PRO DELETION
    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
    _flyersProvider.removeFlyersFromProFlyers(
      flyersIDs: flyersIDs,
      notify: true,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteAllBzFlyersLocally({
    @required BuildContext context,
    @required String bzID,
  }) async {

    if (bzID != null){

      final BzModel _bzModel = await BzProtocols.fetch(
          context: context,
          bzID: bzID,
      );

      if (_bzModel != null){

       await deleteFlyersLocally(
           context: context,
           flyersIDs: _bzModel.flyersIDs,
       );

      }

    }

  }
  // --------------------
}
