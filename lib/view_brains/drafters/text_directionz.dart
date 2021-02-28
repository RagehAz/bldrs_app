import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:flutter/material.dart';
import 'keyboarders.dart';
// === === === === === === === === === === === === === === === === === === ===
bool appIsLeftToRight(BuildContext context){
  return Wordz.textDirection(context) == 'ltr' ? true : false;
}
// === === === === === === === === === === === === === === === === === === ===
TextDirection superTextDirection(BuildContext context){
  if (appIsLeftToRight(context))
  {return TextDirection.ltr;}
  else
  {return TextDirection.rtl;}
}
// === === === === === === === === === === === === === === === === === === ===
TextDirection superInverseTextDirection(BuildContext context){
  if (appIsLeftToRight(context))
  {return TextDirection.rtl;}
  else
  {return TextDirection.ltr;}
}
// === === === === === === === === === === === === === === === === === === ===
/// if keyboard lang is ltr ? ltr : rtl
/// On native iOS the current keyboard language can be gotten from
/// UITextInputMode
/// and listened to with
/// UITextInputCurrentInputModeDidChangeNotification.
/// On native Android you can use
/// getCurrentInputMethodSubtype
/// to get the keyboard language, but I'm not seeing a way to listen
/// to keyboard language changes.
TextDirection superTextDirectionSwitcher(TextEditingController controller){
  TextDirection _textDirection;

  bool controllerIsEmpty =
  controller == null || controller.text == '' || controller.text.length == 0 ?
  true : false;

  if (!controllerIsEmpty){

    String _val = controller.text[0]; // first character defines the direction

    if(textIsEnglish(_val)){
      _textDirection = TextDirection.ltr;
    } else {
      _textDirection = TextDirection.rtl;
    }

  }

  return _textDirection;
}
// === === === === === === === === === === === === === === === === === === ===
