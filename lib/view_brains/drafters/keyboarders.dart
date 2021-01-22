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
  bool textIsEnglish = true;

  if(exp.hasMatch(val.substring(val.length-1)) && val.substring(val.length-1) != " "){
    textIsEnglish = true;
  }
  else if (val.substring(val.length-1) != " " && !exp.hasMatch(val.substring(val.length-1)))
  {
    textIsEnglish = false;
  }
  print(exp.hasMatch(val.substring(val.length-1)).toString());
  return textIsEnglish;
}
// === === === === === === === === === === === === === === === === === === ===
