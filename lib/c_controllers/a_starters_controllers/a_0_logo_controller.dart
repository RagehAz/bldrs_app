import 'dart:async';

import 'package:bldrs/a_models/secondary_models/app_state.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/ops/app_state_ops.dart';
import 'package:bldrs/e_db/ldb/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/ldb_ops.dart' as LDBOps;
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/launchers.dart' as Launcher;
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// -----------------------------------------------------------------------------
Future<void> initializeLogoScreen({
  @required BuildContext context,
  @required bool mounted,
}) async {

  Keyboarders.minimizeKeyboardOnTapOutSide(context);

  /// USER MODEL
  await _initializeUserModel(context);

  /// APP STATE
  await _initializeAppState(context);

  /// APP LANGUAGE
  await _initializeAppLanguage(context);

  /// LOCAL ASSETS PATHS
  await _initializeLocalAssetsPaths(context);

  await goToRoute(context, Routez.home);

}
// -----------------------------------------------------------------------------
Future<void> _initializeUserModel(BuildContext context) async {

  if (AuthModel.userIsSignedIn() == true) {

    final UsersProvider _userProvider = Provider.of<UsersProvider>(context, listen: false);
    final UserModel _myUserModel = _userProvider.myUserModel;

    if (_myUserModel == null){

      await _userProvider.getsetMyUserModelAndCountryAndCity(context);

    }

  }
}
// -----------------------------------------------------------------------------
Future<void> _initializeAppState(BuildContext context) async {

  final AppState _globalState = await AppStateOps.readGlobalAppState(context);
  final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
  final AppState _userState = _usersProvider?.myUserModel?.appState;

  if (_userState != null){

    final String _detectedAppVersion = await AppStateOps.getAppVersion();
    final bool _userAppNeedUpdate = AppStateOps.appVersionNeedUpdate(
        globalVersion: _globalState.appVersion,
        userVersion: _detectedAppVersion
    );

    /// A - WHEN NEED TO UPDATE ENTIRE APP VIA APP STORE
    if (_userAppNeedUpdate == true){
      await _showUpdateAppDialog(context);
    }

    /// B - WHEN APP IS UPDATED
    else {

      AppState _updatedUserAppState = _userState;

      /// APP VERSION
      if (_userState.appVersion != _detectedAppVersion){
        _updatedUserAppState = _updatedUserAppState.copyWith(
            appVersion: _detectedAppVersion,
        );
      }

      /// KEYWORDS CHAIN
      if (_globalState.keywordsChainVersion > _userState.keywordsChainVersion){
        await LDBOps.deleteAllAtOnce(docName: LDBDoc.keywordsChain,);
        _updatedUserAppState = _updatedUserAppState.copyWith(
            keywordsChainVersion: _globalState.keywordsChainVersion,
        );
      }

      /// LDB VERSION
      if (_globalState.ldbVersion > _userState.ldbVersion){
        await LDBOps.wipeOutEntireLDB();
        _updatedUserAppState = _updatedUserAppState.copyWith(
            ldbVersion: _globalState.ldbVersion,
        );
      }

      /// PHRASES
      if (_globalState.phrasesVersion > _userState.phrasesVersion){
        await LDBOps.deleteAllAtOnce(docName: LDBDoc.basicPhrases,);
        _updatedUserAppState = _updatedUserAppState.copyWith(
            phrasesVersion: _globalState.phrasesVersion,
        );
      }

      /// SPEC PICKERS
      if (_globalState.specPickersVersion > _userState.specPickersVersion){
        await LDBOps.deleteAllAtOnce(docName: LDBDoc.specPickers,);
        _updatedUserAppState = _updatedUserAppState.copyWith(
            specPickersVersion: _globalState.specPickersVersion,
        );
      }

      /// SPEC CHAIN VERSION
      if (_globalState.specsChainVersion > _userState.specsChainVersion){
        await LDBOps.deleteAllAtOnce(docName: LDBDoc.specsChain,);
        _updatedUserAppState = _updatedUserAppState.copyWith(
            specsChainVersion: _globalState.specsChainVersion,
        );
      }

      /// --- UPDATE USER MODEL'S APP STATE IF CHANGED
      final bool _appStateNeedUpdate = !AppState.appStatesAreTheSame(
          stateA: _userState,
          stateB: _updatedUserAppState,
      );

      if (_appStateNeedUpdate == true){
        await AppStateOps.updateUserAppState(
            context: context,
            userID: _usersProvider.myUserModel.id,
            newAppState: _updatedUserAppState,
        );
      }

    }

  }

}
// -----------------------------------------------------------------------------
Future<void> _showUpdateAppDialog(BuildContext context) async {

  await CenterDialog.showCenterDialog(
    context: context,
    title: 'New App update is Available',
    body: 'You need to update the app to continue',
    confirmButtonText: 'Update Bldrs.net',
  );

  await Launcher.launchURL('www.pinterest.com');

}
// -----------------------------------------------------------------------------
Future<void> _initializeLocalAssetsPaths(BuildContext context) async {
  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
  await _uiProvider.getSetLocalAssetsPaths(notify: true);
}
// -----------------------------------------------------------------------------
Future<void> _initializeAppLanguage(BuildContext context) async {

  final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);
  await _phraseProvider.getSetCurrentLangAndPhrases(
    context: context,
  );

}
// -----------------------------------------------------------------------------
