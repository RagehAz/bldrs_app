import 'dart:async';
import 'package:bldrs/a_models/x_secondary/app_state.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/a_models/a_user/auth_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/d_zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/a_zone_protocols.dart';
import 'package:bldrs/d_providers/general_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/app_state_fire_ops.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/auth_fire_ops.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_ops.dart';
import 'package:bldrs/e_back_end/x_ops/ldb_ops/auth_ldb_ops.dart';
import 'package:bldrs/e_back_end/x_ops/ldb_ops/user_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
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
  await _refreshUserDeviceModel(context);

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

// --------------------
Future<void> _initializeUserModel(BuildContext context) async {

  // blog('_initializeUserModel : START');

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

  // blog('_initializeUserModel : END');

}
// --------------------
Future<UserModel> completeUserZoneModel({
  @required BuildContext context,
  @required UserModel userModel,
}) async {

  // blog('completeUserZoneModel : START');

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

  // blog('completeUserZoneModel : END');

  return _output;
}
// --------------------
Future<void> setUserAndAuthModelsAndCompleteUserZoneLocally({
  @required BuildContext context,
  @required AuthModel authModel,
  @required bool notify,
}) async {

  // blog('setUserAndAuthModelsAndCompleteUserZoneLocally : START');

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

  // blog('setUserAndAuthModelsAndCompleteUserZoneLocally : END');

}
// -----------------------------------------------------------------------------

/// APP STATE INITIALIZATION

// --------------------
Future<void> _initializeAppState(BuildContext context) async {

  // blog('_initializeAppState : START');

  if (AuthModel.userIsSignedIn() == true){

    final AppState _globalState = await AppStateFireOps.readGlobalAppState();
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
        if (_globalState.chainsVersion > _userState.chainsVersion){
          await LDBOps.deleteAllMapsAtOnce(docName: LDBDoc.bldrsChains,);
          _userAppState = _userAppState.copyWith(
            chainsVersion: _globalState.chainsVersion,
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
        if (_globalState.pickersVersion > _userState.pickersVersion){
          await LDBOps.deleteAllMapsAtOnce(docName: LDBDoc.pickers,);
          _userAppState = _userAppState.copyWith(
            pickersVersion: _globalState.pickersVersion,
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
            userID: _usersProvider.myUserModel.id,
            newAppState: _userAppState,
          );
        }



      }

    }

  }

  // blog('_initializeAppState : END');

}
// --------------------
Future<void> _showUpdateAppDialog(BuildContext context) async {

  await CenterDialog.showCenterDialog(
    context: context,
    titleVerse:  const Verse(
      pseudo: 'New App update is Available',
      text: 'phid_new_app_update_available',
      translate: true
    ),
    bodyVerse: const Verse(
      pseudo: 'You need to update the app to continue',
      text: 'phid_new_app_update_description',
      translate: true,
    ),
    confirmButtonVerse: const Verse(
      pseudo: 'Update Bldrs.net',
      text: 'phid_update_bldrs_net',
      translate: true,
    ),
  );

  await Launcher.launchContactModel(
    context: context,
    contact: ContactModel(
      type: ContactType.website,
      value: Standards.getBldrsAppUpdateLink(context),
    ),
  );

}
// -----------------------------------------------------------------------------

/// APP CONTROLS INITIALIZATION

// --------------------
Future<void> _initializeAppControls(BuildContext context) async {
  // blog('_initializeAppControls : START');

  final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
  await _generalProvider.fetchSetAppControls(
    context: context,
    notify: true,
  );

  // blog('_initializeAppControls : END');
}
// -----------------------------------------------------------------------------

/// LOCAL ASSETS PATHS INITIALIZATION

// --------------------
Future<void> _initializeLocalAssetsPaths(BuildContext context) async {
  // blog('_initializeLocalAssetsPaths : START');
  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
  await _uiProvider.getSetLocalAssetsPaths(notify: true);
  // blog('_initializeLocalAssetsPaths : END');
}
// -----------------------------------------------------------------------------

/// APP LANGUAGE INITIALIZATION

// --------------------
Future<void> _initializeAppLanguage(BuildContext context) async {
  // blog('_initializeAppLanguage : START');

  final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);
  await _phraseProvider.fetchSetCurrentLangAndAllPhrases(
    context: context,
  );

  // blog('_initializeAppLanguage : END');
}
// -----------------------------------------------------------------------------

/// MY DEVICE FCM TOKEN

// --------------------
/// TESTED : WORKS PERFECT
Future<void> _refreshUserDeviceModel(BuildContext context) async {
  // blog('_initializeMyDeviceFCMToken : START');
  await UserProtocols.refreshUserDeviceModel(context: context);
  // blog('_initializeMyDeviceFCMToken : END');
}
// -----------------------------------------------------------------------------
