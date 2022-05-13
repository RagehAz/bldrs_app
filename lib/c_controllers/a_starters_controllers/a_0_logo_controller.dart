import 'dart:async';

import 'package:bldrs/a_models/secondary_models/app_state.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/nav_dialog/nav_dialog.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/ops/app_state_ops.dart';
import 'package:bldrs/e_db/ldb/ldb_ops.dart' as LDBOps;
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart' as Launcher;
import 'package:bldrs/e_db/ldb/ldb_doc.dart' as LDBDoc;

// -----------------------------------------------------------------------------
Future<void> initializeLogoScreen({
  @required BuildContext context,
  @required bool mounted,
}) async {

  Keyboarders.minimizeKeyboardOnTapOutSide(context);

  /// A - APP LANGUAGE
  await _initializeAppLanguage(context);

  _showWaitingDialog(
    context: context,
    text: 'Bldrs.net',
  );

  /// B - LOCAL ASSETS PATHS
  await _initializeLocalAssetsPaths(context);

  _showWaitingDialog(
    context: context,
    text: 'The',
  );

  /// C - USER MODEL
  await _initializeUserModel(context);

  _showWaitingDialog(
    context: context,
    text: 'Network',
  );

  /// D - APP STATE
  await _initializeAppState(context);

  _showWaitingDialog(
    context: context,
    text: 'of Builders',
  );

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

  final AppState _global = await AppStateOps.readGlobalAppState(context);
  final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
  final AppState _user = _usersProvider?.myUserModel?.appState;

  if (_user != null){


    /// A - WHEN NEED TO UPDATE ENTIRE APP VIA APP STORE
    if (_global.appVersion > _user.appVersion){
      await _showUpdateAppDialog(context);
    }

    /// B - WHEN APP IS UPDATED
    else {

      AppState _updatedUserAppState = _user;

      /// KEYWORDS CHAIN
      if (_global.keywordsChainVersion > _user.keywordsChainVersion){
        await LDBOps.deleteAllAtOnce(docName: LDBDoc.keywordsChain,);
        _updatedUserAppState = _user.copyWith(keywordsChainVersion: _global.keywordsChainVersion);
      }

      /// LDB VERSION
      if (_global.ldbVersion > _user.ldbVersion){
        await LDBOps.wipeOutEntireLDB();
        _updatedUserAppState = _user.copyWith(ldbVersion: _global.ldbVersion);
      }

      /// PHRASES
      if (_global.phrasesVersion > _user.phrasesVersion){
        await LDBOps.deleteAllAtOnce(docName: LDBDoc.basicPhrases,);
        _updatedUserAppState = _user.copyWith(phrasesVersion: _global.phrasesVersion);
      }

      /// SPEC PICKERS
      if (_global.specPickersVersion > _user.specPickersVersion){
        await LDBOps.deleteAllAtOnce(docName: LDBDoc.specPickers,);
        _updatedUserAppState = _user.copyWith(specPickersVersion: _global.specPickersVersion);
      }

      /// SPEC CHAIN VERSION
      if (_global.specsChainVersion > _user.specsChainVersion){
        await LDBOps.deleteAllAtOnce(docName: LDBDoc.specsChain,);
        _updatedUserAppState = _user.copyWith(specsChainVersion: _global.specsChainVersion);
      }

      /// --- UPDATE USER MODEL'S APP STATE IF CHANGED
      final bool _appStateUpdated = !AppState.appStatesAreTheSame(
          stateA: _user,
          stateB: _updatedUserAppState
      );

      if (_appStateUpdated == true){
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

void _showWaitingDialog({
  @required BuildContext context,
  @required String text,
}) {

  NavDialog.showNavDialog(
    context: context,
    firstLine: text,
  );

}