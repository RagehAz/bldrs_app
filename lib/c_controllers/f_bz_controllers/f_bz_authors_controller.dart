import 'dart:async';

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
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as AuthFireOps;
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/e_db/fire/ops/note_ops.dart' as NoteFireOps;
import 'package:bldrs/e_db/fire/search/user_fire_search.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------

/// NAVIGATION

// -------------------------------
/// TESTED : WORKS PERFECT
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
  @required bool excludeMyself,
}) async {

  blog('starting onSearchUsers : text : $text');

  triggerIsSearchingNotifier(
      text: text,
      isSearching: isSearching,
  );

  if (isSearching.value == true){

    loading.value = true;

    final String _fixedText = TextMod.fixSearchText(text);

    final List<UserModel> _users = await UserFireSearch.usersByUserName(
      context: context,
      name: _fixedText,
      startAfter: Mapper.checkCanLoopList(foundUsers?.value) ? foundUsers?.value?.last?.docSnapshot : null,
      excludeMyself: excludeMyself,
    );

    foundUsers.value = _users;

    UserModel.blogUsersModels(
      methodName: 'onSearchUsers',
      usersModels: _users,
    );

    loading.value = false;

  }

}
// -------------------------------
Future<void> onShowUserDialog({
  @required BuildContext context,
  @required UserModel userModel,
}) async {

  await BottomDialog.showBottomDialog(
    context: context,
    draggable: true,
    child: const UserProfilePage(),
  );

}
// -----------------------------------------------------------------------------

/// AUTHORSHIP INVITATIONS

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
      authorID: AuthFireOps.superUserID(),
    );

    // final String _noteLang = selectedUser.language;

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
      response: null,
      responseTime: null,
      // senderImageURL:
      buttons: const <String>['phid_accept', 'phid_decline'],
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

  // if (_note.sen)

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

/// AUTHOR MORE OPTIONS

// -------------------------------
Future<void> onMoreTap({
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
Future<void> _onEditAuthor({
  @required BuildContext context,
  @required AuthorModel authorModel,
  @required BzModel bzModel,
}) async {

  blog('should edit author naaaw');

}
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
