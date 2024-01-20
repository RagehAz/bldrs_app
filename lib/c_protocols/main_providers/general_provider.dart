import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/checks/device_checker.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/a_models/x_secondary/app_state_model.dart';
import 'package:bldrs/c_protocols/flyer_protocols/provider/flyers_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/note_protocols/provider/notes_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
/// => TAMAM
// final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
class GeneralProvider extends ChangeNotifier {
  // -----------------------------------------------------------------------------

  /// GLOBAL APP STATE

  // --------------------
  AppStateModel? _globalAppState;
  AppStateModel? get globalAppState => _globalAppState;
  // --------------------
  /// TESTED : WORKS PERFECT
  static AppStateModel? proGetGlobalAppState({
    required BuildContext context,
    required bool listen,
  }){
    final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: listen);
    return _generalProvider.globalAppState;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void proSetGlobalAppState({
    required AppStateModel? state,
    required BuildContext context,
  }){
    final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
    _generalProvider._setGlobalAppState(state);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _setGlobalAppState(AppStateModel? state){
    if (state != _globalAppState){
      _globalAppState = state;
      notifyListeners();
    }
  }
  // -----------------------------------------------------------------------------

  /// LOCAL ASSETS /// ERADICATE_CHAINS

  // --------------------
  // List<String> _localAssetsPaths = <String>[]; /// ERADICATE_CHAINS
  // List<String> get localAssetsPaths => _localAssetsPaths; /// ERADICATE_CHAINS
  // // --------------------
  // static bool proCheckLocalAssetExists({
  //   required String? assetName,
  // }){
  //   final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(getMainContext(), listen: false);
  //
  //   final String? _path = Filers.getLocalAssetPathFromLocalPaths(
  //       allAssetsPaths: _generalProvider.localAssetsPaths,
  //       assetName: assetName
  //   );
  //
  //   if (_path == null){
  //     return false;
  //   }
  //   else {
  //     return true;
  //   }
  //
  // }
  // // --------------------
  // static String? proGetLocalAssetPath({
  //   required String? assetName,
  // }){
  //   final List<String> _localAssetsPaths = proGetLocalAssetsPaths();
  //   final String? _path = Filers.getLocalAssetPathFromLocalPaths(
  //       allAssetsPaths: _localAssetsPaths,
  //       assetName: assetName
  //   );
  //   return _path;
  // }
  // // --------------------
  // static List<String> proGetLocalAssetsPaths(){
  //   final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(getMainContext(), listen: false);
  //   return _generalProvider.localAssetsPaths;
  // }
  // // --------------------
  // static Future<void> proGetSetLocalAssetsPaths({
  //   required bool notify,
  // }) async {
  //   final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(getMainContext(), listen: false);
  //   if (Lister.checkCanLoop(_generalProvider.localAssetsPaths) == false){
  //     await _generalProvider._getSetLocalAssetsPaths(
  //       notify: notify,
  //     );
  //   }
  // }
  // // --------------------
  // /// TESTED : WORKS PERFECT
  // Future<void> _getSetLocalAssetsPaths({
  //   required bool notify,
  // }) async {
  //
  //   final List<String> _paths = await Filers.getLocalAssetsPaths();
  //
  //   _localAssetsPaths = _paths;
  //
  //   if (notify == true){
  //     notifyListeners();
  //   }
  //
  // }
  // -----------------------------------------------------------------------------

  /// CONNECTIVITY

  // --------------------
  bool _isConnected = true;
  // --------------------
  bool get isConnected => _isConnected;
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> getSetConnectivity({
    required bool mounted,
    required bool notify,
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
  /// TESTED : WORKS PERFECT
  void setConnectivity({
    required bool isConnected,
    required bool notify,
  }) {

    if (isConnected != _isConnected) {
      _isConnected = isConnected;

      if (notify == true) {
        notifyListeners();
      }
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onConnectivityChanged({
    required bool? isConnected,
  }) async {

    final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(getMainContext(), listen: false);

    final bool _wasConnected = _generalProvider.isConnected;

    if (_wasConnected != isConnected){
      _generalProvider.setConnectivity(
        isConnected: isConnected ?? false,
        notify: true,
      );

      /// SHOW CONNECTED DIALOG
      if (Mapper.boolIsTrue(isConnected) == true) {
        await TopDialog.showTopDialog(
          firstVerse: getVerse('phid_connected')!,
          color: Colorz.green255,
          textColor: Colorz.white255,
          // seconds: 2,
        );
      }

      /// SHOW DISCONNECTED DIALOG
      else {
        await TopDialog.showTopDialog(
          firstVerse: getVerse('phid_disconnected'),
          secondVerse: getVerse('phid_checkYourInternetConnection'),
          color: Colorz.red255,
          textColor: Colorz.white255,
        );
      }
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool deviceIsConnected(){
  final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(getMainContext(), listen: false);
  return _generalProvider.isConnected;
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
  /// TESTED : WORKS PERFECT
  bool sectionIsOnline(BzSection section){
    return _onlineSections.contains(section) == true;
  }
  // -----------------------------------------------------------------------------

  /// WIPE OUT

  // --------------------
  /// TESTED : WORKS PERFECT
  static void wipeOut({
    required bool notify,
  }){

    final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(getMainContext(), listen: false);

    /// _isConnected
    _generalProvider.setConnectivity(
      isConnected: false,
      notify: notify,
    );

  }
  // -----------------------------------------------------------------------------

  /// CONTROLLING ALL PROVIDERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeOutAllProviders() async {

    /// UiProvider
    UiProvider.wipeOut(notify: true);
    /// UsersProvider
    UsersProvider.wipeOut(notify: true);
    /// GeneralProvider
    GeneralProvider.wipeOut(notify: true);
    /// NotesProvider
    await NotesProvider.wipeOut(notify: true);
    /// UsersProvider
    UsersProvider.wipeOut(notify: true);
    /// ZoneProvider
    ZoneProvider.wipeOut(notify: true);
    /// FlyersProvider
    FlyersProvider.wipeOut(notify: true);

  }
  // -----------------------------------------------------------------------------
}
