import 'dart:async';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/c_protocols/flyer_protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/a_note_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/e_db/fire/ops/bz_ops.dart';
import 'package:bldrs/e_db/ldb/ops/bz_ldb_ops.dart';
import 'package:bldrs/e_db/real/ops/bz_record_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WipeBzProtocols {
// -----------------------------------------------------------------------------

  const WipeBzProtocols();

// -----------------------------------------------------------------------------

  /// WIPE OUT

// ----------------------------------
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
        loadingPhrase: 'Deleting ${bzModel.name}',
      ));
    }

    /// DELETE BZ FLYERS
    await _deleteAllBzFlyersOps(
      context: context,
      bzModel: bzModel,
      showWaitDialog: true,
      updateBz: false,
    );

    /// DELETE BZ NOTES (RECEIVED)
    await NoteProtocols.wipeBzReceivedNotes(
      context: context,
      bzID: bzModel.id,
    );

    /// DELETE BZ SENT AUTHORSHIPS
    await NoteProtocols.wipeBzSentAuthorshipNotes(
      context: context,
      bzID: bzModel.id,
    );

    /// DELETE BZ RECORDS - COUNTERS
    await BzRecordOps.deleteAllBzCountersAndRecords(
      context: context,
      bzID: bzModel.id,
    );

    /// DELETE BZ ON FIREBASE
    await BzFireOps.deleteBzOps(
      context: context,
      bzModel: bzModel,
    );

    /// SEND DELETION NOTES TO AUTHORS
    await NoteProtocols.sendBzDeletionNoteToAllAuthors(
      context: context,
      bzModel: bzModel,
      includeMyself: includeMyselfInBzDeletionNote,
    );

    /// NO NEED TO DELETE BZ IN LDB AND PRO OR REMOVE BZ FROM USER ID OR UPDATE USER NOW
    /// AS [authorBzExitAfterBzDeletionProtocol] METHOD LISTENS TO NOTE AND IS
    /// ACTIVATED AUTOMATICALLY
    /*
    /// DELETE BZ ON LDB
    await localBzDeletionProtocol(
      context: context,
      bzID: bzModel.id,
    );

    /// REMOVE BZ ID FROM MY BZZ IDS
    final UserModel _userModel = UsersProvider.proGetMyUserModel(
        context: context,
        listen: false,
    );
    final UserModel _updated = UserModel.removeBzIDFromMyBzzIDs(
        userModel: _userModel,
        bzIDToRemove: bzModel.id,
    );

    /// UPDATE USER MODEL EVERYWHERE
    await UserProtocol.updateMyUserEverywhereProtocol(
        context: context,
        newUserModel: _updated,
    );
     */

    if (showWaitDialog == true){
      WaitDialog.closeWaitDialog(context);
    }

    blog('WipeBzProtocol.wipeBz : END');
  }
// ----------------------------------
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
        loadingPhrase: 'Deleting ${bzModel.flyersIDs.length} Flyers',
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
      WaitDialog.closeWaitDialog(context);
    }

    blog('WipeBzProtocols._deleteAllBzFlyersOps : END');

  }
// -----------------------------------------------------------------------------

  /// LOCAL DELETION

// ----------------------------------
  static Future<void> deleteLocally({
    @required BuildContext context,
    @required String bzID,
  }) async {

    blog('WipeBzProtocol.deleteLocally : START');

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

    blog('WipeBzProtocol.deleteLocally : END');
  }
// -----------------------------------------------------------------------------
}
