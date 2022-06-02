import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/app_state.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/e_db/ldb/api/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/api/ldb_ops.dart' as LDBOps;
import 'package:bldrs/f_helpers/drafters/device_checkers.dart' as DeviceChecker;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/x_dashboard/a_modules/n_app_controls/app_controls_fire_ops.dart';
import 'package:bldrs/x_dashboard/a_modules/n_app_controls/app_controls_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
class GeneralProvider extends ChangeNotifier {
// -----------------------------------------------------------------------------

  /// APP STATE

  // -------------------------------------
  static Future<AppState> fetchGlobalAppState({
    @required BuildContext context,
    @required bool assignToUser,
  }) async {

    AppState _appState;

    final List<Map<String, dynamic>> _maps = await LDBOps.readAllMaps(
        docName: LDBDoc.appState,
    );

    if (Mapper.canLoopList(_maps) == true){
      _appState = AppState.fromMap(_maps.first);
    }

    else {

      final Map<String, dynamic> _appStateMap = await Fire.readDoc(
        context: context,
        collName: FireColl.admin,
        docName: FireDoc.admin_appState,
      );

      _appState = AppState.fromMap(_appStateMap);

      if (_appState != null){
        await LDBOps.insertMap(
            docName: LDBDoc.appState,
            input: _appStateMap,
        );
      }

    }


    if (_appState != null && assignToUser == true){
      _appState = _appState.copyWith(
        id: 'user',
      );
    }

    return _appState;
  }
// -----------------------------------------------------------------------------

  /// APP CONTROLS

  // -------------------------------------
  static Future<AppControlsModel> fetchAppControls({
    @required BuildContext context,
  }) async {

    AppControlsModel _model;

    final List<Map<String, dynamic>> _maps = await LDBOps.readAllMaps(
        docName: LDBDoc.appControls,
    );

    if (Mapper.canLoopList(_maps) == true){
      final Map<String, dynamic> _map = _maps.first;
      _model = AppControlsModel.decipherAppControlsModel(_map);
    }

    else {
      _model = await AppControlsFireOps.readAppControls(context);

      if (_model != null){
        await LDBOps.insertMap(
            docName: LDBDoc.appControls,
            input: _model.toMap(),
        );
      }

    }

    return _model;
  }
  // -------------------------------------
  AppControlsModel _appControls;
  // -------------------------------------
  AppControlsModel get appControls => _appControls;
  // -------------------------------------
  Future<void> fetchSetAppControls({
    @required BuildContext context,
    @required bool notify,
  }) async {

    final AppControlsModel _controls = await fetchAppControls(context: context);

    _appControls = _controls;

    if (notify == true){
      notifyListeners();
    }

  }
  // -------------------------------------
  static AppControlsModel proGerAppControls(BuildContext context, {bool listen = true}){
    final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: listen);
    return _generalProvider.appControls;
  }
  // -----------------------------------------------------------------------------

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
