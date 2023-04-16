import 'dart:async';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/fire/flyer_fire_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/note_events/z_note_events.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:bldrs/super_fire/super_fire.dart';
import 'package:flutter/material.dart';

class FlyerVerificationProtocols {
  // -----------------------------------------------------------------------------

  const FlyerVerificationProtocols();

  // -----------------------------------------------------------------------------

  /// VERIFY FLYER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> verifyFlyer({
    @required BuildContext context,
    @required FlyerModel flyerModel,
    bool showWaitAndSuccessDialogs = true,
    bool sendNote = true,
  }) async {

    if (flyerModel != null && flyerModel.auditState != AuditState.verified) {

      if (showWaitAndSuccessDialogs == true){
        pushWaitDialog(context: context);
      }

      await Future.wait(<Future>[

        /// UPDATE FIELD
        OfficialFire.updateDocField(
          collName: FireColl.flyers,
          docName: flyerModel.id,
          field: 'auditState',
          input: FlyerModel.cipherAuditState(AuditState.verified),
        ),

        /// SEND VERIFICATION NOTE
        if (sendNote == true)
        NoteEvent.sendFlyerIsVerifiedNoteToBz(
          context: context,
          flyerID: flyerModel.id,
          bzID: flyerModel.bzID,
        ),

      ]);

      /// LOCAL UPDATE
      await FlyerProtocols.updateFlyerLocally(
        context: context,
        notifyFlyerPro: true,
        resetActiveBz: false,
        flyerModel: flyerModel.copyWith(
          auditState: AuditState.verified,
        ),
      );

      if (showWaitAndSuccessDialogs == true){

        await WaitDialog.closeWaitDialog(context);

        /// SHOW SUCCESS DIALOG
        await Dialogs.showSuccessDialog(
          context: context,
          firstLine: Verse.plain('Done'),
          secondLine: Verse.plain('flyer ${flyerModel.getShortHeadline()}... got verified'),
        );

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// VERIFY BZ AND ALL HIS FLYERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<FlyerModel>> verifyBz({
    @required BuildContext context,
    @required String bzID,
  }) async {

    List<FlyerModel> _output = [];

    if (bzID != null){

      pushWaitDialog(context: context);

      final BzModel _bzModel = await BzProtocols.fetchBz(
          context: context,
          bzID: bzID,
      );

      assert(_bzModel != null, 'BzModel is null');

      await Future.wait(<Future>[

        _verifyAllBzFlyers(
          context: context,
          bzModel: _bzModel,
        ).then((List<FlyerModel> flyers){
          _output = flyers;
        }),

        _verifyBzDoc(
          context: context,
          bzModel: _bzModel,
        ),

        NoteEvent.sendBzIsVerifiedNote(
          context: context,
          bzModel: _bzModel,
        ),

      ]);

      await WaitDialog.closeWaitDialog(context);

      /// SHOW SUCCESS DIALOG
      await Dialogs.showSuccessDialog(
        context: context,
        firstLine: Verse.plain('Done'),
        secondLine: Verse.plain('Bz ${_bzModel.name}... got verified'),
      );

    }

    return  _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<FlyerModel>> _verifyAllBzFlyers({
    @required BuildContext context,
    @required BzModel bzModel,
  }) async {

    final List<FlyerModel> _nonVerifiedFlyers = await FlyerFireOps.readFlyersByQuery(
      queryModel: FireQueryModel(
        collRef: OfficialFire.getSuperCollRef(
            aCollName: FireColl.flyers,
        ),
        limit: 1000,
        finders: <FireFinder>[

          FireFinder(
              field: 'bzID',
              comparison: FireComparison.equalTo,
              value: bzModel.id,
          ),

          FireFinder(
            field: 'auditState',
            comparison: FireComparison.equalTo,
            value: FlyerModel.cipherAuditState(AuditState.pending),
          ),

        ],
      ),
    );

    await Future.wait(<Future>[

      ...List.generate(_nonVerifiedFlyers.length, (index){

        return verifyFlyer(
          context: context,
          flyerModel: _nonVerifiedFlyers[index],
          sendNote: false,
          showWaitAndSuccessDialogs: false,
        );

    }),

    ]);

    return _nonVerifiedFlyers;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _verifyBzDoc({
    @required BuildContext context,
    @required BzModel bzModel,
  }) async {

    await BzProtocols.renovateBz(
        context: context,
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
