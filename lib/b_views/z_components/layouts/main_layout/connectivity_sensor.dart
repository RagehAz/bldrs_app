import 'dart:async';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/general_provider.dart';
import 'package:bldrs/f_helpers/drafters/device_checkers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef ConnectivityBuilder = Widget Function(
    bool connected,
    Widget child,
    );

class ConnectivitySensor extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ConnectivitySensor({
    this.builder,
    this.child,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Widget child;
  final ConnectivityBuilder builder;
  /// --------------------------------------------------------------------------
  @override
  _ConnectivitySensorState createState() => _ConnectivitySensorState();
  /// --------------------------------------------------------------------------
}

class _ConnectivitySensorState extends State<ConnectivitySensor> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isConnected = ValueNotifier(null);
  StreamSubscription<ConnectivityResult> subscription;
  GeneralProvider  _generalProvider;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _generalProvider = Provider.of<GeneralProvider>(context, listen: false);

    initConnectivity();

    subscription = DeviceChecker.getConnectivity().onConnectivityChanged
        .listen((ConnectivityResult result) async {

          final bool _connected = await DeviceChecker.checkConnectivity();

          await _onConnectivityChanged(_connected);

          // blog('CONNECTIVITY HAD CHANGED TO : ${result.toString()}');

        });

  }
  // --------------------
  @override
  void dispose() {
    _isConnected.dispose();
    subscription.cancel();
    // _generalProvider.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> initConnectivity() async {

    final bool _connected = await DeviceChecker.checkConnectivity();

    if (mounted == true) {
      _isConnected.value = _connected;
        _generalProvider.setConnectivity(
          isConnected: _connected,
          notify: true,
        );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onConnectivityChanged(bool isConnected) async {

    if (mounted == true){

      /// ASSIGN LOCAL VALUE
      _isConnected.value = isConnected;

      /// IF PROVIDER VALUE IS NOT UPDATED
      if (isConnected != _generalProvider.isConnected){

        /// ASSIGN PROVIDER VALUE
        _generalProvider.setConnectivity(
          isConnected: isConnected,
          notify: true,
        );

        /// SHOW CONNECTED DIALOG
        if (isConnected == true){
          await TopDialog.showTopDialog(
            context: context,
            firstVerse: const Verse(
              text: 'phid_connected',
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
              text: 'phid_disconnected',
              translate: true,
            ),
            secondVerse: const Verse(
              text: 'phid_check_your_internet_connection',
              translate: true,
            ),
            color: Colorz.red255,
          );
        }

      }

    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (widget.builder == null){
      return widget.child;
    }

    else if (_isConnected == null){
      return widget.builder(false, widget.child);
    }

    else {

      return ValueListenableBuilder(
          valueListenable: _isConnected,
          child: widget.child,
          builder: (_, bool connected, Widget child){

            return widget.builder(connected, child);

          }
          );

    }

  }
// -----------------------------------------------------------------------------
}

/*
// -----------------------------------------------------------------------------
Future<void> _initializeConnectivity({
  @required BuildContext context,
  @required bool mounted,
}) async {

  final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
  await _generalProvider.getSetConnectivity(
    context: context,
    mounted: mounted,
    notify: true,
  );

}
// -----------------------------------------------------------------------------
Future<void> connectivityListener({
  @required ConnectivityResult streamResult,
  @required BuildContext context,
  @required bool mounted,
}) async {

  final bool _connected = await DeviceChecker.checkConnectivity(
    context: context,
    streamResult: streamResult,
  );

  final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
  _generalProvider.setConnectivity(
    isConnected: _connected,
    notify: true,
  );

  // blog('CONNECTIVITY HAD CHANGED TO : ${streamResult.toString()}');

}
// -----------------------------------------------------------------------------
 */
