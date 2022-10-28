import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/c_protocols/flyer_protocols/compose_flyers.dart';
import 'package:bldrs/c_protocols/flyer_protocols/fetch_flyers.dart';
import 'package:bldrs/c_protocols/flyer_protocols/renovate_flyers.dart';
import 'package:bldrs/c_protocols/flyer_protocols/wipe_flyers.dart';
import 'package:bldrs/e_back_end/x_ops/ldb_ops/flyer_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/cupertino.dart';

class FlyerProtocols {
  // -----------------------------------------------------------------------------

  const FlyerProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> composeFlyer({
    @required BuildContext context,
    @required FlyerModel flyerModel,
    @required BzModel bzModel,
  }) => ComposeFlyerProtocols.compose(
    context: context,
    flyerToPublish: flyerModel,
    bzModel: bzModel,
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
          pdf: null,
        );
      }

    }

    return _flyer;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerModel> refetch({
    @required BuildContext context,
    @required  String flyerID,
  }) async {

    FlyerModel _output;

    if (flyerID != null){

      await FlyerLDBOps.deleteFlyers(<String>[flyerID]);

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
  /// TESTED : WORKS PERFECT
  static Future<void> renovateFlyer({
    @required BuildContext context,
    @required FlyerModel newFlyer,
    @required FlyerModel oldFlyer,
    @required BzModel bzModel,
    @required bool sendFlyerUpdateNoteToItsBz,
    @required bool updateFlyerLocally,
    @required bool resetActiveBz,
  }) => RenovateFlyerProtocols.renovate(
    context: context,
    newFlyer: newFlyer,
    oldFlyer: oldFlyer,
    bzModel: bzModel,
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
  /// TESTED : WORKS PERFECT
  static Future<BzModel> wipeTheFlyer({
    @required BuildContext context,
    @required FlyerModel flyerModel,
    @required BzModel bzModel,
    @required bool showWaitDialog,
    @required bool isDeletingBz,
  }) => WipeFlyerProtocols.wipeFlyer(
    context: context,
    flyerModel: flyerModel,
    bzModel: bzModel,
    showWaitDialog: showWaitDialog,
    isDeletingBz: isDeletingBz,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<BzModel> wipeFlyers({
    @required BuildContext context,
    @required BzModel bzModel,
    @required List<FlyerModel> flyers,
    @required bool showWaitDialog,
    @required bool updateBzEveryWhere,
    @required bool isDeletingBz,
  }) => WipeFlyerProtocols.wipeMultipleFlyers(
    context: context,
    bzModel: bzModel,
    flyers: flyers,
    showWaitDialog: showWaitDialog,
    updateBzEveryWhere: updateBzEveryWhere,
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
  // --------------------
}
