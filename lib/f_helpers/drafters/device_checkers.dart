import 'dart:io';
import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class DeviceChecker {
  // -----------------------------------------------------------------------------

  const DeviceChecker();

  // -----------------------------------------------------------------------------

  /// DEVICE OS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool deviceIsIOS(){
    bool _isIOS;

    if (Platform.isIOS == true){
      _isIOS = true;
    }

    else {
      _isIOS = false;
    }

    return _isIOS;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool deviceIsAndroid(){
    bool _inAndroid;

    if (Platform.isAndroid == true){
      _inAndroid = true;
    }

    else {
      _inAndroid = false;
    }

    return _inAndroid;
  }
  // -----------------------------------------------------------------------------

  /// SCREEN DIRECTION

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool deviceIsLandscape(BuildContext context){
    final MediaQueryData _mediaQuery = MediaQuery.of(context);

    bool _isLandscape;

    if (_mediaQuery.orientation == Orientation.landscape){
      _isLandscape = true;
    }

    else {
      _isLandscape = false;
    }

    return _isLandscape;
  }
  // -----------------------------------------------------------------------------

  /// CONNECTIVITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkConnectivity({
    @required BuildContext context,
    ConnectivityResult streamResult,
  }) async {

    bool _connected = false;
    ConnectivityResult _result;

    await tryAndCatch(
        context: context,
        functions: () async {
          _result = streamResult ?? await Connectivity().checkConnectivity();
        },
        onError: (String error){
          blog('DISCONNECTED : $error');
        }
    );


    /// THROUGH MOBILE NETWORK
    if (_result == ConnectivityResult.mobile) {
      _connected = true;
    }

    /// THROUGH WIFI
    else if (_result == ConnectivityResult.wifi) {
      _connected = true;
    }

    /// THROUGH BLUETOOTH
    else if (_result == ConnectivityResult.bluetooth){
      _connected = true;
    }

    /// THROUGH ETHERNET
    else if (_result == ConnectivityResult.ethernet){
      _connected = true;
    }

    /// NOT CONNECTED
    else if (_result == ConnectivityResult.none){
      _connected = false;
    }

    else {
      _connected = false;
    }

    return _connected;
  }
  // -----------------------------------------------------------------------------
}
