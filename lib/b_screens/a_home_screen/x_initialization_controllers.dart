import 'dart:async';

import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_screens/b_user_screens/c_user_editor_screen/user_editor_screen.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
import 'package:fire/super_fire.dart';
import 'package:provider/provider.dart';
/// => TAMAM
// -----------------------------------------------------------------------------

/// INITIALIZATION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> initializeHomeScreen() async {

  await checkIfUserIsMissingFields();

  /// I - KEYWORDS
  unawaited(initializeAllChains());

}
// -----------------------------------------------------------------------------

/// USER MISSING FIELDS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> checkIfUserIsMissingFields() async {
  // blog('initializeHomeScreen.checkIfUserIsMissingFields : ~~~~~~~~~~ START');

  final UserModel? _userModel = UsersProvider.proGetMyUserModel(
    context: getMainContext(),
    listen: false,
  );

  if (Authing.userIsSignedUp(_userModel?.signInMethod) == true){

    // _userModel?.blogUserModel(invoker: 'initializeHomeScreen.checkIfUserIsMissingFields');

    if (_userModel != null){

      // blog('_checkIfUserIsMissingFields');
      // AuthModel.blogAuthModel(authModel: _authModel);

      final bool _thereAreMissingFields = Formers.checkUserHasMissingFields(
        userModel: _userModel,
      );

      /// MISSING FIELDS FOUND
      if (_thereAreMissingFields == true){

        await _controlMissingFieldsCase(
          userModel: _userModel,
        );

      }

    }

  }
  // blog('initializeHomeScreen.checkIfUserIsMissingFields : ~~~~~~~~~~ END');
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _controlMissingFieldsCase({
  required UserModel userModel,
}) async {

  // blog('_controlMissingFieldsCase');
  // userModel.blogUserModel(invoker: '_controlMissingFieldsCase');

  await Formers.showUserMissingFieldsDialog(
    userModel: userModel,
  );

  await BldrsNav.goToNewScreen(
      screen: UserEditorScreen(
        initialTab: UserEditorTab.pic,
        firstTimer: false,
        userModel: userModel,
        reAuthBeforeConfirm: false,
        canGoBack: true,
        validateOnStartup: true,
        // checkLastSession: true,
        onFinish: () async {

          await BldrsNav.restartAndRoute();

        },
      )

  );

}
// -----------------------------------------------------------------------------

/// CHAIN INITIALIZATIONS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> initializeAllChains() async {
  // blog('initializeHomeScreen._initializeAllChains : ~~~~~~~~~~ START');
  final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(getMainContext(), listen: false);
  await _chainsProvider.initializeAllChains(
    notify: true,
  );
  // blog('initializeHomeScreen._initializeAllChains : ~~~~~~~~~~ END');
}
// -----------------------------------------------------------------------------
