import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/a_models/x_secondary/app_state.dart';
import 'package:bldrs/a_models/x_utilities/xx_app_controls_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
// import 'package:bldrs/a_models/x_utilities/xx_app_controls_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/search_provider.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/c_protocols/app_state_protocols/real/app_controls_real_ops.dart';
import 'package:bldrs/c_protocols/app_state_protocols/real/app_state_real_ops.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/flyer_protocols/provider/flyers_provider.dart';
import 'package:bldrs/c_protocols/note_protocols/provider/notes_provider.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:ldb/ldb.dart';
import 'package:devicer/devicer.dart';
import 'package:mapper/mapper.dart';
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

    /// NOTE : NOT USED EXCEPT WHILE CREATING A NEW USER
    /// BECAUSE ( readGlobalAppState ) IS USED IN APP INITIALIZATION
    /// AS YOU NEED TO READ IT FRESHLY EVERYTIME YOU START THE APP

    AppState _appState;

    final List<Map<String, dynamic>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.appState,
    );

    if (Mapper.checkCanLoopList(_maps) == true){
      _appState = AppState.fromMap(_maps.first);
    }

    else {

      _appState = await AppStateRealOps.readGlobalAppState();

      if (_appState != null){
        await LDBOps.insertMap(
          docName: LDBDoc.appState,
          primaryKey: LDBDoc.getPrimaryKey(LDBDoc.appState),
          input: _appState.toMap(),
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
  /// TESTED : WORKS PERFECT
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
      _model = await AppControlsRealOps.readAppControls();

      if (_model != null){
        await LDBOps.insertMap(
          docName: LDBDoc.appControls,
          primaryKey: LDBDoc.getPrimaryKey(LDBDoc.appControls),
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

    if (isConnected != _isConnected) {
      _isConnected = isConnected;

      if (notify == true) {
        notifyListeners();
      }
    }

  }
  // --------------------
  static Future<void> onConnectivityChanged({
    @required BuildContext context,
    @required bool isConnected,
  }) async {

    final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);

    _generalProvider.setConnectivity(
      isConnected: isConnected,
      notify: true,
    );

    /// SHOW CONNECTED DIALOG
    if (isConnected == true){
      await TopDialog.showTopDialog(
        context: context,
        firstVerse: const Verse(
          id: 'phid_connected',
          translate: true,
        ),
        color: Colorz.green255,
        // seconds: 2,
      );
    }
    /// SHOW DISCONNECTED DIALOG
    else {
      await TopDialog.showTopDialog(
        context: context,
        firstVerse: const Verse(
          id: 'phid_disconnected',
          translate: true,
        ),
        secondVerse: const Verse(
          id: 'phid_check_your_internet_connection',
          translate: true,
        ),
        color: Colorz.red255,
      );
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

bool deviceIsConnected(BuildContext context){
  final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
  return _generalProvider.isConnected;
}
