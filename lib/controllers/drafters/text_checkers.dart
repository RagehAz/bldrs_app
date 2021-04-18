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
        firstCharacterAfterRemovingSpacesFromAString(controller.text) == '' ||
        firstCharacterAfterRemovingSpacesFromAString(controller.text) == null
        ?
    true : false;
    return controllerIsEmpty;
  }
// -----------------------------------------------------------------------------
  static bool stringHasNoValue(String val){
    bool controllerIsEmpty =
    val == null || val == '' || val.length == 0 ||
        firstCharacterAfterRemovingSpacesFromAString(val) == '' ||
        firstCharacterAfterRemovingSpacesFromAString(val) == null
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

    String _firstCharacter = firstCharacterAfterRemovingSpacesFromAString(val);

    return
      _firstCharacter == null  || _firstCharacter == '' ? false :
      exp.hasMatch(_firstCharacter) == true ? true : false;

  }
// -----------------------------------------------------------------------------
  static bool textStartsInEnglish (String val){
    // bool isEnglish;
    String _reg = r"[a-zA-Z]";
    RegExp exp = RegExp(_reg, unicode: false, multiLine: true);
    String _firstCharacter = firstCharacterAfterRemovingSpacesFromAString(val);

    return
      _firstCharacter == null  || _firstCharacter == '' ? false :
      exp.hasMatch(_firstCharacter) == true ? true : false;

  }
// -----------------------------------------------------------------------------
  static bool listsAreTheSame(List<dynamic> list1, List<dynamic> list2){
    bool listsAreTheSame = true;

    if (list1.length == list2.length){

      for (int i = 0; i < list1.length; i++){

        if(list1[i] != list2[i]){
          listsAreTheSame = false;
          break;
        }

      }

    } else {
      listsAreTheSame = false;
    }

    return listsAreTheSame;
  }
// -----------------------------------------------------------------------------
  /// TASK : textIsRTL is not tested yet
  static bool textIsRTL(String text) {
    return international.Bidi.detectRtlDirectionality(text);
  }
// -----------------------------------------------------------------------------
}
