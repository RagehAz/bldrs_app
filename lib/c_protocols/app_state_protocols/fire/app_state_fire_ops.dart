import 'package:bldrs/a_models/x_secondary/app_state.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppStateFireOps{
  // -----------------------------------------------------------------------------

  const AppStateFireOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> createGlobalAppState({
    @required AppState newAppState,
  }) async {

    await Fire.createNamedDoc(
      collName: FireColl.admin,
      docName: FireDoc.admin_appState,
      input: newAppState.toMap(),
    );

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AppState> readGlobalAppState() async {

    final Map<String, dynamic> _map = await Fire.readDoc(
      collName: FireColl.admin,
      docName: FireDoc.admin_appState,
    );

    return AppState.fromMap(_map);
  }
  // -----------------------------------------------------------------------------

  /// UPDATE USER APP STATE

  // --------------------
  /// TESTED : WORKS PERFECTLY
  static Future<void> updateUserAppState({
    @required AppState newAppState,
    @required String userID
  }) async {

    await Fire.updateDocField(
      collName: FireColl.users,
      docName: userID,
      field: 'appState',
      input: newAppState.toMap(),
    );

  }
  // -----------------------------------------------------------------------------

  /// UPDATE GLOBAL APP STATE

  // --------------------
  /// TESTED : WORKS PERFECTLY
  static Future<void> _updateGlobalAppState({
    @required AppState newAppState,
  }) async {

    await createGlobalAppState(
        newAppState: newAppState
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECTLY
  static Future<void> updateGlobalAppVersion({
    @required String newVersion,
  }) async {

    final AppState _appState = await readGlobalAppState();

    final AppState _newAppState = _appState.copyWith(
      appVersion: newVersion,
    );

    await _updateGlobalAppState(
      newAppState: _newAppState,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECTLY
  static Future<void> updateGlobalChainsVersion() async {

    final AppState _appState = await readGlobalAppState();

    final double lastVersion = _appState.chainsVersion ?? 0;

    final AppState _newAppState = _appState.copyWith(
      chainsVersion: lastVersion + 1,
    );

    await _updateGlobalAppState(
        newAppState: _newAppState
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECTLY
  static Future<void> updateGlobalLDBVersion() async {

    final AppState _appState = await readGlobalAppState();

    final double lastVersion = _appState.ldbVersion ?? 0;

    final AppState _newAppState = _appState.copyWith(
      ldbVersion: lastVersion + 1,
    );

    await _updateGlobalAppState(
        newAppState: _newAppState
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECTLY
  static Future<void> updateGlobalPhrasesVersion() async {

    final AppState _appState = await readGlobalAppState();

    final AppState _newAppState = _appState.copyWith(
      phrasesVersion: _appState.phrasesVersion + 1,
    );

    await _updateGlobalAppState(
      newAppState: _newAppState,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECTLY
  static Future<void> updatePickersVersion() async {

    final AppState _appState = await readGlobalAppState();

    final double lastVersion = _appState.pickersVersion ?? 0;
    final AppState _newAppState = _appState.copyWith(
      pickersVersion: lastVersion + 1,
    );

    await _updateGlobalAppState(
      newAppState: _newAppState,
    );

  }
  // -----------------------------------------------------------------------------

  /// APP VERSION

  // --------------------
  /// TESTED : WORKS PERFECTLY
  static Future<String> getAppVersion() async {
    final PackageInfo _packageInfo = await PackageInfo.fromPlatform();
    return _packageInfo.version;
  }
  // --------------------
  /// TESTED : WORKS PERFECTLY
  static bool appVersionNeedUpdate({
    @required String globalVersion,
    @required String userVersion,
  }){
    bool _needUpdate = false;

    // blog('appVersionNeedUpdate : globalVersion : $globalVersion : userVersion : $userVersion');

    final List<int> _global = _getAppVersionDivisions(globalVersion);
    final List<int> _user = _getAppVersionDivisions(userVersion);

    for (int i = 0; i < _global.length; i++){
      if (_global[i] > _user[i]){
        _needUpdate = true;
        break;
      }
    }

    return _needUpdate;
  }
  // --------------------
  /// TESTED : WORKS PERFECTLY
  static List<int> _getAppVersionDivisions(String version){
    final List<int> _divisions = <int>[];

    if (version != null){
      final String _removedBuildNumber = TextMod.removeTextAfterLastSpecialCharacter(version, '+');

      final List<String> _strings = _removedBuildNumber.split('.');

      for (final String string in _strings){

        final int _int = Numeric.transformStringToInt(string);

        _divisions.add(_int);
      }
    }

    return _divisions;
  }
  // --------------------
}
