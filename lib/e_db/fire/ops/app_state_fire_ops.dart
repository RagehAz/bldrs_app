import 'package:bldrs/a_models/secondary_models/app_state.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppStateFireOps{
// -----------------------------------------------------------------------------

  const AppStateFireOps();

// -----------------------------------------------------------------------------

  /// CREATE

// -----------------------------------
  /// TAMAM : WORKS PERFECT
  static Future<void> createGlobalAppState({
    @required BuildContext context,
    @required AppState newAppState,
}) async {

    await Fire.createNamedDoc(
        context: context,
        collName: FireColl.admin,
        docName: FireDoc.admin_appState,
        input: newAppState.toMap(),
    );

  }
// -----------------------------------------------------------------------------

  /// READ

// -----------------------------------
  /// TAMAM : WORKS PERFECT
  static Future<AppState> readGlobalAppState(BuildContext context) async {

    final Map<String, dynamic> _map = await Fire.readDoc(
        context: context,
        collName: FireColl.admin,
        docName: FireDoc.admin_appState,
    );

    return AppState.fromMap(_map);
  }
// -----------------------------------------------------------------------------

  /// UPDATE USER APP STATE

// -----------------------------------
  /// TAMAM : WORKS PERFECTLY
  static Future<void> updateUserAppState({
    @required BuildContext context,
    @required AppState newAppState,
    @required String userID
  }) async {

    await Fire.updateDocField(
      context: context,
      collName: FireColl.users,
      docName: userID,
      field: 'appState',
      input: newAppState.toMap(),
    );

  }
// -----------------------------------------------------------------------------

  /// UPDATE GLOBAL APP STATE

// -----------------------------------
  /// TAMAM : WORKS PERFECTLY
  static Future<void> _updateGlobalAppState({
    @required BuildContext context,
    @required AppState newAppState,
  }) async {

    await createGlobalAppState(
        context: context,
        newAppState: newAppState
    );

  }
// -----------------------------------
  /// TAMAM : WORKS PERFECTLY
  static Future<void> updateGlobalAppVersion({
    @required BuildContext context,
    @required String newVersion,
}) async {

    final AppState _appState = await readGlobalAppState(context);

    final AppState _newAppState = _appState.copyWith(
      appVersion: newVersion,
    );

    await _updateGlobalAppState(
        context: context,
        newAppState: _newAppState,
    );

  }
// -----------------------------------
  /// TAMAM : WORKS PERFECTLY
  static Future<void> updateGlobalKeywordsChainVersion(BuildContext context) async {

    final AppState _appState = await readGlobalAppState(context);

    final double lastVersion = _appState.keywordsChainVersion ?? 0;

    final AppState _newAppState = _appState.copyWith(
      keywordsChainVersion: lastVersion + 1,
    );

    await _updateGlobalAppState(
      context: context,
      newAppState: _newAppState
    );

  }
// -----------------------------------
  /// TAMAM : WORKS PERFECTLY
  static Future<void> updateGlobalLDBVersion(BuildContext context) async {

    final AppState _appState = await readGlobalAppState(context);

    final double lastVersion = _appState.ldbVersion ?? 0;

    final AppState _newAppState = _appState.copyWith(
      ldbVersion: lastVersion + 1,
    );

    await _updateGlobalAppState(
        context: context,
        newAppState: _newAppState
    );

  }
// -----------------------------------
  /// TAMAM : WORKS PERFECTLY
  static Future<void> updateGlobalPhrasesVersion(BuildContext context) async {

    final AppState _appState = await readGlobalAppState(context);

    final AppState _newAppState = _appState.copyWith(
      phrasesVersion: _appState.phrasesVersion + 1,
    );

    await _updateGlobalAppState(
        context: context,
        newAppState: _newAppState,
    );

  }
// -----------------------------------
  /// TAMAM : WORKS PERFECTLY
  static Future<void> updateSpecsPickersVersion(BuildContext context) async {

    final AppState _appState = await readGlobalAppState(context);

    final double lastVersion = _appState.specPickersVersion ?? 0;
    final AppState _newAppState = _appState.copyWith(
      specPickersVersion: lastVersion + 1,
    );

    await _updateGlobalAppState(
      context: context,
      newAppState: _newAppState,
    );

  }
// -----------------------------------
  /// TAMAM : WORKS PERFECTLY
  static Future<void> updateSpecsChainVersion(BuildContext context) async {

    final AppState _appState = await readGlobalAppState(context);

    final double lastVersion = _appState.specsChainVersion ?? 0;
    final AppState _newAppState = _appState.copyWith(
      specsChainVersion: lastVersion + 1,
    );

    await _updateGlobalAppState(
      context: context,
      newAppState: _newAppState,
    );

  }
// -----------------------------------------------------------------------------

/// APP VERSION

// -----------------------------------
  /// TAMAM : WORKS PERFECTLY
  static Future<String> getAppVersion() async {
    final PackageInfo _packageInfo = await PackageInfo.fromPlatform();
    return _packageInfo.version;
  }
// -----------------------------------
  /// TAMAM : WORKS PERFECTLY
  static bool appVersionNeedUpdate({
    @required String globalVersion,
    @required String userVersion,
}){
    bool _needUpdate = false;

    blog('appVersionNeedUpdate : globalVersion : $globalVersion : userVersion : $userVersion');

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
// -----------------------------------
  /// TAMAM : WORKS PERFECTLY
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
// -----------------------------------
}
