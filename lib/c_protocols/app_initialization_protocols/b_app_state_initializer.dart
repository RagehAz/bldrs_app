import 'dart:async';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/components/sensors/app_version_builder.dart';
import 'package:basics/ldb/methods/ldb_ops.dart';
import 'package:bldrs/a_models/x_secondary/app_state_model.dart';
import 'package:bldrs/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/app_state_protocols.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
import 'package:flutter/foundation.dart';

/// => TAMAM
class AppStateInitializer {
  // -----------------------------------------------------------------------------

  const AppStateInitializer();

  // -----------------------------------------------------------------------------

  /// APP STATE INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> initialize() async {
    bool _canLoadApp = kDebugMode;

    /// GET GLOBAL STATE
    final AppStateModel? _globalState = await AppStateProtocols.fetchGlobalAppState();

    /// ON LOADING FAILED OP
    bool _continue = await _globalStateExistsOps(globalState: _globalState);

    if (_continue == true && kDebugMode == false){

        /// APP IS ONLINE CHECKUP
        _continue = await _appIsOnlineCheckOps(globalState: _globalState!);
        if (_continue == true && kDebugMode == false){

          final String _detectedVersion = await AppVersionBuilder.detectAppVersion();

          /// FORCE UPDATE APP OP
          _continue = await _forceUpdateCheckOps(
            globalState: _globalState,
            detectedVersion: _detectedVersion,
          );

          if (_continue == true && kDebugMode == false){

            /// ENDORSE UPDATE APP OP
            _continue = await _endorseUpdateCheckOps(
              globalState: _globalState,
              detectedVersion: _detectedVersion,
            );

            if (_continue == true && kDebugMode == false){

              unawaited(_superWipeLDBIfDecidedByRage7(
                globalState: _globalState,
              ));

              /// NOW WE CAN LOAD THE APP
              _canLoadApp = true;

            }

          }
        }

      }

    return _canLoadApp;
  }
  // -----------------------------------------------------------------------------

  /// CHECK OPS

  // --------------------
  /// TESTED : WORKS PERFECT
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

      await BldrsNav.pushLogoRouteAndRemoveAllBelow(
        animatedLogoScreen: false,
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
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
      await BldrsNav.pushBldrsUnderConstructionRoute();
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> _forceUpdateCheckOps({
    required AppStateModel globalState,
    required String detectedVersion,
  }) async {
    bool _output = false;

    if (kIsWeb == true){
      _output = true;
    }

    else {

      final bool _mustUpdate = AppVersionBuilder.versionIsBigger(
        thisIsBigger: globalState.minVersion,
        thanThis: detectedVersion,
      );

      /// MUST UPDATE
      if (_mustUpdate == true){

        /// TEMPORARY UNTIL APP BECOMES MORE STABLE
        unawaited(LDBOps.deleteAllMapsAtOnce(docName: LDBDoc.accounts));

        await BldrsCenterDialog.showCenterDialog(
          titleVerse:  getVerse('phid_newUpdateAvailable'),
          bodyVerse: Verse.plain(
'''
${getWord('phid_pleaseUpdateToContinue')}
${getWord('phid_your_version')} : $detectedVersion
${getWord('phid_new_version')} : ${globalState.appVersion}
'''
        ),
        confirmButtonVerse: getVerse('phid_updateApp'),
        // boolDialog: false,
      );

        await Launcher.launchBldrsAppLinkOnStore();

      }

      /// CAN CONTINUE WITHOUT UPDATE
      else {
        _output = true;
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> _endorseUpdateCheckOps({
    required AppStateModel globalState,
    required String detectedVersion,
  }) async {
    bool _output = true;

    if (kIsWeb == true){
      _output = true;
    }

    else {

      final bool _mayUpdate = AppVersionBuilder.versionIsBigger(
        thisIsBigger: globalState.appVersion,
        thanThis: detectedVersion,
      );

      /// MUST UPDATE
      if (_mayUpdate == true){

        await BldrsCenterDialog.showCenterDialog(
          titleVerse:  getVerse('phid_newUpdateAvailable'),
          bodyVerse: Verse.plain(
'''
${getWord('phid_pleaseUpdateToContinue')}
${getWord('phid_your_version')} : $detectedVersion
${getWord('phid_new_version')} : ${globalState.appVersion}
'''
          ),
          confirmButtonVerse: getVerse('phid_updateApp'),
          boolDialog: true,
          noVerse: getVerse('phid_skip'),
          onOk: () async {
            blog('wtf is this why no work');
            _output = false;
            await Launcher.launchBldrsAppLinkOnStore();
            },
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _superWipeLDBIfDecidedByRage7({
    required AppStateModel globalState,
  }) async {

    final Map<String, dynamic>? _localLDBVersionMap = await LDBOps.readMap(
      docName: 'ldbVersion',
      id: 'ldb',
      primaryKey: 'id',
    );

    final int? _localLDBVersion = _localLDBVersionMap?['ldbVersion'];

    if (globalState.ldbVersion != _localLDBVersion){

      await LDBDoc.onHardRebootSystem();

      await LDBOps.insertMap(
        docName: 'ldbVersion',
        primaryKey: 'id',
        input: {
          'id': 'ldb',
          'ldbVersion': globalState.ldbVersion,
        },
      );

    }

  }
  // -----------------------------------------------------------------------------
}
