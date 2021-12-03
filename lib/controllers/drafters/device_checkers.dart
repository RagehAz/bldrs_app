import 'dart:io';
import 'package:flutter/cupertino.dart';

abstract class DeviceChecker{
// -----------------------------------------------------------------------------
  static bool deviceIsIOS(){
    return
      Platform.isIOS ? true : false;
  }
// -----------------------------------------------------------------------------
  static bool deviceIsAndroid(){
    return
      Platform.isAndroid ? true : false;
  }
// -----------------------------------------------------------------------------
  static bool deviceIsLandscape(BuildContext context){
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    return
      _mediaQuery.orientation == Orientation.landscape ? true : false;
  }
// -----------------------------------------------------------------------------
}
