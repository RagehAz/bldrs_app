import 'dart:typed_data';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/mutables/draft_slide.dart';
import 'package:bldrs/a_models/i_pic/pic_meta_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/a_models/j_poster/poster_type.dart';
import 'package:bldrs/a_models/x_utilities/dimensions_model.dart';
import 'package:bldrs/b_views/z_components/poster/poster_display.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/real/bz_record_real_ops.dart';
import 'package:bldrs/c_protocols/census_protocols/protocols/census_protocols.dart';
import 'package:bldrs/c_protocols/chain_protocols/real/city_phids_real_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/fire/flyer_fire_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/ldb/flyer_ldb_ops.dart';
import 'package:bldrs/c_protocols/pdf_protocols/protocols/pdf_protocols.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/e_back_end/g_storage/storage.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class ComposeFlyerProtocols {
  // -----------------------------------------------------------------------------

  const ComposeFlyerProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  /// TASK : TEST ME
  static Future<void> compose({
    @required BuildContext context,
    @required DraftFlyer draftFlyer,
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

        final FlyerModel _flyerToPublish = await DraftFlyer.draftToFlyer(
          draft: _draftWithID,
          toLDB: false,
          isPublishing: true,
        );

        /// TASK : SHOULD ASSERT FLYER IS COMPOSABLE METHOD
        assert (_flyerToPublish != null, 'Flyer is null');
        assert (_flyerToPublish.id != null, 'Flyer ID is null');

        await Future.wait(<Future>[

          /// UPDATE FLYER DOC
          FlyerFireOps.updateFlyerDoc(_flyerToPublish),

          /// CREATE FLYER POSTER
          createFlyerPoster(
            context: context,
            flyerID: flyerID,
            draftFlyer: draftFlyer,
          ),

          /// UPLOAD SLIDES PICS
          PicProtocols.composePics(DraftSlide.getPicModels(_draftWithID.draftSlides)),

          /// UPLOAD PDF
          PDFProtocols.compose(_draftWithID.pdfModel),

          /// ADD FLYER TO LDB
          FlyerLDBOps.insertFlyer(_flyerToPublish),

          /// ADD FLYER ID TO BZ MODEL
          _addFlyerIDToBzAndAuthorAndRenovateBz(
            context: context,
            newFlyerToAdd: _flyerToPublish,
          ),

          /// INCREMENT BZ COUNTER (allSlides) COUNT
          BzRecordRealOps.incrementBzCounter(
            bzID: _flyerToPublish.bzID,
            field: 'allSlides',
            incrementThis: _flyerToPublish.slides.length,
          ),

          /// INCREMENT CITY FLYER CHAIN USAGE
          CityPhidsRealOps.incrementFlyerCityChainUsage(
              context: context,
              flyerModel: _flyerToPublish,
              isIncrementing: true
          ),

          /// CENSUS
          CensusProtocols.onComposeFlyer(_flyerToPublish),

        ]);

      }

    }

    blog('ComposeFlyerProtocol.compose : END');
  }
  // -----------------------------------------------------------------------------

  /// BZ UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _addFlyerIDToBzAndAuthorAndRenovateBz({
    @required BuildContext context,
    @required FlyerModel newFlyerToAdd,
  }) async {
    blog('addFlyerIDToBzFlyersIDsAndAuthorFlyersIDs : START');

    final BzModel _oldBz = await BzProtocols.fetchBz(
      context: context,
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
        context: context,
        newBz: _newBz,
        oldBz: _oldBz,
        showWaitDialog: false,
        navigateToBzInfoPageOnEnd: false,
        newLogo: null,
    );

    blog('_addFlyerIDToBzFlyersIDsAndAuthorFlyersIDs : END');

    // return _uploadedBzModel;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> createFlyerPoster({
    @required String flyerID,
    @required BuildContext context,
    @required DraftFlyer draftFlyer,
  }) async {

    final Uint8List _bytes = await PosterDisplay.capturePoster(
      posterType: PosterType.flyer,
      model: draftFlyer,
      helperModel: draftFlyer.bzModel,
      // finalDesiredPicWidth: Standards.posterDimensions.width,
    );
    
    final PicModel _posterPicModel = PicModel(
      bytes: _bytes,
      path: Storage.generateFlyerPosterPath(flyerID),
      meta: PicMetaModel(
        dimensions: await Dimensions.superDimensions(_bytes),
        ownersIDs: await FlyerModel.generateFlyerOwners(
            context: context,
            bzID: draftFlyer.bzID,
        )
      ),
    );

    await PicProtocols.composePic(_posterPicModel);

  }
  // -----------------------------------------------------------------------------
}