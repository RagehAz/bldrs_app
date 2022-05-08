import 'package:bldrs/a_models/secondary_models/app_state.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:flutter/material.dart';

/// DASH BOARD OPS WESH
class AppStateOps{

  AppStateOps();

  static Future<void> updateKeywordsChainVersion(BuildContext context) async {

    final Map<String, dynamic> _map = await Fire.readDoc(
      context: context,
      collName: FireColl.admin,
      docName: FireDoc.admin_appState,
    );

    final AppState _appState = AppState.fromMap(_map);

    final double lastVersion = _appState.keywordsChainVersion ?? 0;

    final AppState _newAppState = _appState.copyWith(
      keywordsChainVersion: lastVersion + 1,
    );

    await Fire.updateDoc(
        context: context,
        collName: FireColl.admin,
        docName: FireDoc.admin_appState,
        input: _newAppState.toMap(),
    );

  }

  static Future<void> updateSpecsChainVersion(BuildContext context) async {

    final Map<String, dynamic> _map = await Fire.readDoc(
      context: context,
      collName: FireColl.admin,
      docName: FireDoc.admin_appState,
    );

    final AppState _appState = AppState.fromMap(_map);

    final double lastVersion = _appState.specsChainVersion ?? 0;
    final AppState _newAppState = _appState.copyWith(
      specsChainVersion: lastVersion + 1,
    );

    await Fire.updateDoc(
      context: context,
      collName: FireColl.admin,
      docName: FireDoc.admin_appState,
      input: _newAppState.toMap(),
    );

  }

  static Future<void> updatePhrasesVersion(BuildContext context) async {

    final Map<String, dynamic> _map = await Fire.readDoc(
      context: context,
      collName: FireColl.admin,
      docName: FireDoc.admin_appState,
    );

    final AppState _appState = AppState.fromMap(_map);

    final AppState _newAppState = _appState.copyWith(
      phrasesVersion: _appState.phrasesVersion + 1,
    );

    await Fire.updateDoc(
      context: context,
      collName: FireColl.admin,
      docName: FireDoc.admin_appState,
      input: _newAppState.toMap(),
    );

  }

}
