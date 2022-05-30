import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/x_screens/f_bz/f_3_add_author_screen.dart';
import 'package:bldrs/b_views/y_views/g_user/b_1_user_profile_page.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/nav_dialog/nav_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/e_db/fire/ops/note_ops.dart' as NoteFireOps;
import 'package:bldrs/e_db/fire/search/user_fire_search.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------

/// NAVIGATION

// -------------------------------
Future<void> onGoToAddAuthorsScreen(BuildContext context) async {

  await Nav.goToNewScreen(
      context: context,
      screen: const AddAuthorScreen(),
  );

}
// -----------------------------------------------------------------------------

/// SEARCH

// -------------------------------
Future<void> onSearchUsers({
  @required BuildContext context,
  @required String text,
  @required ValueNotifier<List<UserModel>> foundUsers,
  @required ValueNotifier<bool> isSearching,
  @required ValueNotifier<bool> loading,
}) async {

  blog('starting onSearchUsers : text : $text');

  triggerIsSearchingNotifier(
      text: text,
      isSearching: isSearching,
      onSwitchOff: (){
        foundUsers.value = null;
      }
  );

  if (isSearching.value == true){

    loading.value = true;

    final String _fixedText = fixSearchText(text);

    final List<UserModel> _users = await UserFireSearch.usersByUserName(
      context: context,
      name: _fixedText,
      startAfter: canLoopList(foundUsers?.value) ? foundUsers?.value?.last?.docSnapshot : null,
    );

    foundUsers.value = _users;

    UserModel.blogUsersModels(
      methodName: 'onSearchUsers',
      usersModels: _users,
    );

    loading.value = false;

  }

}
// -----------------------------------------------------------------------------

/// SELECTION

// -------------------------------
Future<void> onShowUserDialog({
  @required BuildContext context,
  @required UserModel userModel,
}) async {

  await BottomDialog.showBottomDialog(
    context: context,
    draggable: true,
    child: UserProfilePage(
      userModel: userModel,
      // showContacts: false,
    ),
  );

}
// -----------------------------------------------------------------------------

/// INVITE

// -------------------------------
Future<void> onInviteUserButtonTap({
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
      senderID: bzModel.id,
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
// -----------------------------------------------------------------------------

/// CANCEL SENT INVITATION

// -------------------------------
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
// -----------------------------------------------------------------------------
