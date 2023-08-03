import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/publication_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/census_protocols/census_listeners.dart';
import 'package:bldrs/c_protocols/flyer_protocols/fire/flyer_fire_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/ldb/flyer_ldb_ops.dart';
import 'package:bldrs/c_protocols/pdf_protocols/protocols/pdf_protocols.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/c_protocols/recorder_protocols/recorder_protocols.dart';
import 'package:bldrs/c_protocols/zone_phids_protocols/zone_phids_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/staging_protocols/protocols/staging_leveller.dart';
import 'package:bldrs/e_back_end/f_cloud/dynamic_links.dart';
/// => TAMAM
class ComposeFlyerProtocols {
  // -----------------------------------------------------------------------------

  const ComposeFlyerProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> compose({
    required DraftFlyer? draftFlyer,
  }) async {
    blog('ComposeFlyerProtocol.compose : START');

    // assert(draftFlyer != null, 'Draft is null');

    if (draftFlyer != null){

      final String? flyerID = await FlyerFireOps.createEmptyFlyerDocToGetFlyerID(
        bzID: draftFlyer.bzID,
      );

      if (flyerID != null){

        final DraftFlyer? _draftWithID = DraftFlyer.overrideFlyerID(
          draft: draftFlyer,
          flyerID: flyerID,
        );

        FlyerModel? _flyerToPublish = await DraftFlyer.draftToFlyer(
          draft: _draftWithID,
          slidePicType: SlidePicType.big,
          toLDB: false,
          isPublishing: true,
        );

        assert (_flyerToPublish != null, 'Flyer is null');
        assert (_flyerToPublish?.id != null, 'Flyer ID is null');

        if (_draftWithID != null && _flyerToPublish != null){

          /// CREATE FLYER POSTER
          await PicProtocols.composePic(_draftWithID.poster);

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
            PicProtocols.composePics(DraftSlide.getPicModels(
              drafts: _draftWithID.draftSlides,
              slidePicType: SlidePicType.big,
            )),
            PicProtocols.composePics(DraftSlide.getPicModels(
              drafts: _draftWithID.draftSlides,
              slidePicType: SlidePicType.med,
            )),
            PicProtocols.composePics(DraftSlide.getPicModels(
              drafts: _draftWithID.draftSlides,
              slidePicType: SlidePicType.small,
            )),
            PicProtocols.composePics(DraftSlide.getPicModels(
              drafts: _draftWithID.draftSlides,
              slidePicType: SlidePicType.back,
            )),

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
              numberOfSlides: _flyerToPublish.slides?.length,
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
            zoneModel: _flyerToPublish.zone,
          );

        }

      }

    }

    blog('ComposeFlyerProtocol.compose : END');
  }
  // -----------------------------------------------------------------------------

  /// BZ UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _addFlyerIDToBzAndAuthorAndRenovateBz({
    required FlyerModel? newFlyerToAdd,
  }) async {
    blog('addFlyerIDToBzFlyersIDsAndAuthorFlyersIDs : START');

    if (newFlyerToAdd != null){

      final BzModel? _oldBz = await BzProtocols.fetchBz(
        bzID: newFlyerToAdd.bzID,
      );

      if (_oldBz != null ){

        final PublicationModel _pub = PublicationModel.insertFlyerInPublications(
            pub: _oldBz.publication,
            flyerID: newFlyerToAdd.id!,
            toState: newFlyerToAdd.publishState,
        );

        final List<AuthorModel> _newAuthors = AuthorModel.addFlyerIDToAuthor(
          flyerID: newFlyerToAdd.id,
          authorID: newFlyerToAdd.authorID,
          oldAuthors: _oldBz.authors,
        );

        final BzModel? _newBz = _oldBz.copyWith(
          publication: _pub,
          authors: _newAuthors,
        );

        // final BzModel _uploadedBzModel =
        await BzProtocols.renovateBz(
          newBz: _newBz,
          oldBz: _oldBz,
          showWaitDialog: false,
          newLogo: null,
        );

      }


    }

    blog('_addFlyerIDToBzFlyersIDsAndAuthorFlyersIDs : END');

    // return _uploadedBzModel;
  }
  // -----------------------------------------------------------------------------
}
