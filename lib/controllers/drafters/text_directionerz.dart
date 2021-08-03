import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:flutter/material.dart';

import 'text_checkers.dart';
import 'text_manipulators.dart';
// -----------------------------------------------------------------------------
/// TASK : need to test this method to detect text direction
// import 'package:intl/intl.dart' as international;
// bool isRTL(String text) {
//   return international.Bidi.detectRtlDirectionality(text);
// }
// -----------------------------------------------------------------------------
bool appIsLeftToRight(BuildContext context){
  return Wordz.textDirection(context) == 'ltr' ? true : false;
}
// -----------------------------------------------------------------------------
TextDirection superTextDirection(BuildContext context){
  if (appIsLeftToRight(context))
  {return TextDirection.ltr;}
  else
  {return TextDirection.rtl;}
}
// -----------------------------------------------------------------------------
TextDirection superInverseTextDirection(BuildContext context){
  if (appIsLeftToRight(context))
  {return TextDirection.rtl;}
  else
  {return TextDirection.ltr;}
}
// -----------------------------------------------------------------------------
/// if keyboard lang is ltr ? ltr : rtl
/// On native iOS the current keyboard language can be gotten from
/// UITextInputMode
/// and listened to with
/// UITextInputCurrentInputModeDidChangeNotification.
/// On native Android you can use
/// getCurrentInputMethodSubtype
/// to get the keyboard language, but I'm not seeing a way to listen
/// to keyboard language changes.
TextDirection superTextDirectionSwitcherByController(TextEditingController controller){
  TextDirection _textDirection;

  bool controllerIsEmpty = TextChecker.textControllerHasNoValue(controller);

  if (!controllerIsEmpty){

    String _string = controller.text;

    String _trimmedVal = TextMod.removeSpacesFromAString(_string.trim());

    String _firstCharacter = TextMod.firstCharacterOfAString(_trimmedVal);

    // String _val = _trimmedVal; // first character defines the direction

    // print('_firstCharacter is ($_firstCharacter)');

    if(TextChecker.textStartsInEnglish(_firstCharacter)){
      _textDirection = TextDirection.ltr;
    } else if (TextChecker.textStartsInArabic(_firstCharacter)){
      _textDirection = TextDirection.rtl;
    } else {
      _textDirection = null;
    }

  } else {_textDirection = null;}

  return _textDirection;
}
// -----------------------------------------------------------------------------
TextDirection superTextDirectionSwitcher(String val){
  TextDirection _textDirection;

  // bool _appIsLeftToRight = appIsLeftToRight(context);
  // TextDirection _defaultByLang = _appIsLeftToRight == true ? TextDirection.ltr : TextDirection.rtl;


  bool controllerIsEmpty = TextChecker.stringHasNoValue(val);

  /// when val has a value
  if (!controllerIsEmpty){

    String _string = val;

    String _trimmedVal = TextMod.removeSpacesFromAString(_string.trim());

    String _firstCharacter = TextMod.firstCharacterOfAString(_trimmedVal);

    // String _val = _trimmedVal; // first character defines the direction

    // print('_firstCharacter is ($_firstCharacter)');

    if(TextChecker.textStartsInEnglish(_firstCharacter)){
      _textDirection = TextDirection.ltr;
    } else if (TextChecker.textStartsInArabic(_firstCharacter)){
      _textDirection = TextDirection.rtl;
    } else {
      // _textDirection = _defaultByLang; // can not check app is left to right in initState of SuperTextField

      _textDirection = TextDirection.ltr; // instead of null
    }

  }

  /// when val is empty
  else {
    // _textDirection = _defaultByLang; // can not check app is left to right in initState of SuperTextField
    _textDirection = TextDirection.ltr; // instead of null

  }


  return _textDirection;
}
// -----------------------------------------------------------------------------
