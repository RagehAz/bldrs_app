// ignore_for_file: avoid_redundant_argument_values
import 'dart:async';

import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/ldb/methods/ldb_ops.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/x_secondary/app_state_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/app_state_real_ops.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/ldb/user_ldb_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_timers.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs/f_helpers/router/bldrs_nav.dart';
import 'package:bldrs/f_helpers/router/routing.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:bldrs/f_helpers/theme/words.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
/// => TAMAM
// -----------------------------------------------------------------------------
/// TESTED : WORKS PERFECT
Future<void> initializeLogoScreen({
  required BuildContext context,
  required bool mounted,
}) async {

  // if (kDebugMode == true && DeviceChecker.deviceIsWindows() == true){
  //   await signInAsRage7();
  // }
  
  // blog('1 - initializeLogoScreen : START');

  UiProvider.proSetScreenDimensions(
    notify: false,
  );

  UiProvider.proSetLayoutIsVisible(
      setTo: true,
      notify: true,
  );

  /// USER MODEL
  await initializeUserModel(context);

  UiProvider.proSetLoadingVerse(
      verse: Verse.plain(Words.pleaseWait()),
  );

  // blog('2 - initializeLogoScreen : ${Authing.getUserID()}');

  await Future.wait(
      <Future<void>>[

        /// LOCAL ASSETS PATHS
        initializeLocalAssetsPaths(),
        /// APP LANGUAGE
        initializeAppLanguage(),
        /// APP STATE
        initializeAppState(),

      ]
  );

  // blog('3 - initializeLogoScreen : assetPaths + lang + appState should have ended');

  UiProvider.proSetLoadingVerse(
    verse: Verse.plain(Words.thisIsBabyApp()),
  );

  if (_phrasesAreLoaded() == false){

    // blog('4 - initializeLogoScreen : phrases are not loaded and will restart');

    await CenterDialog.showCenterDialog(
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
    await _refreshUserDeviceModel();

    // blog('5 - initializeLogoScreen : device is refreshed');

    /// CHECK DEVICE CLOCK
    final bool _deviceTimeIsCorrect = await BldrsTimers.checkDeviceTimeIsCorrect(
      context: context,
      showIncorrectTimeDialog: true,
    );

    // blog('6 - initializeLogoScreen : _deviceTimeIsCorrect : $_deviceTimeIsCorrect');

    if (_deviceTimeIsCorrect == false){

      // blog('7 - initializeLogoScreen : will restart app now');

      await _onRestartAppInTimeCorrectionDialog();

    }

    else {

      UiProvider.proSetLoadingVerse(
        verse: Verse.plain(Words.thankYouForWaiting()),
      );

      /// DAILY LDB REFRESH
      await _refreshLDB();

      // blog('7 - initializeLogoScreen : daily refresh is done');

    }

    // blog('8 - initializeLogoScreen : END');

  }

  UiProvider.clearLoadingVerse();

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onRestartAppInTimeCorrectionDialog() async {

  // await Nav.removeRouteBelow(context, const StaticLogoScreen());

  await BldrsNav.goBackToLogoScreen(
    animatedLogoScreen: false,
  );

}
// -----------------------------------------------------------------------------

/// USER & AUTH MODELS INITIALIZATION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> initializeUserModel(BuildContext context) async {

  // blog('_initializeUserModel : START');

  /// USER HAS NO ID
  if (Authing.getUserID() == null){

    /// WILL CONTINUE NORMALLY AS ANONYMOUS
    final AuthModel? _anonymousAuth = await Authing.anonymousSignin();

    final UserModel? _anonymousUser = await UserModel.anonymousUser(
      authModel: _anonymousAuth,
    );

    await setUserModelAndCompleteUserZoneLocally(
      userModel: _anonymousUser,
      notify: false,
    );

  }

  /// USER HAS ID
  else {

      final UserModel? _userModel = await UserProtocols.fetch(
        context: context,
        userID: Authing.getUserID(),
      );

      await setUserModelAndCompleteUserZoneLocally(
        userModel: _userModel,
        notify: false,
      );

  }

  blog('_initializeUserModel : END : ${Authing.getUserID()}');

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> setUserModelAndCompleteUserZoneLocally({
  required UserModel? userModel,
  required bool notify,
}) async {

  // blog('setUserAndAuthModelsAndCompleteUserZoneLocally : START');

  UsersProvider.proSetMyUserModel(
    userModel: userModel,
    notify: notify,
  );

  /// INSERT AUTH AND USER MODEL IN LDB
  await UserLDBOps.updateUserModel(userModel);

  // blog('setUserAndAuthModelsAndCompleteUserZoneLocally : END');

}
// -----------------------------------------------------------------------------

/// APP STATE INITIALIZATION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> initializeAppState() async {

  final UserModel? _userModel = UsersProvider.proGetMyUserModel(
    context: getMainContext(),
    listen: false,
  );

  if (Authing.userIsSignedUp(_userModel?.signInMethod) == true){

    AppStateModel? _userState = _userModel?.appState?.copyWith();

    if (_userModel != null && _userState != null){

      final AppStateModel? _globalState = await AppStateRealOps.readGlobalAppState();
      final bool _statesAreIdentical = AppStateModel.checkAppStatesAreIdentical(
          state1: _userState,
          state2: _globalState
      );

    if (_statesAreIdentical == false && _globalState != null){

      /// LDB CHECK
      if (_globalState.ldbVersion != _userState.ldbVersion){
        await LDBDoc.wipeOutEntireLDB();
        _userState = _userState.copyWith(
          ldbVersion: _globalState.ldbVersion,
        );
      }

      final String _detectedAppVersion = await AppStateModel.detectAppVersion();
      final bool _userNeedToUpdateTheApp = AppStateModel.userNeedToUpdateApp(
        globalVersion: _globalState.appVersion,
        localVersion: _detectedAppVersion,
      );

      /// DETECTED APP VERSION IS INCORRECT
      if (_userNeedToUpdateTheApp == true){
        await _showUpdateAppDialog(
          global: _globalState.appVersion,
          detected: _detectedAppVersion,
        );
      }

      /// DETECTED APP VERSION IS CORRECT BUT USER VERSION IS NOT
      else if (_userState.appVersion != _detectedAppVersion){
        _userState = _userState.copyWith(
          appVersion: _detectedAppVersion,
        );
      }

      /// UPDATE USER STATE
      final bool _userStateIsUpdated = ! AppStateModel.checkAppStatesAreIdentical(
          state1: _userState,
          state2: _userModel.appState,
      );

      if (_userStateIsUpdated == true){

        await UserProtocols.renovate(
          context: getMainContext(),
          oldUser: _userModel,
          newUser: _userModel.copyWith(
            appState: _userState,
          ),
          newPic: null,
          invoker: 'initializeAppState',
        );

      }

    }

    }

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _showUpdateAppDialog({
  required String? global,
  required String? detected,
}) async {

  await CenterDialog.showCenterDialog(
    titleVerse:  Verse.plain(Words.newUpdateAvailable()),
    bodyVerse: Verse.plain(
      '''
      ${Words.pleaseUpdateToContinue()}
      your version : $detected
      new version : $global
      '''
    ),
    confirmButtonVerse: Verse.plain(Words.updateApp()),
    boolDialog: false,
  );

  await Launcher.launchContactModel(
    contact: ContactModel(
      type: ContactType.website,
      value: Standards.getBldrsStoreLink(),
    ),
  );

}
// -----------------------------------------------------------------------------

/// LOCAL ASSETS PATHS INITIALIZATION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> initializeLocalAssetsPaths() async {
  // blog('_initializeLocalAssetsPaths : START');
  final UiProvider _uiProvider = Provider.of<UiProvider>(getMainContext(), listen: false);
  await _uiProvider.getSetLocalAssetsPaths(notify: true);
  // blog('_initializeLocalAssetsPaths : END');
}
// -----------------------------------------------------------------------------

/// APP LANGUAGE INITIALIZATION

// -------------------: WORKS PERFECT
Future<void> initializeAppLanguage() async {
  // blog('_initializeAppLanguage : START');

  final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(getMainContext(), listen: false);
  await _phraseProvider.fetchSetCurrentLangAndAllPhrases();

  // blog('_initializeAppLanguage : END');
}
// --------------------
/// TESTED : WORKS PERFECT
bool _phrasesAreLoaded() {

  final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(getMainContext(), listen: false);

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
Future<void> _refreshUserDeviceModel() async {
  // blog('_initializeMyDeviceFCMToken : START');

  await Future.wait(<Future>[

    UserProtocols.refreshUserDeviceModel(context: getMainContext()),

    LDBDoc.wipeOutLDBDocs(
      /// MAIN
      flyers: true, // WHY WOULD YOU DO THIS
      bzz: true, // WHY WOULD YOU DO THIS
      notes: false,
      pics: false,
      pdfs: false,
      /// USER
      users: false,
      authModel: false,
      accounts: false,
      searches: false,
      /// CHAIN
      bldrsChains: false,
      pickers: false,
      /// ZONES
      countries: false,
      cities: false,
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
      langCode: false, // no need to wipe
      gta: false,
    ),

  ]);

  // blog('_initializeMyDeviceFCMToken : END');
}
// -----------------------------------------------------------------------------

/// Daily LDB REFRESH

// --------------------
/// TESTED : WORKS PERFECT
Future<void> _refreshLDB() async {

  final bool _shouldRefresh = await LDBOps.checkShouldRefreshLDB(
    refreshDurationInHours: Standards.ldbWipeIntervalInHours,
  );

  if (_shouldRefresh == true){

    await LDBDoc.wipeOutLDBDocs(
      /// MAIN
      flyers: true,
      bzz: true,
      notes: false, // I do not think we need to refresh notes everyday
      pics: false, // I do not think we need to refresh pics everyday
      pdfs: false, // i do not think that fetched pdfs are changed frequently by authors,
      /// USER
      users: false,
      authModel: false, // need my authModel to prevent re-auth everyday
      accounts: false, // keep accounts until user decides to not "remember me trigger"
      searches: false,
      /// CHAIN
      bldrsChains: false, // keep the chains man, if chains updated - appState protocols handles this
      pickers: false, // same as chains
      /// ZONES
      countries: true, // countries include staging info, so lets refresh that daily
      cities: false, // cities do not change often
      staging: true, // staging info changes frequently
      census: true, // might need faster refresh aslan

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
      langCode: false, // no need to wipe
      /// GTA
      gta: false, // this is for dashboard
    );

  }

  // else {
  //
  //   blog('_dailyRefreshLDB : IT HAS NOT BEEN A DAY YET : will leave the ldb as is');
  //
  // }

}
// -----------------------------------------------------------------------------
