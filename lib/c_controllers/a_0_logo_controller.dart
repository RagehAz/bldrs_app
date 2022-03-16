import 'package:bldrs/a_models/secondary_models/app_updates.dart';
import 'package:bldrs/d_providers/general_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------
Future<void> initializeLogoScreen(BuildContext context) async {


  /// B - APP STATE
  final bool _canContinue = await _initializeAppState(context);

  if (_canContinue == false) {


  } else {

    Keyboarders.minimizeKeyboardOnTapOutSide(context);

    await goToRoute(context, Routez.home);

  }


}
// -----------------------------------------------------------------------------
Future<bool> _initializeAppState(BuildContext context) async {
  final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
  await _generalProvider.getsetAppState(context);
  final AppState _appState = _generalProvider.appState;

  bool _canContinue = true;

  if (_appState.appUpdateRequired == true) {
    _canContinue = false;
  }
  if (_appState.wordzUpdateRequired == true) {}
  if (_appState.languageUpdateRequired == true) {}
  if (_appState.termsUpdateRequired == true) {}
  if (_appState.aboutBldrsUpdateRequired == true) {}
  if (_appState.notificationsUpdateRequired == true) {}
  if (_appState.keywordsUpdateRequired == true) {}
  if (_appState.zonesUpdateRequired == true) {}

  return _canContinue;
}
// -----------------------------------------------------------------------------
