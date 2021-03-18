import 'dart:io';
import 'package:flutter/cupertino.dart';
// ----------------------------------------------------------------------------
bool deviceIsIOS(){
  return
      Platform.isIOS ? true : false;
}
// ----------------------------------------------------------------------------
bool deviceIsAndroid(){
  return
    Platform.isAndroid ? true : false;
}
// ----------------------------------------------------------------------------
bool deviceIsLandscape(BuildContext context){
  final _mediaQuery = MediaQuery.of(context);
  return
      _mediaQuery.orientation == Orientation.landscape ? true : false;
}
// ----------------------------------------------------------------------------
