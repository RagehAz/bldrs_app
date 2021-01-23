import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:flutter/material.dart';
// === === === === === === === === === === === === === === === === === === ===
Alignment superTopAlignment(BuildContext context){
  return
  Wordz.textDirection(context) == 'ltr' ? Alignment.topLeft : Alignment.topRight;
}
// === === === === === === === === === === === === === === === === === === ===
Alignment superCenterAlignment(BuildContext context){
  return
    Wordz.textDirection(context) == 'ltr' ? Alignment.centerLeft : Alignment.centerRight;
}
// === === === === === === === === === === === === === === === === === === ===
Alignment superInverseCenterAlignment(BuildContext context){
  return
    Wordz.textDirection(context) == 'ltr' ? Alignment.centerRight : Alignment.centerLeft;
}
// === === === === === === === === === === === === === === === === === === ===
Alignment superInverseTopAlignment(BuildContext context){
  return
    Wordz.textDirection(context) == 'ltr' ? Alignment.topRight : Alignment.topLeft;
}
// === === === === === === === === === === === === === === === === === === ===
