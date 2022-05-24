import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/x_screens/f_bz/f_3_add_author_screen.dart';
import 'package:bldrs/b_views/y_views/g_user/b_1_user_profile_page.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/e_db/fire/search/user_fire_search.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:flutter/material.dart';
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
  @required UserModel userModel,
  @required BzModel bzModel,
}) async {

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    title: 'Send Invitation ?',
    body: 'confirm sending invitation to ${userModel.name} to become an author of ${bzModel.name} account',
    boolDialog: true,
    height: 500,
    child: UserProfilePage(
      userModel: userModel,
      // showContacts: false,
    ),
  );

  if (_result == true){

    blog('invite the user naaaaaaaw');

  }

}
// -----------------------------------------------------------------------------
