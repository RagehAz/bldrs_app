import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:flutter/material.dart';
// === === === === === === === === === === === === === === === === === === ===
bool appIsLeftToRight(BuildContext context){
  return Wordz.textDirection(context) == 'ltr' ? true : false;
}
// === === === === === === === === === === === === === === === === === === ===
