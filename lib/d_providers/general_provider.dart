import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/app_state.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/search_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_doc.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/device_checkers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/x_dashboard/n_app_controls/xxx_app_controls_fire_ops.dart';
import 'package:bldrs/x_dashboard/n_app_controls/xx_app_controls_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
class GeneralProvider extends ChangeNotifier {
  // -----------------------------------------------------------------------------

  /// APP STATE

  // --------------------
  static Future<AppState> fetchGlobalAppState({
    @required BuildContext context,
    @required bool assignToUser,
  }) async {

    AppState _appState;

    final List<Map<String, dynamic>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.appState,
    );

    if (Mapper.checkCanLoopList(_maps) == true){
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

  // --------------------
  static Future<AppControlsModel> fetchAppControls({
    @required BuildContext context,
  }) async {

    AppControlsModel _model;

    final List<Map<String, dynamic>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.appControls,
    );

    if (Mapper.checkCanLoopList(_maps) == true){
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
  // --------------------
  AppControlsModel _appControls;
  // --------------------
  AppControlsModel get appControls => _appControls;
  // --------------------
  Future<void> fetchSetAppControls({
    @required BuildContext context,
    @required bool notify,
  }) async {

    final AppControlsModel _controls = await fetchAppControls(
      context: context,
    );

    setAppControls(
      setTo: _controls,
      notify: notify,
    );

  }
  // --------------------
  void setAppControls({
    @required AppControlsModel setTo,
    @required bool notify,
  }){

    _appControls = setTo;

    if (notify == true){
      notifyListeners();
    }


  }
  // --------------------
  static AppControlsModel proGerAppControls(BuildContext context, {bool listen = true}){
    final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: listen);
    return _generalProvider.appControls;
  }
  // -----------------------------------------------------------------------------

  /// CONNECTIVITY

  // --------------------
  bool _isConnected = false;
  // --------------------
  bool get isConnected => _isConnected;
  // --------------------
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
  // --------------------
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

  // --------------------
  final List<BzSection> _onlineSections = <BzSection>[
    BzSection.realestate,
    BzSection.construction,
    BzSection.supplies,
  ];
  // --------------------
  List<BzSection> get onlineSections => _onlineSections;
  // --------------------
  bool sectionIsOnline(BzSection section){
    return _onlineSections.contains(section) == true;
  }
  // -----------------------------------------------------------------------------

  /// WIPE OUT

  // --------------------
  static void wipeOut({
    @required BuildContext context,
    @required bool notify,
  }){

    final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);

    ///_appControls
    _generalProvider.setAppControls(
      setTo: null,
      notify: false,
    );

    /// _isConnected
    _generalProvider.setConnectivity(
      isConnected: false,
      notify: notify,
    );

  }
  // -----------------------------------------------------------------------------

  /// CONTROLLING ALL PROVIDERS

  // --------------------
  static void wipeOutAllProviders(BuildContext context){

    /// PhraseProvider
    PhraseProvider.wipeOut(context: context, notify: true);
    /// UiProvider
    UiProvider.wipeOut(context: context, notify: true);
    /// UsersProvider
    UsersProvider.wipeOut(context: context, notify: true);
    /// GeneralProvider
    GeneralProvider.wipeOut(context: context, notify: true);
    /// NotesProvider
    NotesProvider.wipeOut(context: context, notify: true);
    /// UsersProvider
    UsersProvider.wipeOut(context: context, notify: true);
    /// ZoneProvider
    ZoneProvider.wipeOut(context: context, notify: true);
    /// BzzProvider
    BzzProvider.wipeOut(context: context, notify: true);
    /// FlyersProvider
    FlyersProvider.wipeOut(context: context, notify: true);
    /// ChainsProvider
    ChainsProvider.wipeOut(context: context, notify: true);
    /// SearchProvider
    SearchProvider.wipeOut(context: context, notify: true);
    // /// QuestionsProvider
    // QuestionsProvider.wipeOut(context: context, notify: true);

  }
  // -----------------------------------------------------------------------------
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
