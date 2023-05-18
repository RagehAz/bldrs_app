import 'package:bldrs/a_models/x_secondary/app_state.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:bldrs/super_fire/super_fire.dart';
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
    if (newAppState != null) {
      await Real.createDoc(
        coll: RealColl.app,
        doc: RealDoc.app_appState,
        map: newAppState.toMap(),
      );
    }
  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AppState> readGlobalAppState() async {

    final Map<String, dynamic> _map = await Real.readDoc(
      coll: RealColl.app,
      doc: RealDoc.app_appState,
    );

    return AppState.fromMap(_map);
  }
  // -----------------------------------------------------------------------------

  /// UPDATE GLOBAL APP STATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _updateGlobalAppState({
    @required AppState newAppState,
  }) async {

    await createGlobalAppState(
        newAppState: newAppState
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateGlobalAppVersion({
    @required String newAppVersion,
  }) async {

    final AppState _appState = await readGlobalAppState();

    final AppState _newAppState = _appState.copyWith(
      appVersion: newAppVersion,
    );

    await _updateGlobalAppState(
      newAppState: _newAppState,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateGlobalLDBVersion() async {

    final AppState _appState = await readGlobalAppState();

    final AppState _newAppState = _appState.copyWith(
      ldbVersion: _appState.ldbVersion + 1,
    );

    await _updateGlobalAppState(
        newAppState: _newAppState
    );

  }
  // -----------------------------------------------------------------------------
}
