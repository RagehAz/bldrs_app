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
  RegExp exp = RegExp("[a-zA-Z]");
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
