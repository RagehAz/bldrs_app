import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/x_screens/f_bz/f_0_my_bz_screen.dart';
import 'package:bldrs/b_views/x_screens/f_bz/f_1_my_bzz_selector_screen.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
// -----------------------------------------------------------------------------

/// NAVIGATION

// -------------------------------
Future<void> onNavBarBzzButtonTap({
  @required BuildContext context,
  @required List<BzModel> myBzz,
  @required UserModel myUserModel,
}) async {

  blog('fish');

  /// IF HAS ONLY ONE BZ ACCOUNT
  if (myUserModel.myBzzIDs.length == 1) {

    await goToMyBzScreen(
      context: context,
      myBzModel: myBzz.first,
    );

  }

  /// IF HAS MULTIPLE BZZ ACCOUNTS
  else {

    await goToMyBzzScreen(
      context: context,
      myBzzModels: myBzz,
      myUserModel: myUserModel,
    );

  }

}
// -------------------------------
Future<void> goToMyBzScreen({
  @required BuildContext context,
  @required BzModel myBzModel,
}) async {

  await Nav.goToNewScreen(
      context: context,
      screen: MyBzScreen(
        bzModel: myBzModel,
      )
  );

}
// -------------------------------
Future<void> goToMyBzzScreen({
  @required BuildContext context,
  @required List<BzModel> myBzzModels,
  @required UserModel myUserModel,
}) async {

  await Nav.goToNewScreen(
      context: context,
      screen: MyBzzSelectorScreen(
        userModel: myUserModel,
        bzzModels: myBzzModels,
      )
  );

}
