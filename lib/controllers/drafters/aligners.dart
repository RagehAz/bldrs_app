import 'package:flutter/material.dart';
import 'text_directionerz.dart';

class Aligners{
  // === === === === === === === === === === === === === === === === === === ===
  static Alignment superTopAlignment(BuildContext context){
    return
      appIsLeftToRight(context) ? Alignment.topLeft : Alignment.topRight;
  }
// === === === === === === === === === === === === === === === === === === ===
  static Alignment superCenterAlignment(BuildContext context){
    return
      appIsLeftToRight(context) ? Alignment.centerLeft : Alignment.centerRight;
  }
// === === === === === === === === === === === === === === === === === === ===
  static Alignment superInverseCenterAlignment(BuildContext context){
    return
      appIsLeftToRight(context) ? Alignment.centerRight : Alignment.centerLeft;
  }
// === === === === === === === === === === === === === === === === === === ===
  static Alignment superInverseTopAlignment(BuildContext context){
    return
      appIsLeftToRight(context) ? Alignment.topRight : Alignment.topLeft;
  }
// === === === === === === === === === === === === === === === === === === ===
}