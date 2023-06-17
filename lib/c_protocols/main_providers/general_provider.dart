import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/flyer_protocols/provider/flyers_provider.dart';
import 'package:bldrs/c_protocols/note_protocols/provider/notes_provider.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/f_helpers/theme/words.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:devicer/devicer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
/// => TAMAM
// final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
class GeneralProvider extends ChangeNotifier {
  // -----------------------------------------------------------------------------

  /// CONNECTIVITY

  // --------------------
  bool _isConnected = true;
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
  /// TESTED : WORKS PERFECT
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
  /// TESTED : WORKS PERFECT
  static Future<void> onConnectivityChanged({
    @required bool isConnected,
  }) async {

    final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(getMainContext(), listen: false);

    final bool _wasConnected = _generalProvider.isConnected;

    if (_wasConnected != isConnected){
      _generalProvider.setConnectivity(
        isConnected: isConnected,
        notify: true,
      );

      /// SHOW CONNECTED DIALOG
      if (isConnected == true) {
        await TopDialog.showTopDialog(
          firstVerse: Verse.plain(Words.connected()),
          color: Colorz.green255,
          textColor: Colorz.white255,
          // seconds: 2,
        );
      }

      /// SHOW DISCONNECTED DIALOG
      else {
        await TopDialog.showTopDialog(
          firstVerse: Verse.plain(Words.disconnected()),
          secondVerse: Verse.plain(Words.checkYourInternetConnection()),
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
    @required bool notify,
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

    /// PhraseProvider
    PhraseProvider.wipeOut(notify: true);
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
    /// BzzProvider
    BzzProvider.wipeOut(notify: true);
    /// FlyersProvider
    FlyersProvider.wipeOut(notify: true);
    /// ChainsProvider
    ChainsProvider.wipeOut(notify: true);

  }
  // -----------------------------------------------------------------------------
}
