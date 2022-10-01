import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/flyer_protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/a_note_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/bz_fire_ops.dart';
import 'package:bldrs/e_back_end/x_ops/ldb_ops/bz_ldb_ops.dart';
import 'package:bldrs/e_back_end/x_ops/real_ops/bz_record_real_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WipeBzProtocols {
  // -----------------------------------------------------------------------------

  const WipeBzProtocols();

  // -----------------------------------------------------------------------------

  /// WIPE OUT

  // --------------------
  static Future<void> wipeBz({
    @required BuildContext context,
    @required BzModel bzModel,
    @required bool showWaitDialog,
    @required bool includeMyselfInBzDeletionNote,
  }) async {

    blog('WipeBzProtocol.wipeBz : START');

    if (showWaitDialog == true){
      unawaited(WaitDialog.showWaitDialog(
        context: context,
        loadingVerse: Verse(
          text: '##Deleting ${bzModel.name}',
          translate: true,
          variables: bzModel.name,
        ),
      ));
    }

    await Future.wait(<Future>[

      /// DELETE BZ FLYERS
      _deleteAllBzFlyersOps(
        context: context,
        bzModel: bzModel,
        showWaitDialog: true,
        updateBz: false,
      ),

      /// DELETE BZ NOTES (RECEIVED)
      NoteProtocols.wipeBzReceivedNotes(
        context: context,
        bzID: bzModel.id,
      ),

      /// DELETE BZ SENT AUTHORSHIPS
      NoteProtocols.wipeBzSentAuthorshipNotes(
        context: context,
        bzID: bzModel.id,
      ),

      /// DELETE BZ RECORDS - COUNTERS
      BzRecordRealOps.deleteAllBzCountersAndRecords(
        context: context,
        bzID: bzModel.id,
      ),

    ]);

    /// DELETE BZ ON FIREBASE
    await BzFireOps.deleteBzOps(
      context: context,
      bzModel: bzModel,
    );

    /// CLOSE DIALOG BEFORE SENDING NOTES => FIXES A goBack() bug
    if (showWaitDialog == true){
      await WaitDialog.closeWaitDialog(context);
    }

    /// SEND DELETION NOTES TO AUTHORS
    await NoteProtocols.sendBzDeletionNoteToAllAuthors(
      context: context,
      bzModel: bzModel,
      includeMyself: includeMyselfInBzDeletionNote,
    );


    blog('WipeBzProtocol.wipeBz : END');
  }
  // --------------------
  static Future<void> _deleteAllBzFlyersOps({
    @required BuildContext context,
    @required BzModel bzModel,
    @required bool updateBz,
    @required bool showWaitDialog,
  }) async {
    blog('WipeBzProtocols._deleteAllBzFlyersOps : START');

    if (showWaitDialog == true){
      unawaited(WaitDialog.showWaitDialog(
        context: context,
        loadingVerse: Verse(
          text: '##Deleting ${bzModel.flyersIDs.length} Flyers',
          translate: true,
          variables: bzModel.flyersIDs.length,
        ),
      ));
    }

    /// DELETE BZ FLYERS
    final List<FlyerModel> _flyers = await FlyerProtocols.fetchFlyers(
        context: context,
        flyersIDs: bzModel.flyersIDs
    );

    await FlyerProtocols.wipeFlyers(
      context: context,
      bzModel: bzModel,
      flyers: _flyers,
      showWaitDialog: false,
      updateBzEveryWhere: updateBz,
      isDeletingBz: true,
    );

    if (showWaitDialog == true){
      await WaitDialog.closeWaitDialog(context);
    }

    blog('WipeBzProtocols._deleteAllBzFlyersOps : END');

  }
  // -----------------------------------------------------------------------------

  /// LOCAL DELETION

  // --------------------
  static Future<void> deleteLocally({
    @required BuildContext context,
    @required String bzID,
    @required String invoker,
  }) async {

    blog('WipeBzProtocol.deleteLocally : $invoker : START');

    // NOTE DELETES ALL BZ MODEL INSTANCES IN LDB AND BZ PRO

    /// DELETE BZ ON LDB
    await BzLDBOps.deleteBzOps(
      bzID: bzID,
    );

    blog('WipeBzProtocol.deleteLocally : ops should reach here ba2aaaaa');

    /// DELETE BZ ON PROVIDER
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    _bzzProvider.removeProBzEveryWhere(
      bzID: bzID,
      notify: true,
    );

    blog('WipeBzProtocol.deleteLocally : $invoker : END');
  }
  // -----------------------------------------------------------------------------
}
