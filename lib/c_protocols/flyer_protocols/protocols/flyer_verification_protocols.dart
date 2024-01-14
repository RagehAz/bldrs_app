import 'dart:async';

import 'package:basics/helpers/maps/lister.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/publication_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/publish_time_model.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/fire/flyer_fire_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/note_protocols/note_events/z_note_events.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:fire/super_fire.dart';
/// => TAMAM
class FlyerVerificationProtocols {
  // -----------------------------------------------------------------------------

  const FlyerVerificationProtocols();

  // -----------------------------------------------------------------------------

  /// VERIFY FLYER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> verifyFlyer({
    required FlyerModel? flyerModel,
    bool showWaitAndSuccessDialogs = true,
    bool sendNote = true,
  }) async {

    if (
        flyerModel?.id != null &&
        flyerModel?.bzID != null &&
        flyerModel?.publishState != PublishState.published
    ) {

      if (showWaitAndSuccessDialogs == true){
        WaitDialog.showUnawaitedWaitDialog();
      }

      final List<PublishTime> _publishTimes = <PublishTime>[...?flyerModel!.times];
      _publishTimes.add(PublishTime(
        state: PublishState.published,
        time: DateTime.now(),
      ));

      final FlyerModel _newFlyer = flyerModel.copyWith(
        publishState: PublishState.published,
        times: _publishTimes,
      );

      await Future.wait(<Future>[

        FlyerProtocols.renovateFlyer(
          oldFlyer: flyerModel,
          newFlyer: _newFlyer,
        ),

        _promoteFlyerInBzPublications(
          flyerModel: _newFlyer,
        ),

        /// SEND VERIFICATION NOTE
        if (sendNote == true)
        NoteEvent.sendFlyerIsVerifiedNoteToBz(
          flyerID: flyerModel.id!,
          bzID: flyerModel.bzID!,
        ),

      ]);

      if (showWaitAndSuccessDialogs == true){

        await WaitDialog.closeWaitDialog();

        /// SHOW SUCCESS DIALOG
        await Dialogs.showSuccessDialog(
          firstLine: Verse.plain('Done'),
          secondLine: Verse.plain('flyer ${flyerModel.getShortHeadline()}... got verified'),
        );

      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _promoteFlyerInBzPublications({
    required FlyerModel? flyerModel,
  }) async {

    final BzModel? _bz = await BzProtocols.fetchBz(
      bzID: flyerModel?.bzID,
    );

    if (_bz != null && flyerModel?.id != null){

      final PublicationModel _newPub = PublicationModel.insertFlyerInPublications(
          pub: _bz.publication,
          flyerID: flyerModel!.id!,
          toState: PublishState.published,
      );

      await BzProtocols.renovateBz(
        oldBz: _bz,
        newBz: _bz.copyWith(
          publication: _newPub,
        ),
        newLogo: null,
        showWaitDialog: false,
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// VERIFY BZ AND ALL HIS FLYERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<FlyerModel>> verifyBz({
    required String? bzID,
  }) async {

    List<FlyerModel> _output = [];

    if (bzID != null){

      WaitDialog.showUnawaitedWaitDialog();

      BzModel? _bzModel = await BzProtocols.fetchBz(
          bzID: bzID,
      );

      if (_bzModel?.id != null) {

        _output = await _verifyAllBzFlyers(
          bzModel: _bzModel!,
        );

        _bzModel = await BzProtocols.refetch(
          bzID: bzID,
        );

         await _verifyBzDoc(
           bzModel: _bzModel!,
         );

         await NoteEvent.sendBzIsVerifiedNote(
           bzModel: _bzModel,
         );

        await WaitDialog.closeWaitDialog();

        /// SHOW SUCCESS DIALOG
        await Dialogs.showSuccessDialog(
          firstLine: Verse.plain('Done'),
          secondLine: Verse.plain('Bz ${_bzModel.name}... got verified'),
        );
        
      }
    }

    return  _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<FlyerModel>> _verifyAllBzFlyers({
    required BzModel bzModel,
  }) async {

    final List<FlyerModel>? _nonVerifiedFlyers = await FlyerFireOps.readFlyersByQuery(
      queryModel: FireQueryModel(
        coll: FireColl.flyers,
        limit: 1000,
        finders: <FireFinder>[

          FireFinder(
              field: 'bzID',
              comparison: FireComparison.equalTo,
              value: bzModel.id,
          ),

          FireFinder(
            field: 'publishState',
            comparison: FireComparison.equalTo,
            value: PublicationModel.cipherPublishState(PublishState.pending),
          ),

        ],
      ),
    );

    if (Lister.checkCanLoop(_nonVerifiedFlyers) == true){

      for (final FlyerModel _flyer in _nonVerifiedFlyers!){

        UiProvider.proSetLoadingVerse(
            verse: Verse.plain('Verifying flyer ${_flyer.getShortHeadline()}...'),
        );
        
        await verifyFlyer(
          flyerModel: _flyer,
          showWaitAndSuccessDialogs: false,
          sendNote: false,
        );

      }
      
    }


    return [...?_nonVerifiedFlyers];
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _verifyBzDoc({
    required BzModel bzModel,
  }) async {

    UiProvider.proSetLoadingVerse(verse: Verse.plain('Verifying Bz: ${bzModel.name}'));
    
    await BzProtocols.renovateBz(
        showWaitDialog: false,
        oldBz: bzModel,
        newLogo: null,
        newBz: bzModel.copyWith(
          isVerified: true,
        ),
    );

  }
  // -----------------------------------------------------------------------------
}
