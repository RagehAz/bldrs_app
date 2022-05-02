import 'dart:io';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
// -----------------------------------------------------------------------------
  bool deviceIsIOS(){
    bool _isIOS;

    if (Platform.isIOS == true){
      _isIOS = true;
    }

    else {
      _isIOS = false;
    }

    return _isIOS;
  }
// -----------------------------------------------------------------------------
  bool deviceIsAndroid(){
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
  bool deviceIsLandscape(BuildContext context){
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
  Future<bool> deviceIsConnected({
    ConnectivityResult streamResult,
}) async {

    bool _connected = false;

    final ConnectivityResult _result = streamResult ?? await Connectivity().checkConnectivity();

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
