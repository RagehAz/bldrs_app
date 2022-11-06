import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/mutables/draft_slide.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/real/bz_record_real_ops.dart';
import 'package:bldrs/c_protocols/chain_protocols/real/city_phids_real_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/fire/flyer_fire_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/ldb/flyer_ldb_ops.dart';
import 'package:bldrs/c_protocols/pdf_protocols/protocols/pdf_protocols.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

/*

protocol level ops

 - create -> compose
 - read -> fetch
 - update -> renovate
 - delete -> wipe

 */

class ComposeFlyerProtocols {
  // -----------------------------------------------------------------------------

  const ComposeFlyerProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  ///
  static Future<void> compose({
    @required BuildContext context,
    @required DraftFlyer draftFlyer,
  }) async {
    blog('ComposeFlyerProtocol.compose : START');

    if (draftFlyer != null){

      final String flyerID = await FlyerFireOps.createEmptyFlyerDocToGetFlyerID();

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

      ]);

    }

    blog('ComposeFlyerProtocol.compose : END');
  }
  // -----------------------------------------------------------------------------

  /// BZ UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<BzModel> _addFlyerIDToBzAndAuthorAndRenovateBz({
    @required BuildContext context,
    @required FlyerModel newFlyerToAdd,
  }) async {
    blog('addFlyerIDToBzFlyersIDsAndAuthorFlyersIDs : START');

    final BzModel _bzModel = await BzProtocols.fetch(
      context: context,
      bzID: newFlyerToAdd.bzID,
    );

    final List<String> _updatedBzFlyersIDs = Stringer.addStringToListIfDoesNotContainIt(
      strings: _bzModel.flyersIDs,
      stringToAdd: newFlyerToAdd.id,
    );

    final List<AuthorModel> _updatedAuthors = AuthorModel.addFlyerIDToAuthor(
      flyerID: newFlyerToAdd.id,
      authorID: newFlyerToAdd.authorID,
      authors: _bzModel.authors,
    );

    final BzModel _updatedBzModel = _bzModel.copyWith(
      flyersIDs: _updatedBzFlyersIDs,
      authors: _updatedAuthors,
    );

    final BzModel _uploadedBzModel = await BzProtocols.renovateBz(
        context: context,
        newBz: _updatedBzModel,
        oldBzModel: _bzModel,
        showWaitDialog: false,
        navigateToBzInfoPageOnEnd: false,
        newLogo: null,
    );

    blog('_addFlyerIDToBzFlyersIDsAndAuthorFlyersIDs : END');

    return _uploadedBzModel;
  }
  // -----------------------------------------------------------------------------
}
