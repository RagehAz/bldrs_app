import 'package:bldrs/view_brains/drafters/text_directionz.dart';
import 'package:flutter/material.dart';

// === === === === === === === === === === === === === === === === === === ===
/// TO MINIMIZE KEYBOARD WHEN TAPPING OUTSIDE
/// USE THIS TO CALL THE FUNCTION TO PASS THE context
///  onTap: () => minimizeKeyboardOnTapOutSite(context),
void minimizeKeyboardOnTapOutSide (BuildContext context){
FocusScope.of(context).requestFocus(FocusNode());
  // // ANOTHER SOLUTION
  // FocusScopeNode currentFocus = FocusScope.of(context);
  // if(!currentFocus.hasPrimaryFocus){
  //   currentFocus.unfocus();
  // }
}
// === === === === === === === === === === === === === === === === === === ===
void closeKeyboard(BuildContext context){
  FocusScope.of(context).unfocus();
}
// === === === === === === === === === === === === === === === === === === ===
// HOW TO DETECT CURRENT KEYBOARD LANGUAGE OF THE DEVICE (NOT SOLVED)
// BEST COMMENT HERE https://github.com/flutter/flutter/issues/25841
// justinmc commented on Jul 9, 2020 •
// On native iOS the current keyboard language can be gotten from [UITextInputMode]
// and listened to with UITextInputCurrentInputModeDidChangeNotification.
//
// On native Android you can use [getCurrentInputMethodSubtype] to get the keyboard
// language, but I'm not seeing a way to listen to keyboard language changes.
// Does anyone know if it's possible to listen for a keyboard language change
// on native Android?
bool textIsEnglish (String val){
  RegExp exp = RegExp("[a-zA-Z]", multiLine: true, unicode: true);
  bool textIsEnglish;

  /// if you want to check the last character input by user let the [characterNumber = val.length-1;]
  int characterNumber = 0;

  if(exp.hasMatch(val.substring(characterNumber)) && val.substring(characterNumber) != " "){
    textIsEnglish = true;
  }
  else if (!exp.hasMatch(val.substring(characterNumber)) && val.substring(characterNumber) != " ")
  {
    textIsEnglish = false;
  }
  return textIsEnglish;
}
// === === === === === === === === === === === === === === === === === === ===
bool textControllerHasNoValue(TextEditingController controller){
  bool controllerIsEmpty =
  controller == null || controller.text == '' || controller.text.length == 0 ||
  firstCharacterAfterRemovingSpacesFromAString(controller.text) == '' ||
      firstCharacterAfterRemovingSpacesFromAString(controller.text) == null
      ?
  true : false;
  return controllerIsEmpty;
}
// === === === === === === === === === === === === === === === === === === ===
bool stringHasNoValue(String val){
  bool controllerIsEmpty =
  val == null || val == '' || val.length == 0 ||
      firstCharacterAfterRemovingSpacesFromAString(val) == '' ||
      firstCharacterAfterRemovingSpacesFromAString(val) == null
      ?
  true : false;
  return controllerIsEmpty;
}
// === === === === === === === === === === === === === === === === === === ===
bool textStartsInArabic (String val){

  /// \p{N} will match any unicode numeric digit.
  // String _reg = r"^[\u0621-\u064A\s\p{N}]+$" ;

  /// To match only ASCII digit use:
  // String _reg = r"^[\u0621-\u064A\s0-9]+$" ;

  /// this gets all arabic and english together
  // String _reg = r"^[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z]+[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z-_]*$" ;

  // others
  // String _reg = r"^[\u0621-\u064A\u0660-\u0669 ]+$";
  // "[\u0600-\u06ff]|[\u0750-\u077f]|[\ufb50-\ufc3f]|[\ufe70-\ufefc]"

  /// This works for Arabic/Persian even numbers.
  String _reg = r"^[؀-ۿ]+$" ;

  RegExp exp = RegExp(_reg, unicode: false, multiLine: true);
  bool isArabic;

  String _firstCharacter = firstCharacterAfterRemovingSpacesFromAString(val);

  // if(exp.hasMatch(_firstCharacter)
  //     // && val.substring(characterNumber) != " "
  // ){
  //   isArabic = true;
  // }
  // // else if (!exp.hasMatch(val.substring(characterNumber)) && val.substring(characterNumber) != " ")
  // else
  // {
  //   isArabic = false;
  // }

  return
    _firstCharacter == null  || _firstCharacter == '' ? false :
    exp.hasMatch(_firstCharacter) == true ? true : false;

}
// === === === === === === === === === === === === === === === === === === ===
bool textStartsInEnglish (String val){
  bool isEnglish;
  String _reg = r"[a-zA-Z]";
  RegExp exp = RegExp(_reg, unicode: false, multiLine: true);
  String _firstCharacter = firstCharacterAfterRemovingSpacesFromAString(val);

  // if (){
  // }
  // else if(exp.hasMatch(_firstCharacter)){
  //   isEnglish = true;
  // } else {
  //   isEnglish = false;
  // }

  return
    _firstCharacter == null  || _firstCharacter == '' ? false :
    exp.hasMatch(_firstCharacter) == true ? true : false;

}
// === === === === === === === === === === === === === === === === === === ===
