import 'dart:async';
import 'package:bldrs/b_views/z_components/dialogs/nav_dialog/nav_dialog.dart';
import 'package:bldrs/d_providers/general_provider.dart';
import 'package:bldrs/f_helpers/drafters/device_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bldrs/f_helpers/drafters/device_checkers.dart' as DeviceChecker;

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
  ValueNotifier<bool> _isConnected;
  StreamSubscription<ConnectivityResult> subscription;
  GeneralProvider  _generalProvider;
// -----------------------------------------------------------------------------
  @override
  void initState() {

    _generalProvider = Provider.of<GeneralProvider>(context, listen: false);

    initConnectivity();

    subscription = Connectivity().onConnectivityChanged
        .listen((ConnectivityResult result) async {

          final bool _connected = await checkConnectivity(
            context: context,
          );

          await _onConnectivityChanged(_connected);

          blog('CONNECTIVITY HAD CHANGED TO : ${result.toString()}');

        });

    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  Future<void> initConnectivity() async {

    if (mounted == true) {

      final bool _connected = await DeviceChecker.checkConnectivity(
        context: context,
      );

      _isConnected = ValueNotifier(_connected);
      _generalProvider.setConnectivity(
          isConnected: _connected,
          notify: true,
      );

    }

  }
// -----------------------------------------------------------------------------
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
          NavDialog.showNavDialog(
            context: context,
            firstLine: 'Connected',
            color: Colorz.green255,
            // seconds: 2,
          );
        }
        /// SHOW DISCONNECTED DIALOG
        else {
          NavDialog.showNavDialog(
            context: context,
            firstLine: 'Disconnected',
            secondLine: 'Check your Internet connection',
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
