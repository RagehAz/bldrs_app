import 'package:bldrs/a_models/x_secondary/app_state.dart';
import 'package:bldrs/super_fire/super_fire.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class AppStateRealOps {
  // -----------------------------------------------------------------------------

  const AppStateRealOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> createGlobalAppState({
    @required AppState newAppState,
  }) async {

    await Real.createNamedDoc(
      collName: RealColl.app,
      docName: RealDoc.app_globalAppState,
      map: newAppState.toMap(),
    );

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AppState> readGlobalAppState() async {

    final Map<String, dynamic> _map = await Real.readDoc(
      collName: RealColl.app,
      docName: RealDoc.app_globalAppState,
    );

    return AppState.fromMap(_map);
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
}
