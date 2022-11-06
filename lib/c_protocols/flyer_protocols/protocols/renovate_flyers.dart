import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/mutables/draft_slide.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/real/bz_record_real_ops.dart';
import 'package:bldrs/c_protocols/chain_protocols/real/city_phids_real_ops.dart';
import 'package:bldrs/c_protocols/note_protocols/note_events/z_note_events.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/flyer_protocols/provider/flyers_provider.dart';
import 'package:bldrs/c_protocols/flyer_protocols/fire/flyer_fire_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/ldb/flyer_ldb_ops.dart';
import 'package:bldrs/c_protocols/pdf_protocols/protocols/pdf_protocols.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RenovateFlyerProtocols {
  // -----------------------------------------------------------------------------

  const RenovateFlyerProtocols();

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> renovate({
    @required BuildContext context,
    @required DraftFlyer newDraft,
    @required FlyerModel oldFlyer,
    @required bool sendFlyerUpdateNoteToItsBz,
    @required bool updateFlyerLocally,
    @required bool resetActiveBz,
  }) async {
    blog('RenovateFlyerProtocols.renovate : START');

    /// ASSERTIONS
    assert(
    (resetActiveBz == true && updateFlyerLocally == true) || (resetActiveBz == false)
    , 'RenovateFlyerProtocols renovate : CAN NOT resetActiveBz IF updateFlyerLocally is false');
    assert(newDraft != null, 'flyer is null');
    // -------------------------------

    final BzModel _bzModel = await BzProtocols.fetch(
        context: context,
        bzID: newDraft.bzID,
    );

    final FlyerModel _flyerToUpload = await DraftFlyer.draftToFlyer(
      draft: newDraft,
      toLDB: false,
    );

    await Future.wait(<Future>[

      /// RENOVATE SLIDES PICS
      PicProtocols.renovatePics(DraftSlide.getPicModels(newDraft.draftSlides)),

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
      BzRecordRealOps.incrementBzCounter(
        bzID: newDraft.bzID,
        field: 'allSlides',
        incrementThis: newDraft.draftSlides.length - oldFlyer.slides.length,
      ),

      /// INCREMENT CITY CHAIN USAGE
      CityPhidsRealOps.updateFlyerCityChainUsage(
          context: context,
          flyerModel: _flyerToUpload,
          oldFlyer: oldFlyer,
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
          context: context,
          flyerModel: _flyerToUpload,
          notifyFlyerPro: true,
          resetActiveBz: resetActiveBz,
        ),

    ]);

    blog('RenovateFlyerProtocols.renovate : END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateLocally({
    @required BuildContext context,
    @required FlyerModel flyerModel,
    @required bool notifyFlyerPro,
    @required bool resetActiveBz,
  }) async {
    blog('RenovateFlyerProtocols.updateLocally : START');

    if (flyerModel != null){

      await FlyerLDBOps.insertFlyer(flyerModel);

      final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
      _flyersProvider.updateFlyerInAllProFlyers(
          flyerModel: flyerModel,
          notify: notifyFlyerPro
      );

      if (resetActiveBz == true){
        BzzProvider.resetActiveBz(context);
      }

    }

    blog('RenovateFlyerProtocols.updateLocally : END');
  }
  // --------------------
  ///
  static Future<void> _renovateOrWipePDF({
    @required DraftFlyer draft,
    @required FlyerModel oldFlyer,
  }) async {

    /// FLYER SHOULD HAVE NO PDF
    if (draft.pdfModel == null){

      /// FLYER DID NOT HAVE A PDF
      if (oldFlyer.pdfPath == null){
        // do nothing
      }

      /// FLYER HAD A PDF
      else {
        await PDFProtocols.wipe(oldFlyer.pdfPath);
      }

    }

    /// FLYER HAS A PDF
    else {

      /// FLYER DID NOT HAVE A PDF
      if (oldFlyer.pdfPath == null){
        await PDFProtocols.compose(draft.pdfModel);
      }

      /// FLYER HAD A PDF
      else {
        await PDFProtocols.renovate(draft.pdfModel);
      }

    }

  }
  // --------------------
  ///
  static Future<void> _wipeUnusedSlidesPics({
    @required DraftFlyer draft,
    @required FlyerModel oldFlyer,
  }) async {
    blog('wipeUnusedSlidesPics : START');

    final int _newLength = draft.draftSlides.length;
    final int _oldLength = oldFlyer.slides.length;

    if (_oldLength > _newLength) {

      final List<String> _picsPathsToBeDeleted = <String>[];

      for (int i = _newLength; i < _oldLength; i++) {
        final String _path = oldFlyer.slides[i].picPath;
        _picsPathsToBeDeleted.add(_path);
      }

      await PicProtocols.wipePics(_picsPathsToBeDeleted);

    }

      blog('wipeUnusedSlidesPics : END');
  }

  // --------------------
}
