import 'dart:async';

import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/widgets/general/dialogs/dialogz.dart' as Dialogz;
import 'package:bldrs/b_views/x_screens/a_starters/a_0_logo_screen.dart';
import 'package:bldrs/b_views/x_screens/b_auth/b_1_email_auth_screen.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as FireAuthOps;
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------

  /// AUTH MAIN CONTROLLERS

// -------------------------------------
Future<void> controlOnAuth(BuildContext context, AuthBy authBy) async {

  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
  _uiProvider.triggerLoading();

  blog('starting controlAuth');

  /// start auth to return String error or return Map<String,dynamic>
  ///  {
  ///    'userModel' : _existingUserModel or new _finalUserModel
  ///    'firstTimer' : false or true
  ///  };
  dynamic _authResult;

  if (authBy == AuthBy.google) {
    _authResult = await _controlGoogleAuth(context);
  }

  else if (authBy == AuthBy.facebook) {
    _authResult = await _controlFacebookAuth(context);
  }

  else if (authBy == AuthBy.apple) {
    _authResult = await _controlAppleAuth(context);
  }

  else if (authBy == AuthBy.email){
    _uiProvider.triggerLoading(setLoadingTo: false);
    await _goToEmailAuth(context);
  }

  if (_authResult != null){
    await _controlAuthResult(
      context: context,
      authResult: _authResult,
    );
  }

}
// -------------------------------------
Future<dynamic> _controlGoogleAuth(BuildContext context) async {

  final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
  final ZoneModel _currentZone = _zoneProvider.currentZone;

  /// start google auth ops,
  final dynamic _authResult = await FireAuthOps.googleSignInOps(
    context: context,
    currentZone: _currentZone,
  );

  return _authResult;
}
// -------------------------------------
Future<dynamic> _controlFacebookAuth(BuildContext context) async {

  final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
  final ZoneModel _currentZone = _zoneProvider.currentZone;

  final dynamic _authResult = FireAuthOps.facebookSignInOps(
    context: context,
    currentZone: _currentZone,
  );

  return _authResult;
}
// -------------------------------------
Future<dynamic> _controlAppleAuth(BuildContext context) async {

  final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
  final ZoneModel _currentZone = _zoneProvider.currentZone;

  final dynamic _authResult = FireAuthOps.appleAuthOps(
    context: context,
    currentZone: _currentZone,
  );

  return _authResult;
}
// -------------------------------------
Future<void> _goToEmailAuth(BuildContext context) async {

  await Nav.goToNewScreen(context, const EmailAuthScreen());

}
// -----------------------------------------------------------------------------

/// AUTH RESULT

// -------------------------------------
Future<void> _controlAuthResult({
  @required BuildContext context,
  @required dynamic authResult
}) async {

  blog('_controlAuthResult : authResult : $authResult');
  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);

  /// 1 - WHEN SIGN IN FAILS
  if (authResult is String || authResult == null) {
    _uiProvider.triggerLoading(setLoadingTo: false);

    final String _errorMessage = authResult ?? 'Something went wrong, please try again';
    await Dialogz.authErrorDialog(context: context, result: _errorMessage);
  }

  /// 2 - WHEN SIGN IN SUCCEEDS
  else {

    /// B.1 - get UserModel from auth result
    final UserModel _userModel = _getUserModelFromAuthResult(authResult);

    /// B.2 - so sign in succeeded returning a userModel, then set it in provider
    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
    _usersProvider.setUserModel(_userModel);

    _uiProvider.triggerLoading(setLoadingTo: false);

    /// B.3 - go back to logo screen
    Nav.goBackToLogoScreen(context);
    /// B.4 - then restart it
    await Nav.replaceScreen(context, const LogoScreen());

  }

}
// -------------------------------------
UserModel _getUserModelFromAuthResult(dynamic authResult){
  UserModel _userModel;

  if (authResult != null){

    if (authResult is Map<String, dynamic>){
      /// receives : Map<String, dynamic> authResult = { 'userModel' : userModel, 'firstTimer' : true or false, };
      _userModel = authResult['userModel'];
    }
    else if (authResult is UserModel){
      _userModel = authResult;
    }

  }

  return _userModel;
}
// -----------------------------------------------------------------------------

/// EMAIL AUTH CONTROLLERS

// -------------------------------------
Future<void> controlEmailSignin({
  @required BuildContext context,
  @required String email,
  @required String password,
  @required GlobalKey<FormState> formKey,
}) async {

  /// A - PREPARE FOR AUTH AND CHECK VALIDITY
  final bool _allFieldsAreValid = _prepareForEmailAuthOps(context: context, formKey: formKey);

  if (_allFieldsAreValid == true) {

    /// B - LOADING
    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
    _uiProvider.triggerLoading(setLoadingTo: true);

    /// C - FIRE SIGN IN OPS
    final dynamic _result = await FireAuthOps.emailSignInOps(
      context: context,
      email: email,
      password: password,
    );

    /// D - RESULT
    await _controlAuthResult(
        context: context,
        authResult: _result,
    );

  }

}
// -------------------------------------
Future<void> controlEmailSignup({
  @required BuildContext context,
  @required String email,
  @required String password,
  @required String passwordConfirmation,
  @required GlobalKey<FormState> formKey,
}) async {

  /// A - PREPARE FOR AUTH AND CHECK VALIDITY
  final bool _allFieldsAreValid = _prepareForEmailAuthOps(context: context, formKey: formKey);

  if (_allFieldsAreValid == true) {

    /// B - LOADING
    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
    _uiProvider.triggerLoading(setLoadingTo: true);

    /// C - START REGISTER OPS
    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    final dynamic _result = await FireAuthOps.emailRegisterOps(
        context: context,
        currentZone: _zoneProvider.currentZone,
        email: email,
        password: password
    );

    /// D - AUTH RESULT
    await _controlAuthResult(
      context: context,
      authResult: _result,
    );

  }

}
// -------------------------------------
bool _prepareForEmailAuthOps({
  @required BuildContext context,
  @required GlobalKey<FormState> formKey,
}) {

  /// A - OBSCURE TEXT FIELDS
  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
  _uiProvider.triggerTextFieldsObscured(setObscuredTo: true);

  /// B - MINIMIZE KEYBOARD
  Keyboarders.minimizeKeyboardOnTapOutSide(context);

  /// C - CHECK VALIDITY
  final bool _allFieldsAreValid = _formStateValidation(formKey: formKey);

  return _allFieldsAreValid;
}
// -----------------------------------------------------------------------------

/// EMAIL AUTH VALIDATION

// -------------------------------------
String emailValidation({
  @required BuildContext context,
  @required String val,
}) {

  String _output;

  if (val.isEmpty) {
    _output = Wordz.enterEmail(context);
  }

  else {

    if (EmailValidator.validate(val) == false){
      _output = Wordz.emailInvalid(context);
    }

  }

  return _output;
}
// -------------------------------------
String passwordValidation({
  @required BuildContext context,
  @required String password,
}){

  String _output;

  if (password.isEmpty){
    _output = Wordz.enterPassword(context);
  }

  else if (password.length < 6){
    _output = Wordz.min6CharError(context);
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
    _output = Wordz.confirmPassword(context);
  }

  else if (passwordConfirmation != password){
    _output = Wordz.passwordMismatch(context);
  }

  else if (password.length < 6){
    _output = Wordz.min6CharError(context);
  }

  return _output;
}
// -------------------------------------
bool _formStateValidation({@required GlobalKey<FormState> formKey}){
  final bool _areValid = formKey.currentState.validate();
  blog('_allFieldsAreValid() = $_areValid');
  return _areValid;
}
// -----------------------------------------------------------------------------
