import 'dart:async';

import 'package:bldrs/c_protocols/auth_protocols/auth_protocols.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:bldrs/super_fire/super_fire.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/x_secondary/app_state.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/general_provider.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/c_protocols/app_state_protocols/real/app_state_real_ops.dart';
import 'package:bldrs/c_protocols/app_state_protocols/versioning/app_version.dart';
import 'package:bldrs/c_protocols/auth_protocols/auth_ldb_ops.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/fire/user_fire_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/ldb/user_ldb_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_timers.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs/f_helpers/router/bldrs_nav.dart';
import 'package:bldrs/f_helpers/router/routing.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:devicer/devicer.dart';
import 'package:filers/filers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:ldb/ldb.dart';
import 'package:provider/provider.dart';
/// => TAMAM
// -----------------------------------------------------------------------------
/// TESTED : WORKS PERFECT
Future<void> initializeLogoScreen({
  @required BuildContext context,
  @required bool mounted,
}) async {

  if (kDebugMode == true && DeviceChecker.deviceIsWindows() == true){
    await signInAsRage7(context: context);
  }
  
  // blog('1 - initializeLogoScreen : START');

  UiProvider.proSetScreenDimensions(
    context: context,
    notify: false,
  );

  UiProvider.proSetLayoutIsVisible(
      context: context,
      setTo: true,
      notify: true,
  );

  /// USER MODEL
  await initializeUserModel(context);

  blog('2 - initializeLogoScreen : ${Authing.getUserID()}');

  await Future.wait(
      <Future<void>>[

        /// APP CONTROLS
        initializeAppControls(context),
        /// LOCAL ASSETS PATHS
        initializeLocalAssetsPaths(context),
        /// APP LANGUAGE
        initializeAppLanguage(context),
        /// APP STATE
        initializeAppState(context),

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
    final bool _deviceTimeIsCorrect = await BldrsTimers.checkDeviceTimeIsCorrect(
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

  await BldrsNav.goBackToLogoScreen(
    context: context,
    animatedLogoScreen: false,
  );

}
// -----------------------------------------------------------------------------

/// USER & AUTH MODELS INITIALIZATION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> initializeUserModel(BuildContext context) async {

  // blog('_initializeUserModel : START');

  /// IF USER IS SIGNED IN
  if (Authing.userIsSignedIn() == true) {

    final AuthModel _authModel = await AuthLDBOps.readAuthModel();

    final UserModel _userModel = await UserProtocols.fetch(
      context: context,
      userID: Authing.getUserID(),
    );

    await setUserAndAuthModelsAndCompleteUserZoneLocally(
      context: context,
      authModel: _authModel,
      userModel: _userModel,
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
  @required UserModel userModel,
  @required bool notify,
}) async {

  // blog('setUserAndAuthModelsAndCompleteUserZoneLocally : START');

  /// B.3 - so sign in succeeded returning a userModel, then set it in provider
  UsersProvider.proSetMyAuthModel(
    context: context,
    authModel: authModel,
    notify: false,
  );

  UsersProvider.proSetMyUserModel(
    context: context,
    userModel: userModel,
    notify: notify,
  );

  /// INSERT AUTH AND USER MODEL IN LDB
  await AuthLDBOps.updateAuthModel(authModel);
  await UserLDBOps.updateUserModel(userModel);

  // blog('setUserAndAuthModelsAndCompleteUserZoneLocally : END');

}
// -----------------------------------------------------------------------------

/// APP STATE INITIALIZATION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> initializeAppState(BuildContext context) async {

  // blog('_initializeAppState : START');

  if (Authing.userIsSignedIn() == true){

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
          await LDBDoc.wipeOutEntireLDB();
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
      id: 'phid_new_app_update_available',
      translate: true
    ),
    bodyVerse: const Verse(
      pseudo: 'You need to update the app to continue',
      id: 'phid_new_app_update_description',
      translate: true,
    ),
    confirmButtonVerse: const Verse(
      pseudo: 'Update Bldrs.net',
      id: 'phid_update_bldrs_net',
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
Future<void> initializeAppControls(BuildContext context) async {
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
Future<void> initializeLocalAssetsPaths(BuildContext context) async {
  // blog('_initializeLocalAssetsPaths : START');
  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
  await _uiProvider.getSetLocalAssetsPaths(notify: true);
  // blog('_initializeLocalAssetsPaths : END');
}
// -----------------------------------------------------------------------------

/// APP LANGUAGE INITIALIZATION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> initializeAppLanguage(BuildContext context) async {
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

    LDBDoc.wipeOutEntireLDB(
      /// MAIN
      // flyers: true, // WHY WOULD YOU DO THIS
      // bzz: true, // WHY WOULD YOU DO THIS
      notes: false,
      pics: false,
      pdfs: false,
      /// USER
      users: false,
      authModel: false,
      accounts: false,
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

  final bool _shouldRefresh = await LDBOps.checkShouldRefreshLDB(
    // refreshDurationInHours: Standards.dailyLDBWipeIntervalInHours,
  );

  if (_shouldRefresh == true){

    await LDBDoc.wipeOutEntireLDB(
      /// MAIN
      // flyers: true,
      // bzz: true,
      notes: false, // I do not think we need to refresh notes everyday
      pics: false, // I do not think we need to refresh pics everyday
      pdfs: false, // i do not think that fetched pdfs are changed frequently by authors,
      /// USER
      users: false,
      authModel: false, // need my authModel to prevent re-auth everyday
      accounts: false, // keep accounts until user decides to not "remember me trigger"
      /// CHAIN
      bldrsChains: false, // keep the chains man, if chains updated - appState protocols handles this
      pickers: false, // same as chains
      /// ZONES
      // countries: true, // countries include staging info, so lets refresh that daily
      cities: false, // cities do not change often
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

/// RAGE7 SIGN IN

// --------------------
Future<void> signInAsRage7({
  @required BuildContext context,
}) async {
  final AuthModel _authModel = await EmailAuthing.signIn(
    email: 'rageh@bldrs.net',
    password: '123456',
    onError: (String error) => AuthProtocols.onAuthError(
      context: context,
      error: error,
    ),
  );

  if (_authModel != null) {
    final Map<String, dynamic> _map = await Fire.readDoc(
      coll: FireColl.users,
      doc: _authModel.id,
    );

    final UserModel _userModel = UserModel.decipherUser(
      map: _map,
      fromJSON: false,
    );

    /// UPDATE LDB USER MODEL
    await UserLDBOps.updateUserModel(_userModel);

    UsersProvider.proSetMyUserModel(
      context: context,
      userModel: _userModel,
      notify: true,
    );
  }
}
// -----------------------------------------------------------------------------
