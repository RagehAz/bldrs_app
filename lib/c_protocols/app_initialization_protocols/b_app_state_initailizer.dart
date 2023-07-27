import 'package:basics/helpers/widgets/sensors/app_version_builder.dart';
import 'package:bldrs/a_models/x_secondary/app_state_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/app_state_protocols.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs/f_helpers/router/bldrs_nav.dart';
import 'package:bldrs/f_helpers/theme/words.dart';
import 'package:flutter/foundation.dart';

class AppStateInitializer {
  // -----------------------------------------------------------------------------

  const AppStateInitializer();

  // -----------------------------------------------------------------------------

  /// APP STATE INITIALIZATION

  // --------------------
  ///
  static Future<bool> initialize() async {
    bool _canLoadApp = false;

    /// GET GLOBAL STATE
    final AppStateModel? _globalState = await AppStateProtocols.fetchGlobalAppState();

    if (kDebugMode == true){
      _canLoadApp = true;
    }
    else {

      /// ON LOADING FAILED OP
      bool _continue = await _globalStateExistsOps(globalState: _globalState);
      if (_continue == true){

        /// APP IS ONLINE CHECKUP
        _continue = await _appIsOnlineCheckOps(globalState: _globalState!);
        if (_continue == true){

          final String _detectedVersion = await AppVersionBuilder.detectAppVersion();

          /// FORCE UPDATE APP OP
          _continue = await _forceUpdateCheckOps(
            globalState: _globalState,
            detectedVersion: _detectedVersion,
          );

          if (_continue == true){

            /// ENDORSE UPDATE APP OP
            _continue = await _endorseUpdateCheckOps(
              globalState: _globalState,
              detectedVersion: _detectedVersion,
            );

            if (_continue == true){

              /// NOW WE CAN LOAD THE APP
              _canLoadApp = true;

            }

          }
        }

      }

    }

    return _canLoadApp;
  }
  // -----------------------------------------------------------------------------

  /// CHECK OPS

  // --------------------
  ///
  static Future<bool> _globalStateExistsOps({
    required AppStateModel? globalState,
  }) async {
    bool _output = false;

    /// GLOBAL STATE IS GOOD
    if (globalState != null && globalState.appVersion != null) {
      _output = true;
    }

    /// INTERNET COULDN'T GET GLOBAL STATE
    else {

      await Dialogs.somethingWentWrongAppWillRestart();

      await BldrsNav.goToLogoScreenAndRemoveAllBelow(
        animatedLogoScreen: false,
      );

    }

    return _output;
  }
  // --------------------
  ///
  static Future<bool> _appIsOnlineCheckOps({
    required AppStateModel globalState,
  }) async {
    bool _output = false;

    /// BLDRS IS ONLINE
    if (globalState.bldrsIsOnline == true){
      _output = true;
    }

    /// BLDRS IS UNDER CONSTRUCTION
    else {
      await BldrsNav.goToBldrsUnderConstructionScreen();
    }

    return _output;
  }
  // --------------------
  ///
  static Future<bool> _forceUpdateCheckOps({
    required AppStateModel globalState,
    required String detectedVersion,
  }) async {
    bool _output = false;

    final bool _mustUpdate = AppStateModel.versionIsBigger(
        thisIsBigger: globalState.minVersion,
        thanThis: detectedVersion,
    );

    /// MUST UPDATE
    if (_mustUpdate == true){

      await CenterDialog.showCenterDialog(
        titleVerse:  Verse.plain(Words.newUpdateAvailable()),
        bodyVerse: Verse.plain(
'''
${Words.pleaseUpdateToContinue()}
your version : $detectedVersion
new version : ${globalState.appVersion}
'''
        ),
        confirmButtonVerse: Verse.plain(Words.updateApp()),
        // boolDialog: false,
      );

      await Launcher.launchBldrsAppLinkOnStore();

    }

    /// CAN CONTINUE WITHOUT UPDATE
    else {
      _output = true;
    }

    return _output;
  }
  // --------------------
  ///
  static Future<bool> _endorseUpdateCheckOps({
    required AppStateModel globalState,
    required String detectedVersion,
  }) async {
    bool _output = true;

    final bool _mayUpdate = AppStateModel.versionIsBigger(
        thisIsBigger: globalState.appVersion,
        thanThis: detectedVersion,
    );

    /// MUST UPDATE
    if (_mayUpdate == true){

      await CenterDialog.showCenterDialog(
        titleVerse:  Verse.plain(Words.newUpdateAvailable()),
        bodyVerse: Verse.plain(
'''
${Words.pleaseUpdateToContinue()}
your version : $detectedVersion
new version : ${globalState.appVersion}
'''
        ),
        confirmButtonVerse: Verse.plain(Words.updateApp()),
        boolDialog: true,
        noVerse: Verse.plain(Words.skip()),
        onOk: () async {
          _output = false;
          await Launcher.launchBldrsAppLinkOnStore();
        },
      );

    }

    return _output;
  }
  // --------------------
}
