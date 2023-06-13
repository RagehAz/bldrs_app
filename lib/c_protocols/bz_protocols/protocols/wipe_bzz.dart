import 'dart:async';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/b_bz/sub/pending_author_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/fire/bz_fire_ops.dart';
import 'package:bldrs/c_protocols/bz_protocols/ldb/bz_ldb_ops.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/census_protocols/census_listeners.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/note_protocols/note_events/z_note_events.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/pic_protocols/ldb/pic_ldb_ops.dart';
import 'package:bldrs/c_protocols/recorder_protocols/recorder_protocols.dart';
import 'package:bldrs/e_back_end/f_cloud/cloud_functions.dart';
import 'package:bldrs/e_back_end/g_storage/storage_path.dart';
import 'package:fire/super_fire.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
/// => TAMAM
class WipeBzProtocols {
  // -----------------------------------------------------------------------------

  const WipeBzProtocols();

  // -----------------------------------------------------------------------------

  /// WIPE OUT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeBz({
    @required BuildContext context,
    @required BzModel bzModel,
    @required bool showWaitDialog,
    @required bool includeMyselfInBzDeletionNote,
    @required bool deleteBzLocally,
  }) async {

    blog('WipeBzProtocol.wipeBz : START');

    if (showWaitDialog == true){
      pushWaitDialog(
        verse: Verse(
          id: '${Verse.transBake('phid_deleting')} ${bzModel.name}',
          translate: false,
          variables: bzModel.name,
        ),
      );
    }

    await Future.wait(<Future>[

      /// DELETE BZ FLYERS
      _deleteAllBzFlyersOps(
        context: getMainContext(),
        bzModel: bzModel,
      ),

      /// DELETE BZ NOTES
      NoteProtocols.wipeAllNotes(
        partyType: PartyType.bz,
        id: bzModel.id,
      ),

      NoteProtocols.unsubscribeFromAllBzTopics(
        context: getMainContext(),
        bzID: bzModel.id,
        renovateUser: true,
      ),

      /// DELETE BZ STORAGE DIRECTORY
      BldrsCloudFunctions.deleteStorageDirectory(
        context: getMainContext(),
        path: StoragePath.bzz_bzID(bzModel.id),
      ),

      /// DELETE BZ LOGO & AUTHORS PICS
      PicLDBOps.deletePic(bzModel.logoPath),
      PicLDBOps.deletePics(AuthorModel.getAuthorsPicsPaths(bzModel.authors)),

      /// CENSUS
      CensusListener.onWipeBz(bzModel),

    ]);

    await Future.wait(<Future>[

      /// DELETE BZ RECORDS - COUNTERS : NOTE : SHOULD BE DELETED AFTER CENSUS WIPE PROTOCOL IS DONE
      RecorderProtocols.onWipeBz(
        bzID: bzModel.id,
      ),

      /// DELETE BZ ON FIREBASE
      BzFireOps.delete(
        bzModel: bzModel,
      ),

      /// DELETE LOCALLY
      if (deleteBzLocally == true)
        /// DELETING BZ LOCALLY IMPACTS LISTENING TO NOTE TRIGGERS
      deleteLocally(
        bzID: bzModel.id,
        invoker: 'wipeBz',
      ),

    ]);

    /// SEND DELETION NOTES TO AUTHORS
    await NoteEvent.sendBzDeletionNoteToAllAuthors(
      context: getMainContext(),
      bzModel: bzModel,
      includeMyself: includeMyselfInBzDeletionNote,
    );

    /// CLOSE DIALOG BEFORE SENDING NOTES => FIXES A goBack() bug
    if (showWaitDialog == true){
      await WaitDialog.closeWaitDialog();
    }

    blog('WipeBzProtocol.wipeBz : END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _deleteAllBzFlyersOps({
    @required BuildContext context,
    @required BzModel bzModel,
  }) async {

      final String _text =  '${Verse.transBake('phid_deleting')} '
                            '${bzModel.flyersIDs.length} '
                            '${Verse.transBake('phid_flyers')}';

      pushWaitDialog(
        verse: Verse.plain(_text),
      );


    await FlyerProtocols.onWipeBz(
      bzID: bzModel.id,
    );

    await WaitDialog.closeWaitDialog();

  }
  // -----------------------------------------------------------------------------

  /// LOCAL DELETION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteLocally({
    @required String bzID,
    @required String invoker,
  }) async {

    /// NOTE DELETES ALL BZ MODEL INSTANCES IN LDB AND BZ PRO

    blog('WipeBzProtocol.deleteLocally : $invoker : START');

    final BzModel _bzModel = await BzProtocols.fetchBz(
        bzID: bzID
    );

    await Future.wait(<Future>[

      /// DELETE ALL BZ FLYERS LOCALLY
      FlyerProtocols.deleteFlyersLocally(
        flyersIDs: _bzModel?.flyersIDs,
      ),

      /// DELETE BZ ON LDB
      BzLDBOps.deleteBzOps(
        bzID: bzID,
      ),

      /// DELETE BZ EDITOR SESSION
      BzLDBOps.deleteBzEditorSession(bzID),

      /// DELETE AUTHOR EDITOR SESSION
      BzLDBOps.deleteAuthorEditorSession(Authing.getUserID()),

    ]);


    blog('WipeBzProtocol.deleteLocally : ops should reach here ba2aaaaa');

    /// DELETE BZ ON PROVIDER
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(getMainContext(), listen: false);
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
        newLogo: null,
      );

    }

  }
  // -----------------------------------------------------------------------------
}
