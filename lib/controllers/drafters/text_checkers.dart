import 'package:bldrs/controllers/drafters/text_mod.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as international;

abstract class TextChecker{
// -----------------------------------------------------------------------------
  static bool textIsEnglish (String val){
    final RegExp exp = RegExp("[a-zA-Z]", multiLine: true, unicode: true);
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
  static bool textControllerIsEmpty(TextEditingController controller){
    final bool controllerIsEmpty =
    controller == null || controller.text == '' || controller.text.length == 0 ||
        TextMod.firstCharacterAfterRemovingSpacesFromAString(controller.text) == '' ||
        TextMod.firstCharacterAfterRemovingSpacesFromAString(controller.text) == null
        ?
    true : false;
    return controllerIsEmpty;
  }
// -----------------------------------------------------------------------------
  /// TASK : is this the correct way to dispose a text controller ? are you sure ?
  static void disposeControllerIfPossible(TextEditingController controller){
    if(controller != null){
      if(TextChecker.textControllerIsEmpty(controller) == true){
        controller.dispose();
      }
    }
  }
// -----------------------------------------------------------------------------
  /// TASK : this makes more sense, dispose if controller has a value => tested and does not fire an error in search screen controller,,,
  static void disposeControllerIfNotEmpty(TextEditingController controller){
    if(controller != null){
      if(TextChecker.textControllerIsEmpty(controller) == false){
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
  static bool stringIsEmpty(String val){
    final bool controllerIsEmpty =
    val == null || val == '' || val.length == 0 ||
        TextMod.firstCharacterAfterRemovingSpacesFromAString(val) == '' ||
        TextMod.firstCharacterAfterRemovingSpacesFromAString(val) == null
        ?
    true : false;
    return controllerIsEmpty;
  }
// -----------------------------------------------------------------------------
  static bool stringIsNotEmpty(String val){
    return !stringIsEmpty(val);
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
    const String _reg = r"^[؀-ۿ]+$" ;

    final RegExp _exp = RegExp(_reg, unicode: false, multiLine: true);
    // bool isArabic;

    final String _firstCharacter = TextMod.firstCharacterAfterRemovingSpacesFromAString(val);

    return
      _firstCharacter == null  || _firstCharacter == '' ? false :
      _exp.hasMatch(_firstCharacter) == true ? true : false;

  }
// -----------------------------------------------------------------------------
  static bool textStartsInEnglish (String val){
    // bool isEnglish;
    const String _reg = r"[a-zA-Z]";
    final RegExp _exp = RegExp(_reg, unicode: false, multiLine: true);
    final String _firstCharacter = TextMod.firstCharacterAfterRemovingSpacesFromAString(val);

    return
      _firstCharacter == null  || _firstCharacter == '' ? false :
      _exp.hasMatch(_firstCharacter) == true ? true : false;

  }
// -----------------------------------------------------------------------------
  /// TASK : textIsRTL is not tested yet
  static bool textIsRTL(String text) {
    return international.Bidi.detectRtlDirectionality(text);
  }
// -----------------------------------------------------------------------------
  static bool stringContainsSubString({String string, String subString, bool caseSensitive, bool multiLine = false}){
    bool _itContainsIt = false;
    // string.contains(new RegExp(subString, caseSensitive: caseSensitive, multiLine: multiLine));

    if (string != null && subString != null){

      if (string.toLowerCase().contains(subString?.toLowerCase())){
        _itContainsIt = true;
      }

    }


    final String _blah = _itContainsIt == true ? 'CONTAIN' : 'DOES NOT CONTAIN';
    print('string : $string : $_blah this : $subString');

    return _itContainsIt;
  }
// -----------------------------------------------------------------------------
  static String concludeEnglishOrArabicLingo(String text){

    final String _lingoCode =
        textStartsInArabic(text) == true ? 'ar'
            :
            textStartsInEnglish(text) == true ? 'en'
                :
                'en';

    return _lingoCode;
  }
// -----------------------------------------------------------------------------
}
