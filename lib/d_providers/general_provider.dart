import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/app_state.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/f_helpers/drafters/device_checkers.dart' as DeviceChecker;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bldrs/e_db/ldb/api/ldb_ops.dart' as LDBOps;
import 'package:bldrs/e_db/ldb/api/ldb_doc.dart' as LDBDoc;

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

      final Map<String, dynamic> _appStateMap = await readDoc(
        context: context,
        collName: FireColl.admin,
        docName: FireDoc.admin_appState,
      );

      _appState = AppState.fromMap(_appStateMap);

      if (_appState != null){
        await LDBOps.insertMap(
            primaryKey: 'id',
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
