import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/compose_flyers.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/fetch_flyers.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/renovate_flyers.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/wipe_flyers.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/ldb/flyer_ldb_ops.dart';
import 'package:bldrs/e_back_end/g_storage/storage_paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

class FlyerProtocols {
  // -----------------------------------------------------------------------------

  const FlyerProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  ///
  static Future<void> composeFlyer({
    @required BuildContext context,
    @required DraftFlyer draftFlyer,
  }) => ComposeFlyerProtocols.compose(
    context: context,
    draftFlyer: draftFlyer,
  );
  // -----------------------------------------------------------------------------

  /// FETCH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerModel> fetchFlyer({
    @required BuildContext context,
    @required  String flyerID,
  }) => FetchFlyerProtocols.fetchFlyer(
    context: context,
    flyerID: flyerID,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<FlyerModel>> fetchFlyers({
    @required BuildContext context,
    @required List<String> flyersIDs,
  }) => FetchFlyerProtocols.fetchFlyers(
      context: context,
      flyersIDs: flyersIDs
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerModel> fetchAndCombineBzSlidesInOneFlyer({
    @required BuildContext context,
    @required BzModel bzModel,
    @required int maxSlides,
  }) async {
    FlyerModel _flyer;

    if (bzModel != null && maxSlides != null && maxSlides != 0){

      final List<SlideModel> _bzSlides = <SlideModel>[];

      for (int i = 0; i < bzModel.flyersIDs.length; i++){

        final String _flyerID = bzModel.flyersIDs[i];

        final FlyerModel _flyer = await fetchFlyer(
          context: context,
          flyerID: _flyerID,
        );

        for (final SlideModel _slide in _flyer.slides){

          _bzSlides.add(_slide);

          blog('added slide with index ${_slide.slideIndex}');

          if (_bzSlides.length >= maxSlides){
            blog('breaking _bzSlides.length ${_bzSlides.length} : maxSlides $maxSlides : ${_bzSlides.length >= maxSlides}');
            break;
          }

        }

        if (_bzSlides.length >= maxSlides){
          break;
        }

      }

      if (_bzSlides.isNotEmpty == true){
        _flyer = FlyerModel(
          id: 'combinedSlidesInOneFlyer_${bzModel.id}',
          headline: _bzSlides[0].headline,
          trigram: const [],
          description: null,
          flyerType: null,
          publishState: PublishState.published,
          auditState: AuditState.verified,
          keywordsIDs: const [],
          zone: bzModel.zone,
          authorID: null,
          bzID: bzModel.id,
          position: null,
          slides: _bzSlides,
          specs: const [],
          times: const [],
          priceTagIsOn: false,
          showsAuthor: false,
          score: null,
          pdfPath: null,
        );
      }

    }

    return _flyer;
  }
  // --------------------
  ///
  static Future<FlyerModel> refetch({
    @required BuildContext context,
    @required  String flyerID,
  }) async {

    FlyerModel _output;

    if (flyerID != null){

      final FlyerModel _flyerModel = await fetchFlyer(
          context: context,
          flyerID: flyerID,
      );

      await Future.wait(<Future>[

        FlyerLDBOps.deleteFlyers(<String>[flyerID]),

        PicProtocols.refetchPics(FlyerModel.getPicsPaths(_flyerModel)),

      ]);

      _output = await fetchFlyer(
          context: context,
          flyerID: flyerID
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  ///
  static Future<void> renovate({
    @required BuildContext context,
    @required DraftFlyer newDraft,
    @required FlyerModel oldFlyer,
    @required bool sendFlyerUpdateNoteToItsBz,
    @required bool updateFlyerLocally,
    @required bool resetActiveBz,
  }) => RenovateFlyerProtocols.renovate(
    context: context,
    newDraft: newDraft,
    oldFlyer: oldFlyer,
    sendFlyerUpdateNoteToItsBz: sendFlyerUpdateNoteToItsBz,
    updateFlyerLocally: updateFlyerLocally,
    resetActiveBz: resetActiveBz,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateFlyerLocally({
    @required BuildContext context,
    @required FlyerModel flyerModel,
    @required bool notifyFlyerPro,
    @required bool resetActiveBz,
  }) => RenovateFlyerProtocols.updateLocally(
    context: context,
    flyerModel: flyerModel,
    notifyFlyerPro: notifyFlyerPro,
    resetActiveBz: resetActiveBz,
  );
  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------
  ///
  static Future<void> wipeFlyer({
    @required BuildContext context,
    @required FlyerModel flyerModel,
    @required bool showWaitDialog,
    @required bool isDeletingBz,
  }) => WipeFlyerProtocols.wipeFlyer(
    context: context,
    flyerModel: flyerModel,
    showWaitDialog: showWaitDialog,
    isDeletingBz: isDeletingBz,
  );
  // --------------------
  ///
  static Future<void> wipeFlyers({
    @required BuildContext context,
    @required BzModel bzModel,
    @required List<FlyerModel> flyers,
    @required bool showWaitDialog,
    @required bool isDeletingBz,
  }) => WipeFlyerProtocols.wipeFlyers(
    context: context,
    bzModel: bzModel,
    flyers: flyers,
    showWaitDialog: showWaitDialog,
    isDeletingBz: isDeletingBz,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteFlyersLocally({
    @required BuildContext context,
    @required List<String> flyersIDs,
  }) => WipeFlyerProtocols.deleteFlyersLocally(
    context: context,
    flyersIDs: flyersIDs,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteAllBzFlyersLocally({
    @required BuildContext context,
    @required String bzID
  }) => WipeFlyerProtocols.deleteAllBzFlyersLocally(
    context: context,
    bzID: bzID,
  );
  // -----------------------------------------------------------------------------

  /// IMAGIFICATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerModel> imagifyFirstSlide(FlyerModel flyerModel) async {
    FlyerModel _output;

    if (flyerModel != null){

      _output = flyerModel;

      if (Mapper.checkCanLoopList(flyerModel.slides) == true){

        SlideModel _firstSlide = flyerModel.slides[0];

        if (ObjectCheck.objectIsUiImage(_firstSlide.picPath) == false){
          final ui.Image _image = await PicProtocols.fetchPicUiImage(_firstSlide.picPath); // is path
          _firstSlide = _firstSlide.copyWith(
            uiImage: _image,
          );
        }

        final List<SlideModel> _slides = <SlideModel>[...flyerModel.slides];
        _slides[0] = _firstSlide; /// NOT SURE ABOUT YOU FUCKER

        _output = flyerModel.copyWith(
          slides: _slides,
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerModel> imagifySlides(FlyerModel flyerModel) async {
    FlyerModel _output;

    if (flyerModel != null){

      _output = flyerModel;

      if (Mapper.checkCanLoopList(flyerModel.slides) == true){

        final List<SlideModel> _flyerSlides = <SlideModel>[];

        for (int i = 0; i < flyerModel.slides.length; i++){

          final SlideModel _slide = flyerModel.slides[i];

          /// UI IMAGE IS MISSING
          if (_slide.uiImage == null){

            final ui.Image _image = await PicProtocols.fetchPicUiImage(_slide.picPath); // is path
            final SlideModel _updatedSlide = _slide.copyWith(
              uiImage: _image,
            );

            _flyerSlides.add(_updatedSlide);
          }

          /// UI IMAGE IS DEFINED
          else {

            _flyerSlides.add(_slide);

          }

        }

        _output = flyerModel.copyWith(
          slides: _flyerSlides,
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerModel> imagifyBzLogo(FlyerModel flyerModel) async {
    FlyerModel _output = flyerModel;

    if (flyerModel != null){

      assert(flyerModel.bzID != null, 'bz ID is null');

      if (ObjectCheck.objectIsUiImage(flyerModel.bzLogoImage) == false){

        final ui.Image _logoImage = await PicProtocols.fetchPicUiImage(
            StorageColl.getBzLogoPath(flyerModel.bzID)
        );

        _output = flyerModel.copyWith(
          bzLogoImage: _logoImage,
        );

      }


    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerModel> imagifyAuthorPic(FlyerModel flyerModel) async {
    FlyerModel _output = flyerModel;

    if (flyerModel != null){

      assert(flyerModel.bzID != null, 'bz ID is null');

      if (ObjectCheck.objectIsUiImage(flyerModel.authorImage) == false){

        final ui.Image _authorImage = await PicProtocols.fetchPicUiImage(
            StorageColl.getAuthorPicPath(
              authorID: flyerModel.authorID,
              bzID: flyerModel.bzID,
            )
        );

        _output = flyerModel.copyWith(
          authorImage: _authorImage,
        );

      }


    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
