import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/x_screens/f_bz/f_0_my_bz_screen.dart';
import 'package:bldrs/b_views/x_screens/g_user/g_0_user_profile_screen.dart';
import 'package:bldrs/b_views/x_screens/j_questions/questions_screen.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
// Future<void> onNavBarBzzButtonTap({
//   @required BuildContext context,
//   @required List<BzModel> myBzz,
// }) async {
//
//   final UserModel _myUserModel = UsersProvider.proGetMyUserModel(context);
//
//   /// IF HAS ONLY ONE BZ ACCOUNT
//   if (_myUserModel.myBzzIDs.length == 1) {
//
//
//     await goToMyBzScreen(
//       context: context,
//       bzID: _myUserModel.myBzzIDs[0],
//     );
//
//   }
//
//   /// IF HAS MULTIPLE BZZ ACCOUNTS
//   else {
//
//     await _goToMyBzzScreen(
//       context: context,
//     );
//
//   }
//
// }
// -------------------------------
Future<void> goToMyBzScreen({
  @required BuildContext context,
  @required String bzID,
}) async {

  final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);

  final BzModel _bzModel = await _bzzProvider.fetchBzModel(
    context: context,
    bzID: bzID,
  );

  _bzzProvider.setActiveBz(
    bzModel: _bzModel,
    notify: true,
  );

  await Nav.goToNewScreen(
      context: context,
      screen: const MyBzScreen()
  );

}
// -------------------------------
// Future<void> _goToMyBzzScreen({
//   @required BuildContext context,
// }) async {
//
//   await Nav.goToNewScreen(
//       context: context,
//       screen: const MyBzzSelectorScreen(),
//   );
//
// }
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
