import 'dart:async';

import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/b_bz/sub/pending_author_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/census_protocols/protocols/census_listeners.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/note_events/z_note_events.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/c_protocols/bz_protocols/fire/bz_fire_ops.dart';
import 'package:bldrs/c_protocols/bz_protocols/ldb/bz_ldb_ops.dart';
import 'package:bldrs/c_protocols/bz_protocols/real/bz_record_real_ops.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/c_protocols/pic_protocols/ldb/pic_ldb_ops.dart';
import 'package:bldrs/e_back_end/g_storage/foundation/storage_paths.dart';
import 'package:bldrs/e_back_end/g_storage/storage.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WipeBzProtocols {
  // -----------------------------------------------------------------------------

  const WipeBzProtocols();

  // -----------------------------------------------------------------------------

  /// WIPE OUT

  // --------------------
  /// TASK : TEST ME
  static Future<void> wipeBz({
    @required BuildContext context,
    @required BzModel bzModel,
    @required bool showWaitDialog,
    @required bool includeMyselfInBzDeletionNote,
    @required bool deleteBzLocally, // TASK : DELETE THIS LINE WHEN EVERYTHING IS GOOD
  }) async {

    blog('WipeBzProtocol.wipeBz : START');

    if (showWaitDialog == true){
      unawaited(WaitDialog.showWaitDialog(
        context: context,
        loadingVerse: Verse(
          text: '${xPhrase(context, 'phid_deleting')} ${bzModel.name}',
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

      /// DELETE BZ NOTES
      NoteProtocols.wipeAllNotes(
        partyType: PartyType.bz,
        id: bzModel.id,
      ),

      NoteProtocols.unsubscribeFromAllBzTopics(
        context: context,
        bzID: bzModel.id,
        renovateUser: true,
      ),

      /// DELETE BZ STORAGE DIRECTORY
      Storage.deletePath(
        context: context,
        path: '${StorageColl.bzz}/${bzModel.id}',
      ),

      /// DELETE BZ LOGO & AUTHORS PICS
      PicLDBOps.deletePic(bzModel.logoPath),
      PicLDBOps.deletePics(AuthorModel.getAuthorsPicsPaths(bzModel.authors)),

      /// CENSUS
      CensusListener.onWipeBz(bzModel),

    ]);

    await Future.wait(<Future>[

      /// DELETE BZ RECORDS - COUNTERS : NOTE : SHOULD BE DELETED AFTER CENSUS WIPE PROTOCOL IS DONE
      BzRecordRealOps.deleteAllBzCountersAndRecords(
        bzID: bzModel.id,
      ),

      /// DELETE BZ ON FIREBASE
      BzFireOps.delete(
        bzModel: bzModel,
      ),

      /// DELETE LOCALLY
      if (deleteBzLocally == true)
      deleteLocally(
        context: context,
        bzID: bzModel.id,
        invoker: 'wipeBz',
      ),

    ]);

    /// CLOSE DIALOG BEFORE SENDING NOTES => FIXES A goBack() bug
    if (showWaitDialog == true){
      await WaitDialog.closeWaitDialog(context);
    }

    /// SEND DELETION NOTES TO AUTHORS
    await NoteEvent.sendBzDeletionNoteToAllAuthors(
      context: context,
      bzModel: bzModel,
      includeMyself: includeMyselfInBzDeletionNote,
    );

    blog('WipeBzProtocol.wipeBz : END');
  }
  // --------------------
  /// TASK : TEST ME
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
  /// TESTED : WORKS PERFECT
  static Future<void> deleteLocally({
    @required BuildContext context,
    @required String bzID,
    @required String invoker,
  }) async {

    /// NOTE DELETES ALL BZ MODEL INSTANCES IN LDB AND BZ PRO

    blog('WipeBzProtocol.deleteLocally : $invoker : START');

    final BzModel _bzModel = await BzProtocols.fetchBz(
        context: context,
        bzID: bzID
    );

    await Future.wait(<Future>[

      /// DELETE ALL BZ FLYERS LOCALLY
      FlyerProtocols.deleteFlyersLocally(
        context: context,
        flyersIDs: _bzModel?.flyersIDs,
      ),

      /// DELETE BZ ON LDB
      BzLDBOps.deleteBzOps(
        bzID: bzID,
      ),

      /// DELETE BZ EDITOR SESSION
      BzLDBOps.deleteBzEditorSession(bzID),

      /// DELETE AUTHOR EDITOR SESSION
      BzLDBOps.deleteAuthorEditorSession(AuthFireOps.superUserID()),

    ]);


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

  /// PENDING AUTHOR

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipePendingAuthor({
    @required BuildContext context,
    @required String bzID,
    @required String pendingUserID,
  }) async {

    final BzModel _oldBz = await BzProtocols.fetchBz(
        context: context,
        bzID: bzID,
    );

    if (_oldBz != null){

      /// remove this user from the pending authors list to update bz
      final List<PendingAuthor> _updatedPendingUsers = PendingAuthor.removePendingAuthor(
        pendingAuthors: _oldBz.pendingAuthors,
        userID: pendingUserID,
      );

      /// update bz model to renovate
      final BzModel _newBz = _oldBz.copyWith(
        pendingAuthors: _updatedPendingUsers,
      );

      /// RENOVATE BZ
      await BzProtocols.renovateBz(
        context: context,
        newBz: _newBz,
        oldBz: _oldBz,
        showWaitDialog: false,
        navigateToBzInfoPageOnEnd: false,
        newLogo: null,
      );

    }

  }
  // -----------------------------------------------------------------------------
}
