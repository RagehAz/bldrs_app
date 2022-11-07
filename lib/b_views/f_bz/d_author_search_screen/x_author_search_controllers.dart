import 'dart:async';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/d_user/z_components/banners/aa_user_banner.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/c_protocols/user_protocols/fire/user_fire_search.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// SEARCH

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSearchUsers({
  @required String text,
  @required ValueNotifier<List<UserModel>> foundUsers,
  @required ValueNotifier<bool> isSearching,
  @required ValueNotifier<bool> loading,
  @required List<String> userIDsToExclude,
}) async {

  blog('starting onSearchUsers : text : $text');

  TextCheck.triggerIsSearchingNotifier(
    text: text,
    isSearching: isSearching,
  );

  if (isSearching.value == true){

    loading.value = true;

    final String _fixedText = TextMod.fixSearchText(text);

    final List<UserModel> _users = await UserFireSearch.usersByUserName(
      name: _fixedText,
      // startAfter: Mapper.checkCanLoopList(foundUsers?.value) ? foundUsers?.value?.last?.docSnapshot : null,
      userIDsToExclude: userIDsToExclude,
    );

    foundUsers.value = _users;

    UserModel.blogUsersModels(
      invoker: 'onSearchUsers : text : $_fixedText',
      usersModels: _users,
    );

    loading.value = false;

  }

}
// --------------------

Future<void> onShowUserDialog({
  @required BuildContext context,
  @required UserModel userModel,
}) async {

  await BottomDialog.showBottomDialog(
    context: context,
    draggable: true,
    child: UserBanner(userModel: userModel),
  );

}
// -----------------------------------------------------------------------------
