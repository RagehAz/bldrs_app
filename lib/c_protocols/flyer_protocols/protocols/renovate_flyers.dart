import 'package:basics/helpers/checks/tracers.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/flyer_protocols/fire/flyer_fire_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/ldb/flyer_ldb_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/provider/flyers_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:provider/provider.dart';
/// => TAMAM
class RenovateFlyerProtocols {
  // -----------------------------------------------------------------------------

  const RenovateFlyerProtocols();

  // -----------------------------------------------------------------------------

  /// FLYER RENOVATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> renovateDraft({
    required DraftFlyer? newDraft,
    required FlyerModel? oldFlyer,
    required bool sendFlyerUpdateNoteToItsBz,
    required bool updateFlyerLocally,
    required bool resetActiveBz,
  }) async {
    blog('RenovateFlyerProtocols.renovate : START a77aa');
    blog('RenovateFlyerProtocols.renovate : START a77aa');
    /// ASSERTIONS
    assert(
    (resetActiveBz == true && updateFlyerLocally == true) || (resetActiveBz == false)
    , 'RenovateFlyerProtocols renovate : CAN NOT resetActiveBz IF updateFlyerLocally is false');
    // assert(newDraft != null, 'flyer is null');
    // -------------------------------

    final DraftFlyer? _oldDraft = await DraftFlyer.createDraft(oldFlyer: oldFlyer);

    final bool _identical = DraftFlyer.checkDraftsAreIdentical(
        draft1: _oldDraft,
        draft2: newDraft,
    );

    if (newDraft != null && oldFlyer != null && _identical == false){

      // final BzModel? _bzModel = await BzProtocols.fetchBz(
      //   bzID: newDraft.bzID,
      // );
      //
      // FlyerModel? _flyerToUpload = await DraftFlyer.draftToFlyer(
      //   draft: newDraft,
      //   slidePicType: SlidePicType.small,
      //   toLDB: false,
      // );
      //
      // if (_flyerToUpload != null && _bzModel != null && newDraft.id != null) {
      //
      //   /// CHECK IF POSTER HAS CHANGED
      //   final bool _posterHasChanged = await DraftFlyer.checkPosterHasChanged(
      //     draft: newDraft,
      //     oldFlyer: oldFlyer,
      //   );
      //
      //   if (_posterHasChanged == true){
      //
      //     await PicProtocols.renovatePic(newDraft.poster);
      //
      //     /// CREATE SHARE LINK
      //     _flyerToUpload = _flyerToUpload.copyWith(
      //       shareLink: await BldrsShareLink.generateFlyerLink(
      //         flyerID: _flyerToUpload.id,
      //         flyerType: _flyerToUpload.flyerType,
      //         headline: _flyerToUpload.headline,
      //       ),
      //     );
      //
      //   }
      //
      //   await Future.wait(<Future>[
      //     /// RENOVATE SLIDES PICS
      //     PicProtocols.renovatePics(DraftSlide.getPicModels(
      //       drafts: newDraft.draftSlides,
      //       slidePicType: SlidePicType.big,
      //     )),
      //     PicProtocols.renovatePics(DraftSlide.getPicModels(
      //       drafts: newDraft.draftSlides,
      //       slidePicType: SlidePicType.med,
      //     )),
      //     PicProtocols.renovatePics(DraftSlide.getPicModels(
      //       drafts: newDraft.draftSlides,
      //       slidePicType: SlidePicType.small,
      //     )),
      //     PicProtocols.renovatePics(DraftSlide.getPicModels(
      //       drafts: newDraft.draftSlides,
      //       slidePicType: SlidePicType.back,
      //     )),
      //
      //     /// WIPE UN-USED PICS
      //     _wipeUnusedSlidesPics(
      //       draft: newDraft,
      //       oldFlyer: oldFlyer,
      //     ),
      //     /// UPDATE PDF (RENOVATE PDF || WIPE UNUSED PDF)
      //     _renovateOrWipePDF(
      //       draft: newDraft,
      //       oldFlyer: oldFlyer,
      //     ),
      //     /// UPDATE FLYER DOC
      //     FlyerFireOps.updateFlyerDoc(_flyerToUpload),
      //     /// INCREMENT BZ COUNTER (all slides) COUNT
      //     RecorderProtocols.onRenovateFlyer(
      //       bzID: newDraft.bzID,
      //       newNumberOfSlides: newDraft.draftSlides?.length,
      //       oldNumberOfSlides: oldFlyer.slides?.length,
      //     ),
      //     /// INCREMENT CITY PHIDS
      //     ZonePhidsRealOps.onRenovateFlyer(
      //       flyerModel: _flyerToUpload,
      //       oldFlyer: oldFlyer,
      //     ),
      //     /// CENSUS
      //     CensusListener.onRenovateFlyer(
      //       oldFlyer: oldFlyer,
      //       newFlyer: _flyerToUpload,
      //     ),
      //     /// SEND UPDATE NOTE TO BZ TEAM
      //     if (sendFlyerUpdateNoteToItsBz == true)
      //       NoteEvent.sendFlyerUpdateNoteToItsBz(
      //         bzModel: _bzModel,
      //         flyerID: newDraft.id,
      //       ),
      //     /// UPDATE FLYER LOCALLY
      //     if (updateFlyerLocally == true)
      //       updateLocally(
      //         flyerModel: _flyerToUpload,
      //         notifyFlyerPro: true,
      //         resetActiveBz: resetActiveBz,
      //       ),
      //   ]);
      // }

      await FlyerProtocols.onWipeSingleFlyer(
        flyerModel: oldFlyer,
      );

      await FlyerProtocols.composeFlyer(
        draftFlyer: newDraft,
      );

    }

    blog('RenovateFlyerProtocols.renovate : END');
  }
  // --------------------
  /// TESTED : PERFECT
  static Future<void> renovateFlyer({
    required FlyerModel? newFlyer,
    required FlyerModel? oldFlyer,
  }) async {

    /// NOTE : THIS METHOD DOES NOT UPDATE BZ MODEL
    /// IT IS ONLY USED TO RENOVATE FLYER IN VERIFICATION PROTOCOLS FOR NOW

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
  /// DEPRECATED
  /*
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
   */
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
