import 'dart:async';

import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/x_secondary/scope_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/census_protocols/census_listeners.dart';
import 'package:bldrs/c_protocols/flyer_protocols/fire/flyer_fire_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/ldb/flyer_ldb_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/slide_pic_maker.dart';
import 'package:bldrs/c_protocols/flyer_protocols/provider/flyers_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/pdf_protocols/ldb/pdf_ldb_ops.dart';
import 'package:bldrs/c_protocols/pic_protocols/ldb/pic_ldb_ops.dart';
import 'package:bldrs/c_protocols/records_protocols/recorder_protocols.dart';
import 'package:bldrs/c_protocols/review_protocols/protocols/a_reviews_protocols.dart';
import 'package:bldrs/c_protocols/zone_phids_protocols/zone_phids_protocols.dart';
import 'package:bldrs/e_back_end/f_cloud/cloud_functions.dart';
import 'package:bldrs/e_back_end/g_storage/storage_path.dart';
import 'package:provider/provider.dart';
/// => TAMAM
class WipeFlyerProtocols {
  // -----------------------------------------------------------------------------

  const WipeFlyerProtocols();

  // -----------------------------------------------------------------------------

  /// WIPE SINGLE FLYER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onWipeSingleFlyer({
    required FlyerModel? flyerModel,
  }) async {

    final BzModel? _oldBz = await BzProtocols.fetchBz(
      bzID: flyerModel?.bzID,
    );

    if (flyerModel != null && flyerModel.id != null && _oldBz != null){

      await Future.wait(<Future>[

        /// UPDATE BZ AND AUTHOR MODELS
        _renovateBzOnFlyerWipe(
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
            numberOfSlides: flyerModel.slides?.length,
        ),

        /// REMOVE SPECS FROM CITY CHAIN USAGE
        ZonePhidsProtocols.onWipeFlyer(
          flyerModel: flyerModel,
        ),

        /// DELETE SLIDES PICS + PDF + POSTER
        BldrsCloudFunctions.deleteStorageDirectory(
          path: StoragePath.flyers_flyerID(flyerID: flyerModel.id),
        ),

        /// DELETE LDB SLIDES AND POSTER PICS + PDF
        PicLDBOps.deleteMediasByFireStoragePaths(
          paths: FlyerModel.getPicsPaths(flyer: flyerModel,type: SlidePicType.big),
        ),

        PicLDBOps.deleteMediasByFireStoragePaths(
          paths: FlyerModel.getPicsPaths(flyer: flyerModel,type: SlidePicType.med),
        ),

        PicLDBOps.deleteMediasByFireStoragePaths(
          paths: FlyerModel.getPicsPaths(flyer: flyerModel,type: SlidePicType.small),
        ),

        PicLDBOps.deleteMediasByFireStoragePaths(
          paths: FlyerModel.getPicsPaths(flyer: flyerModel,type: SlidePicType.back),
        ),

        PicLDBOps.deleteMediaByFireStoragePath(
          path: StoragePath.flyers_flyerID_poster(flyerModel.id),
        ),

        PDFLDBOps.delete(flyerModel.pdfPath),

        /// CENSUS
        CensusListener.onWipeFlyer(flyerModel),

        /// REMOVE FLYER DOC
        FlyerFireOps.deleteFlyerDoc(
          flyerID: flyerModel.id,
        ),

        /// REMOVE FLYER LOCALLY
        if (flyerModel.id != null)
          deleteFlyersLocally(
            flyersIDs: <String>[flyerModel.id!],
          ),

      ]);

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _renovateBzOnFlyerWipe({
    required FlyerModel? flyer,
    required BzModel? oldBz,
  }) async {
    blog('_renovateBzOnFlyerWipe : START');

    if (oldBz != null && flyer != null){

      /// REMOVE FLYER ID FROM PUBLICATION AND AUTHOR MODEL
      BzModel? _newBz = BzModel.removeFlyerIDFromBzAndAuthor(
        oldBz: oldBz,
        flyer: flyer,
      );

      _newBz = ScopeModel.removeFlyerFromBz(
        bzModel: _newBz,
        flyerModel: flyer,
      );

      await BzProtocols.renovateBz(
          newBz: _newBz,
          oldBz: oldBz,
          showWaitDialog: false,
          newLogo: null,
      );

    }

    blog('_renovateBzOnFlyerWipe : END');
  }
  // -----------------------------------------------------------------------------

  /// WIPE MULTIPLE FLYERS ON WIPE BZ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onWipeBz({
    required String? bzID,
  }) async {

    if (bzID != null){

      final BzModel? _oldBz = await BzProtocols.fetchBz(
        bzID: bzID,
      );

      if (_oldBz != null){

        Future<void> _wipeAFlyer(String? flyerID) async {

          final FlyerModel? _flyerModel = await FlyerProtocols.fetchFlyer(
            flyerID: flyerID,
          );

          if (_flyerModel != null && _flyerModel.id != null){

            await Future.wait(<Future>[

              /// REMOVE SPECS FROM CITY CHAIN USAGE
              ZonePhidsProtocols.onWipeFlyer(
                flyerModel: _flyerModel,
              ),

              /// DELETE SLIDES PICS + PDF + POSTER
              BldrsCloudFunctions.deleteStorageDirectory(
                path: StoragePath.flyers_flyerID(flyerID: flyerID),
              ),

              /// DELETE LDB SLIDES AND POSTER PICS + PDF
              PicLDBOps.deleteMediasByFireStoragePaths(
                paths: FlyerModel.getPicsPaths(flyer: _flyerModel, type: SlidePicType.big),
              ),
              PicLDBOps.deleteMediasByFireStoragePaths(
                paths: FlyerModel.getPicsPaths(flyer: _flyerModel, type: SlidePicType.med),
              ),
              PicLDBOps.deleteMediasByFireStoragePaths(
                paths: FlyerModel.getPicsPaths(flyer: _flyerModel, type: SlidePicType.small),
              ),
              PicLDBOps.deleteMediasByFireStoragePaths(
                paths: FlyerModel.getPicsPaths(flyer: _flyerModel, type: SlidePicType.back),
              ),
              PicLDBOps.deleteMediaByFireStoragePath(
                path: StoragePath.flyers_flyerID_poster(_flyerModel.id),
              ),
              PDFLDBOps.delete(_flyerModel.pdfPath),

              /// CENSUS
              CensusListener.onWipeFlyer(_flyerModel),

              /// REMOVE FLYER DOC
              FlyerFireOps.deleteFlyerDoc(
                flyerID: _flyerModel.id,
              ),

              /// REMOVE FLYER LOCALLY
              deleteFlyersLocally(
                flyersIDs: <String>[_flyerModel.id!],
              ),

            ]);

          }

        }

        final List<String> _flyersIDs = _oldBz.publication.getAllFlyersIDs();

        await Future.wait(<Future>[

          /// WIPE FLYERS
          if (Lister.checkCanLoop(_flyersIDs) == true)
            ...List.generate(_flyersIDs.length, (index){

              final String _flyerID = _flyersIDs[index];

              return _wipeAFlyer(_flyerID);

            }),

          /// WIPE FLYER REVIEWS
          ReviewProtocols.onWipeBz(
            flyersIDs: _flyersIDs,
            bzID: _oldBz.id,
          ),

        ]);

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// LOCAL DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteFlyersLocally({
    required List<String>? flyersIDs,
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
    required String? bzID,
  }) async {

    if (bzID != null){

      final BzModel? _bzModel = await BzProtocols.fetchBz(
          bzID: bzID,
      );

      if (_bzModel != null){

       await deleteFlyersLocally(
           flyersIDs: _bzModel.publication.getAllFlyersIDs(),
       );

      }

    }

  }
  // -----------------------------------------------------------------------------
}
