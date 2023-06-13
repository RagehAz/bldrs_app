import 'package:bldrs/a_models/x_secondary/app_state_model.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:fire/super_fire.dart';
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
    @required AppStateModel newAppState,
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
  static Future<AppStateModel> readGlobalAppState() async {

    final Map<String, dynamic> _map = await Real.readDoc(
      coll: RealColl.app,
      doc: RealDoc.app_appState,
    );

    return AppStateModel.fromMap(_map);
  }
  // -----------------------------------------------------------------------------

  /// UPDATE GLOBAL APP STATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _updateGlobalAppState({
    @required AppStateModel newAppState,
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

    final AppStateModel _appState = await readGlobalAppState();

    final AppStateModel _newAppState = _appState.copyWith(
      appVersion: newAppVersion,
    );

    await _updateGlobalAppState(
      newAppState: _newAppState,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateGlobalLDBVersion() async {

    final AppStateModel _appState = await readGlobalAppState();

    final AppStateModel _newAppState = _appState.copyWith(
      ldbVersion: _appState.ldbVersion + 1,
    );

    await _updateGlobalAppState(
        newAppState: _newAppState
    );

  }
  // -----------------------------------------------------------------------------
}
