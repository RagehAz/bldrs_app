import 'package:bldrs/view_brains/drafters/text_directionz.dart';
import 'package:flutter/material.dart';
// === === === === === === === === === === === === === === === === === === ===
Alignment superTopAlignment(BuildContext context){
  return
  appIsLeftToRight(context) ? Alignment.topLeft : Alignment.topRight;
}
// === === === === === === === === === === === === === === === === === === ===
Alignment superCenterAlignment(BuildContext context){
  return
    appIsLeftToRight(context) ? Alignment.centerLeft : Alignment.centerRight;
}
// === === === === === === === === === === === === === === === === === === ===
Alignment superInverseCenterAlignment(BuildContext context){
  return
    appIsLeftToRight(context) ? Alignment.centerRight : Alignment.centerLeft;
}
// === === === === === === === === === === === === === === === === === === ===
Alignment superInverseTopAlignment(BuildContext context){
  return
    appIsLeftToRight(context) ? Alignment.topRight : Alignment.topLeft;
}
// === === === === === === === === === === === === === === === === === === ===
