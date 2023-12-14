// ignore_for_file: avoid_redundant_argument_values, unused_element
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/layouts/nav/nav.dart';
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
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/note_protocols/note_events/z_note_events.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/provider/notes_provider.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/g_storage/storage_path.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/router/a_route_name.dart';
/// => TAMAM
class NewAuthorshipExit {
  // -----------------------------------------------------------------------------

  const NewAuthorshipExit();

  // -----------------------------------------------------------------------------

  /// EXIT HIMSELF

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onRemoveMyselfWhileDeletingMyUserAccount({
    required AuthorModel? authorModel,
    required BzModel? bzModel,
  }) async {

      /// REMOVE AUTHOR FROM BZ MODEL
      /// MIGRATE OWNERSHIP OF ALL MY FLYERS TO BZ CREATOR AND TURN OFF SHOW AUTHOR
      /// RENOVATE BZ
      await _migrateFlyersAndRemoveAuthorAndRenovateBz(
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
        bzID: bzModel?.id,
      );

      /// (only i can) : SEND authorExit NOTES
      await NoteEvent.sendAuthorDeletionNotes(
        bzModel: bzModel,
        deletedAuthor: authorModel,
        sendToUserAuthorExitNote: false,
      );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onRemoveMySelf({
    required AuthorModel? authorModel,
    required BzModel? bzModel,
    required bool showConfirmDialog,
  }) async {

    bool _canDelete = true;

    if (showConfirmDialog == true){
      /// SHOW CONFIRM DIALOG
      _canDelete = await _deleteMyselfConfirmationDialogs();
    }

    if (_canDelete == true){

      /// THIS PREVENTS BZ STREAM FROM FIRING (onIGotRemoved) METHOD
      // await Nav.goBackUntil(
      //     context: getMainContext(),
      //     routeName: '/',
      // );

      /// SHOW WAIT DIALOG
      _showRemovingAuthorWaitDialog(
        isBzDeleted: false,
      );

      /// REMOVE AUTHOR FROM BZ MODEL
      /// MIGRATE OWNERSHIP OF ALL MY FLYERS TO BZ CREATOR AND TURN OFF SHOW AUTHOR
      /// RENOVATE BZ
      await _migrateFlyersAndRemoveAuthorAndRenovateBz(
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
        bzID: bzModel?.id,
      );

      /// (only i can) : SEND authorExit NOTES
      await NoteEvent.sendAuthorDeletionNotes(
        bzModel: bzModel,
        deletedAuthor: authorModel,
        sendToUserAuthorExitNote: false,
      );

      /// SHOW SUCCESS CENTER DIALOG
      await _showRemovedAuthorSuccessDialog(
        isBzDeleted: false,
      );

      /// GO HOME
      await Nav.pushHomeAndRemoveAllBelow(
        context: getMainContext(),
        invoker: 'NewAuthorshipExit.onRemoveMySelf',
        homeRoute: RouteName.home,
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// KICK OUT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onRemoveOtherAuthor({
    required AuthorModel? authorModel,
    required BzModel? bzModel,
  }) async {

    /// SHOW DIALOG
    final bool _canDelete = await _deleteOtherAuthorConfirmationDialog();

    if (_canDelete == true) {

      /// SHOW WAIT DIALOG
      _showRemovingAuthorWaitDialog(
        isBzDeleted: false,
      );

      /// REMOVE AUTHOR FROM BZ MODEL
      /// MIGRATE OWNERSHIP OF ALL MY FLYERS TO BZ CREATOR AND TURN OFF SHOW AUTHOR
      /// RENOVATE BZ
      await _migrateFlyersAndRemoveAuthorAndRenovateBz(
        bzModel: bzModel,
        authorModel: authorModel,
      );

      /// REF : BZ_STREAM_OPENS_ON_ACTIVE_BZ_AND_UPDATES_LOCALLY
      // NO NEED TO UPDATE BZ LOCALLY (IT IS STREAMED AND SYNCED IN onMyActiveBzStreamChanged())
      // BUT FOR CLEANER CODE, WE WILL UPDATE LOCALLY AND IT AUTO CHECKS IF IT IS THE SAME AS STREAMED

      /// SEND authorKick NOTES
      await NoteEvent.sendAuthorDeletionNotes(
        bzModel: bzModel,
        deletedAuthor: authorModel,
        sendToUserAuthorExitNote: true,
      );

      /// CLOSE WAIT DIALOG
      await _closeWaitDialog();

      /// SHOW SUCCESS CENTER DIALOG
      await _showRemovedAuthorSuccessDialog(
        isBzDeleted: false,
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// I GOT REMOVED

  // --------------------
  /// TASK : TEST ME : WORKS GOOD FOR WIPING BZ CYCLE
  static Future<void> onIGotRemoved({
    required String? bzID, // this should not include my id
    required bool isBzDeleted,
  }) async {

    // blog('bzModel == null : ${bzModel == null}');

    if (bzID != null){

      final BzModel? _bzModel = await BzProtocols.fetchBz(
        bzID: bzID,
      );

      if (_bzModel != null){

        /// SHOW NOTICE CENTER DIALOG : is switched of to clean wipe bz sequence
          // await _iGotDeletedNoticeDialog(
          //   bzID: bzID,
          //   isBzDeleted: isBzDeleted,
          // );

          /// SHOW WAIT DIALOG
          _showRemovingAuthorWaitDialog(
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
              bzID: bzID,
            ),
            /// (only i can) : UPDATE BZ LOCALLY
            BzProtocols.deleteLocally(
              bzID: bzID,
              invoker: 'onIGotRemoved',
            ),

          ]);

          // /// CLOSE WAIT DIALOG
          // await _closeWaitDialog();

          /// GO HOME
          if (isBzDeleted == false){

            await Nav.pushHomeAndRemoveAllBelow(
              context: getMainContext(),
              invoker: 'NewAuthorshipExit.onRemoveMySelf',
              homeRoute: RouteName.home,
            );

            /// SHOW SUCCESS CENTER DIALOG
            await _showRemovedAuthorSuccessDialog(
              isBzDeleted: isBzDeleted,
            );

          }


      }

    }

  }
  // -----------------------------------------------------------------------------

  /// FLYER MIGRATION

  // --------------------
    /// TESTED : WORKS PERFECT
  static Future<void> _migrateFlyersAndRemoveAuthorAndRenovateBz({
    required BzModel? bzModel,
    required AuthorModel? authorModel,
  }) async {

    /// REMOVE AUTHOR FROM BZ MODEL
    final BzModel? _newBz = BzModel.removeAuthor(
        oldBz: bzModel,
        authorID: authorModel?.userID,
    );

    await Future.wait(<Future>[

      /// MIGRATE OWNERSHIP OF ALL MY FLYERS TO BZ CREATOR AND TURN OFF SHOW AUTHOR
      if (authorModel != null)
      _migrateAuthorFlyersToBzCreator(
        bzModel: _newBz,
        authorModel: authorModel,
      ),

      /// RENOVATE BZ
      BzProtocols.renovateBz(
        newBz: _newBz,
        oldBz: bzModel,
        showWaitDialog: false,
        newLogo: null,
      ),

    ]);

  }
  // --------------------
    /// TESTED : WORKS PERFECT
  static Future<void> _migrateAuthorFlyersToBzCreator({
    required AuthorModel? authorModel,
    required BzModel? bzModel,
  }) async {

    if (Lister.checkCanLoop(authorModel?.flyersIDs) == true){

      await Future.wait(<Future>[

        ...List.generate(authorModel!.flyersIDs!.length, (index){

          final String _flyerID = authorModel.flyersIDs![index];

          return _migrateTheFlyer(
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
    /// TESTED : WORKS PERFECT
  static Future<void> _migrateTheFlyer({
    required String? flyerID,
    required BzModel? bzModel,
  }) async {

    FlyerModel? _flyer = await FlyerProtocols.fetchFlyer(
      flyerID: flyerID,
    );

    _flyer = FlyerModel.migrateOwnership(
        flyerModel: _flyer,
        newOwnerID: AuthorModel.getCreatorAuthorFromAuthors(bzModel?.authors)?.userID,
        bzModel: bzModel,
    );

    await FlyerFireOps.updateFlyerDoc(_flyer);

  }
  // -----------------------------------------------------------------------------

  /// HANDLE USER CHANGES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _doAllMyUserRemovalFromBzOps({
    required String? bzID,
  }) async {

    /// (only i can) : REMOVE BZ & BZ TOPICS FROM MY USER MODEL
    final UserModel? _oldUser = UsersProvider.proGetMyUserModel(
      context: getMainContext(),
      listen: false,
    );

    /// REMOVE BZ ID
    UserModel? _newUser = UserModel.removeBzIDFromUserBzzIDs(bzIDToRemove: bzID, oldUser: _oldUser);
    /// REMOVE BZ TOPICS
    _newUser = UserModel.removeAllBzTopicsFromMyTopics(oldUser: _newUser, bzID: bzID);

    await Future.wait(<Future>[

      /// (only i can) : UNSUBSCRIBE FROM BZ FCM TOPICS
      NoteProtocols.unsubscribeFromAllBzTopics(
        bzID: bzID,
        renovateUser: false,
      ),

      /// (only i can) : WIPE AUTHOR PIC
      PicProtocols.wipePic(StoragePath.bzz_bzID_authorID(
        bzID: bzID,
        authorID: _oldUser?.id,
      )),

      /// (only i can) : RENOVATE MY USER MODEL
      UserProtocols.renovate(
        newUser: _newUser,
        oldUser: _oldUser,
        invoker: 'onIGotRemoved',
      ),

    ]);

    /// (only i can) : REMOVE BZ FROM PRO MY BZZ
    BzzProvider.proRemoveBzFromMyBzz(
      bzID: bzID,
      notify: true,
    );

    /// (only i can) : REMOVE BZ NOTES FROM OBELISK NUMBERS
    NotesProvider.proAuthorResignationNotesRemovalOps(
      bzIDResigned: bzID,
      notify: true,
    );

  }
  // -----------------------------------------------------------------------------

  /// DIALOGS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> _deleteMyselfConfirmationDialogs() async {
    bool _canProceed = false;

    /// confirm you want to delete yourself
    final bool _canDeleteMyself = await Dialogs.confirmProceed(
      titleVerse: const Verse(id: 'phid_exit_bz_account', translate: true),
      bodyVerse: const Verse(id: 'phid_exit_bz_account_body', translate: true),
      invertButtons: true,
    );

    if (_canDeleteMyself == true){

      /// confirm you agree on flyers migration
      final bool _canMigrateFlyers = await Dialogs.confirmProceed(
        titleVerse: const Verse(id: 'phid_migrate_flyers_?', translate: true),
        bodyVerse: const Verse(id: 'phid_migrate_flyers_body', translate: true),
        invertButtons: true,
      );

      if (_canMigrateFlyers == true){
        _canProceed = true;
      }

    }

    return _canProceed;
  }
  // --------------------
    /// TESTED : WORKS PERFECT
  static Future<bool> _deleteOtherAuthorConfirmationDialog() async {
    bool _canProceed = false;

    /// confirm you want to delete yourself
    final bool _canDeleteOtherAuthor = await Dialogs.confirmProceed(
      titleVerse: const Verse(id: 'phid_remove_author_?', translate: true),
      /// TRANSLATE ME
      bodyVerse: const Verse(id: 'phid_delete_author_body', translate: true),
      invertButtons: true,
    );

    if (_canDeleteOtherAuthor == true){
      _canProceed = true;
    }

    return _canProceed;
  }
  // --------------------
    /// TESTED : WORKS PERFECT
  static Future<void> _iGotDeletedNoticeDialog({
    required bool isBzDeleted,
    required String bzID,
  }) async {

    /// BZ DELETED
    if (isBzDeleted == true){

      final BzModel? _bzModel = await BzLDBOps.readBz(bzID);

      await Dialogs.bzBannerDialog(
        titleVerse: Verse(
          id: _bzModel?.name ?? 'Account is deleted !!',
          translate: false,
        ),
        bodyVerse: const Verse(
          id: 'phid_bz_is_deleted_can_not_be_used',
          translate: true,
        ),
        bzModel: _bzModel,
        boolDialog: false,
      );

    }

    /// AUTHOR DELETED
    else {

      await BldrsCenterDialog.showCenterDialog(
        titleVerse: const Verse(
          id: 'phid_bz_account_is_unavailable',
          translate: true,
        ),
        bodyVerse: const Verse(
          id: 'phid_no_access_to_this_account',
          translate: true,
        ),
      );

    }

  }
  // --------------------
    /// TESTED : WORKS PERFECT
  static void _showRemovingAuthorWaitDialog({
    required bool isBzDeleted,
  }) {

    final String? _waitText = isBzDeleted == true ?
    getWord('phid_removing_bz')
      :
    getWord('phid_removing_author');

    WaitDialog.showUnawaitedWaitDialog(
        verse: Verse(
          id: _waitText,
          translate: false,
        ),
      );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _closeWaitDialog() async {
    await WaitDialog.closeWaitDialog();
  }
  // --------------------
    /// TESTED : WORKS PERFECT
  static Future<void> _showRemovedAuthorSuccessDialog({
    required bool isBzDeleted,
  }) async {

    if (isBzDeleted == true){

      await Dialogs.centerNotice(
        verse: const Verse(
          id: 'phid_bz_has_been_removed',
          translate: true,
        ),
      );

    }

    else {

      await Dialogs.centerNotice(
        verse: const Verse(
          id: 'phid_Author_has_been_removed_successfully',
          translate: true,
        ),
      );

    }

  }
  // -----------------------------------------------------------------------------
}
