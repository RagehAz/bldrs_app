import 'package:basics/helpers/widgets/sensors/connectivity_sensor.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/c_protocols/main_providers/general_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:flutter/material.dart';

class PreLayout extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PreLayout({
    required this.child,
    this.onBack,
    this.canGoBack = true,
    this.connectivitySensorIsOn = false,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Widget? child;
  final bool canGoBack;
  final Function? onBack;
  final bool connectivitySensorIsOn;
  // --------------------------------------------------------------------------
  static Future<void> onGoBack({
    required Function? onBack,
    required bool canGoBack,
  }) async {

    if (onBack != null){
      await onBack.call();
    }

    else {

      await Keyboard.closeKeyboard();

      if (canGoBack == true){
        await Nav.goBack(
          context: getMainContext(),
          invoker: 'MainLayout._onBack',
        );
      }

    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      key: const ValueKey<String>('PreLayout'),
      onWillPop: () async {
        await onGoBack(
          canGoBack: canGoBack,
          onBack: onBack,
        );
        return false;
      },
      child: GestureDetector(
        onTap: () async  {

          await Keyboard.closeKeyboard();
          UiProvider.proSetPyramidsAreExpanded(setTo: false, notify: true);

        },
        child: SafeArea(
          // key: ,
          // bottom: ,
          // left: ,
          // maintainBottomViewPadding: ,
          // minimum: ,
          // right: ,
          // top: ,
          child: ConnectivitySensor(
            onConnectivityChanged: connectivitySensorIsOn == false ?
                null
                :
                (bool isConnected) => GeneralProvider.onConnectivityChanged(
                  isConnected: isConnected,
                ),
            child: child,
          ),
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
