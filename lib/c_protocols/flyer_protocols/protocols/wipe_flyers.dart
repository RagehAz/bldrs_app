import 'dart:async';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/real/bz_record_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/census_protocols/protocols/census_listeners.dart';
import 'package:bldrs/c_protocols/chain_protocols/real/city_phids_real_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/fire/flyer_fire_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/ldb/flyer_ldb_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/provider/flyers_provider.dart';
import 'package:bldrs/c_protocols/flyer_protocols/real/flyer_record_real_ops.dart';
import 'package:bldrs/c_protocols/pdf_protocols/ldb/pdf_ldb_ops.dart';
import 'package:bldrs/c_protocols/pic_protocols/ldb/pic_ldb_ops.dart';
import 'package:bldrs/c_protocols/review_protocols/protocols/a_reviews_protocols.dart';
import 'package:bldrs/e_back_end/g_storage/foundation/storage_paths.dart';
import 'package:bldrs/e_back_end/g_storage/storage.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WipeFlyerProtocols {
  // -----------------------------------------------------------------------------

  const WipeFlyerProtocols();

  // -----------------------------------------------------------------------------

  /// WIPE FLYER

  // --------------------
  /// TASK : TEST ME
  static Future<void> wipeFlyer({
    @required BuildContext context,
    @required FlyerModel flyerModel,
    @required bool showWaitDialog,
    @required bool isDeletingBz,
  }) async {
    blog('WipeFlyerProtocols.wipeFlyer : START');

    if (flyerModel != null){

      if (showWaitDialog == true){
        unawaited(WaitDialog.showWaitDialog(
          context: context,
          loadingVerse: const Verse(
            text: 'phid_deleting_flyer',
            translate: true,
          ),
        ));
      }

      final BzModel _oldBz = await BzProtocols.fetchBz(
          context: context,
          bzID: flyerModel.bzID,
      );

      await Future.wait(<Future>[

        /// DECREMENT BZ COUNTER
        if (isDeletingBz == false)
          BzRecordRealOps.incrementBzCounter(
            bzID: _oldBz.id,
            field: 'allSlides',
            incrementThis: - flyerModel.slides.length,
          ),

        /// REMOVE FLYER ID FROM BZ AND AUTHOR MODELS
        if (isDeletingBz == false)
          _deleteFlyerIDFromBzFlyersIDsAndAuthorIDs(
            context: context,
            oldBz: _oldBz,
            flyer: flyerModel,
          ),

        /// WIPE REVIEWS
        ReviewProtocols.wipeAllFlyerReviews(
          context: context,
          flyerID: flyerModel.id,
          isDeletingFlyer: true,
          bzID: _oldBz.id,
          isDeletingBz: isDeletingBz,
        ),

        /// WIPE FLYER COUNTERS
        FlyerRecordRealOps.deleteAllFlyerCountersAndRecords(
          flyerID: flyerModel.id,
        ),

        /// REMOVE SPECS FROM CITY CHAIN USAGE
        CityPhidsRealOps.incrementFlyerCityChainUsage(
          context: context,
          flyerModel: flyerModel,
          isIncrementing: false,
        ),

        /// DELETE SLIDES PICS + PDF + POSTER
        Storage.deletePath(
          context: context,
          path: '${StorageColl.flyers}/${flyerModel.id}',
        ),

        /// DELETE LDB SLIDES AND POSTER PICS + PDF
        PicLDBOps.deletePics(FlyerModel.getPicsPaths(flyerModel)),
        PicLDBOps.deletePic(Storage.generateFlyerPosterPath(flyerModel.id)),
        PDFLDBOps.delete(flyerModel.pdfPath),

        /// CENSUS
        CensusListener.onWipeFlyer(flyerModel),

        /// REMOVE FLYER DOC
        FlyerFireOps.deleteFlyerDoc(
          flyerID: flyerModel.id,
        ),

        /// REMOVE FLYER LOCALLY
        deleteFlyersLocally(
          context: context,
          flyersIDs: <String>[flyerModel.id],
        ),

      ]);

      if (showWaitDialog == true){
        await WaitDialog.closeWaitDialog(context);
      }

    }

    blog('WipeFlyerProtocols.wipeFlyer : END');
  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> _deleteFlyerIDFromBzFlyersIDsAndAuthorIDs({
    @required BuildContext context,
    @required FlyerModel flyer,
    @required BzModel oldBz,
  }) async {
    blog('_deleteFlyerIDFromBzFlyersIDsAndAuthorIDs : START');

    if (oldBz != null && flyer != null){

      final BzModel _newBz = BzModel.removeFlyerIDFromBzAndAuthor(
        oldBz: oldBz,
        flyer: flyer,
      );

      await BzProtocols.renovateBz(
          context: context,
          newBz: _newBz,
          oldBz: oldBz,
          showWaitDialog: false,
          navigateToBzInfoPageOnEnd: false,
          newLogo: null,
      );

    }

    blog('_deleteFlyerIDFromBzFlyersIDsAndAuthorIDs : END');
  }
  // -----------------------------------------------------------------------------

  /// WIPE FLYERS

  // --------------------
  /// TASK : TEST ME
  static Future<void> wipeFlyers({
    @required BuildContext context,
    @required BzModel bzModel,
    @required List<FlyerModel> flyers,
    @required bool showWaitDialog,
    @required bool isDeletingBz,
  }) async {
    blog('WipeFlyerProtocols.wipeFlyers : START');

    if (Mapper.checkCanLoopList(flyers) == true && bzModel != null){

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

        ...List.generate(flyers.length, (index){

          return wipeFlyer(
              context: context,
              flyerModel: flyers[index],
              showWaitDialog: false,
              isDeletingBz: isDeletingBz,
          );

      }),

      ]);

      // final List<String> _flyersIDs = FlyerModel.getFlyersIDsFromFlyers(flyers);
      // BzModel _bzModel = bzModel;
      //
      // await Future.wait(<Future>[
      //
      //   ReviewProtocols.wipeMultipleFlyersReviews(
      //     context: context,
      //     flyersIDs: _flyersIDs,
      //     isDeletingFlyer: true,
      //     isDeletingBz: isDeletingBz,
      //     bzID: bzModel.id,
      //   ),
      //
      //   FlyerRecordRealOps.deleteMultipleFlyersCountersAndRecords(
      //     flyersIDs: _flyersIDs,
      //   ),
      //
      //   CityPhidsRealOps.incrementFlyersCityChainUsage(
      //     context: context,
      //     flyersModels: flyers,
      //     isIncrementing: false,
      //   ),
      //
      // ]);

      // /// FIRE DELETION
      // _bzModel = await FlyerFireOps.deleteMultipleBzFlyers(
      //   context: context,
      //   flyersToDelete: flyers,
      //   bzModel: bzModel,
      //   updateBzFireOps: updateBzEveryWhere,
      // );
      //
      // if (isDeletingBz == false){
      //   await BzRecordRealOps.incrementBzCounter(
      //     bzID: _bzModel.id,
      //     field: 'allSlides',
      //     incrementThis: - FlyerModel.getNumberOfFlyersSlides(flyers),
      //   );
      // }
      //
      // /// BZ LDB UPDATE
      // if (updateBzEveryWhere == true){
      //   await BzLDBOps.updateBzOps(
      //       bzModel: _bzModel
      //   );
      // }
      //
      // /// DELETE FLYERS LOCALLY
      // await deleteFlyersLocally(
      //   context: context,
      //   flyersIDs: _flyersIDs,
      // );

      // /// BZ PRO UPDATE
      // final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
      // final bool _thisBzIsTheActiveBz = _bzzProvider.myActiveBz?.id == _bzModel.id;
      // final bool _shouldUpdateMyActiveBz = updateBzEveryWhere == true && _thisBzIsTheActiveBz == true;
      //
      //
      // /// BZ PRO UPDATE
      // if (_shouldUpdateMyActiveBz == true){
      //   _bzzProvider.setActiveBz(
      //     bzModel: _bzModel,
      //     notify: true,
      //   );
      // }

      if (showWaitDialog == true){
        await WaitDialog.closeWaitDialog(context);
      }

    }

    blog('WipeFlyerProtocols.wipeFlyers : END');
  }
  // -----------------------------------------------------------------------------

  /// LOCAL DELETE

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

      final BzModel _bzModel = await BzProtocols.fetchBz(
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
  // -----------------------------------------------------------------------------
}
