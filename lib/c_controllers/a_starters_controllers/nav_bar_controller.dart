import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/x_screens/f_bz/f_0_my_bz_screen.dart';
import 'package:bldrs/b_views/x_screens/f_bz/f_1_my_bzz_selector_screen.dart';
import 'package:bldrs/b_views/x_screens/g_user/g_0_user_profile_screen.dart';
import 'package:bldrs/b_views/x_screens/j_questions/questions_screen.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/router/route_names.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// GO TO SAVES SCREEN

// -------------------------------
Future<void> goToSavesScreen(BuildContext context) async {
  await Nav.goToRoute(context, Routez.savedFlyers);
}
// -----------------------------------------------------------------------------

/// GO TO QUESTIONS SCREEN

// -------------------------------
Future<void> goToQuestionsScreen(BuildContext context) async {
  await Nav.goToNewScreen(
    context: context,
    screen: const QScreen(),
  );
}
// -----------------------------------------------------------------------------

/// GO TO BZ SCREEN

// -------------------------------
Future<void> onNavBarBzzButtonTap({
  @required BuildContext context,
  @required List<BzModel> myBzz,
}) async {

  final UserModel _myUserModel = UsersProvider.proGetMyUserModel(context);

  /// IF HAS ONLY ONE BZ ACCOUNT
  if (_myUserModel.myBzzIDs.length == 1) {

    await goToMyBzScreen(
      context: context,
      myBzModel: myBzz.first,
    );

  }

  /// IF HAS MULTIPLE BZZ ACCOUNTS
  else {

    await _goToMyBzzScreen(
      context: context,
      myBzzModels: myBzz,
      myUserModel: _myUserModel,
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
Future<void> _goToMyBzzScreen({
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
// -----------------------------------------------------------------------------

/// GO TO USER SCREEN

// -------------------------------
Future<void> goToMyProfileScreen(BuildContext context) async {
  await Nav.goToNewScreen(
      context: context,
      screen: const UserProfileScreen()
  );
}
// -----------------------------------------------------------------------------
