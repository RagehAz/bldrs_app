import 'dart:io';
import 'package:bldrs/a_models/x_utilities/error_helpers.dart';
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

    if (Platform.isIOS == true){
      return true;
    }

    else {
      return false;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool deviceIsAndroid(){

    if (Platform.isAndroid == true){
      return true;
    }

    else {
      return false;
    }

  }
  // -----------------------------------------------------------------------------

  /// SCREEN DIRECTION

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool deviceIsLandscape(BuildContext context){

    final MediaQueryData _mediaQuery = MediaQuery.of(context);

    if (_mediaQuery.orientation == Orientation.landscape){
      return true;
    }

    else {
      return false;
    }

  }
  // -----------------------------------------------------------------------------

  /// CONNECTIVITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkConnectivity({
    @required BuildContext context,
    ConnectivityResult streamResult,
  }) async {

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
      return true;
    }

    /// THROUGH WIFI
    else if (_result == ConnectivityResult.wifi) {
      return true;
    }

    /// THROUGH BLUETOOTH
    else if (_result == ConnectivityResult.bluetooth){
      return true;
    }

    /// THROUGH ETHERNET
    else if (_result == ConnectivityResult.ethernet){
      return true;
    }

    /// NOT CONNECTED
    else if (_result == ConnectivityResult.none){
      return false;
    }

    else {
      return false;
    }

  }
  // -----------------------------------------------------------------------------
}
