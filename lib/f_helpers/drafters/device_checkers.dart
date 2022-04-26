import 'dart:io';
import 'package:flutter/material.dart';

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
