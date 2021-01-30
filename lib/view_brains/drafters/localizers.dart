import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:flutter/material.dart';
// === === === === === === === === === === === === === === === === === === ===
bool appIsLeftToRight(BuildContext context){
  return Wordz.textDirection(context) == 'ltr' ? true : false;
}
// === === === === === === === === === === === === === === === === === === ===
TextDirection superTextDirection(BuildContext context){
  if (Wordz.textDirection(context) == 'ltr')
  {return TextDirection.ltr;}
  else
  {return TextDirection.rtl;}
}
// === === === === === === === === === === === === === === === === === === ===
TextDirection superInverseTextDirection(BuildContext context){
  if (Wordz.textDirection(context) == 'ltr')
  {return TextDirection.rtl;}
  else
  {return TextDirection.ltr;}
}
// === === === === === === === === === === === === === === === === === === ===
