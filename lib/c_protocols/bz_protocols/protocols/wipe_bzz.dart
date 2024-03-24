import 'dart:async';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/b_bz/sub/pending_author_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/fire/bz_fire_ops.dart';
import 'package:bldrs/c_protocols/bz_protocols/ldb/bz_ldb_ops.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/census_protocols/census_listeners.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/main_providers/home_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/media_protocols/ldb/media_ldb_ops.dart';
import 'package:bldrs/c_protocols/note_protocols/note_events/note_events.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/records_protocols/recorder_protocols.dart';
import 'package:bldrs/e_back_end/f_cloud/cloud_functions.dart';
import 'package:bldrs/e_back_end/g_storage/storage_path.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class WipeBzProtocols {
  // -----------------------------------------------------------------------------

  const WipeBzProtocols();

  // -----------------------------------------------------------------------------

  /// WIPE OUT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeBz({
    required BuildContext context,
    required BzModel? bzModel,
    required bool showWaitDialog,
    // required bool includeMyselfInBzDeletionNote,
    // required bool deleteBzLocally,
  }) async {

    blog('WipeBzProtocol.wipeBz : START');

    if (bzModel != null){

      if (showWaitDialog == true){
        WaitDialog.showUnawaitedWaitDialog(
          verse: Verse(
            id: '${getWord('phid_deleting')} ${bzModel.name}',
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
          bzID: bzModel.id,
          renovateUser: true,
        ),
        /// DELETE BZ STORAGE DIRECTORY
        BldrsCloudFunctions.deleteStorageDirectory(
          path: StoragePath.bzz_bzID(bzModel.id),
        ),
        /// DELETE BZ LOGO & AUTHORS PICS
        MediaLDBOps.deleteMedia(
          path: bzModel.logoPath,
        ),
        MediaLDBOps.deleteMedias(
          paths: AuthorModel.getAuthorsPicsPaths(bzModel.authors),
        ),
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
        /// DELETE LOCALLY : IS HANDLED BY NOTE TRIGGER FOR EACH AUTHOR
        // if (deleteBzLocally == true)
        //   /// DELETING BZ LOCALLY IMPACTS LISTENING TO NOTE TRIGGERS
        //   deleteLocally(
        //     bzID: bzModel.id,
        //     invoker: 'wipeBz',
        //   ),

      ]);

      /// SEND DELETION NOTES TO AUTHORS
      await NoteEvent.sendBzDeletionNoteToAllAuthors(
        bzModel: bzModel,
        includeMyself: true,
      );

      /// CLOSE DIALOG BEFORE SENDING NOTES => FIXES A goBack() bug
      if (showWaitDialog == true){
        await WaitDialog.closeWaitDialog();
      }

    }

    blog('WipeBzProtocol.wipeBz : END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _deleteAllBzFlyersOps({
    required BuildContext context,
    required BzModel? bzModel,
  }) async {

      final String _text =  '${getWord('phid_deleting')} '
                            '${bzModel?.publication.getAllFlyersIDs().length} '
                            '${getWord('phid_flyers')}';

      WaitDialog.showUnawaitedWaitDialog(
        verse: Verse.plain(_text),
      );


    await FlyerProtocols.onWipeBz(
      bzID: bzModel?.id,
    );

    await WaitDialog.closeWaitDialog();

  }
  // -----------------------------------------------------------------------------

  /// LOCAL DELETION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteLocally({
    required String? bzID,
    required String invoker,
  }) async {

    /// NOTE DELETES ALL BZ MODEL INSTANCES IN LDB AND BZ PRO

    blog('WipeBzProtocol.deleteLocally : $invoker : START');

    if (bzID != null){

      final BzModel? _bzModel = await BzProtocols.fetchBz(
          bzID: bzID
      );

      await Future.wait(<Future>[

        /// DELETE ALL BZ FLYERS LOCALLY
        FlyerProtocols.deleteFlyersLocally(
          flyersIDs: _bzModel?.publication.getAllFlyersIDs(),
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

      if (HomeProvider.proGetActiveBzModel(context: getMainContext(), listen: false)?.id == bzID){
        HomeProvider.proSetActiveBzModel(bzModel: null, context: getMainContext(), notify: true);
      }

    }

    blog('WipeBzProtocol.deleteLocally : $invoker : END');
  }
  // -----------------------------------------------------------------------------

  /// PENDING AUTHOR

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipePendingAuthor({
    required String? bzID,
    required String? pendingUserID,
  }) async {

    final BzModel? _oldBz = await BzProtocols.fetchBz(
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
        newBz: _newBz,
        oldBz: _oldBz,
        showWaitDialog: false,
        newLogo: null,
      );

    }

  }
  // -----------------------------------------------------------------------------
}
