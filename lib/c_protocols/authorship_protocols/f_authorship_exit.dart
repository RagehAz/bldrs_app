import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/authorship_protocols/a_authorship_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/auth_fire_ops.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/bz_fire_ops.dart';
import 'package:bldrs/e_back_end/x_ops/ldb_ops/bz_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthorshipExitProtocols {
  // -----------------------------------------------------------------------------

  const AuthorshipExitProtocols();

  // -----------------------------------------------------------------------------
  ///
  static Future<void> deleteMyAuthorPic({
    @required BuildContext context,
    @required String bzID,
  }) async {
    blog('WipeAuthorProtocols.deleteMyAuthorPicProtocol : START');

    /// GET MY USER MODEL -------------------
    final UserModel _myUserModel = await UserProtocols.fetchUser(
      context: context,
      userID: AuthFireOps.superUserID(),
    );

    /// GET THE BZ MODEL -------------------
    final BzModel _bzModel = await BzLDBOps.readBz(bzID);

    if (_bzModel != null){

      /// GET MY AUTHOR MODEL -------------------
      final AuthorModel _myAuthor = AuthorModel.getAuthorFromAuthorsByID(
        authors: _bzModel.authors,
        authorID: _myUserModel.id,
      );

      /// CHECK IF USER MODEL PIC IS AUTHOR MODEL PIC -------------------
      final bool _authorPicIsHisUserPic = await AuthorModel.checkUserImageIsAuthorImage(
        context: context,
        authorModel: _myAuthor,
        userModel: _myUserModel,
      );

      /// PROCEED IF NOT IDENTICAL -------------------
      if (_authorPicIsHisUserPic == false){
        await BzFireOps.deleteAuthorPic(
          authorModel: _myAuthor,
          bzID: bzID,
        );
      }

    }

    blog('WipeAuthorProtocols.deleteMyAuthorPicProtocol : END');
  }
  // --------------------
  ///
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
    final UserModel _newUserModel = UserModel.removeBzIDFromMyBzzIDs(
        bzIDToRemove: streamedBzModelWithoutMyID.id,
        userModel: _myOldUserModel
    );

    /// UPDATE MY USER MODEL EVERYWHERE
    await UserProtocols.renovateMyUserModel(
      context: context,
      newUserModel: _newUserModel,
    );

    await NoteProtocols.unsubscribeFromAllBzTopics(
        bzID: streamedBzModelWithoutMyID.id,
    );

    /// 10 - REMOVE ALL NOTES FROM ALL-MY-BZZ-NOTES AND OBELISK NOTES NUMBERS
    NotesProvider.proAuthorResignationNotesRemovalOps(
      context: context,
      bzIDResigned: streamedBzModelWithoutMyID.id,
    );

    blog('WipeAuthorProtocols.removeMeFromBzProtocol : END');
  }
  // --------------------
  ///
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

    /// UPDATE BZ ON FIREBASE
    await BzFireOps.updateBz(
        context: context,
        newBzModel: _updatedBzModel,
        oldBzModel: bzModel,
        authorPicFile: null
    );

    /// NOTE : no need to update bz locally here as bz stream listener does the job

    blog('WipeAuthorProtocols.removeFlyerlessAuthorProtocol : END');

  }
  // --------------------
  ///
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
      final UserModel _newUserModel = UserModel.removeBzIDFromMyBzzIDs(
        bzIDToRemove: bzID,
        userModel: _myOldUserModel,
      );

      /// UPDATE USER MODEL EVERYWHERE
      await UserProtocols.renovateMyUserModel(
        context: context,
        newUserModel: _newUserModel,
      );

      /// DELETE MY AUTHOR PICTURE FROM STORAGE
      await AuthorshipProtocols.deleteMyAuthorPic(
        context: context,
        bzID: bzID,
      );

      await NoteProtocols.unsubscribeFromAllBzTopics(
          bzID: bzID
      );

      /// DELETE BZ LOCALLY
      await BzProtocols.deleteLocally(
        context: context,
        bzID: bzID,
        invoker: 'authorBzExitAfterBzDeletionProtocol',
      );

    }


    blog('WipeAuthorProtocols.removeBzTracesAfterDeletion : end');

  }
  // --------------------
  ///
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
