import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/recorder_protocols/recorder_protocols.dart';
import 'package:bldrs/c_protocols/zone_phids_protocols/zone_phids_real_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/fire/flyer_fire_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/ldb/flyer_ldb_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/compose_flyers.dart';
import 'package:bldrs/c_protocols/flyer_protocols/provider/flyers_provider.dart';
import 'package:bldrs/c_protocols/note_protocols/note_events/z_note_events.dart';
import 'package:bldrs/c_protocols/pdf_protocols/protocols/pdf_protocols.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/c_protocols/census_protocols/census_listeners.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RenovateFlyerProtocols {
  // -----------------------------------------------------------------------------

  const RenovateFlyerProtocols();

  // -----------------------------------------------------------------------------

  /// FLYER RENOVATION

  // --------------------
  /// TASK : TEST ME VERIFY_ME
  static Future<void> renovateDraft({
    required BuildContext context,
    required DraftFlyer? newDraft,
    required FlyerModel? oldFlyer,
    required bool sendFlyerUpdateNoteToItsBz,
    required bool updateFlyerLocally,
    required bool resetActiveBz,
  }) async {
    blog('RenovateFlyerProtocols.renovate : START');

    /// ASSERTIONS
    assert(
    (resetActiveBz == true && updateFlyerLocally == true) || (resetActiveBz == false)
    , 'RenovateFlyerProtocols renovate : CAN NOT resetActiveBz IF updateFlyerLocally is false');
    // assert(newDraft != null, 'flyer is null');
    // -------------------------------

    if (newDraft != null && oldFlyer != null){

      final BzModel? _bzModel = await BzProtocols.fetchBz(
        bzID: newDraft.bzID,
      );

      final FlyerModel? _flyerToUpload = await DraftFlyer.draftToFlyer(
        draft: newDraft,
        toLDB: false,
      );

      if (_flyerToUpload != null && _bzModel != null && newDraft.id != null) {

        /// CHECK IF POSTER HAS CHANGED
        final bool _posterHasChanged = await DraftFlyer.checkPosterHasChanged(
          draft: newDraft,
          oldFlyer: oldFlyer,
        );

        /// RENOVATE POSTER PIC
        if (_posterHasChanged == true) {
          await ComposeFlyerProtocols.createFlyerPoster(
              flyerID: oldFlyer.id!, context: context, draftFlyer: newDraft);
        }

        await Future.wait(<Future>[
          /// RENOVATE SLIDES PICS
          PicProtocols.renovatePics(DraftSlide.getPicModels(
            drafts: newDraft.draftSlides,
            slidePicType: SlidePicType.big,
          )),
          PicProtocols.renovatePics(DraftSlide.getPicModels(
            drafts: newDraft.draftSlides,
            slidePicType: SlidePicType.med,
          )),
          PicProtocols.renovatePics(DraftSlide.getPicModels(
            drafts: newDraft.draftSlides,
            slidePicType: SlidePicType.small,
          )),
          PicProtocols.renovatePics(DraftSlide.getPicModels(
            drafts: newDraft.draftSlides,
            slidePicType: SlidePicType.back,
          )),

          /// WIPE UN-USED PICS
          _wipeUnusedSlidesPics(
            draft: newDraft,
            oldFlyer: oldFlyer,
          ),
          /// UPDATE PDF (RENOVATE PDF || WIPE UNUSED PDF)
          _renovateOrWipePDF(
            draft: newDraft,
            oldFlyer: oldFlyer,
          ),
          /// UPDATE FLYER DOC
          FlyerFireOps.updateFlyerDoc(_flyerToUpload),
          /// INCREMENT BZ COUNTER (all slides) COUNT
          RecorderProtocols.onRenovateFlyer(
            bzID: newDraft.bzID,
            newNumberOfSlides: newDraft.draftSlides?.length,
            oldNumberOfSlides: oldFlyer.slides?.length,
          ),
          /// INCREMENT CITY PHIDS
          ZonePhidsRealOps.onRenovateFlyer(
            flyerModel: _flyerToUpload,
            oldFlyer: oldFlyer,
          ),
          /// CENSUS
          CensusListener.onRenovateFlyer(
            oldFlyer: oldFlyer,
            newFlyer: _flyerToUpload,
          ),
          /// SEND UPDATE NOTE TO BZ TEAM
          if (sendFlyerUpdateNoteToItsBz == true)
            NoteEvent.sendFlyerUpdateNoteToItsBz(
              context: context,
              bzModel: _bzModel,
              flyerID: newDraft.id,
            ),
          /// UPDATE FLYER LOCALLY
          if (updateFlyerLocally == true)
            updateLocally(
              flyerModel: _flyerToUpload,
              notifyFlyerPro: true,
              resetActiveBz: resetActiveBz,
            ),
        ]);
      }


    }

    blog('RenovateFlyerProtocols.renovate : END');
  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> renovateFlyer({
    required FlyerModel? newFlyer,
    required FlyerModel? oldFlyer,
  }) async {

    final bool _identical = FlyerModel.checkFlyersAreIdentical(
        flyer1: newFlyer,
        flyer2: oldFlyer,
    );

    if (_identical == false){

      await Future.wait([

        FlyerFireOps.updateFlyerDoc(newFlyer),

        updateLocally(
          flyerModel: newFlyer,
          notifyFlyerPro: true,
          resetActiveBz: false,
        ),

      ]);

    }

  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> _renovateOrWipePDF({
    required DraftFlyer draft,
    required FlyerModel? oldFlyer,
  }) async {

    /// FLYER SHOULD HAVE NO PDF
    if (draft.pdfModel == null){

      /// FLYER DID NOT HAVE A PDF
      if (oldFlyer?.pdfPath == null){
        // do nothing
      }

      /// FLYER HAD A PDF
      else {
        await PDFProtocols.wipe(oldFlyer?.pdfPath);
      }

    }

    /// FLYER HAS A PDF
    else {

      /// FLYER DID NOT HAVE A PDF
      if (oldFlyer?.pdfPath == null){
        await PDFProtocols.compose(draft.pdfModel);
      }

      /// FLYER HAD A PDF
      else {
        await PDFProtocols.renovate(draft.pdfModel);
      }

    }

  }
  // --------------------
  /// TASK : TEST ME VERIFY_ME
  static Future<void> _wipeUnusedSlidesPics({
    required DraftFlyer? draft,
    required FlyerModel? oldFlyer,
  }) async {
    blog('wipeUnusedSlidesPics : START');

    final int? _newLength = draft?.draftSlides?.length;
    final int? _oldLength = oldFlyer?.slides?.length;

    if (_newLength != null && _oldLength != null){

      if (_oldLength > _newLength) {

      final List<String> _picsPathsToBeDeleted = <String>[];

      for (int i = _newLength; i < _oldLength; i++) {

        final SlideModel _slideToDelete = oldFlyer!.slides![i];

        final String? _bigPicPath = SlideModel.generateSlidePicPath(
            flyerID: _slideToDelete.flyerID,
            slideIndex: _slideToDelete.slideIndex,
            type: SlidePicType.big,
        );
        if (_bigPicPath != null){
          _picsPathsToBeDeleted.add(_bigPicPath);
        }

        final String? _medPicPath = SlideModel.generateSlidePicPath(
            flyerID: _slideToDelete.flyerID,
            slideIndex: _slideToDelete.slideIndex,
            type: SlidePicType.med,
        );
        if (_medPicPath != null){
          _picsPathsToBeDeleted.add(_medPicPath);
        }

        final String? _smallPicPath = SlideModel.generateSlidePicPath(
            flyerID: _slideToDelete.flyerID,
            slideIndex: _slideToDelete.slideIndex,
            type: SlidePicType.small,
        );
        if (_smallPicPath != null){
          _picsPathsToBeDeleted.add(_smallPicPath);
        }

        final String? _backPicPath = SlideModel.generateSlidePicPath(
            flyerID: _slideToDelete.flyerID,
            slideIndex: _slideToDelete.slideIndex,
            type: SlidePicType.back,
        );
        if (_backPicPath != null){
          _picsPathsToBeDeleted.add(_backPicPath);
        }

      }

      await PicProtocols.wipePics(_picsPathsToBeDeleted);

    }

    }

      blog('wipeUnusedSlidesPics : END');
  }
  // -----------------------------------------------------------------------------

  /// LOCAL UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateLocally({
    required FlyerModel? flyerModel,
    required bool notifyFlyerPro,
    required bool resetActiveBz,
  }) async {
    blog('RenovateFlyerProtocols.updateLocally : START');

    if (flyerModel != null){

      await FlyerLDBOps.insertFlyer(flyerModel);

      final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(getMainContext(), listen: false);
      _flyersProvider.updateFlyerInAllProFlyers(
          flyerModel: flyerModel,
          notify: notifyFlyerPro
      );

      if (resetActiveBz == true){
        BzzProvider.resetActiveBz();
      }

    }

    blog('RenovateFlyerProtocols.updateLocally : END');
  }
  // --------------------
}
