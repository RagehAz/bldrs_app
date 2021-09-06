import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as international;

class TextChecker{
// -----------------------------------------------------------------------------
  static bool textIsEnglish (String val){
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
// -----------------------------------------------------------------------------
  static bool textControllerHasNoValue(TextEditingController controller){
    bool controllerIsEmpty =
    controller == null || controller.text == '' || controller.text.length == 0 ||
        TextMod.firstCharacterAfterRemovingSpacesFromAString(controller.text) == '' ||
        TextMod.firstCharacterAfterRemovingSpacesFromAString(controller.text) == null
        ?
    true : false;
    return controllerIsEmpty;
  }
// -----------------------------------------------------------------------------
  static void disposeControllerIfPossible(TextEditingController controller){
    if(controller != null){
      if(TextChecker.textControllerHasNoValue(controller) == true){
        controller.dispose();
      }
    }
  }
// -----------------------------------------------------------------------------
  static void disposeAllTextControllers(List<TextEditingController> controllers){

    if(controllers != null){
      controllers.forEach((controller) {
        disposeControllerIfPossible(controller);
      });
    }

  }
// -----------------------------------------------------------------------------
  static List<TextEditingController> createEmptyTextControllers(int length){
    List<TextEditingController> _controllers = [];

    for (int i = 0; i <= length; i++){

      if (i == 0){
        _controllers.add(TextEditingController());
      }

      else {
        _controllers.add(TextEditingController());
      }

    }

    return _controllers;
  }
// -----------------------------------------------------------------------------
  /// createTextControllersAndOverrideOneString
//   static List<TextEditingController> createTextControllersAndOverrideOneString({int length, int indexToOverride, String overridingString}){
//     List<TextEditingController> _controllers = [];
//
//     for (int i = 0; i < length; i++){
//
//       if (i == indexToOverride){
//         _controllers.add(TextEditingController(text: overridingString));
//       }
//
//       else {
//         _controllers.add(TextEditingController());
//       }
//
//     }
//
//     return _controllers;
//   }
// -----------------------------------------------------------------------------
  static bool stringHasNoValue(String val){
    bool controllerIsEmpty =
    val == null || val == '' || val.length == 0 ||
        TextMod.firstCharacterAfterRemovingSpacesFromAString(val) == '' ||
        TextMod.firstCharacterAfterRemovingSpacesFromAString(val) == null
        ?
    true : false;
    return controllerIsEmpty;
  }
// -----------------------------------------------------------------------------
  static bool textStartsInArabic (String val){

    /// \p{N} will match any unicode numeric digit.
    // String _reg = r"^[\u0621-\u064A\s\p{N}]+$" ;

    /// To match only ASCII digit use:
    // String _reg = r"^[\u0621-\u064A\s0-9]+$" ;

    /// this gets all arabic and english together
    // String _reg = r"^[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z]+[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z-_]*$" ;

    /// others
    // String _reg = r"^[\u0621-\u064A\u0660-\u0669 ]+$";
    // "[\u0600-\u06ff]|[\u0750-\u077f]|[\ufb50-\ufc3f]|[\ufe70-\ufefc]"

    /// This works for Arabic/Persian even numbers.
    String _reg = r"^[؀-ۿ]+$" ;

    RegExp exp = RegExp(_reg, unicode: false, multiLine: true);
    // bool isArabic;

    String _firstCharacter = TextMod.firstCharacterAfterRemovingSpacesFromAString(val);

    return
      _firstCharacter == null  || _firstCharacter == '' ? false :
      exp.hasMatch(_firstCharacter) == true ? true : false;

  }
// -----------------------------------------------------------------------------
  static bool textStartsInEnglish (String val){
    // bool isEnglish;
    String _reg = r"[a-zA-Z]";
    RegExp exp = RegExp(_reg, unicode: false, multiLine: true);
    String _firstCharacter = TextMod.firstCharacterAfterRemovingSpacesFromAString(val);

    return
      _firstCharacter == null  || _firstCharacter == '' ? false :
      exp.hasMatch(_firstCharacter) == true ? true : false;

  }
// -----------------------------------------------------------------------------
  /// TASK : textIsRTL is not tested yet
  static bool textIsRTL(String text) {
    return international.Bidi.detectRtlDirectionality(text);
  }
// -----------------------------------------------------------------------------
  static bool stringContainsSubString({String string, String subString, bool caseSensitive, bool multiLine = false}){
    bool _itContainsIt = string.contains(new RegExp(subString, caseSensitive: caseSensitive, multiLine: multiLine));

    return _itContainsIt;
  }
// -----------------------------------------------------------------------------
}
