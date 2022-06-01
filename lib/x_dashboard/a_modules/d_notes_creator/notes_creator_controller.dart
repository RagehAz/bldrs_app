import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/x_dashboard/a_modules/d_notes_creator/search_users_screen.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// INITIALIZATION

// -------------------------------
NoteModel createInitialNote(BuildContext context) {

  final UserModel _userModel = UsersProvider.proGetMyUserModel(context);

  final NoteModel _noteModel = NoteModel(
    id: null,
    senderID: _userModel.id,
    senderImageURL: _userModel.pic,
    noteSenderType: NoteSenderType.bldrs,
    receiverID: null,
    title: 'Note Title',
    body: 'Note body',
    metaData: NoteModel.defaultMetaData,
    sentTime: DateTime.now(),
    attachment: null,
    attachmentType: null,
    seen: null,
    seenTime: null,
    sendFCM: false,
    noteType: NoteType.announcement,
    response: null,
    responseTime: null,
    buttons: null,
  );

  return _noteModel;
}
// -----------------------------------------------------------------------------
Future<UserModel> onSelectNoteReceiverTap(BuildContext context) async {

  final List<UserModel> _selectedUsers = await Nav.goToNewScreen(
      context: context,
      screen: const SearchUsersScreen(
        // multipleSelection: false,
        // selectedUsers: null,
      ),
  );

    blog('selected these users ahowwan');
    UserModel.blogUsersModels(
        usersModels: _selectedUsers
    );

}
