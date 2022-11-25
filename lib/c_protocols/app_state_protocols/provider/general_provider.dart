import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/a_models/d_zone/b_country/flag.dart';
import 'package:bldrs/a_models/x_secondary/app_state.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/search_provider.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/flyer_protocols/provider/flyers_provider.dart';
import 'package:bldrs/c_protocols/note_protocols/provider/notes_provider.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/provider/zone_provider.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/device_checkers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/x_dashboard/app_controls/xx_app_controls_model.dart';
import 'package:bldrs/x_dashboard/app_controls/xxx_app_controls_fire_ops.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
class GeneralProvider extends ChangeNotifier {
  // -----------------------------------------------------------------------------

  /// APP STATE

  // --------------------
  /// TESTED : WORKS PERFECT
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
      _model = await AppControlsFireOps.readAppControls();

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
    @required bool mounted,
    @required bool notify,
  }) async {

    if (mounted == true){

      final bool _connected = await DeviceChecker.checkConnectivity();

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
  static Future<void> wipeOutAllProviders(BuildContext context) async {

    /// PhraseProvider
    PhraseProvider.wipeOut(context: context, notify: true);
    /// UiProvider
    UiProvider.wipeOut(context: context, notify: true);
    /// UsersProvider
    UsersProvider.wipeOut(context: context, notify: true);
    /// GeneralProvider
    GeneralProvider.wipeOut(context: context, notify: true);
    /// NotesProvider
    await NotesProvider.wipeOut(context: context, notify: true);
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

  final List<String> _allIDs = Flag.getAllCountriesIDsSortedByName(context);
  return _allIDs;

  // final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
  // final List<String> _activeIDs = _generalProvider.appState.activeCountries;
  // return _activeIDs;
}

bool deviceIsConnected(BuildContext context){
  final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
  return _generalProvider.isConnected;
}
