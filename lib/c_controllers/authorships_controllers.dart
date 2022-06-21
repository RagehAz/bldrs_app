import 'dart:async';

import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/x_screens/f_bz_editor/f_x_author_editor_screen.dart';
import 'package:bldrs/b_views/x_screens/f_bz_editor/f_x_author_role_editor_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/flyer/c_flyer_groups/flyers_grid.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/user_profile/user_banner.dart';
import 'package:bldrs/c_controllers/a_starters_controllers/main_navigation_controllers.dart';
import 'package:bldrs/c_controllers/f_bz_controllers/bz_flyers_page_controllers.dart';
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
import 'package:bldrs/e_db/ldb/ops/flyer_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/user_ldb_ops.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// -----------------------------------------------------------------------------

/// BZ AUTHORSHIP NOTES STREAMING QUERY MODEL

// ------------------------------------------
/// TESTED : WORKS PERFECT
QueryModel bzSentPendingAuthorshipNotesStreamQueryModel({
  @required String bzID,
  @required ValueChanged<List<Map<String, dynamic>>> onDataChanged,
}){

  return QueryModel(
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
// ------------------------------------------
/// TESTED : NOT YET
QueryModel bzSentDeclinedAndCancelledNotesPaginatorQueryModel({
  @required String bzID,
  @required ValueChanged<List<Map<String, dynamic>>> onDataChanged,
}){

  return QueryModel(
    collName: FireColl.notes,
    limit: 10,
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
        value: NoteModel.cipherResponse(NoteResponse.declined),
      ),

      /// TASK : ??? will this work ?
      FireFinder(
        field: 'response',
        comparison: FireComparison.equalTo,
        value: NoteModel.cipherResponse(NoteResponse.cancelled),
      ),

    ],
  );

}
// -----------------------------------------------------------------------------

/// SENDING AUTHORSHIP INVITATIONS

// -------------------------------
/// TESTED : SENDS GOOD : need translations
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
      buttons: NoteModel.generateAcceptDeclineButtons(),
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

    unawaited(
    TopDialog.showTopDialog(
      context: context,
      firstLine: 'Invitation Sent',
      secondLine: 'Account authorship invitation has been sent to ${selectedUser.name} successfully',
      color: Colorz.green255,
    ));

  }

}
// -------------------------------
/// TESTED : WORKS PERFECT
Future<void> cancelSentAuthorshipInvitation ({
  @required BuildContext context,
  @required NoteModel note,
}) async {

  if (note != null){

    final UserModel _receiverModel = await UsersProvider.proFetchUserModel(
        context: context,
        userID: note.receiverID
    );

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      title: 'Cancel Invitation ?',
      body: '${_receiverModel.name} will be notified with cancelling this invitation',
      boolDialog: true,
      confirmButtonText: 'Yes, Cancel Invitation',
    );

    if (_result == true){

      final NoteModel _updated = note.copyWith(
        response: NoteResponse.cancelled,
        responseTime: DateTime.now(),
      );

      await NoteFireOps.updateNote(
        context: context,
        newNoteModel: _updated,
      );

      await TopDialog.showTopDialog(
        context: context,
        firstLine: 'Invitation request has been cancelled',
        color: Colorz.green255,
        textColor: Colorz.white255,
      );

    }

  }

}
// -----------------------------------------------------------------------------

/// AUTHORSHIP NOTE RESPONSES

// ------------------------------------------
/// TESTED : WORKS PERFECT
Future<void> respondToAuthorshipNote({
  @required BuildContext context,
  @required NoteResponse response,
  @required NoteModel noteModel,
  @required BzModel bzModel,
}) async {

  // NOTE : USER RESPONSE TO AUTHORSHIP INVITATION

  await NoteFireOps.markNoteAsSeen(
      context: context,
      noteModel: noteModel
  );

  /// ACCEPT AUTHORSHIP
  if (response == NoteResponse.accepted){
    await _acceptAuthorshipInvitation(
      context: context,
      noteModel: noteModel,
      bzModel: bzModel,
    );
  }

  /// DECLINE AUTHORSHIP
  else if (response == NoteResponse.declined){
    await _declineAuthorshipInvitation(
      context: context,
      noteModel: noteModel,
    );
  }

  else {
    blog('respondToAuthorshipNote : response : $response');
  }

}
// ------------------------------------------

/// ACCEPT AUTHORSHIP INVITATION

// -------------------
/// TESTED :
Future<void> _acceptAuthorshipInvitation({
  @required BuildContext context,
  @required NoteModel noteModel,
  @required BzModel bzModel,
}) async {

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    title: 'Accept invitation ?',
    body: 'This will add you as an Author for this business account',
    boolDialog: true,
  );

  if (_result == true){

    blog('_acceptAuthorshipInvitation : accepted ');

    unawaited(WaitDialog.showWaitDialog(
      context: context,
      loadingPhrase: "Adding you to '${bzModel.name}' business account",
    ));

    /// MODIFY MY USER MODEL
    // has to come before modifying the bzModel on firebase to let security rules allow
    // this user to modify bz on firebase.
    final UserModel _newUserModel = await _addBzIDToMyUserModelOps(
      context: context,
      bzModel: bzModel,
    );

    /// MODIFY THIS BZ MODEL
    await _addNewAuthorToNewBzOps(
      context: context,
      newUserModel: _newUserModel,
      oldBzModel: bzModel,
    );

    /// MODIFY NOTE RESPONSE
    await _modifyNoteResponse(
      context: context,
      noteModel: noteModel,
      response: NoteResponse.accepted,
    );

    await _sendAuthorshipAcceptanceNote(
      context: context,
      bzID: noteModel.senderID,
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
      replaceCurrentScreen: true,
    );

  }

}
// -------------------
/// TESTED :
Future<UserModel> _addBzIDToMyUserModelOps({
  @required BuildContext context,
  @required BzModel bzModel,
}) async {

  final UserModel _oldUserModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
  );

  /// FIRE OPS
  final UserModel _newUserModel = await UserFireOps.addBzIDToUserBzzIDs(
    context: context,
    bzID: bzModel.id,
    oldUserModel: _oldUserModel,
  );

  final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
  AuthModel _authModel = _usersProvider.myAuthModel;
  _authModel = _authModel.copyWith(
    userModel: _newUserModel,
  );

  /// PRO OPS
  _usersProvider.setMyUserModelAndAuthModel(
      userModel: _newUserModel,
      notify: false
  );

  /// LDB OPS
  await AuthLDBOps.updateAuthModel(_authModel);
  await UserLDBOps.updateUserModel(_newUserModel);

  return _newUserModel;
}
// -------------------
/// TESTED :
Future<BzModel> _addNewAuthorToNewBzOps({
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
  await BzLDBOps.insertBz(bzModel: _uploadedBzModel,);

  return _uploadedBzModel;
}
// -------------------
/// TESTED :
Future<void> _sendAuthorshipAcceptanceNote({
  @required BuildContext context,
  @required String bzID,
}) async {

  final UserModel _myUserModel = UsersProvider.proGetMyUserModel(
    context: context,
    listen: false,
  );

  final NoteModel _noteModel = NoteModel(
    id: 'x',
    senderID: _myUserModel.id,
    senderImageURL: _myUserModel.pic,
    noteSenderType: NoteSenderType.user,
    receiverID: bzID,
    receiverType: NoteReceiverType.bz,
    title: '${_myUserModel.name} accepted The invitation request',
    body: '${_myUserModel.name} has become a part of the team now.',
    metaData: NoteModel.defaultMetaData,
    sentTime: DateTime.now(),
    attachment: null,
    attachmentType: NoteAttachmentType.non,
    seen: false,
    seenTime: null,
    sendFCM: true,
    noteType: NoteType.authorship,
    response: null,
    responseTime: null,
    buttons: null,
  );

  await NoteFireOps.createNote(
      context: context,
      noteModel: _noteModel
  );

}
// ------------------------------------------

/// DECLINE AUTHORSHIP INVITATION

// -------------------
/// TESTED :
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
/// TESTED : WORKS PERFECT
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
      onTap: () => _onDeleteAuthorFromActiveBzTeam(
        context: context,
        // bzModel: bzModel,
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
Future<void> _onDeleteAuthorFromActiveBzTeam({
  @required BuildContext context,
  @required AuthorModel authorModel,
}) async {

  /// CLOSE BOTTOM DIALOG
  Nav.goBack(context);

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    title: 'Remove ${authorModel.name} ?',
    body: '${authorModel.name} and all his published flyers will be deleted as well',
    boolDialog: true,
  );

  if (_result == true){

    final bool _authorHasFlyers = AuthorModel.checkAuthorHasFlyers(
      author: authorModel,
    );

    /// REMOVE AUTHOR HAS FLYERS
    if (_authorHasFlyers == true){

      await _removeAuthorWhoHasFlyers(
          context: context,
          authorModel: authorModel,
      );

    }

    /// REMOVE AUTHOR HAS NO FLYERS
    else {

      await _removeAuthorWhoHasNoFlyers(
        context: context,
        authorModel: authorModel,
      );

    }

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
// -------------------------------
/// TASK : NEED OPTIMIZATION TO DELETE FLYERS AND REBUILD MINIMUM NUMBER OF TIME INSTEAD OR ITERATIONS PER FLYER
Future<void> _removeAuthorWhoHasFlyers({
  @required BuildContext context,
  @required AuthorModel authorModel,
}) async {

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    title: 'Delete All Flyers',
    body: '${authorModel.flyersIDs.length} flyers published by ${authorModel.name} will be permanently deleted',
    height: 400,
    boolDialog: true,
    confirmButtonText: 'Delete All Flyers And Remove ${authorModel.name}',
    child: Container(
      width: CenterDialog.getWidth(context),
      height: 200,
      color: Colorz.white10,
      alignment: Alignment.center,
      child: FlyersGrid(
        scrollController: ScrollController(),
        paginationFlyersIDs: authorModel.flyersIDs,
        scrollDirection: Axis.horizontal,
        gridWidth: CenterDialog.getWidth(context) - 10,
        gridHeight: 200,
        numberOfColumnsOrRows: 1,
      ),
    ),
  );

  if (_result == true){

    unawaited(WaitDialog.showWaitDialog(
      context: context,
      loadingPhrase: 'Removing ${authorModel.name}',
    ));

    final BzModel _bzModel = BzzProvider.proGetActiveBzModel(
        context: context,
        listen: false,
    );

    /// DELETE ALL AUTHOR FLYERS
    for (final String flyerID in authorModel.flyersIDs){
      final FlyerModel _flyer = await FlyerLDBOps.readFlyer(flyerID);
      await deleteFlyerOps(
        bzModel: _bzModel,
        context: context,
        flyer: _flyer,
        showWaitDialog: false,
      );
    }

    /// REMOVE AUTHOR MODEL FROM BZ MODEL
    final BzModel _updatedBzModel = BzModel.removeAuthor(
      bzModel: _bzModel,
      authorID: authorModel.userID,
    );

    /// UPDATE BZ ON FIREBASE
    await BzFireOps.updateBz(
        context: context,
        newBzModel: _updatedBzModel,
        oldBzModel: _bzModel,
        authorPicFile: null
    );

    /// SEND AUTHOR DELETION NOTES
    await _sendAuthorDeletionNotes(
      context: context,
      bzModel: _bzModel,
      deletedAuthor: authorModel,
    );

    WaitDialog.closeWaitDialog(context);

    /// SHOW CONFIRMATION DIALOG
    await _showAuthorRemovalConfirmationDialog(
      context: context,
      bzModel: _bzModel,
      deletedAuthor: authorModel,
    );

  }

}
// -------------------------------
Future<void> _removeAuthorWhoHasNoFlyers({
  @required BuildContext context,
  @required AuthorModel authorModel,
}) async {

  final BzModel _bzModel = BzzProvider.proGetActiveBzModel(
    context: context,
    listen: false,
  );

  /// REMOVE AUTHOR MODEL FROM BZ MODEL
  final BzModel _updatedBzModel = BzModel.removeAuthor(
    bzModel: _bzModel,
    authorID: authorModel.userID,
  );

  /// UPDATE BZ ON FIREBASE
  await BzFireOps.updateBz(
      context: context,
      newBzModel: _updatedBzModel,
      oldBzModel: _bzModel,
      authorPicFile: null
  );

  /// SEND AUTHOR DELETION NOTES
  await _sendAuthorDeletionNotes(
    context: context,
    bzModel: _bzModel,
    deletedAuthor: authorModel,
  );

  /// SHOW CONFIRMATION DIALOG
  await _showAuthorRemovalConfirmationDialog(
    context: context,
    bzModel: _bzModel,
    deletedAuthor: authorModel,
  );


}
// -------------------------------
Future<void> _sendAuthorDeletionNotes({
  @required BuildContext context,
  @required BzModel bzModel,
  @required AuthorModel deletedAuthor,
}) async {

  /// NOTE TO BZ
  final NoteModel _noteToBz = NoteModel(
    id: 'x',
    senderID: deletedAuthor.userID,
    senderImageURL: deletedAuthor.pic,
    noteSenderType: NoteSenderType.user,
    receiverID: bzModel.id,
    receiverType: NoteReceiverType.bz,
    title: '${deletedAuthor.name} has left the team',
    body: '${deletedAuthor.name} is no longer part of ${bzModel.name} team',
    metaData: NoteModel.defaultMetaData,
    sentTime: DateTime.now(),
    attachment: null,
    attachmentType: NoteAttachmentType.non,
    seen: false,
    seenTime: null,
    sendFCM: true,
    noteType: NoteType.announcement,
    response: null,
    responseTime: null,
    buttons: null,
  );

  await NoteFireOps.createNote(
      context: context,
      noteModel: _noteToBz,
  );

  /// NOTE TO DELETED AUTHOR
  final NoteModel _noteToUser = NoteModel(
    id: 'x',
    senderID: bzModel.id,
    senderImageURL: bzModel.logo,
    noteSenderType: NoteSenderType.bz,
    receiverID: deletedAuthor.userID,
    receiverType: NoteReceiverType.user,
    title: 'You have exited from ${bzModel.name} account',
    body: 'You are no longer part of ${bzModel.name} team',
    metaData: NoteModel.defaultMetaData,
    sentTime: DateTime.now(),
    attachment: null,
    attachmentType: NoteAttachmentType.non,
    seen: false,
    seenTime: null,
    sendFCM: true,
    noteType: NoteType.announcement,
    response: null,
    responseTime: null,
    buttons: null,
  );

  await NoteFireOps.createNote(
    context: context,
    noteModel: _noteToUser,
  );

}
// -------------------------------
Future<void> _showAuthorRemovalConfirmationDialog({
  @required BuildContext context,
  @required BzModel bzModel,
  @required AuthorModel deletedAuthor,
}) async {

  unawaited(TopDialog.showTopDialog(
    context: context,
    firstLine: '${deletedAuthor.name} has been removed from the team of ${bzModel.name}',
    color: Colorz.green255,
    textColor: Colorz.white255,
  ));

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

  await Nav.goToNewScreen(
      context: context,
      screen: const AuthorEditorScreen(),
  );

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

  /// CLOSE BOTTOM DIALOG
  Nav.goBack(context);

  await Nav.goToNewScreen(
      context: context,
      screen: AuthorRoleEditorScreen(
        authorModel: authorModel,
      ),
  );

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
