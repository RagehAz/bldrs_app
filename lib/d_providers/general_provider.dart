import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/f_helpers/drafters/device_checkers.dart' as DeviceChecker;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
class GeneralProvider extends ChangeNotifier {
// // -----------------------------------------------------------------------------
//
//   /// APP STATE
//
//   // -------------------------------------
//   AppState _appState = AppState.initialState();
//   // -------------------------------------
//   AppState get appState {
//     return _appState;
//   }
//   // -------------------------------------
//   Future<void> getsetGlobalAppState(BuildContext context) async {
//
//     final AppState _globalAppState = await AppStateOps.readGlobalAppState(context);
//
//     _appState = _appState;
//     notifyListeners();
//   }
//   // -----------------------------------------------------------------------------

  /// CONNECTIVITY

  // -------------------------------------
  bool _isConnected = false;
  // -------------------------------------
  bool get isConnected => _isConnected;
  // -------------------------------------
  Future<void> getSetConnectivity({
    @required BuildContext context,
    @required bool mounted,
    @required bool notify,
}) async {

    if (mounted == true){

      final bool _connected = await DeviceChecker.checkConnectivity(
        context: context,
      );

      setConnectivity(
        isConnected: _connected,
        notify: notify,
      );
    }

  }
  // -------------------------------------
  void setConnectivity({
    @required bool isConnected,
    @required bool notify,
  }) {

    _isConnected = isConnected;

      if(notify == true){
        notifyListeners();
      }

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

bool deviceIsConnected(BuildContext context){
  final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
  return _generalProvider.isConnected;
}
