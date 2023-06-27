import 'dart:typed_data';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/files/file_size_unit.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/a_models/j_poster/poster_type.dart';
import 'package:bldrs/b_views/z_components/poster/poster_display.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/census_protocols/census_listeners.dart';
import 'package:bldrs/c_protocols/flyer_protocols/fire/flyer_fire_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/ldb/flyer_ldb_ops.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/pdf_protocols/protocols/pdf_protocols.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/c_protocols/recorder_protocols/recorder_protocols.dart';
import 'package:bldrs/c_protocols/zone_phids_protocols/zone_phids_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/staging_protocols/protocols/staging_leveller.dart';
import 'package:bldrs/e_back_end/f_cloud/dynamic_links.dart';
import 'package:bldrs/e_back_end/g_storage/storage_path.dart';
import 'package:fire/super_fire.dart';
import 'package:basics/helpers/classes/files/filers.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';
import 'package:mediators/models/dimension_model.dart';

class ComposeFlyerProtocols {
  // -----------------------------------------------------------------------------

  const ComposeFlyerProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  /// TASK : TEST ME
  static Future<void> compose({
    required BuildContext context,
    required DraftFlyer draftFlyer,
  }) async {
    blog('ComposeFlyerProtocol.compose : START');

    assert(draftFlyer != null, 'Draft is null');

    if (draftFlyer != null){

      final String flyerID = await FlyerFireOps.createEmptyFlyerDocToGetFlyerID(
        bzID: draftFlyer.bzID,
      );

      if (flyerID != null){

        final DraftFlyer _draftWithID = DraftFlyer.overrideFlyerID(
          draft: draftFlyer,
          flyerID: flyerID,
        );

        FlyerModel _flyerToPublish = await DraftFlyer.draftToFlyer(
          draft: _draftWithID,
          toLDB: false,
          isPublishing: true,
        );

        /// TASK : SHOULD ASSERT FLYER IS COMPOSABLE METHOD
        assert (_flyerToPublish != null, 'Flyer is null');
        assert (_flyerToPublish.id != null, 'Flyer ID is null');

        /// CREATE FLYER POSTER
        // NOTE : when this is put among the below methods in Future.wait,
        // the pic does not get generated, and it works here out of the Future.wait
        await createFlyerPoster(
          context: context,
          flyerID: flyerID,
          draftFlyer: draftFlyer,
        );

        /// CREATE SHARE LINK
        _flyerToPublish = _flyerToPublish.copyWith(
          shareLink: await BldrsShareLink.generateFlyerLink(
            flyerID: _flyerToPublish.id,
            flyerType: _flyerToPublish.flyerType,
            headline: _flyerToPublish.headline,
          ),
        );


        await Future.wait(<Future>[

          /// UPDATE FLYER DOC
          FlyerFireOps.updateFlyerDoc(_flyerToPublish),

          /// UPLOAD SLIDES PICS
          PicProtocols.composePics(DraftSlide.getPicModels(_draftWithID.draftSlides)),

          /// UPLOAD PDF
          PDFProtocols.compose(_draftWithID.pdfModel),

          /// ADD FLYER TO LDB
          FlyerLDBOps.insertFlyer(_flyerToPublish),

          /// ADD FLYER ID TO BZ MODEL
          _addFlyerIDToBzAndAuthorAndRenovateBz(
            newFlyerToAdd: _flyerToPublish,
          ),

          /// INCREMENT BZ COUNTER (allSlides) COUNT
          RecorderProtocols.onComposeFlyer(
            bzID: _flyerToPublish.bzID,
            numberOfSlides: _flyerToPublish.slides.length,
          ),

          /// INCREMENT CITY FLYER CHAIN USAGE
          ZonePhidsRealOps.incrementFlyerCityPhids(
              flyerModel: _flyerToPublish,
              isIncrementing: true
          ),

          /// CENSUS
          CensusListener.onComposeFlyer(_flyerToPublish),

        ]);

        await StagingLeveller.levelUpZone(
          context: context,
          zoneModel: _flyerToPublish.zone,
        );

      }

    }

    blog('ComposeFlyerProtocol.compose : END');
  }
  // -----------------------------------------------------------------------------

  /// BZ UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _addFlyerIDToBzAndAuthorAndRenovateBz({
    required FlyerModel newFlyerToAdd,
  }) async {
    blog('addFlyerIDToBzFlyersIDsAndAuthorFlyersIDs : START');

    final BzModel _oldBz = await BzProtocols.fetchBz(
      bzID: newFlyerToAdd.bzID,
    );

    final List<String> _newBzFlyersIDs = Stringer.addStringToListIfDoesNotContainIt(
      strings: _oldBz.flyersIDs,
      stringToAdd: newFlyerToAdd.id,
    );

    final List<AuthorModel> _newAuthors = AuthorModel.addFlyerIDToAuthor(
      flyerID: newFlyerToAdd.id,
      authorID: newFlyerToAdd.authorID,
      oldAuthors: _oldBz.authors,
    );

    final BzModel _newBz = _oldBz.copyWith(
      flyersIDs: _newBzFlyersIDs,
      authors: _newAuthors,
    );

    // final BzModel _uploadedBzModel =
    await BzProtocols.renovateBz(
        context: getMainContext(),
        newBz: _newBz,
        oldBz: _oldBz,
        showWaitDialog: false,
        newLogo: null,
    );

    blog('_addFlyerIDToBzFlyersIDsAndAuthorFlyersIDs : END');

    // return _uploadedBzModel;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> createFlyerPoster({
    required BuildContext context,
    required String flyerID,
    required DraftFlyer draftFlyer,
  }) async {

    final Uint8List _bytes = await PosterDisplay.capturePoster(
      context: context,
      posterType: PosterType.flyer,
      model: draftFlyer,
      helperModel: draftFlyer.bzModel,
      // finalDesiredPicWidth: Standards.posterDimensions.width,
    );

    final Dimensions? _dims = await Dimensions.superDimensions(_bytes);
    final double? _mega = Filers.calculateSize(_bytes.length, FileSizeUnit.megaByte);

    final PicModel _posterPicModel = PicModel(
      bytes: _bytes,
      path: StoragePath.flyers_flyerID_poster(flyerID),
      meta: StorageMetaModel(
          sizeMB: _mega,
          width: _dims?.width,
          height: _dims?.height,
          ownersIDs: await FlyerModel.generateFlyerOwners(
            bzID: draftFlyer.bzID,
          )
      ),
    );

    await PicProtocols.composePic(_posterPicModel);

    _posterPicModel.blogPic(invoker: 'createFlyerPoster : is done');

  }
  // -----------------------------------------------------------------------------
}
