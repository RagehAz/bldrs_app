import 'dart:async';

import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_controllers/a_starters_controllers/nav_bar_controller.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/ops/bz_ops.dart' as BzFireOps;
import 'package:bldrs/e_db/fire/ops/note_ops.dart' as NoteFireOps;
import 'package:bldrs/e_db/fire/ops/user_ops.dart' as UserFireOps;
import 'package:bldrs/e_db/ldb/ops/auth_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/bz_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/user_ldb_ops.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------

/// NOTE OPTIONS

// ------------------------------------------
Future<void> onShowNoteOptions({
  @required BuildContext context,
  @required NoteModel noteModel,
}) async {

  blog('note options');

}
// -----------------------------------------------------------------------------

/// NOTE RESPONSES

// ------------------------------------------
/// TESTED : WORKS PERFECT
Future<void> markNoteAsSeen({
  @required BuildContext context,
  @required NoteModel noteModel,
}) async {

  if (noteModel.noteType != null){

    if (noteModel.seen != true){

      final NoteModel _updatedNote = noteModel.copyWith(
        seen: true,
        seenTime: DateTime.now(),
      );

      await NoteFireOps.updateNote(
        context: context,
        newNoteModel: _updatedNote,
      );

    }

  }

}
// ------------------------------------------
Future<void> onNoteButtonTap({
  @required BuildContext context,
  @required String response,
  @required NoteModel noteModel,
}) async {

  /// AUTHORSHIP NOTES
  if (noteModel.noteType == NoteType.authorship){

    final BzModel _bzModel = await BzzProvider.proFetchBzModel(
      context: context,
      bzID: noteModel.senderID,
    );

    await _respondToAuthorshipNote(
      context: context,
      response: response,
      noteModel: noteModel,
      bzModel: _bzModel,
    );

  }

}
// -----------------------------------------------------------------------------

/// AUTHORSHIP NOTE RESPONSES

// ------------------------------------------
/// USER RESPONSE TO AUTHORSHIP INVITATION
Future<void> _respondToAuthorshipNote({
  @required BuildContext context,
  @required String response,
  @required NoteModel noteModel,
  @required BzModel bzModel,
}) async {

  /// ACCEPT AUTHORSHIP
  if (response == 'phid_accept'){
    await _acceptAuthorshipInvitation(
      context: context,
      noteModel: noteModel,
      bzModel: bzModel,
    );
  }

  /// DECLINE AUTHORSHIP
  else if (response == 'phid_decline'){
    await _declineAuthorshipInvitation(
      context: context,
      noteModel: noteModel,
    );
  }

}
// ------------------------------------------

/// ACCEPT AUTHORSHIP INVITATION

// -------------------
Future<void> _acceptAuthorshipInvitation({
  @required BuildContext context,
  @required NoteModel noteModel,
  @required BzModel bzModel,
}) async {
  blog('_acceptAuthorshipInvitation : accepted ');

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    title: 'Accept invitation ?',
    body: 'This will add you as an Author for this business account',
    boolDialog: true,
  );

  if (_result == true){

    unawaited(WaitDialog.showWaitDialog(
      context: context,
      loadingPhrase: "Adding you to '${bzModel.name}' business account",
    ));

    final UserModel _newUserModel = await _modifyUserAuthorshipOps(
      context: context,
      bzModel: bzModel,
    );

    await _modifyBzAuthorshipOps(
      context: context,
      newUserModel: _newUserModel,
      oldBzModel: bzModel,
    );


    await _modifyNoteResponse(
      context: context,
      noteModel: noteModel,
      response: 'phid_accept',
    );

    WaitDialog.closeWaitDialog(context);

    await CenterDialog.showCenterDialog(
      context: context,
      title: 'You have become an Author in ${bzModel.name}',
      body: 'You can control the business account, publish flyers, reply to costumers on behalf of the business and more.',
      confirmButtonText: 'Great',
    );

    await goToMyBzScreen(
      context: context,
    );

  }

}
// -------------------
Future<UserModel> _modifyUserAuthorshipOps({
  @required BuildContext context,
  @required BzModel bzModel,
}) async {

  final UserModel _oldUserModel = UsersProvider.proGetMyUserModel(context);

  /// FIRE OPS
  final UserModel _newUserModel = await UserFireOps.addBzIDToUserBzzIDs(
    context: context,
    bzID: bzModel.id,
    oldUserModel: _oldUserModel,
  );

  /// PRO OPS
  final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
  _usersProvider.setMyUserModel(
      userModel: _newUserModel,
      notify: false
  );
  AuthModel _authModel = _usersProvider.myAuthModel;
  _authModel = _authModel.copyWith(
    userModel: _newUserModel,
  );
  _usersProvider.setMyAuthModel(
      authModel: _authModel,
      notify: true
  );

  /// LDB OPS
  await AuthLDBOps.updateAuthModel(_authModel);
  await UserLDBOps.updateUserModel(_newUserModel);

  return _newUserModel;
}
// -------------------
Future<void> _modifyBzAuthorshipOps({
  @required BuildContext context,
  @required UserModel newUserModel,
  @required BzModel oldBzModel,
}) async {

  final List<AuthorModel> _newAuthors = AuthorModel.addNewUserToAuthors(
    authors: oldBzModel.authors,
    newUserModel: newUserModel,
  );

  final BzModel _newBzModel = oldBzModel.copyWith(
    authors: _newAuthors,
  );

  /// FIRE OPS
  final BzModel _uploadedBzModel = await BzFireOps.updateBz(
    context: context,
    newBzModel: _newBzModel,
    oldBzModel: oldBzModel,
    authorPicFile: null,
  );

  /// PRO OPS
  final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
  _bzzProvider.addBzToMyBzz(
    bzModel: _uploadedBzModel,
    notify: true,
  );

  /// LDB OPS
  await BzLDBOps.insertBz(bzModel: _uploadedBzModel);

}
// ------------------------------------------

/// DECLINE AUTHORSHIP INVITATION

// -------------------
/// USER DECLINE AUTHORSHIP INVITATION
Future<void> _declineAuthorshipInvitation({
  @required BuildContext context,
  @required NoteModel noteModel,
}) async {
  blog('_declineAuthorshipInvitation : decline ');

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    title: 'Decline invitation ?',
    body: 'This will reject the invitation and you will not be added as an author.',
    confirmButtonText: 'Decline Invitation',
    boolDialog: true,
  );

  if (_result == true){

    await _modifyNoteResponse(
      context: context,
      noteModel: noteModel,
      response: 'phid_decline',
    );

  }

}
// -------------------
Future<void> _modifyNoteResponse({
  @required BuildContext context,
  @required NoteModel noteModel,
  @required String response,
}) async {

  final NoteModel _newNoteModel = noteModel.copyWith(
    response: response,
    responseTime: DateTime.now(),
  );

  await NoteFireOps.updateNote(
    context: context,
    newNoteModel: _newNoteModel,
  );

}
// ------------------------------------------
