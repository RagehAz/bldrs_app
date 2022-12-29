import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

// --------------------
/// TESTED : WORKS PERFECT
EdgeInsets superMargins({dynamic margin}) {

  if (margin == null || margin == 0){
    return EdgeInsets.zero;
  }

  else if (margin.runtimeType == double){
    return EdgeInsets.all(margin);
  }

  else if (margin.runtimeType == int){
    return EdgeInsets.all(margin.toDouble());
  }

  else if (margin.runtimeType == EdgeInsets){
    return margin;
  }

  else {
    return margin;
  }

}
// --------------------
/// TESTED : WORKS PERFECT
bool stringIsEmpty(String text){

  if (text == null || text == '' || text.isEmpty == true) {
    return true;
  }

  else {
    return false;
  }

}
// --------------------
bool checkColorIsBlack(Color color) {
  bool _isBlack = false;

  const Color _black = Colorz.black255;

  if (color != null &&
      color.red == _black.red &&
      color.green == _black.green &&
      color.blue == _black.blue) {
    _isBlack = true;
  }

  return _isBlack;
}
// --------------------
