import 'package:bldrs/a_models/secondary_models/app_state.dart';
import 'package:bldrs/d_providers/general_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------
Future<void> initializeLogoScreen({
  @required BuildContext context,
  @required bool mounted,
}) async {

  // /// 0 - CONNECTIVITY
  // await _initializeConnectivity(
  //   context: context,
  //   mounted: mounted,
  // );
  //
  // final bool _isConnected = deviceIsConnected(context);

  // /// WHEN CONNECTED TO INTERNET
  // if (_isConnected == true){

    /// A - APP LANGUAGE
    await _initializeAppLanguage(context);

    /// B - APP STATE
    final bool _canContinue = await _initializeAppState(context);

    if (_canContinue == false) {


    } else {

      Keyboarders.minimizeKeyboardOnTapOutSide(context);

      await goToRoute(context, Routez.home);

    }

  // }
  //
  // /// IF DISCONNECTED FORM INTERNET
  // else {
  //
  //   await WaitDialog.showWaitDialog(
  //     context: context,
  //     loadingPhrase: 'You are Disconnected',
  //     canManuallyGoBack: true,
  //   );
  //
  // }


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
Future<void> _initializeAppLanguage(BuildContext context) async {

  final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);
  await _phraseProvider.getSetCurrentLangAndPhrases(
    context: context,
  );

}
