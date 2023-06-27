import 'dart:async';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/census_protocols/census_listeners.dart';
import 'package:bldrs/c_protocols/flyer_protocols/fire/flyer_fire_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/ldb/flyer_ldb_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/provider/flyers_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/pdf_protocols/ldb/pdf_ldb_ops.dart';
import 'package:bldrs/c_protocols/pic_protocols/ldb/pic_ldb_ops.dart';
import 'package:bldrs/c_protocols/recorder_protocols/recorder_protocols.dart';
import 'package:bldrs/c_protocols/review_protocols/protocols/a_reviews_protocols.dart';
import 'package:bldrs/c_protocols/zone_phids_protocols/zone_phids_real_ops.dart';
import 'package:bldrs/e_back_end/f_cloud/cloud_functions.dart';
import 'package:bldrs/e_back_end/g_storage/storage_path.dart';
import 'package:basics/helpers/classes/files/filers.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:provider/provider.dart';

/*


      if (showWaitDialog == true){
        pushWaitDialog(
          context: context,
          verse: const Verse(
            id: 'phid_deleting_flyers',
            translate: true,
          ),
        );
      }



 */

class WipeFlyerProtocols {
  // -----------------------------------------------------------------------------

  const WipeFlyerProtocols();

  // -----------------------------------------------------------------------------

  /// WIPE SINGLE FLYER

  // --------------------
  /// TASK : TEST ME
  static Future<void> onWipeSingleFlyer({
    required FlyerModel flyerModel,
  }) async {

    if (flyerModel != null){

      final BzModel _oldBz = await BzProtocols.fetchBz(
          bzID: flyerModel.bzID,
      );

      await Future.wait(<Future>[

        /// UPDATE BZ AND AUTHOR MODELS
        _deleteFlyerIDFromBzFlyersIDsAndAuthorIDs(
          context: getMainContext(),
          oldBz: _oldBz,
          flyer: flyerModel,
        ),

        /// WIPE FLYER REVIEWS
        ReviewProtocols.onWipeFlyer(
          flyerID: flyerModel.id,
          bzID: _oldBz.id,
        ),

        /// WIPE FLYER COUNTERS
        RecorderProtocols.onWipeFlyer(
          flyerID: flyerModel.id,
            bzID: _oldBz.id,
            numberOfSlides: flyerModel.slides.length,
        ),

        /// REMOVE SPECS FROM CITY CHAIN USAGE
        ZonePhidsRealOps.incrementFlyerCityPhids(
          flyerModel: flyerModel,
          isIncrementing: false,
        ),

        /// DELETE SLIDES PICS + PDF + POSTER
        BldrsCloudFunctions.deleteStorageDirectory(
          context: getMainContext(),
          path: StoragePath.flyers_flyerID(flyerID: flyerModel.id),
        ),

        /// DELETE LDB SLIDES AND POSTER PICS + PDF
        PicLDBOps.deletePics(FlyerModel.getPicsPaths(flyerModel)),
        PicLDBOps.deletePic(StoragePath.flyers_flyerID_poster(flyerModel.id)),
        PDFLDBOps.delete(flyerModel.pdfPath),

        /// CENSUS
        CensusListener.onWipeFlyer(flyerModel),

        /// REMOVE FLYER DOC
        FlyerFireOps.deleteFlyerDoc(
          flyerID: flyerModel.id,
        ),

        /// REMOVE FLYER LOCALLY
        deleteFlyersLocally(
          flyersIDs: <String>[flyerModel.id],
        ),

      ]);

    }

  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> _deleteFlyerIDFromBzFlyersIDsAndAuthorIDs({
    required BuildContext context,
    required FlyerModel flyer,
    required BzModel oldBz,
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
          newLogo: null,
      );

    }

    blog('_deleteFlyerIDFromBzFlyersIDsAndAuthorIDs : END');
  }
  // -----------------------------------------------------------------------------

  /// WIPE MULTIPLE FLYERS ON WIPE BZ

  // --------------------
  /// TASK : TEST ME
  static Future<void> onWipeBz({
    required String bzID,
  }) async {

    if (bzID != null){

      final BzModel _oldBz = await BzProtocols.fetchBz(
        bzID: bzID,
      );

      Future<void> _wipeAFlyer(String flyerID) async {

        final FlyerModel _flyerModel = await FlyerProtocols.fetchFlyer(
          context: getMainContext(),
          flyerID: flyerID,
        );

        await Future.wait(<Future>[

          /// REMOVE SPECS FROM CITY CHAIN USAGE
          ZonePhidsRealOps.incrementFlyerCityPhids(
            flyerModel: _flyerModel,
            isIncrementing: false,
          ),

          /// DELETE SLIDES PICS + PDF + POSTER
          BldrsCloudFunctions.deleteStorageDirectory(
            context: getMainContext(),
            path: StoragePath.flyers_flyerID(flyerID: flyerID),
          ),

          /// DELETE LDB SLIDES AND POSTER PICS + PDF
          PicLDBOps.deletePics(FlyerModel.getPicsPaths(_flyerModel)),
          PicLDBOps.deletePic(StoragePath.flyers_flyerID_poster(_flyerModel?.id)),
          PDFLDBOps.delete(_flyerModel?.pdfPath),

          /// CENSUS
          CensusListener.onWipeFlyer(_flyerModel),

          /// REMOVE FLYER DOC
          FlyerFireOps.deleteFlyerDoc(
            flyerID: _flyerModel?.id,
          ),

          /// REMOVE FLYER LOCALLY
          deleteFlyersLocally(
            flyersIDs: <String>[_flyerModel.id],
          ),

        ]);
      }

      await Future.wait(<Future>[

        /// WIPE FLYERS
        if (Mapper.checkCanLoopList(_oldBz.flyersIDs) == true)
          ...List.generate(_oldBz.flyersIDs.length, (index){
            final String _flyerID = _oldBz.flyersIDs[index];
            return _wipeAFlyer(_flyerID);
          }),

        /// WIPE FLYER REVIEWS
        ReviewProtocols.onWipeBz(
          flyersIDs: _oldBz.flyersIDs,
          bzID: _oldBz.id,
        ),

      ]);

    }

  }
  // -----------------------------------------------------------------------------

  /// LOCAL DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteFlyersLocally({
    required List<String> flyersIDs,
  }) async {

    /// FLYER LDB DELETION
    await FlyerLDBOps.deleteFlyers(flyersIDs);

    /// FLYER PRO DELETION
    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(getMainContext(), listen: false);
    _flyersProvider.removeFlyersFromProFlyers(
      flyersIDs: flyersIDs,
      notify: true,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteAllBzFlyersLocally({
    required String bzID,
  }) async {

    if (bzID != null){

      final BzModel _bzModel = await BzProtocols.fetchBz(
          bzID: bzID,
      );

      if (_bzModel != null){

       await deleteFlyersLocally(
           flyersIDs: _bzModel.flyersIDs,
       );

      }

    }

  }
  // -----------------------------------------------------------------------------
}
