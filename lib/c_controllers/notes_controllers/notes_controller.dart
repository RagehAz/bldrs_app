import 'dart:async';

import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/y_views/g_user/b_1_user_profile_page.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/nav_dialog/nav_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_controllers/a_starters_controllers/nav_bar_controller.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/e_db/fire/ops/note_ops.dart' as NoteFireOps;
import 'package:bldrs/e_db/ldb/ops/auth_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/bz_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/user_ldb_ops.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bldrs/e_db/fire/ops/user_ops.dart' as UserFireOps;
import 'package:bldrs/e_db/fire/ops/bz_ops.dart' as BzFireOps;
// -----------------------------------------------------------------------------

/// NOTE OPTIONS

// -------------------------------
Future<void> onShowNoteOptions({
  @required BuildContext context,
  @required NoteModel noteModel,
}) async {

  blog('note options');

}
// -----------------------------------------------------------------------------

/// NOTE RESPONSES

// -------------------------------
Future<void> markNoteAsSeen({
  @required BuildContext context,
  @required NoteModel noteModel,
}) async {

  if (noteModel != null){

    await NoteFireOps.updateNoteSeen(
        context: context,
        noteModel: noteModel,
    );

  }

}
// -------------------------------
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

/// AUTHORSHIP NOTES

// -------------------------------
/// BZ INVITE USER
Future<void> sendAuthorshipInvitation({
  @required BuildContext context,
  @required UserModel selectedUser,
  @required BzModel bzModel,
}) async {

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    title: 'Send Invitation ?',
    body: 'confirm sending invitation to ${selectedUser.name} to become an author of ${bzModel.name} account',
    boolDialog: true,
    height: 500,
    child: UserProfilePage(
      userModel: selectedUser,
      // showContacts: false,
    ),
  );

  if (_result == true){

    final AuthorModel _myAuthorModel = AuthorModel.getAuthorFromBzByAuthorID(
      bz: bzModel,
      authorID: superUserID(),
    );

    final String _noteLang = selectedUser.language;

    final NoteModel _note = NoteModel(
      id: null, // will be defined in note create fire ops
      senderID: bzModel.id, /// HAS TO BE BZ ID NOT AUTHOR ID
      senderImageURL: _myAuthorModel.pic,
      noteSenderType: NoteSenderType.bz,
      receiverID: selectedUser.id,
      title: 'Business Account Invitation',
      body: "'${_myAuthorModel.name}' sent you an invitation to become an Author for '${bzModel.name}' business page",
      metaData: NoteModel.defaultMetaData,
      sentTime: DateTime.now(),
      attachment: bzModel.id,
      attachmentType: NoteAttachmentType.bzID,
      seen: false,
      seenTime: null,
      sendFCM: true,
      noteType: NoteType.authorship,
      response: null,
      responseTime: null,
      // senderImageURL:
      buttons: <String>['phid_accept', 'phid_decline'],
    );

    await NoteFireOps.createNote(
      context: context,
      noteModel: _note,
    );

    final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
    await _notesProvider.addNewPendingSentAuthorshipNote(
      context: context,
      note: _note,
      notify: true,
    );

    NavDialog.showNavDialog(
      context: context,
      firstLine: 'Invitation Sent',
      secondLine: 'Account authorship invitation has been sent to ${selectedUser.name} successfully',
      color: Colorz.green255,
    );

  }

}
// -------------------------------
/// BZ CANCEL SENT INVITATION
Future<void> cancelSentAuthorshipInvitation ({
  @required BuildContext context,
  @required List<NoteModel> pendingNotes,
  @required String receiverID,
}) async {

  final NoteModel _note = NoteModel.getFirstNoteByRecieverID(
    notes: pendingNotes,
    receiverID: receiverID,
  );

  if (_note != null){

    await NoteFireOps.deleteNote(
      context: context,
      noteID: _note.id,
    );

    final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
    _notesProvider.removeSentAuthorshipNote(
      note: _note,
      notify: true,
    );

    await TopDialog.showTopDialog(
      context: context,
      firstLine: 'Invitation request has been cancelled',
      color: Colorz.green255,
      textColor: Colorz.white255,
    );

  }

}
// -------------------------------
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
// -------------------------------
/// USER ACCEPT AUTHORSHIP INVITATION
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
          myBzModel: bzModel,
      );

    }

}
// -------------------------------
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
// -------------------------------
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
  await BzLDBOps.createBzOps(bzModel: _uploadedBzModel);

}

// -------------------------------
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
// -------------------------------
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
// -------------------------------
