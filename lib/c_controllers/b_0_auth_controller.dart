import 'dart:async';

import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/screens/a_starters/a_0_logo_screen.dart';
import 'package:bldrs/b_views/widgets/general/dialogs/dialogz.dart' as Dialogz;
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as FireAuthOps;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------
Future<void> controlAuth(BuildContext context, AuthBy authBy) async {

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

  _uiProvider.triggerLoading();

  await _controlAuthResult(
    context: context,
    authResult: _authResult,
  );

}
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
Future<dynamic> _controlFacebookAuth(BuildContext context) async {

  final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
  final ZoneModel _currentZone = _zoneProvider.currentZone;

  final dynamic _authResult = FireAuthOps.facebookSignInOps(
    context: context,
    currentZone: _currentZone,
  );

  return _authResult;
}
// -----------------------------------------------------------------------------
Future<dynamic> _controlAppleAuth(BuildContext context) async {

  final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
  final ZoneModel _currentZone = _zoneProvider.currentZone;

  final dynamic _authResult = FireAuthOps.appleAuthOps(
    context: context,
    currentZone: _currentZone,
  );

  return _authResult;
}
// -----------------------------------------------------------------------------
Future<void> _controlAuthResult({@required BuildContext context, @required dynamic authResult}) async {

  blog('_controlAuthResult : authResult : $authResult');

  /// A - if auth returns error string we show dialog
  if (authResult is String || authResult == null) {
    await Dialogz.authErrorDialog(context: context, result: authResult);
  }

  /// A - if auth returns a Map<String, dynamic>, we check its completion
  else {

    /// B.1 - Map<String, dynamic> authResult = { 'userModel' : userModel, 'firstTimer' : true or false, };
    final UserModel _userModel = authResult['userModel'];

    /// B.2 - so sign in succeeded returning a userModel, then set it in provider
    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
    _usersProvider.setUserModel(_userModel);

    /// B.3 - go back to home
    Nav.goBackToLogoScreen(context);
    await Nav.replaceScreen(context, const LogoScreen());

  }

}
// -----------------------------------------------------------------------------
