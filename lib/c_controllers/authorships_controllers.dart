import 'dart:async';

import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/nav_dialog/nav_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/user_profile/user_banner.dart';
import 'package:bldrs/c_controllers/a_starters_controllers/main_navigation_controllers.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/fire_models/fire_finder.dart';
import 'package:bldrs/e_db/fire/fire_models/query_order_by.dart';
import 'package:bldrs/e_db/fire/fire_models/query_parameters.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as AuthFireOps;
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/e_db/fire/ops/bz_ops.dart' as BzFireOps;
import 'package:bldrs/e_db/fire/ops/note_ops.dart' as NoteFireOps;
import 'package:bldrs/e_db/fire/ops/user_ops.dart' as UserFireOps;
import 'package:bldrs/e_db/ldb/ops/auth_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/bz_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/user_ldb_ops.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------

/// BZ AUTHORSHIP NOTES STREAMING QUERY PARAMETERS

// ------------------------------------------
QueryParameters bzSentPendingAuthorshipNotesStreamQueryParameters({
  @required String bzID,
  @required ValueChanged<List<Map<String, dynamic>>> onDataChanged,
}){

  return QueryParameters(
    collName: FireColl.notes,
    limit: 50,
    orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
    onDataChanged: onDataChanged,
    finders: <FireFinder>[

      FireFinder(
        field: 'senderID',
        comparison: FireComparison.equalTo,
        value: bzID,
      ),

      FireFinder(
        field: 'noteType',
        comparison: FireComparison.equalTo,
        value: NoteModel.cipherNoteType(NoteType.authorship),
      ),

      FireFinder(
        field: 'response',
        comparison: FireComparison.equalTo,
        value: NoteModel.cipherResponse(NoteResponse.pending),
      ),

    ],
  );

}
// -----------------------------------------------------------------------------

/// SENDING AUTHORSHIP INVITATIONS

// -------------------------------
///
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
    child: UserBanner(
      userModel: selectedUser,
    ),
  );

  if (_result == true){

    final AuthorModel _myAuthorModel = AuthorModel.getAuthorFromBzByAuthorID(
      bz: bzModel,
      authorID: AuthFireOps.superUserID(),
    );

    // final String _noteLang = selectedUser.language;

    /// TASK : SHOULD SEND NOTE WITH SELECTED USER'S LANG

    final NoteModel _note = NoteModel(
      id: null, // will be defined in note create fire ops
      senderID: bzModel.id, /// HAS TO BE BZ ID NOT AUTHOR ID
      senderImageURL: _myAuthorModel.pic,
      noteSenderType: NoteSenderType.bz,
      receiverID: selectedUser.id,
      receiverType: NoteReceiverType.user,
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
      response: NoteResponse.pending,
      responseTime: null,
      // senderImageURL:
      buttons: const <String>['phid_accept', 'phid_decline'],
    );

    await NoteFireOps.createNote(
      context: context,
      noteModel: _note,
    );

    // final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
    // await _notesProvider.addNewPendingSentAuthorshipNote(
    //   context: context,
    //   note: _note,
    //   notify: true,
    // );

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

  // if (_note.sen)

  if (_note != null){

    await NoteFireOps.deleteNote(
      context: context,
      noteID: _note.id,
    );

    // final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
    // _notesProvider.removeSentAuthorshipNote(
    //   note: _note,
    //   notify: true,
    // );

    await TopDialog.showTopDialog(
      context: context,
      firstLine: 'Invitation request has been cancelled',
      color: Colorz.green255,
      textColor: Colorz.white255,
    );

  }

}
// -----------------------------------------------------------------------------

/// AUTHORSHIP NOTE RESPONSES

// ------------------------------------------
/// USER RESPONSE TO AUTHORSHIP INVITATION
Future<void> respondToAuthorshipNote({
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
      response: NoteResponse.accepted,
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
      bzID: bzModel.id,
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
      response: NoteResponse.declined,
    );

  }

}
// -------------------
Future<void> _modifyNoteResponse({
  @required BuildContext context,
  @required NoteModel noteModel,
  @required NoteResponse response,
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
// -----------------------------------------------------------------------------

/// AUTHOR OPTIONS

// -------------------------------
Future<void> onAuthorOptionsTap({
  @required BuildContext context,
  @required AuthorModel authorModel,
  @required BzModel bzModel,
}) async {

  final bool _itIsMine = superUserID() == authorModel.userID;
  final bool _iAmMaster = AuthorModel.checkUserIsMasterAuthor(userID: superUserID(), bzModel: bzModel);

  final bool _canChangeRoles = _iAmMaster;
  final bool _canEditAuthor = _itIsMine;
  final bool _canRemoveAuthor = _iAmMaster || _itIsMine;

  final List<Widget> _buttons = <Widget>[

    /// CHANGE ROLE
    BottomDialog.wideButton(
      context: context,
      verse: 'Change team role for ${authorModel.name}',
      icon: Iconz.bz,
      isDeactivated: !_canChangeRoles,
      onDeactivatedTap: () => _onShowCanNotChangeAuthorRoleDialog(
        context: context,
        authorModel: authorModel,
      ),
      onTap: () => _onChangeAuthorRole(
        context: context,
        bzModel: bzModel,
        authorModel: authorModel,
      ),
    ),

    /// EDIT AUTHOR
    BottomDialog.wideButton(
      context: context,
      verse: 'Edit ${authorModel.name} Author details',
      icon: Iconz.gears,
      isDeactivated: !_canEditAuthor,
      onDeactivatedTap: () => _onShowCanNotEditAuthorDialog(
        context: context,
        authorModel: authorModel,
      ),
      onTap: () => _onEditAuthor(
        context: context,
        bzModel: bzModel,
        authorModel: authorModel,
      ),
    ),

    /// REMOVE AUTHOR
    BottomDialog.wideButton(
      context: context,
      verse: 'Remove ${authorModel.name} from the team',
      icon: Iconz.xSmall,
      isDeactivated: !_canRemoveAuthor,
      onDeactivatedTap: () => _onShowCanNotRemoveAuthorDialog(
        context: context,
        authorModel: authorModel,
      ),
      onTap: () => _onDeleteAuthorFromTheTeam(
        context: context,
        bzModel: bzModel,
        authorModel: authorModel,
      ),
    ),

  ];

  await BottomDialog.showButtonsBottomDialog(
      context: context,
      draggable: true,
      numberOfWidgets: _buttons.length,
      builder: (_, PhraseProvider phraseProvider){

        return _buttons;

      }
  );

}
// -----------------------------------------------------------------------------

/// DELETE AUTHOR

// -------------------------------
Future<void> _onDeleteAuthorFromTheTeam({
  @required BuildContext context,
  @required AuthorModel authorModel,
  @required BzModel bzModel,
}) async {

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    title: 'Remove ${authorModel.name} ?',
    body: '${authorModel.name} and all his published flyers will be deleted as well',
    boolDialog: true,
  );

  if (_result == true){

    blog('SHOULD REMOVE THIS AUTHOR ${authorModel.name} and all his FLYERS from this bz ${bzModel.name} naaaw');


  }

}
// -------------------------------
Future<void> _onShowCanNotRemoveAuthorDialog({
  @required BuildContext context,
  @required AuthorModel authorModel,
}) async {

  await CenterDialog.showCenterDialog(
    context: context,
    title: 'You can not remove ${authorModel.name}',
    body: 'Only Account Admins can remove other team members,\n'
        'however you can remove only yourself from this business account',
  );

}
// -----------------------------------------------------------------------------

/// EDIT AUTHOR

// -------------------------------
Future<void> _onEditAuthor({
  @required BuildContext context,
  @required AuthorModel authorModel,
  @required BzModel bzModel,
}) async {

  blog('should edit author naaaw');

}
// -------------------------------
Future<void> _onShowCanNotEditAuthorDialog({
  @required BuildContext context,
  @required AuthorModel authorModel,
}) async {

  await CenterDialog.showCenterDialog(
    context: context,
    title: 'You can not Edit ${authorModel.name}',
    body: 'Only ${authorModel.name} can edit his Author detail',
  );

}
// -----------------------------------------------------------------------------

/// AUTHOR ROLES

// -------------------------------
Future<void> _onChangeAuthorRole({
  @required BuildContext context,
  @required AuthorModel authorModel,
  @required BzModel bzModel,
}) async {

  blog('SHOULD CHANGE ROLE FOR AUTHOR ${authorModel.name} from this bz ${bzModel.name} naaaAAAAAAAAAw');

}
// -------------------------------
Future<void> _onShowCanNotChangeAuthorRoleDialog({
  @required BuildContext context,
  @required AuthorModel authorModel,
}) async {

  await CenterDialog.showCenterDialog(
    context: context,
    title: 'You can not Change team member roles',
    body: 'Only Account Admins can change the roles of other team members',
  );

}
// -----------------------------------------------------------------------------
