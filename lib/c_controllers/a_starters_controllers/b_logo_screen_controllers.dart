import 'dart:async';
import 'package:bldrs/a_models/secondary_models/app_state.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/a_zone_protocols.dart';
import 'package:bldrs/d_providers/general_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/ops/app_state_fire_ops.dart';
import 'package:bldrs/e_db/fire/ops/auth_fire_ops.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_doc.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/auth_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/user_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/notifications/notifications.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// -----------------------------------------------------------------------------
Future<void> initializeLogoScreen({
  @required BuildContext context,
  @required bool mounted,
}) async {

  /// USER MODEL
  await _initializeUserModel(context);

  await Future.wait(
      <Future<void>>[

        /// APP CONTROLS
        _initializeAppControls(context),
        /// LOCAL ASSETS PATHS
        _initializeLocalAssetsPaths(context),
        /// APP LANGUAGE
        _initializeAppLanguage(context),

        /// APP STATE
        _initializeAppState(context),

      ]
  );

  /// USER APP - FCM - TOKEN
  await _initializeMyDeviceFCMToken(context);

  /// CHECK DEVICE CLOCK
  final bool _deviceTimeIsCorrect = await Timers.checkDeviceTimeIsCorrect(
    context: context,
    showIncorrectTimeDialog: true,
  );

  if (_deviceTimeIsCorrect == false){
    await _onRestartAppInTimeCorrectionDialog(
      context: context,
    );
  }

}
// -----------------------------------------------------------------------------
Future<void> _onRestartAppInTimeCorrectionDialog({
  @required BuildContext context,
}) async {

  // await Nav.removeRouteBelow(context, const StaticLogoScreen());

  await Nav.goBackToLogoScreen(
      context: context,
      animatedLogoScreen: false,
  );

}
// -----------------------------------------------------------------------------

/// USER & AUTH MODELS INITIALIZATION

// ---------------------------------
Future<void> _initializeUserModel(BuildContext context) async {

  blog('_initializeUserModel : START');

  /// IF USER IS SIGNED IN
  if (AuthModel.userIsSignedIn() == true) {

  final AuthModel _authModel = await AuthLDBOps.readAuthModel();

  await setUserAndAuthModelsAndCompleteUserZoneLocally(
    context: context,
    authModel: _authModel,
    notify: false,
  );

  }

  /// IF USER IS NOT SIGNED IN
  // else {
  /// WILL CONTINUE NORMALLY AS ANONYMOUS
  // }

  blog('_initializeUserModel : END');

}
// ---------------------------------
Future<UserModel> completeUserZoneModel({
  @required BuildContext context,
  @required UserModel userModel,
}) async {

  blog('completeUserZoneModel : START');

  UserModel _output = userModel;

  if (userModel != null){

    /// COMPLETED ZONE MODEL
    final ZoneModel _completeZoneModel = await ZoneProtocols.completeZoneModel(
      context: context,
      incompleteZoneModel: userModel.zone,
    );

    /// COMPLETED USER MODEL
    _output = userModel.copyWith(
      zone: _completeZoneModel,
    );

  }

  blog('completeUserZoneModel : END');

  return _output;
}
// ---------------------------------
Future<void> setUserAndAuthModelsAndCompleteUserZoneLocally({
  @required BuildContext context,
  @required AuthModel authModel,
  @required bool notify,
}) async {

  blog('setUserAndAuthModelsAndCompleteUserZoneLocally : START');

  /// B.3 - so sign in succeeded returning a userModel, then set it in provider

  UserModel _userModel;

  if (authModel == null || authModel.userModel == null){
    _userModel = await UserProtocols.fetchUser(
        context: context,
        userID: AuthFireOps.superUserID(),
    );
  }
  else {
    _userModel = await completeUserZoneModel(
      context: context,
      userModel: authModel.userModel,
    );
  }

  final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);

  _usersProvider.setMyUserModelAndAuthModel(
    userModel: _userModel,
    authModel: authModel,
    notify: notify,
  );

  /// INSERT AUTH AND USER MODEL IN LDB
  await AuthLDBOps.updateAuthModel(authModel);
  await UserLDBOps.updateUserModel(authModel.userModel);

  blog('setUserAndAuthModelsAndCompleteUserZoneLocally : END');

}
// -----------------------------------------------------------------------------

/// APP STATE INITIALIZATION

// ---------------------------------
Future<void> _initializeAppState(BuildContext context) async {

  blog('_initializeAppState : START');

  if (AuthModel.userIsSignedIn() == true){

    final AppState _globalState = await AppStateFireOps.readGlobalAppState(context);
    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final AppState _userState = _usersProvider?.myUserModel?.appState;

    if (_userState != null){

      final String _detectedAppVersion = await AppStateFireOps.getAppVersion();
      final bool _userAppNeedUpdate = AppStateFireOps.appVersionNeedUpdate(
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
          await LDBOps.deleteAllMapsAtOnce(docName: LDBDoc.bigChainK,);
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
          await LDBOps.deleteAllMapsAtOnce(docName: LDBDoc.mainPhrases,);
          _userAppState = _userAppState.copyWith(
            phrasesVersion: _globalState.phrasesVersion,
          );
        }

        /// SPEC PICKERS
        if (_globalState.specPickersVersion > _userState.specPickersVersion){
          await LDBOps.deleteAllMapsAtOnce(docName: LDBDoc.pickers,);
          _userAppState = _userAppState.copyWith(
            specPickersVersion: _globalState.specPickersVersion,
          );
        }

        /// SPEC CHAIN VERSION
        if (_globalState.specsChainVersion > _userState.specsChainVersion){
          await LDBOps.deleteAllMapsAtOnce(docName: LDBDoc.bigChainS,);
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
        final bool _appStateNeedUpdate = !AppState.appStatesAreIdentical(
          stateA: _userState,
          stateB: _userAppState,
        );

        if (_appStateNeedUpdate == true){
          await AppStateFireOps.updateUserAppState(
            context: context,
            userID: _usersProvider.myUserModel.id,
            newAppState: _userAppState,
          );
        }



      }

    }

  }

  blog('_initializeAppState : END');

}
// ---------------------------------
Future<void> _showUpdateAppDialog(BuildContext context) async {

  await CenterDialog.showCenterDialog(
    context: context,
    titleVerse: 'New App update is Available',
    bodyVerse: 'You need to update the app to continue',
    confirmButtonVerse: 'Update Bldrs.net',
  );

  await Launcher.launchURL('www.pinterest.com');

}
// -----------------------------------------------------------------------------

/// APP CONTROLS INITIALIZATION

// ---------------------------------
Future<void> _initializeAppControls(BuildContext context) async {
  blog('_initializeAppControls : START');

  final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
  await _generalProvider.fetchSetAppControls(
      context: context,
      notify: true,
  );

  blog('_initializeAppControls : END');
}
// -----------------------------------------------------------------------------

/// LOCAL ASSETS PATHS INITIALIZATION

// ---------------------------------
Future<void> _initializeLocalAssetsPaths(BuildContext context) async {
  blog('_initializeLocalAssetsPaths : START');
  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
  await _uiProvider.getSetLocalAssetsPaths(notify: true);
  blog('_initializeLocalAssetsPaths : END');
}
// -----------------------------------------------------------------------------

/// APP LANGUAGE INITIALIZATION

// ---------------------------------
Future<void> _initializeAppLanguage(BuildContext context) async {
  blog('_initializeAppLanguage : START');

  final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);
  await _phraseProvider.fetchSetCurrentLangAndAllPhrases(
    context: context,
  );

  blog('_initializeAppLanguage : END');
}
// -----------------------------------------------------------------------------

/// MY DEVICE FCM TOKEN

// ---------------------------------
Future<void> _initializeMyDeviceFCMToken(BuildContext context) async {
  await Notifications.updateMyUserFCMToken(context: context);
}
// -----------------------------------------------------------------------------

/// NOTES STREAM INITIALIZATION

// ---------------------------------
/*
void _initializeUserNotesStream(BuildContext context){

  // final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
  // _notesProvider.startSetUserNotesStream(
  //   context: context,
  //   notify: true,
  // );

}
 */
// -----------------------------------------------------------------------------

/// NAVIGATION

// ---------------------------------
/*
Future<void> _goToLogoScreen(BuildContext context) async {
  await Nav.pushNamedAndRemoveAllBelow(
      context: context,
      goToRoute: Routez.logoScreen,
  );
}
 */
// -----------------------------------------------------------------------------
