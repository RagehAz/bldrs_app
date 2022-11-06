import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/sub/pending_author_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthorshipEntryProtocols {
  // -----------------------------------------------------------------------------

  const AuthorshipEntryProtocols();

  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> addMeToBz({
    @required BuildContext context,
    @required String bzID,
  }) async {

    assert(bzID != null, 'AuthorshipEntryProtocols.addMeToBz : bzID is null');

    blog('AuthorshipEntryProtocols.addMeToBz : START');

    final BzModel _oldBzModel = await BzProtocols.fetch(
      context: context,
      bzID: bzID,
    );

    /// GET AND MODIFY MY USER MODEL --------------------------
    // NOTE : modify user before bz to allow the user modify the bz in fire security rules
    final UserModel _oldUserModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    UserModel _newUserModel = UserModel.addBzIDToUserBzz(
      userModel: _oldUserModel,
      bzIDToAdd: _oldBzModel.id,
    );

    _newUserModel = UserModel.addAllBzTopicsToMyTopics(
        userModel: _newUserModel,
        bzID: bzID
    );

    /// SUBSCRIBE TO BZ TOPICS
    await NoteProtocols.subscribeToAllBzTopics(
      context: context,
      bzID: bzID,
      renovateUser: false,
    );

    /// UPDATE MY USER MODEL EVERY WHERE --------------------------
    final UserModel _uploadedUser = await UserProtocols.renovate(
      context: context,
      newUserModel: _newUserModel,
      newPic: null,
    );

    /// MODIFY BZ MODEL --------------------------
    BzModel _bzModel = BzModel.addNewUserAsAuthor(
      oldBzModel: _oldBzModel,
      userModel: _uploadedUser,
    );
    // _bzModel = await BzFireOps.updateAuthorPicIfChangedAndReturnNewBzModel(
    //   context: context,
    //   bzModel: _bzModel,
    // );

    _bzModel = PendingAuthor.removePendingAuthorFromBz(
        bzModel: _bzModel,
        userID: _newUserModel.id,
    );

    /// ADD BZ MODEL TO MY BZZ --------------------------
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    _bzzProvider.addBzToMyBzz(
      bzModel: _bzModel,
      notify: false, // uploaded model will update it and notify listeners
    );

    /// UPDATE BZ EVERYWHERE PROTOCOL --------------------------
    final BzModel _uploadedBzModel = await BzProtocols.renovateBz(
      context: context,
      oldBzModel: _oldBzModel,
      newBzModel: _bzModel,
      showWaitDialog: false,
      navigateToBzInfoPageOnEnd: false,
    );

    blog('AuthorshipEntryProtocols.addMeToBz : END');

    return _uploadedBzModel;
  }
// -----------------------------------------------------------------------------
}
