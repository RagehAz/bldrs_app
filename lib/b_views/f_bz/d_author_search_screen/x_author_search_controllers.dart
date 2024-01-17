import 'dart:async';

import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/strings/searching.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:basics/layouts/handlers/max_bounce_navigator.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/z_components/bubbles/b_variants/user_bubbles/aa_user_banner.dart';
import 'package:bldrs/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/c_protocols/user_protocols/fire/user_fire_search.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// SEARCH

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSearchUsers({
  required String? text,
  required ValueNotifier<List<UserModel>?> foundUsers,
  required ValueNotifier<bool> isSearching,
  required ValueNotifier<bool> loading,
  required List<String> userIDsToExclude,
  required bool mounted,
}) async {

  blog('starting onSearchUsers : text : $text');

  Searching.triggerIsSearchingNotifier(
    text: text,
    isSearching: isSearching,
    mounted: mounted,
  );

  if (isSearching.value == true){

    setNotifier(notifier: loading, mounted: mounted, value: true);

    final String? _fixedText = TextMod.fixSearchText(text);

    final List<UserModel> _users = await UserFireSearchOps.usersByUserName(
      name: _fixedText,
      // startAfter: Lister.checkCanLoop(foundUsers?.value) ? foundUsers?.value?.last?.docSnapshot : null,
      userIDsToExclude: userIDsToExclude,
    );

    setNotifier(notifier: foundUsers, mounted: mounted, value: _users);

    UserModel.blogUsersModels(
      invoker: 'onSearchUsers : text : $_fixedText',
      usersModels: _users,
    );

    setNotifier(notifier: loading, mounted: mounted, value: false);

  }

}
// --------------------

Future<void> onShowUserDialog({
  required UserModel userModel,
}) async {

  await BottomDialog.showBottomDialog(
    child: MaxBounceNavigator(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: UserBanner(userModel: userModel),
      ),
    ),
  );

}
// -----------------------------------------------------------------------------
