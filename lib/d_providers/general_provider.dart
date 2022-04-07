import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/app_state.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
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

  /// ONLINE SECTIONS

  // -------------------------------------
  final List<BzSection> _onlineSections = <BzSection>[
    BzSection.realestate,
    BzSection.construction,
    BzSection.supplies,
  ];
  // -------------------------------------
  List<BzSection> get onlineSections => _onlineSections;
  // -------------------------------------
  bool sectionIsOnline(BzSection section){
    return _onlineSections.contains(section) == true;
  }
// -------------------------------------
}

List<String> getActiveCountriesIDs(BuildContext context){

  final List<String> _allIDs = CountryModel.getAllCountriesIDsSortedByName(context);
  return _allIDs;

  // final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
  // final List<String> _activeIDs = _generalProvider.appState.activeCountries;
  // return _activeIDs;
}
