import 'dart:async';

import 'package:bldrs/a_models/a_user/auth_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/x_secondary/app_state.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/general_provider.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/c_protocols/app_state_protocols/real/app_state_real_ops.dart';
import 'package:bldrs/c_protocols/app_state_protocols/versioning/app_version.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/c_protocols/auth_protocols/ldb/auth_ldb_ops.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/fire/user_fire_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/ldb/user_ldb_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/router/routing.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
/// => TAMAM
// -----------------------------------------------------------------------------
/// TESTED : WORKS PERFECT
Future<void> initializeLogoScreen({
  @required BuildContext context,
  @required bool mounted,
}) async {

  FlutterNativeSplash.remove();

  // blog('1 - initializeLogoScreen : START');

  UiProvider.proSetScreenDimensions(
    context: context,
    notify: true,
  );

  /// USER MODEL
  await _initializeUserModel(context);

  blog('2 - initializeLogoScreen : ${AuthFireOps.superUserID()}');

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

  blog('3 - initializeLogoScreen : appControls + assetPaths + lang + appState should have ended');

  if (_phrasesAreLoaded(context) == false){

    // blog('4 - initializeLogoScreen : phrases are not loaded and will restart');

    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: Verse.plain('Bldrs.net is currently under construction'),
      bodyVerse: Verse.plain('Sorry for inconvenience'),
      confirmButtonVerse: Verse.plain('Ok'),
    );

    await Nav.pushNamedAndRemoveAllBelow(
        context: context,
        goToRoute: Routing.staticLogoScreen,
    );

  }

  else {

    // blog('4 - initializeLogoScreen : phrases found and will check user device');

    /// DEVICE ID - TOKEN
    await _refreshUserDeviceModel(context);

    // blog('5 - initializeLogoScreen : device is refreshed');

    /// CHECK DEVICE CLOCK
    final bool _deviceTimeIsCorrect = await Timers.checkDeviceTimeIsCorrect(
      context: context,
      showIncorrectTimeDialog: true,
    );

    // blog('6 - initializeLogoScreen : _deviceTimeIsCorrect : $_deviceTimeIsCorrect');

    if (_deviceTimeIsCorrect == false){

      // blog('7 - initializeLogoScreen : will restart app now');

      await _onRestartAppInTimeCorrectionDialog(
        context: context,
      );

    }

    else {


      /// DAILY LDB REFRESH
      await _dailyRefreshLDB(context);

      // blog('7 - initializeLogoScreen : daily refresh is done');

    }

    // blog('8 - initializeLogoScreen : END');

  }

}
// --------------------
/// TESTED : WORKS PERFECT
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
/// TESTED : WORKS PERFECT
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
/// TESTED : WORKS PERFECT
Future<void> setUserAndAuthModelsAndCompleteUserZoneLocally({
  @required BuildContext context,
  @required AuthModel authModel,
  @required bool notify,
}) async {

  // blog('setUserAndAuthModelsAndCompleteUserZoneLocally : START');

  /// B.3 - so sign in succeeded returning a userModel, then set it in provider

  UserModel _userModel = authModel?.userModel;
  _userModel ??= await UserProtocols.fetch(
    context: context,
    userID: AuthFireOps.superUserID(),
  );

  UsersProvider.proSetMyUserAndAuthModels(
    context: context,
    userModel: _userModel,
    authModel: authModel,
    notify: notify,
  );

  /// INSERT AUTH AND USER MODEL IN LDB
  await AuthLDBOps.updateAuthModel(authModel);
  await UserLDBOps.updateUserModel(authModel?.userModel);

  // blog('setUserAndAuthModelsAndCompleteUserZoneLocally : END');

}
// -----------------------------------------------------------------------------

/// APP STATE INITIALIZATION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> _initializeAppState(BuildContext context) async {

  // blog('_initializeAppState : START');

  if (AuthModel.userIsSignedIn() == true){

    final AppState _globalState = await AppStateRealOps.readGlobalAppState();
    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final AppState _userState = _usersProvider?.myUserModel?.appState;

    if (_userState != null && _globalState != null){

      final String _detectedAppVersion = await AppVersion.getAppVersion();
      final bool _userAppNeedUpdate = AppVersion.appVersionNeedUpdate(
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
          await UserFireOps.updateUserAppState(
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
/// TESTED : WORKS PERFECT
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
/// TESTED : WORKS PERFECT
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
/// TESTED : WORKS PERFECT
Future<void> _initializeLocalAssetsPaths(BuildContext context) async {
  // blog('_initializeLocalAssetsPaths : START');
  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
  await _uiProvider.getSetLocalAssetsPaths(notify: true);
  // blog('_initializeLocalAssetsPaths : END');
}
// -----------------------------------------------------------------------------

/// APP LANGUAGE INITIALIZATION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> _initializeAppLanguage(BuildContext context) async {
  // blog('_initializeAppLanguage : START');

  final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);
  await _phraseProvider.fetchSetCurrentLangAndAllPhrases(
    context: context,
  );

  // blog('_initializeAppLanguage : END');
}
// --------------------
/// TESTED : WORKS PERFECT
bool _phrasesAreLoaded(BuildContext context) {

  final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);

  // blog('_phrasesAreLoaded : _phraseProvider.mainPhrases.length : ${_phraseProvider.mainPhrases.length}');

  /// empty phrases mean its not loaded
  if (_phraseProvider.mainPhrases.isEmpty == true){
    return false;
  }

  else {
    return true;
  }

}
// -----------------------------------------------------------------------------

/// MY DEVICE FCM TOKEN

// --------------------
/// TESTED : WORKS PERFECT
Future<void> _refreshUserDeviceModel(BuildContext context) async {
  // blog('_initializeMyDeviceFCMToken : START');

  await Future.wait(<Future>[

    UserProtocols.refreshUserDeviceModel(context: context),

    LDBOps.wipeOutEntireLDB(
      /// MAIN
      // flyers: true,
      // bzz: true,
      // users: true,
      authModel: false,
      // notes: true, // not sure why
      pics: false,
      pdfs: false,
      /// CHAIN
      bldrsChains: false,
      pickers: false,
      /// ZONES
      countries: false,
      cities: false,
      districts: false,
      staging: false,
      census: false, // this has nothing to do with the user refreshing the device
      /// PHRASES
      mainPhrases: false,
      countriesPhrases: false,
      /// EDITORS
      userEditor: false, // keep this for user to find later anytime
      bzEditor: false, // keep this as well
      authorEditor: false, // keep
      flyerMaker: false, // keep
      reviewEditor: false, // keep
      /// SETTINGS
      theLastWipe: false, // no need to wipe
      appState: false, // no need to wipe
      appControls: false, // no need to wipe
      langCode: false, // no need to wipe
    ),

  ]);

  // blog('_initializeMyDeviceFCMToken : END');
}
// -----------------------------------------------------------------------------

/// Daily LDB REFRESH

// --------------------
/// TESTED : WORKS PERFECT
Future<void> _dailyRefreshLDB(BuildContext context) async {

  final bool _shouldRefresh = await LDBOps.checkShouldRefreshLDB(context);

  if (_shouldRefresh == true){

    await LDBOps.wipeOutEntireLDB(
      /// MAIN
      // flyers: true,
      // bzz: true,
      // users: true,
      authModel: false, // need my authModel to prevent re-auth everyday
      notes: false, // I do not think we need to refresh notes everyday
      pics: false, // I do not think we need to refresh pics everyday
      pdfs: false, // i do not think that fetched pdfs are changed frequently by authors,
      /// CHAIN
      bldrsChains: false, // keep the chains man, if chains updated - appState protocols handles this
      pickers: false, // same as chains
      /// ZONES
      // countries: true, // countries include staging info, so lets refresh that daily
      cities: false, // cities do not change often
      districts: false, // districts do not change frequently
      // staging: true, // staging info changes frequently
      // census: true, // might need faster refresh aslan

      /// PHRASES
      mainPhrases: false,
      countriesPhrases: false,
      /// EDITORS
      userEditor: false, // keep this for user to find later anytime
      bzEditor: false, // keep this as well
      authorEditor: false, // keep
      flyerMaker: false, // keep
      reviewEditor: false, // keep
      /// SETTINGS
      theLastWipe: false, // no need to wipe
      appState: false, // no need to wipe
      appControls: false, // no need to wipe
      langCode: false, // no need to wipe
    );

  }

  // else {
  //
  //   blog('_dailyRefreshLDB : IT HAS NOT BEEN A DAY YET : will leave the ldb as is');
  //
  // }

}
// -----------------------------------------------------------------------------
