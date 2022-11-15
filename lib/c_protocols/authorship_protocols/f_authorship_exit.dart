import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/authorship_protocols/a_authorship_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/note_protocols/provider/notes_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/c_protocols/bz_protocols/ldb/bz_ldb_ops.dart';
import 'package:bldrs/e_back_end/g_storage/storage.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
/// => TAMAM
class AuthorshipExitProtocols {
  // -----------------------------------------------------------------------------

  const AuthorshipExitProtocols();

  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteMyAuthorPic({
    @required BuildContext context,
    @required String bzID,
  }) async {
    blog('WipeAuthorProtocols.deleteMyAuthorPicProtocol : START');

    /// WIPE AUTHOR PIC
    await PicProtocols.wipePic(Storage.generateAuthorPicPath(
      bzID: bzID,
      authorID: AuthFireOps.superUserID(),
    ));

    // /// GET MY USER MODEL -------------------
    // final UserModel _myUserModel = await UserProtocols.fetch(
    //   context: context,
    //   userID: AuthFireOps.superUserID(),
    // );
    //
    // /// GET THE BZ MODEL -------------------
    // final BzModel _bzModel = await BzLDBOps.readBz(bzID);
    //
    // if (_bzModel != null){
    //
    //   /// GET MY AUTHOR MODEL -------------------
    //   final AuthorModel _myAuthor = AuthorModel.getAuthorFromAuthorsByID(
    //     authors: _bzModel.authors,
    //     authorID: _myUserModel.id,
    //   );
    //
    //   /// CHECK IF USER MODEL PIC IS AUTHOR MODEL PIC -------------------
    //   final bool _authorPicIsHisUserPic = await AuthorModel.checkUserImageIsAuthorImage(
    //     context: context,
    //     authorModel: _myAuthor,
    //     userModel: _myUserModel,
    //   );
    //
    //   /// PROCEED IF NOT IDENTICAL -------------------
    //   if (_authorPicIsHisUserPic == false){
    //     await BzFireOps.deleteAuthorPic(
    //       authorModel: _myAuthor,
    //       bzID: bzID,
    //     );
    //   }
    //
    // }

    blog('WipeAuthorProtocols.deleteMyAuthorPicProtocol : END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> removeMeFromBz({
    @required BuildContext context,
    @required BzModel streamedBzModelWithoutMyID,
  }) async {

    blog('WipeAuthorProtocols.removeMeFromBzProtocol : START');

    // description
    // when the streamedBzModel does not include my ID
    // should update this bz in LDB
    // remove this bz from my bzz ids
    // update my model everywhere

    /// REMOVE ME FROM PRO MY BZZ
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    _bzzProvider.removeBzFromMyBzz(
      bzID: streamedBzModelWithoutMyID.id,
      notify: true,
    );
    /// UPDATE BZ IN LDB
    await BzLDBOps.updateBzOps(
      bzModel: streamedBzModelWithoutMyID,
    );

    /// MODIFY MY USER MODEL
    final UserModel _myOldUserModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );
    UserModel _newUserModel = UserModel.removeBzIDFromMyBzzIDs(
        bzIDToRemove: streamedBzModelWithoutMyID.id,
        userModel: _myOldUserModel
    );

    _newUserModel = UserModel.removeAllBzTopicsFromMyTopics(
        userModel: _newUserModel,
        bzID: streamedBzModelWithoutMyID.id,
    );

    /// WIPE AUTHOR PIC
    await PicProtocols.wipePic(Storage.generateAuthorPicPath(
      bzID: streamedBzModelWithoutMyID.id,
      authorID: _newUserModel.id,
    ));

    await Future.wait(<Future>[

      /// UNSUBSCRIBE FROM FCM TOPICS
      NoteProtocols.unsubscribeFromAllBzTopics(
        bzID: streamedBzModelWithoutMyID.id,
        context: context,
        renovateUser: false,
      ),

      /// UPDATE MY USER MODEL EVERYWHERE
      UserProtocols.renovate(
        context: context,
        newUserModel: _newUserModel,
        newPic: null,
      ),

    ]);

    /// 10 - REMOVE ALL NOTES FROM ALL-MY-BZZ-NOTES AND OBELISK NOTES NUMBERS
    NotesProvider.proAuthorResignationNotesRemovalOps(
      context: context,
      bzIDResigned: streamedBzModelWithoutMyID.id,
    );

    blog('WipeAuthorProtocols.removeMeFromBzProtocol : END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> removeFlyerlessAuthor({
    @required BuildContext context,
    @required BzModel bzModel,
    @required AuthorModel author,
  }) async {
    blog('WipeAuthorProtocols.removeFlyerlessAuthorProtocol : START');

    /// REMOVE AUTHOR MODEL FROM BZ MODEL
    final BzModel _updatedBzModel = BzModel.removeAuthor(
      bzModel: bzModel,
      authorID: author.userID,
    );

    await Future.wait(<Future>[

      /// WIPE AUTHOR PIC
      PicProtocols.wipePic(author.picPath),

      /// UPDATE BZ ON FIREBASE
      BzProtocols.renovateBz(
        context: context,
        newBz: _updatedBzModel,
        oldBzModel: bzModel,
        showWaitDialog: false,
        navigateToBzInfoPageOnEnd: false,
        newLogo: null,
      ),

    ]);

    blog('WipeAuthorProtocols.removeFlyerlessAuthorProtocol : END');

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> removeBzTracesAfterDeletion({
    @required BuildContext context,
    @required String bzID,
  }) async {

    /// NOTES
    /// I RECEIVED A NOTE SAYING MY BZ HAS BEEN DELETED
    /// SO BZ HAS ALREADY BEEN DELETED BUT I WAS AN AUTHOR AND STILL HAVE TRACES OF THAT BUSINESS
    /// IN MY MODEL IN FIRE - LDB - PRO

    blog('WipeAuthorProtocols.removeBzTracesAfterDeletion : start');

    final UserModel _myOldUserModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    final bool _bzIDisInMyBzzIDs = Stringer.checkStringsContainString(
      strings: _myOldUserModel.myBzzIDs,
      string: bzID,
    );

    if (_bzIDisInMyBzzIDs == true){

      await _authorBzDeletionDialog(
        context: context,
        bzID: bzID,
      );

      /// MODIFY USER MODEL
      UserModel _newUserModel = UserModel.removeBzIDFromMyBzzIDs(
        bzIDToRemove: bzID,
        userModel: _myOldUserModel,
      );

      _newUserModel = UserModel.removeAllBzTopicsFromMyTopics(
          userModel: _newUserModel,
          bzID: bzID
      );

      await Future.wait(<Future>[

        /// FCM UN-SUBSCRIBE FROM ALL BZ TOPICS
        NoteProtocols.unsubscribeFromAllBzTopics(
          bzID: bzID,
          context: context,
          renovateUser: false,
        ),

        /// UPDATE USER MODEL EVERYWHERE
        UserProtocols.renovate(
          context: context,
          newUserModel: _newUserModel,
          newPic: null,
        ),

        /// DELETE MY AUTHOR PICTURE FROM STORAGE
        AuthorshipProtocols.deleteMyAuthorPic(
          context: context,
          bzID: bzID,
        ),

        /// DELETE BZ LOCALLY
        BzProtocols.deleteLocally(
          context: context,
          bzID: bzID,
          invoker: 'authorBzExitAfterBzDeletionProtocol',
        )

      ]);

    }

    blog('WipeAuthorProtocols.removeBzTracesAfterDeletion : end');

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _authorBzDeletionDialog({
    @required BuildContext context,
    @required String bzID,
  }) async {

    final BzModel _bzModel = await BzLDBOps.readBz(bzID);

    if (_bzModel != null){

      await Dialogs.bzBannerDialog(
        context: context,
        titleVerse: Verse(
          text: '##${_bzModel.name} is no longer Available',
          translate: true,
          variables: _bzModel.name,
        ),
        bodyVerse: const Verse(
          pseudo: 'This Business account has been permanently deleted and can no longer be used',
          text: 'phid_bz_is_deleted_can_not_be_used',
          translate: true,
        ),
        bzModel: _bzModel,
        boolDialog: false,
      );

    }

  }
  // -----------------------------------------------------------------------------
}
