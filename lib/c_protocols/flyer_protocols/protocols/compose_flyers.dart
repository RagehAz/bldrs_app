import 'package:basics/helpers/checks/tracers.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/publication_model.dart';
import 'package:bldrs/a_models/x_secondary/scope_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/census_protocols/census_listeners.dart';
import 'package:bldrs/c_protocols/flyer_protocols/fire/flyer_fire_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/ldb/flyer_ldb_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/slide_pic_maker.dart';
import 'package:bldrs/c_protocols/note_protocols/note_events/note_events.dart';
import 'package:bldrs/c_protocols/pdf_protocols/protocols/pdf_protocols.dart';
import 'package:bldrs/c_protocols/media_protocols/protocols/media_protocols.dart';
import 'package:bldrs/c_protocols/records_protocols/recorder_protocols.dart';
import 'package:bldrs/c_protocols/zone_phids_protocols/zone_phids_protocols.dart';
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
  static Future<FlyerModel?> compose({
    required DraftFlyer? draftFlyer,
  }) async {
    FlyerModel? _output;
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
          await MediaProtocols.composeMedia(_draftWithID.poster);

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
            MediaProtocols.composeMedias(DraftSlide.getPicModels(
              drafts: _draftWithID.draftSlides,
              slidePicType: SlidePicType.big,
            )),
            MediaProtocols.composeMedias(DraftSlide.getPicModels(
              drafts: _draftWithID.draftSlides,
              slidePicType: SlidePicType.med,
            )),
            MediaProtocols.composeMedias(DraftSlide.getPicModels(
              drafts: _draftWithID.draftSlides,
              slidePicType: SlidePicType.small,
            )),
            MediaProtocols.composeMedias(DraftSlide.getPicModels(
              drafts: _draftWithID.draftSlides,
              slidePicType: SlidePicType.back,
            )),

            /// UPLOAD PDF
            PDFProtocols.compose(_draftWithID.pdfModel),

            /// ADD FLYER TO LDB
            FlyerLDBOps.insertFlyer(_flyerToPublish),

            /// ADD FLYER ID TO BZ MODEL + AUTHOR MODEL + UPDATE SCOPE
            _renovateBzOnFlyerCompose(newFlyerToAdd: _flyerToPublish),

            /// INCREMENT BZ COUNTER (allSlides) COUNT
            RecorderProtocols.onComposeFlyer(
              bzID: _flyerToPublish.bzID,
              numberOfSlides: _flyerToPublish.slides?.length,
            ),

            /// INCREMENT CITY FLYER CHAIN USAGE
            ZonePhidsProtocols.onComposeFlyer(flyerModel: _flyerToPublish),

            /// CENSUS
            CensusListener.onComposeFlyer(_flyerToPublish),

            /// SEND ADMIN NOTE
            NoteEvent.onNewFlyer(flyerModel: _flyerToPublish),

          ]);

          await StagingLeveller.levelUpZone(
            zoneModel: _flyerToPublish.zone,
          );

          _output = _flyerToPublish;

        }

      }

    }

    blog('ComposeFlyerProtocol.compose : END');

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BZ UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _renovateBzOnFlyerCompose({
    required FlyerModel? newFlyerToAdd,
  }) async {
    blog('_renovateBzOnFlyerCompose : START');

    if (newFlyerToAdd != null){

      final BzModel? _oldBz = await BzProtocols.fetchBz(
        bzID: newFlyerToAdd.bzID,
      );

      if (_oldBz != null ){

        /// INSERT FLYER ID IN PUBLICATION
        final PublicationModel _pub = PublicationModel.insertFlyerInPublications(
            pub: _oldBz.publication,
            flyerID: newFlyerToAdd.id!,
            toState: newFlyerToAdd.publishState,
        );

        /// ADD FLYER ID TO AUTHOR
        final List<AuthorModel> _newAuthors = AuthorModel.addFlyerIDToAuthor(
          flyerID: newFlyerToAdd.id,
          authorID: newFlyerToAdd.authorID,
          oldAuthors: _oldBz.authors,
        );

        /// ADD FLYER PHIDS TO SCOPE
        final ScopeModel? _newScope = ScopeModel.addFlyerToScope(
            scope: _oldBz.scopes,
            flyer: newFlyerToAdd,
        );

        final BzModel? _newBz = _oldBz.copyWith(
          publication: _pub,
          authors: _newAuthors,
          scopes: _newScope,
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

    blog('_renovateBzOnFlyerCompose : END');

    // return _uploadedBzModel;
  }
  // -----------------------------------------------------------------------------
}
