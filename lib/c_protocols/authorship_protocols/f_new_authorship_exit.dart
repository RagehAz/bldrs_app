// ignore_for_file: avoid_redundant_argument_values
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/ldb/bz_ldb_ops.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/flyer_protocols/fire/flyer_fire_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/ldb/flyer_ldb_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/note_events/z_note_events.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/provider/notes_provider.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/g_storage/storage.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';

class NewAuthorshipExit {
  // -----------------------------------------------------------------------------

  const NewAuthorshipExit();

  // -----------------------------------------------------------------------------

  /// EXIT HIMSELF

  // --------------------
  /// TASK : TEST ME
  static Future<void> onRemoveMySelf({
    @required BuildContext context,
    @required AuthorModel authorModel,
    @required BzModel bzModel,
  }) async {

    /// SHOW CONFIRM DIALOG
    final bool _canDelete = await _deleteMyselfConfirmationDialogs(
      context: context,
    );

    if (_canDelete == true){

      /// (only i can) : GO TO HOME SCREEN
      await _goBackToHomeScreen(
        context: context,
      );

      /// SHOW WAIT DIALOG
      _showRemovingAuthorWaitDialog(
        context: context,
        authorName: authorModel.name, // authorName != userName
        isBzDeleted: false,
      );

      /// REMOVE AUTHOR FROM BZ MODEL
      /// MIGRATE OWNERSHIP OF ALL MY FLYERS TO BZ CREATOR AND TURN OFF SHOW AUTHOR
      /// RENOVATE BZ
      await _migrateFlyersAndRemoveAuthorAndRenovateBz(
        context: context,
        bzModel: bzModel,
        authorModel: authorModel,
      );

      /// (only i can) : REMOVE BZ FROM PRO MY BZZ
      /// (only i can) : REMOVE BZ & BZ TOPICS FROM MY USER MODEL
      /// (only i can) : UNSUBSCRIBE FROM BZ FCM TOPICS
      /// (only i can) : WIPE AUTHOR PIC
      /// (only i can) : RENOVATE MY USER MODEL
      /// (only i can) : REMOVE BZ NOTES FROM OBELISK NUMBERS
      await _doAllMyUserRemovalFromBzOps(
        context: context,
        bzID: bzModel.id,
      );

      /// (only i can) : SEND authorExit NOTES
      await NoteEvent.sendAuthorDeletionNotes(
        context: context,
        bzModel: bzModel,
        deletedAuthor: authorModel,
        sendToUserAuthorExitNote: false,
      );

      /// CLOSE WAIT DIALOG
      await _closeWaitDialog(
        context: context,
      );

      /// SHOW SUCCESS CENTER DIALOG
      await _showRemovedAuthorSuccessDialog(
        context: context,
        isBzDeleted: false,
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// KICK OUT

  // --------------------
  /// TASK : TEST ME
  static Future<void> onRemoveOtherAuthor({
    @required BuildContext context,
    @required AuthorModel authorModel,
    @required BzModel bzModel,
  }) async {

    /// SHOW DIALOG
    final bool _canDelete = await _deleteOtherAuthorConfirmationDialog(
      context: context,
    );

    if (_canDelete == true) {

      /// SHOW WAIT DIALOG
      _showRemovingAuthorWaitDialog(
        context: context,
        authorName: authorModel.name, // authorName != userName
        isBzDeleted: false,
      );

      /// REMOVE AUTHOR FROM BZ MODEL
      /// MIGRATE OWNERSHIP OF ALL MY FLYERS TO BZ CREATOR AND TURN OFF SHOW AUTHOR
      /// RENOVATE BZ
      await _migrateFlyersAndRemoveAuthorAndRenovateBz(
        context: context,
        bzModel: bzModel,
        authorModel: authorModel,
      );

      /// REF : BZ_STREAM_OPENS_ON_ACTIVE_BZ_AND_UPDATES_LOCALLY
      // NO NEED TO UPDATE BZ LOCALLY (IT IS STREAMED AND SYNCED IN onMyActiveBzStreamChanged())
      // BUT FOR CLEANER CODE, WE WILL UPDATE LOCALLY AND IT AUTO CHECKS IF IT IS THE SAME AS STREAMED

      /// SEND authorKick NOTES
      await NoteEvent.sendAuthorDeletionNotes(
        context: context,
        bzModel: bzModel,
        deletedAuthor: authorModel,
        sendToUserAuthorExitNote: true,
      );

      /// CLOSE WAIT DIALOG
      await _closeWaitDialog(
        context: context,
      );

      /// SHOW SUCCESS CENTER DIALOG
      await _showRemovedAuthorSuccessDialog(
        context: context,
        isBzDeleted: false,
      );

    }
  }
  // -----------------------------------------------------------------------------

  /// I GOT REMOVED

  // --------------------
  /// TASK : TEST ME
  static Future<void> onIGotRemoved({
    @required BuildContext context,
    @required AuthorModel authorModel,
    @required String bzID, // this should not include my id
    @required bool isBzDeleted,
  }) async {

    final BzModel bzModel = await BzProtocols.fetchBz(
      context: context,
      bzID: bzID,
    );

    if (bzModel != null) {

    // final bool _authorsContainMyUserID = AuthorModel.checkAuthorsContainUserID(
    //   authors: bzModel?.authors,
    //   userID: AuthFireOps.superUserID(),
    // );
    // assert(_authorsContainMyUserID == false, 'I should not be in authors list anymore');

    /// SHOW NOTICE CENTER DIALOG
    await _iGotDeletedNoticeDialog(
      context: context,
      bzID: bzModel.id,
      isBzDeleted: isBzDeleted,
    );

    /// SHOW WAIT DIALOG
    _showRemovingAuthorWaitDialog(
      context: context,
      authorName: authorModel.name,
      isBzDeleted: isBzDeleted,
    );

    await Future.wait(<Future>[

      /// (only i can) : REMOVE BZ FROM PRO MY BZZ
      /// (only i can) : REMOVE BZ & BZ TOPICS FROM MY USER MODEL
      /// (only i can) : UNSUBSCRIBE FROM BZ FCM TOPICS
      /// (only i can) : WIPE AUTHOR PIC
      /// (only i can) : RENOVATE MY USER MODEL
      /// (only i can) : REMOVE BZ NOTES FROM OBELISK NUMBERS
      _doAllMyUserRemovalFromBzOps(
        context: context,
        bzID: bzModel.id,
      ),

      /// (only i can) : UPDATE BZ LOCALLY
      BzProtocols.deleteLocally(
        context: context,
        bzID: bzModel.id,
        invoker: 'onIGotRemoved',
      ),

    ]);

    /// CLOSE WAIT DIALOG
    await _closeWaitDialog(
      context: context,
    );

    /// SHOW SUCCESS CENTER DIALOG
    await _showRemovedAuthorSuccessDialog(
      context: context,
      isBzDeleted: isBzDeleted,
    );

    /// NO NEED TO GO BACK AS THIS RUNS WHILE GOING BACK FROM MyBzScreen

    }

  }
  // -----------------------------------------------------------------------------

  /// FLYER MIGRATION

  // --------------------
  /// TASK : TEST ME
  static Future<void> _migrateFlyersAndRemoveAuthorAndRenovateBz({
    @required BuildContext context,
    @required BzModel bzModel,
    @required AuthorModel authorModel,
  }) async {

    /// REMOVE AUTHOR FROM BZ MODEL
    final BzModel _newBz = BzModel.removeAuthor(
        oldBz: bzModel,
        authorID: authorModel.userID,
    );

    await Future.wait(<Future>[

      /// MIGRATE OWNERSHIP OF ALL MY FLYERS TO BZ CREATOR AND TURN OFF SHOW AUTHOR
      _migrateAuthorFlyersToBzCreator(
        context: context,
        bzModel: _newBz,
        authorModel: authorModel,
      ),

      /// RENOVATE BZ
      BzProtocols.renovateBz(
        context: context,
        newBz: _newBz,
        oldBz: bzModel,
        showWaitDialog: false,
        navigateToBzInfoPageOnEnd: false,
        newLogo: null,
      ),

    ]);

  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> _migrateAuthorFlyersToBzCreator({
    @required BuildContext context,
    @required AuthorModel authorModel,
    @required BzModel bzModel,
  }) async {

    if (Mapper.checkCanLoopList(authorModel.flyersIDs) == true){

      await Future.wait(<Future>[

        ...List.generate(authorModel.flyersIDs.length, (index){

          final String _flyerID = authorModel.flyersIDs[index];

          return _migrateTheFlyer(
            context: context,
            flyerID: _flyerID,
            bzModel: bzModel,
          );

        }),

      ]);

      /// delete all flyers locally in the end to re-read them later
      await FlyerLDBOps.deleteFlyers(authorModel.flyersIDs);

    }

  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> _migrateTheFlyer({
    @required BuildContext context,
    @required String flyerID,
    @required BzModel bzModel,
  }) async {

    FlyerModel _flyer = await FlyerProtocols.fetchFlyer(
      context: context,
      flyerID: flyerID,
    );

    _flyer = FlyerModel.migrateOwnership(
        context: context,
        flyerModel: _flyer,
        newOwnerID: AuthorModel.getCreatorAuthorFromAuthors(bzModel.authors).userID,
        bzModel: bzModel,
    );

    await FlyerFireOps.updateFlyerDoc(_flyer);

  }
  // -----------------------------------------------------------------------------

  /// HANDLE USER CHANGES

  // --------------------
  /// TASK : TEST ME
  static Future<void> _doAllMyUserRemovalFromBzOps({
    @required BuildContext context,
    @required String bzID,
  }) async {

    /// (only i can) : REMOVE BZ & BZ TOPICS FROM MY USER MODEL
    final UserModel _oldUser = UsersProvider.proGetMyUserModel(context: context, listen: false);
    /// REMOVE BZ ID
    UserModel _newUser = UserModel.removeBzIDFromUserBzzIDs(bzIDToRemove: bzID, oldUser: _oldUser);
    /// REMOVE BZ TOPICS
    _newUser = UserModel.removeAllBzTopicsFromMyTopics(oldUser: _newUser, bzID: bzID);

    await Future.wait(<Future>[

      /// (only i can) : UNSUBSCRIBE FROM BZ FCM TOPICS
      NoteProtocols.unsubscribeFromAllBzTopics(
        bzID: bzID,
        context: context,
        renovateUser: false,
      ),

      /// (only i can) : WIPE AUTHOR PIC
      PicProtocols.wipePic(Storage.generateAuthorPicPath(
        bzID: bzID,
        authorID: _oldUser.id,
      )),

      /// (only i can) : RENOVATE MY USER MODEL
      UserProtocols.renovate(
        context: context,
        newUser: _newUser,
        oldUser: _oldUser,
        newPic: null,
      ),

    ]);

    /// (only i can) : REMOVE BZ FROM PRO MY BZZ
    BzzProvider.proRemoveBzFromMyBzz(
      context: context,
      bzID: bzID,
      notify: true,
    );

    /// (only i can) : REMOVE BZ NOTES FROM OBELISK NUMBERS
    NotesProvider.proAuthorResignationNotesRemovalOps(
      context: context,
      bzIDResigned: bzID,
      notify: true,
    );

  }
  // -----------------------------------------------------------------------------

  /// DIALOGS

  // --------------------
  /// TASK : TEST ME
  static Future<bool> _deleteMyselfConfirmationDialogs({
    @required BuildContext context,
  }) async {
    bool _canProceed = false;

    /// confirm you want to delete yourself
    final bool _canDeleteMyself = await Dialogs.confirmProceed(
      context: context,
      titleVerse: const Verse(text: 'phid_exit_bz_account', translate: true), /// TASK : TRANSLATE ME
      bodyVerse: const Verse(text: 'phid_exit_bz_account_body', translate: true), /// TASK : TRANSLATE ME
      invertButtons: true,
    );

    if (_canDeleteMyself == true){

      /// confirm you agree on flyers migration
      final bool _canMigrateFlyers = await Dialogs.confirmProceed(
        context: context,
        titleVerse: const Verse(text: 'phid_migrate_flyers_?', translate: true), /// TASK : TRANSLATE ME
        bodyVerse: const Verse(text: 'phid_migrate_flyers_body', translate: true), /// TASK : TRANSLATE ME
        invertButtons: true,
      );

      if (_canMigrateFlyers == true){
        _canProceed = true;
      }

    }

    return _canProceed;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<bool> _deleteOtherAuthorConfirmationDialog({
    @required BuildContext context,
  }) async {
    bool _canProceed = false;

    /// confirm you want to delete yourself
    final bool _canDeleteOtherAuthor = await Dialogs.confirmProceed(
      context: context,
      titleVerse: const Verse(text: 'phid_delete_author_?', translate: true), /// TASK : TRANSLATE ME
      bodyVerse: const Verse(text: 'phid_delete_author_body', translate: true), /// TASK : TRANSLATE ME
      invertButtons: true,
    );

    if (_canDeleteOtherAuthor == true){
      _canProceed = true;
    }

    return _canProceed;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> _iGotDeletedNoticeDialog({
    @required BuildContext context,
    @required bool isBzDeleted,
    @required String bzID,
  }) async {

    /// BZ DELETED
    if (isBzDeleted == true){

      final BzModel _bzModel = await BzLDBOps.readBz(bzID);

      await Dialogs.bzBannerDialog(
        context: context,
        titleVerse: Verse(
          text: _bzModel.name,
          translate: false,
        ),
        bodyVerse: const Verse(
          text: 'phid_bz_is_deleted_can_not_be_used',
          translate: true,
        ),
        bzModel: _bzModel,
        boolDialog: false,
      );

    }

    /// AUTHOR DELETED
    else {

      await CenterDialog.showCenterDialog(
        context: context,
        titleVerse: const Verse(
          text: 'phid_bz_account_is_unavailable',
          translate: true,
        ),
        bodyVerse: const Verse(
          text: 'phid_no_access_to_this_account',
          translate: true,
        ),
      );

    }

  }
  // --------------------
    /// TESTED : WORKS PERFECT
  static void _showRemovingAuthorWaitDialog({
    @required BuildContext context,
    @required String authorName,
    @required bool isBzDeleted,
  }) {

    final String _waitText = isBzDeleted == true
      ? Verse.transBake(context, 'phid_removing_bz') /// TASK : TRANSLATE ME
      : Verse.transBake(context, 'phid_removing_author'); /// TASK : TRANSLATE ME

    pushWaitDialog(
        context: context,
        verse: Verse(
          text: _waitText,
          translate: false,
        ),
      );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _closeWaitDialog({
    @required BuildContext context,
  }) async {
    await WaitDialog.closeWaitDialog(context);
  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> _showRemovedAuthorSuccessDialog({
    @required BuildContext context,
    @required bool isBzDeleted,
  }) async {

    if (isBzDeleted == true){

      await Dialogs.centerNotice(
        context: context,
        verse: const Verse(
          text: 'phid_bz_has_been_removed', // TASK : TRANSLATE ME
          translate: true,
        ),
      );

    }

    else {

      await Dialogs.centerNotice(
        context: context,
        verse: const Verse(
          text: 'phid_Author_has_been_removed_successfully', // TASK : TRANSLATE ME
          translate: true,
        ),
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// NAVIGATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _goBackToHomeScreen({
    @required BuildContext context,
  }) async {
    await Nav.goBackToLogoScreen(
      context: context,
      animatedLogoScreen: true,
    );
  }
  // -----------------------------------------------------------------------------
}
