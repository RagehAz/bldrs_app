import 'dart:async';
import 'package:bldrs/a_models/a_user/account_model.dart';
import 'package:bldrs/a_models/a_user/auth_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/c_protocols/auth_protocols/ldb/account_ldb_ops.dart';
import 'package:bldrs/c_protocols/auth_protocols/ldb/auth_ldb_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/ldb/user_ldb_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/b_views/d_user/b_user_editor_screen/user_editor_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// -----------------------------------------------------------------------------

/// AUTHENTICATORS

// --------------------
/*
Future<void> authByGoogle(BuildContext context) async {

  final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
  final ZoneModel _currentZone = _zoneProvider.currentZone;
  final AuthModel _authModel = await AuthFireOps.signInByGoogle(
    context: context,
    currentZone: _currentZone,
  );

  await _controlAuthResult(
    context: context,
    authModel: _authModel,
  );

}
 */
// --------------------
/*
Future<void> authByFacebook(BuildContext context) async {

  final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
  final ZoneModel _currentZone = _zoneProvider.currentZone;
  final AuthModel _authModel = await AuthFireOps.signInByFacebook(
    context: context,
    currentZone: _currentZone,
  );

  await _controlAuthResult(
    context: context,
    authModel: _authModel,
  );

}

 */
// --------------------
/// PLAN : FIX ME
Future<void> authByApple(BuildContext context) async {
  /*
  final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
  final ZoneModel _currentZone = _zoneProvider.currentZone;
  final AuthModel _authModel = await AuthFireOps.signInByApple(
    context: context,
    currentZone: _currentZone,
  );

  await _controlAuthResult(
    context: context,
    authModel: _authModel,
  );


   */
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> authByEmailSignIn({
  @required BuildContext context,
  @required String email,
  @required String password,
  @required GlobalKey<FormState> formKey,
  @required bool mounted,
  @required bool rememberMe,
}) async {

  /// A - PREPARE FOR AUTH AND CHECK VALIDITY
  final bool _allFieldsAreValid = _prepareForEmailAuthOps(
    context: context,
    formKey: formKey,
  );

  AuthModel _authModel;

  if (_allFieldsAreValid == true) {

    pushWaitDialog(
      context: context,
      verse: const Verse(
        id: 'phid_signing_in',
        translate: true,
      ),
    );

    /// C - FIRE SIGN IN OPS
    _authModel = await AuthFireOps.signInByEmailAndPassword(
      email: email,
      password: password,
    );

    await Future.wait(<Future>[

      _rememberOrForgetAccount(
        rememberMe: rememberMe,
        account: AccountModel(
          id: _authModel?.uid,
          email: email,
          password: password,
        ),
      ),

      _controlAuthResult(
        context: context,
        authModel: _authModel,
      ),

    ]);

    if (mounted == true){
      await WaitDialog.closeWaitDialog(context);
    }

  }

  else {
    blog('controlEmailSignin : _allFieldsAreValid : $_allFieldsAreValid');
  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> authByEmailRegister({
  @required BuildContext context,
  @required String email,
  @required String password,
  @required String passwordConfirmation,
  @required GlobalKey<FormState> formKey,
  @required bool rememberMe,
}) async {

  /// A - PREPARE FOR AUTH AND CHECK VALIDITY
  final bool _allFieldsAreValid = _prepareForEmailAuthOps(
    context: context,
    formKey: formKey,
  );

  AuthModel _authModel;

  if (_allFieldsAreValid == true) {

    pushWaitDialog(
      context: context,
      verse: const Verse(
        id: 'phid_creating_new_account',
        translate: true,
      ),
    );

    /// C - START REGISTER OPS
    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    _authModel = await AuthFireOps.registerByEmailAndPassword(
        context: context,
        currentZone: _zoneProvider.currentZone,
        email: email,
        password: password
    );

    await Future.wait(<Future>[

      _rememberOrForgetAccount(
        rememberMe: rememberMe,
        account: AccountModel(
          id: _authModel?.uid,
          email: email,
          password: password,
        ),
      ),

      _controlAuthResult(
          context: context,
          authModel: _authModel
      ),

    ]);


    await WaitDialog.closeWaitDialog(context);

  }

  ///
  else {
    blog('_allFieldsAreValid : controlEmailRegister : $_allFieldsAreValid');
  }

}
// -----------------------------------------------------------------------------

/// CONTROLLING AUTH RESULT

// --------------------
/// TESTED : WORKS PERFECT
Future<void> _controlAuthResult({
  @required BuildContext context,
  @required AuthModel authModel,
}) async {

  /// B1. IF AUTH FAILS
  if (authModel.authSucceeds == false || authModel?.userModel == null){
    await _controlAuthFailure(
      context: context,
      authModel: authModel,
    );
  }

  /// B2. IF AUTH SUCCEEDS
  else {

    /// INSERT AUTH AND USER MODEL IN LDB
    await AuthLDBOps.updateAuthModel(authModel);
    await UserLDBOps.updateUserModel(authModel.userModel);

    if (authModel.firstTimer == true){

      final bool _thereAreMissingFields = Formers.checkUserHasMissingFields(
        context: context,
        userModel: authModel?.userModel,
      );

      if (_thereAreMissingFields == true){
        await _goToUserEditorForFirstTime(
          context: context,
          authModel: authModel,
        );
      }
      else {
        await _goToLogoScreen(context);
      }

    }
    else {
      await _goToLogoScreen(context);
    }


  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _controlAuthFailure({
  @required BuildContext context,
  @required AuthModel authModel,
}) async {

  final String _errorMessage = authModel.authError ??
      'Something went wrong, please try again';

  // const Verse(
  //   text: 'phid_somethingIsWrong',
  //   translate: true,
  // )

  await Dialogs.authErrorDialog(
      context: context,
      result: _errorMessage
  );

}
// --------------------
/*
Future<void> setUserAndAuthModelsLocallyAndOnLDB({
  @required BuildContext context,
  @required AuthModel authModel,
}) async {

  final UserModel _userModel = authModel.userModel;

  /// B.3 - so sign in succeeded returning a userModel, then set it in provider
  final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
  final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
  final CountryModel _userCountry = await _zoneProvider.fetchCountryByID(
      context: context,
      countryID: _userModel.zone.countryID
  );

  final CityModel _userCity = await _zoneProvider.fetchCityByID(
      context: context,
      cityID: _userModel.zone.cityID
  );

  _usersProvider.setMyUserModelAndCountryAndCity(
    userModel: _userModel,
    countryModel: _userCountry,
    cityModel: _userCity,
    notify: false,
  );

  // await LDBOps.insertMap(
  //     primaryKey: primaryKey,
  //     docName: LDBDoc.auth,
  //     input: authModel.toMap(),
  // );

  _usersProvider.setMyAuthModel(
    authModel: authModel,
    notify: true,
  );

}
// --------------------
Future<void> _controlMissingFieldsCase({
  @required BuildContext context,
  @required AuthModel authModel,
}) async {

  await showMissingFieldsDialog(
    context: context,
    userModel: authModel.userModel,
  );

  await Nav.goToNewScreen(
      context: context,
      screen: EditProfileScreen(
        userModel: authModel.userModel,
        onFinish: () async {

          await _goToLogoScreen(context);

          },
      )

  );

}
// --------------------
Future<void> showMissingFieldsDialog({
  @required BuildContext context,
  @required UserModel userModel,
}) async {

  final List<String> _missingFields = UserModel.missingFields(userModel);
  final String _missingFieldsString = TextGen.generateStringFromStrings(
      strings: _missingFields,
  );

  await CenterDialog.showCenterDialog(
    context: context,
    title: 'Complete Your profile',
    body:
    'Required fields :\n'
        '$_missingFieldsString',
  );

}
*/
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _goToLogoScreen(BuildContext context) async {
  await Nav.goBackToLogoScreen(
      context: context,
      animatedLogoScreen: true,
  );
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _goToUserEditorForFirstTime({
  @required BuildContext context,
  @required AuthModel authModel,
}) async {

  await Nav.goToNewScreen(
      context: context,
      screen: UserEditorScreen(
        userModel: authModel.userModel,
        reAuthBeforeConfirm: false,
        canGoBack: false,
        validateOnStartup: false,
        checkLastSession: false,
        onFinish: () async {
          await _goToLogoScreen(context);
        },
      )

  );


}
// -----------------------------------------------------------------------------

/// EMAIL AUTH VALIDATION

// --------------------
/// TESTED : WORKS PERFECT
bool _prepareForEmailAuthOps({
  @required BuildContext context,
  @required GlobalKey<FormState> formKey,
}) {

  /// MINIMIZE KEYBOARD
  Keyboard.closeKeyboard(context);

  /// CHECK VALIDITY
  final bool _allFieldsAreValid = formKey.currentState.validate();


  return _allFieldsAreValid;
}
// -----------------------------------------------------------------------------

/// REMEMBERING ME

// --------------------
/// TASK : TEST ME
Future<void> _rememberOrForgetAccount({
  @required AccountModel account,
  @required bool rememberMe,
}) async {

  if (rememberMe == true){
    await AccountLDBOps.insertAccount(
        account: account,
    );
  }

  else {
    await AccountLDBOps.deleteAccount(
        id: account?.id,
    );
  }

}
// -----------------------------------------------------------------------------
