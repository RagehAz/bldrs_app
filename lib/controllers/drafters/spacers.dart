import 'package:bldrs/controllers/drafters/text_directionerz.dart';
import 'package:flutter/material.dart';

abstract class Spacers {
// -----------------------------------------------------------------------------
  static EdgeInsets superPadding({BuildContext context, double enLeft, double enRight, double top, double bottom}){
    return
      appIsLeftToRight(context) ?

      EdgeInsets.only(left: enLeft,right: enRight,top: top, bottom: bottom)
          :
      EdgeInsets.only(left: enRight,right: enLeft,top: top, bottom: bottom);
  }
// -----------------------------------------------------------------------------
}