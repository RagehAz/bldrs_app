import 'package:bldrs/view_brains/drafters/stringers.dart';
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
TextDirection superTextDirectionSwitcherByController(TextEditingController controller){
  TextDirection _textDirection;

  bool controllerIsEmpty = textControllerHasNoValue(controller);

  if (!controllerIsEmpty){

    String _string = controller.text;

    String _trimmedVal = removeSpacesFromAString(_string.trim());

    String _firstCharacter = firstCharacterOfAString(_trimmedVal);

    String _val = _trimmedVal; // first character defines the direction

    print('_firstCharacter is ($_firstCharacter)');

    if(textStartsInEnglish(_firstCharacter)){
      _textDirection = TextDirection.ltr;
    } else if (textStartsInArabic(_firstCharacter)){
      _textDirection = TextDirection.rtl;
    } else {
      _textDirection = null;
    }

  } else {_textDirection = null;}

  return _textDirection;
}
// === === === === === === === === === === === === === === === === === === ===
String firstCharacterAfterRemovingSpacesFromAString(String string){
  String _output;

  String _stringTrimmed = string.trim();

  String _stringWithoutSpaces = removeSpacesFromAString(_stringTrimmed);

  String _firstCharacter = firstCharacterOfAString(_stringWithoutSpaces);

  _output =
  _stringWithoutSpaces == null || _stringWithoutSpaces == '' || _stringWithoutSpaces == ' '? null :
      _firstCharacter == '' ? null : _firstCharacter;

  print('string($string) - _stringTrimmed($_stringTrimmed) - _stringWithoutSpaces($_stringWithoutSpaces) - _firstCharacter($_firstCharacter) - _output($_output)');
  return
    _output;
}
// === === === === === === === === === === === === === === === === === === ===
TextDirection superTextDirectionSwitcher(String val){
  TextDirection _textDirection;

  bool controllerIsEmpty = stringHasNoValue(val);

  if (!controllerIsEmpty){

    String _string = val;

    String _trimmedVal = removeSpacesFromAString(_string.trim());

    String _firstCharacter = firstCharacterOfAString(_trimmedVal);

    String _val = _trimmedVal; // first character defines the direction

    print('_firstCharacter is ($_firstCharacter)');

    if(textStartsInEnglish(_firstCharacter)){
      _textDirection = TextDirection.ltr;
    } else if (textStartsInArabic(_firstCharacter)){
      _textDirection = TextDirection.rtl;
    } else {
      _textDirection = null;
    }

  } else {_textDirection = null;}

  return _textDirection;
}