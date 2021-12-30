import 'package:bldrs/a_models/secondary_models/app_updates.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:flutter/material.dart';


// final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
class GeneralProvider extends ChangeNotifier {
// -----------------------------------------------------------------------------

  /// APP STATE

// -------------------------------------
  AppState _appState = AppState.initialState();
// -------------------------------------
  AppState get appState {
    return _appState;
  }
// -------------------------------------
  Future<void> getsetAppState(BuildContext context) async {
    final Map<String, dynamic> _map = await Fire.readDoc(
      context: context,
      collName: FireColl.admin,
      docName: FireDoc.admin_appState,
    );

    final AppState _updates = AppState.fromMap(_map);

    _appState = _updates;
    notifyListeners();
  }
// -----------------------------------------------------------------------------
}
