import 'dart:async';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogz.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_fire_ops.dart';
import 'package:bldrs/e_db/ldb/ops/auth_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/user_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// -----------------------------------------------------------------------------

/// AUTHENTICATORS

// ------------------------------------------------------
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
// ------------------------------------------------------
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
// ------------------------------------------------------
Future<void> authByApple(BuildContext context) async {

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

}
// ------------------------------------------------------
Future<void> authByEmailSignIn({
  @required BuildContext context,
  @required String email,
  @required String password,
  @required GlobalKey<FormState> formKey,
}) async {

  /// A - PREPARE FOR AUTH AND CHECK VALIDITY
  final bool _allFieldsAreValid = _prepareForEmailAuthOps(
    context: context,
    formKey: formKey,
  );

  AuthModel _authModel;

  if (_allFieldsAreValid == true) {

    unawaited(WaitDialog.showWaitDialog(
      context: context,
      loadingPhrase: 'Signing in',
    ));

    /// C - FIRE SIGN IN OPS
    _authModel = await AuthFireOps.signInByEmailAndPassword(
      context: context,
      email: email,
      password: password,
    );

    await _controlAuthResult(
      context: context,
      authModel: _authModel,
    );

    WaitDialog.closeWaitDialog(context);

  }

  else {
    blog('controlEmailSignin : _allFieldsAreValid : $_allFieldsAreValid');
  }

}
// ------------------------------------------------------
Future<void> authByEmailRegister({
  @required BuildContext context,
  @required String email,
  @required String password,
  @required String passwordConfirmation,
  @required GlobalKey<FormState> formKey,
}) async {

  /// A - PREPARE FOR AUTH AND CHECK VALIDITY
  final bool _allFieldsAreValid = _prepareForEmailAuthOps(
    context: context,
    formKey: formKey,
  );

  AuthModel _authModel;

  if (_allFieldsAreValid == true) {

    unawaited(WaitDialog.showWaitDialog(
      context: context,
      loadingPhrase: 'Creating new Account',
    ));

    /// C - START REGISTER OPS
    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    _authModel = await AuthFireOps.registerByEmailAndPassword(
        context: context,
        currentZone: _zoneProvider.currentZone,
        email: email,
        password: password
    );

    await _controlAuthResult(
        context: context,
        authModel: _authModel
    );

    WaitDialog.closeWaitDialog(context);

  }

  ///
  else {
    blog('_allFieldsAreValid : controlEmailRegister : $_allFieldsAreValid');
  }

}
// -----------------------------------------------------------------------------

/// CONTROLLING AUTH RESULT

// ------------------------------------------------------
Future<void> _controlAuthResult({
  @required BuildContext context,
  @required AuthModel authModel,
}) async {

  /// B1. IF AUTH FAILS
  if (authModel.authSucceeds == false){
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

    await _goToLogoScreen(context);

  }

}
// ------------------------------------------------------
Future<void> _controlAuthFailure({
  @required BuildContext context,
  @required AuthModel authModel,
}) async {

  final String _errorMessage = authModel.authError ??
      'Something went wrong, please try again';

  await Dialogz.authErrorDialog(
      context: context,
      result: _errorMessage
  );

}
// ------------------------------------------------------
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

  /// TASK : SHOULD SAVE AUTH MODEL ON LDB TO HAVE IT WHEN USER CLOSES AND REOPENS THE APP

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
// ------------------------------------------------------
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
// ------------------------------------------------------
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
// ------------------------------------------------------
Future<void> _goToLogoScreen(BuildContext context) async {
  await Nav.goBackToLogoScreen(
      context: context,
      animatedLogoScreen: true,
  );
}
// -----------------------------------------------------------------------------

/// EMAIL AUTH VALIDATION

// -------------------------------------
bool _prepareForEmailAuthOps({
  @required BuildContext context,
  @required GlobalKey<FormState> formKey,
}) {

  /// A - OBSCURE TEXT FIELDS
  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
  _uiProvider.triggerTextFieldsObscured(
    setObscuredTo: true,
    notify: true,
  );

  /// B - MINIMIZE KEYBOARD
  Keyboard.closeKeyboard(context);

  /// C - CHECK VALIDITY
  final bool _allFieldsAreValid = formKey.currentState.validate();


  return _allFieldsAreValid;
}
// -------------------------------------
String emailValidation({
  @required BuildContext context,
  @required String val,
}) {

  final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);

  String _output;

  if (val.isEmpty) {
    _output = xPhrase(context, 'phid_enterEmail', phrasePro: _phraseProvider);
  }

  else {

    if (EmailValidator.validate(val) == false){
      _output = xPhrase(context, 'phid_emailInvalid', phrasePro: _phraseProvider);
    }

  }

  return _output;
}
// -------------------------------------
String passwordValidation({
  @required BuildContext context,
  @required String password,
}){

  final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);
  String _output;

  if (password.isEmpty){
    _output = xPhrase(context, 'phid_enterPassword', phrasePro: _phraseProvider);
  }

  else if (password.length < 6){
    _output = xPhrase(context, 'phid_min6CharError', phrasePro: _phraseProvider);
  }

  return _output;
}
// -------------------------------------
String passwordConfirmationValidation({
  @required BuildContext context,
  @required String password,
  @required String passwordConfirmation,
}){

  String _output;

  if (passwordConfirmation.isEmpty || password.isEmpty){
    _output = xPhrase(context, 'phid_confirmPassword');
  }

  else if (passwordConfirmation != password){
    _output = xPhrase(context, 'phid_passwordMismatch');
  }

  else if (password.length < 6){
    _output = xPhrase(context, 'phid_min6CharError');
  }

  return _output;
}

// -----------------------------------------------------------------------------

// / DIALOGS
//
// -------------------------------------
// -----------------------------------------------------------------------------

// Future<void> startOverFromLogoScreen(BuildContext context) async {
//   /// B.3 - go back to logo screen
//   Nav.goBackToLogoScreen(context);
//   /// B.4 - then restart it
//   await Nav.replaceScreen(context, const LogoScreen());
// }
// -------------------------------------
// Future<void> controlOnAuth(BuildContext context, AuthType authType) async {
//
//   // final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
//   // _uiProvider.triggerLoading();
//   // _uiProvider.triggerLoading(setLoadingTo: false);
//
//   /// A. AUTHENTICATE THEN RETURN AUTH MODEL
//   final AuthModel _authModel = await _authenticateAndGetAuthModel(
//     context: context,
//     authType: authType,
//   );
//
//
// }
// // -------------------------------------
// Future<AuthModel> _authenticateAndGetAuthModel({
//   @required BuildContext context,
//   @required AuthType authType,
//   GlobalKey<FormState> formKey,
//   String password,
//   String passwordConfirmation,
//   String email,
// }) async {
//
//   AuthModel _authModel;
//
//   if (authType == AuthType.google) {
//     _authModel = await _authByGoogle(context);
//   }
//
//   else if (authType == AuthType.facebook) {
//     _authModel = await _authByFacebook(context);
//   }
//
//   else if (authType == AuthType.apple) {
//     _authModel = await _authByApple(context);
//   }
//
//   else if (authType == AuthType.emailRegister){
//     _authModel = await _controlEmailRegister(
//       context: context,
//       formKey: formKey,
//       password: password,
//       passwordConfirmation: passwordConfirmation,
//       email: email,
//     );
//   }
//
//   else if (authType == AuthType.emailSignIn){
//     _authModel = await _controlEmailSignin(
//       context: context,
//       formKey: formKey,
//       email: email,
//       password: password,
//     );
//   }
//
//   return _authModel;
// }
// -------------------------------------
// Future<void> _controlEmailAuth(BuildContext context) async {
//
//   await Nav.goToNewScreen(context, const EmailAuthScreen(
//
//   ));
//
// }
