import 'dart:async';

import 'package:bldrs/a_models/secondary_models/app_state.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/d_user/b_user_editor/a_user_editor_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/d_providers/general_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/ops/app_state_ops.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/foundation/ldb_ops.dart' as LDBOps;
import 'package:bldrs/e_db/ldb/ops/auth_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/user_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart' as Launcher;
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// -----------------------------------------------------------------------------
Future<void> initializeLogoScreen({
  @required BuildContext context,
  @required bool mounted,
}) async {

  await Future.wait(
    <Future<void>>[

      /// APP CONTROLS
      _initializeAppControls(context),
      /// LOCAL ASSETS PATHS
      _initializeLocalAssetsPaths(context),
      /// APP LANGUAGE
      _initializeAppLanguage(context),
      /// USER MODEL
      _initializeUserModel(context),
      /// APP STATE
      _initializeAppState(context),
      /// INITIALIZE USER NOTES STREAM
      // _initializeUserNotesStream(context);

  ]
  );

}
// -----------------------------------------------------------------------------

/// USER & AUTH MODELS INITIALIZATION

// ---------------------------------
Future<void> _initializeUserModel(BuildContext context) async {

  /// IF USER IS SIGNED IN
  if (AuthModel.userIsSignedIn() == true) {

  final AuthModel _authModel = await AuthLDBOps.readAuthModel();

  // if (_authModel?.userModel != null){

    final bool _thereAreMissingFields = UserModel.checkMissingFields(_authModel?.userModel);

    /// MISSING FIELDS FOUND
    if (_thereAreMissingFields == true){

      await _controlMissingFieldsCase(
        context: context,
        authModel: _authModel,
      );

    }

    /// NO MISSING FIELDS FOUND
    else {

      await setUserAndAuthModelsAndCompleteUserZoneLocally(
        context: context,
        authModel: _authModel,
      );

    }

  // }

  }

  /// IF USER IS NOT SIGNED IN
  // else {
  /// WILL CONTINUE NORMALLY AS ANONYMOUS
  // }

}
// ---------------------------------
Future<UserModel> completeUserZoneModel({
  @required BuildContext context,
  @required UserModel userModel,
}) async {

  UserModel _output = userModel;

  if (userModel != null){

    /// COMPLETED ZONE MODEL
    final ZoneModel _completeZoneModel = await ZoneProvider.proFetchCompleteZoneModel(
      context: context,
      incompleteZoneModel: userModel.zone,
    );

    /// COMPLETED USER MODEL
    _output = userModel.copyWith(
      zone: _completeZoneModel,
    );

  }

  return _output;

}
// ---------------------------------
Future<void> setUserAndAuthModelsAndCompleteUserZoneLocally({
  @required BuildContext context,
  @required AuthModel authModel,
}) async {

  /// B.3 - so sign in succeeded returning a userModel, then set it in provider

  final UserModel _userModel = await completeUserZoneModel(
      context: context,
      userModel: authModel.userModel,
  );

  final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);

  _usersProvider.setMyUserModelAndAuthModel(
    userModel: _userModel,
    authModel: authModel,
    notify: false,
  );

  /// INSERT AUTH AND USER MODEL IN LDB
  await AuthLDBOps.updateAuthModel(authModel);
  await UserLDBOps.updateUserModel(authModel.userModel);

}
// ---------------------------------
Future<void> _controlMissingFieldsCase({
  @required BuildContext context,
  @required AuthModel authModel,
}) async {

  await showMissingFieldsDialog(
    context: context,
    userModel: authModel?.userModel,
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
// ---------------------------------
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

// -----------------------------------------------------------------------------

/// APP STATE INITIALIZATION

// ---------------------------------
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

      AppState _userAppState = _userState;

      /// APP VERSION
      if (_userState.appVersion != _detectedAppVersion){
        _userAppState = _userAppState.copyWith(
            appVersion: _detectedAppVersion,
        );
      }

      /// KEYWORDS CHAIN
      if (_globalState.keywordsChainVersion > _userState.keywordsChainVersion){
        await LDBOps.deleteAllMapsAtOnce(docName: LDBDoc.keywordsChain,);
        _userAppState = _userAppState.copyWith(
            keywordsChainVersion: _globalState.keywordsChainVersion,
        );
      }

      /// LDB VERSION
      if (_globalState.ldbVersion > _userState.ldbVersion){
        await LDBOps.wipeOutEntireLDB();
        _userAppState = _userAppState.copyWith(
            ldbVersion: _globalState.ldbVersion,
        );
      }

      /// PHRASES
      if (_globalState.phrasesVersion > _userState.phrasesVersion){
        await LDBOps.deleteAllMapsAtOnce(docName: LDBDoc.basicPhrases,);
        _userAppState = _userAppState.copyWith(
            phrasesVersion: _globalState.phrasesVersion,
        );
      }

      /// SPEC PICKERS
      if (_globalState.specPickersVersion > _userState.specPickersVersion){
        await LDBOps.deleteAllMapsAtOnce(docName: LDBDoc.specPickers,);
        _userAppState = _userAppState.copyWith(
            specPickersVersion: _globalState.specPickersVersion,
        );
      }

      /// SPEC CHAIN VERSION
      if (_globalState.specsChainVersion > _userState.specsChainVersion){
        await LDBOps.deleteAllMapsAtOnce(docName: LDBDoc.specsChain,);
        _userAppState = _userAppState.copyWith(
            specsChainVersion: _globalState.specsChainVersion,
        );
      }

      /// APP CONTROLS VERSION
      if (_globalState.appControlsVersion > _userState.appControlsVersion){
        await LDBOps.deleteAllMapsAtOnce(docName: LDBDoc.appControls);
        _userAppState = _userAppState.copyWith(
          appControlsVersion: _globalState.appControlsVersion,
        );
      }

      /// --- UPDATE USER MODEL'S APP STATE IF CHANGED
      final bool _appStateNeedUpdate = !AppState.appStatesAreTheSame(
          stateA: _userState,
          stateB: _userAppState,
      );

      if (_appStateNeedUpdate == true){
        await AppStateOps.updateUserAppState(
            context: context,
            userID: _usersProvider.myUserModel.id,
            newAppState: _userAppState,
        );
      }



    }

  }

}
// ---------------------------------
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

/// APP CONTROLS INITIALIZATION

// ---------------------------------
Future<void> _initializeAppControls(BuildContext context) async {
  final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
  await _generalProvider.fetchSetAppControls(
      context: context,
      notify: true,
  );
}
// -----------------------------------------------------------------------------

/// LOCAL ASSETS PATHS INITIALIZATION

// ---------------------------------
Future<void> _initializeLocalAssetsPaths(BuildContext context) async {
  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
  await _uiProvider.getSetLocalAssetsPaths(notify: true);
}
// -----------------------------------------------------------------------------

/// APP LANGUAGE INITIALIZATION

// ---------------------------------
Future<void> _initializeAppLanguage(BuildContext context) async {

  final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);
  await _phraseProvider.fetchSetCurrentLangAndPhrases(
    context: context,
  );

}
// -----------------------------------------------------------------------------

/// NOTES STREAM INITIALIZATION

// ---------------------------------
// void _initializeUserNotesStream(BuildContext context){
//
//   // final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
//   // _notesProvider.startSetUserNotesStream(
//   //   context: context,
//   //   notify: true,
//   // );
//
// }
// -----------------------------------------------------------------------------

/// NAVIGATION

// ---------------------------------
Future<void> _goToLogoScreen(BuildContext context) async {
  await Nav.pushNamedAndRemoveAllBelow(
      context: context,
      goToRoute: Routez.logoScreen,
  );
}
// -----------------------------------------------------------------------------
