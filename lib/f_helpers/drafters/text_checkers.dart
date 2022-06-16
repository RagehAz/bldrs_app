import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as international;
// -----------------------------------------------------------------------------

/// LANGUAGE CHECK

// -------------------------------------
bool textIsEnglish(String val) {
  final RegExp exp = RegExp('[a-zA-Z]', multiLine: true, unicode: true);
  bool textIsEnglish;

  /// if you want to check the last character input by user let the [characterNumber = val.length-1;]
  const int characterNumber = 0;

  if (exp.hasMatch(val.substring(characterNumber)) &&
      val.substring(characterNumber) != ' ') {
    textIsEnglish = true;
  }

  else if (!exp.hasMatch(val.substring(characterNumber)) &&
      val.substring(characterNumber) != ' ') {
    textIsEnglish = false;
  }

  return textIsEnglish;
}
// -------------------------------------
bool textStartsInArabic(String val) {
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
  const String _reg = r'^[؀-ۿ]+$';

  final RegExp _exp = RegExp(_reg, multiLine: true);
  // bool isArabic;

  final String _firstCharacter =
  TextMod.cutFirstCharacterAfterRemovingSpacesFromAString(val);

  bool _startInArabic;

  if (_firstCharacter == null || _firstCharacter == '') {
    _startInArabic = false;
  }

  else if (_exp.hasMatch(_firstCharacter) == true) {
    _startInArabic = true;
  }

  else {
    _startInArabic = false;
  }

  return _startInArabic;
}
// -------------------------------------
bool textStartsInEnglish(String val) {
  const String _reg = r'[a-zA-Z]';
  final RegExp _exp = RegExp(_reg, multiLine: true);
  final String _firstCharacter = TextMod.cutFirstCharacterAfterRemovingSpacesFromAString(val);

  bool _startsInEnglish;

  if (_firstCharacter == null || _firstCharacter == '') {
    _startsInEnglish = false;
  }

  else if (_exp.hasMatch(_firstCharacter) == true) {
    _startsInEnglish = true;
  }

  else {
    _startsInEnglish = false;
  }

  return _startsInEnglish;
}
// -------------------------------------
/// TASK : textIsRTL is not tested yet
bool textIsRTL(String text){
  return international.Bidi.detectRtlDirectionality(text);
}
// -------------------------------------
String concludeEnglishOrArabicLang(String text) {

  final String _lingoCode =
  textStartsInArabic(text) == true ? 'ar'
      :
  textStartsInEnglish(text) == true ?
  'en'
      :
  'en';

  return _lingoCode;
}
// -----------------------------------------------------------------------------

/// TEXT CONTROLLER CHECKERS

// -------------------------------------
bool textControllerIsEmpty(TextEditingController controller) {
  bool _controllerIsEmpty;

  if (controller == null ||
      controller.text == '' ||
      controller.text.isEmpty ||
      TextMod.cutFirstCharacterAfterRemovingSpacesFromAString(controller.text) == '' ||
      TextMod.cutFirstCharacterAfterRemovingSpacesFromAString(controller.text) == null) {
    _controllerIsEmpty = true;
  }

  else {
    _controllerIsEmpty = false;
  }

  return _controllerIsEmpty;
}
// -----------------------------------------------------------------------------

/// TEXT CONTROLLER DISPOSERS

// -------------------------------------
/// TASK : is this the correct way to dispose a text controller ? are you sure ?
void disposeControllerIfPossible(TextEditingController controller) {
  if (controller != null) {
    if (textControllerIsEmpty(controller) == true) {
      controller.dispose();
    }
  }
}
// -----------------------------------------------------------------------------
/// TASK : this makes more sense, dispose if controller has a value => tested and does not fire an error in search screen controller,,,
void disposeControllerIfNotEmpty(TextEditingController controller) {
  if (controller != null) {
    if (textControllerIsEmpty(controller) == false) {
      controller.dispose();
    }
  }
}
// -----------------------------------------------------------------------------
void disposeAllTextControllers(List<TextEditingController> controllers) {
  if (controllers != null) {
    for (final TextEditingController controller in controllers) {
      disposeControllerIfPossible(controller);
    }
  }
}
// -----------------------------------------------------------------------------

/// TEXT CONTROLLER CREATORS

// -------------------------------------
List<TextEditingController> createEmptyTextControllers(int length) {
  final List<TextEditingController> _controllers = <TextEditingController>[];

  for (int i = 0; i <= length; i++) {
    if (i == 0) {
      _controllers.add(TextEditingController());
    } else {
      _controllers.add(TextEditingController());
    }
  }

  return _controllers;
}
// -------------------------------------
/*
/// createTextControllersAndOverrideOneString
//   List<TextEditingController> createTextControllersAndOverrideOneString({int length, int indexToOverride, String overridingString}){
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
 */
// -----------------------------------------------------------------------------

/// STRING CHECKERS

// -------------------------------------
/// TESTED : WORKS PERFECT
bool stringIsEmpty(String val) {
  bool _controllerIsEmpty;

  if (
  val == null || val == '' || val.isEmpty ||
      TextMod.cutFirstCharacterAfterRemovingSpacesFromAString(val) == '' ||
      TextMod.cutFirstCharacterAfterRemovingSpacesFromAString(val) == null) {
    _controllerIsEmpty = true;
  }

  else {
    _controllerIsEmpty = false;
  }

  return _controllerIsEmpty;
}
// -------------------------------------
/// TESTED : WORKS PERFECT
bool stringIsNotEmpty(String val) {
  return !stringIsEmpty(val);
}
// -------------------------------------
/// TESTED : WORKS PERFECT
bool stringContainsSubString({
  String string,
  String subString,
}) {
  bool _itContainsIt = false;

  if (string != null && subString != null) {
    if (
    string.toLowerCase().contains(subString?.toLowerCase())
    ) {
      _itContainsIt = true;
    }
  }

  return _itContainsIt;
}
// -----------------------------------------------------------------------------
/*bool stringContainsPhraseIDKeyword({
  String string,
  String subString,
  bool caseSensitive = false,
  // bool multiLine = false
}) {
  bool _itContainsIt = false;

  if (string != null && subString != null) {

    final RegExp pattern = RegExp(r'phid_k',
      caseSensitive: caseSensitive,
      // multiLine: multiLine // mesh shaghal w mesh wa2to
    );

    // final Iterable matches = pattern.allMatches(string);

    _itContainsIt = string.contains(pattern);

    // Matcher containsSubstringNoCase(String substring) =>
    //     predicate((String expected) => expected.contains(RegExp(substring, caseSensitive: false)));

    // if (matches.isNotEmpty) {
    //   _itContainsIt = true;
    //   blog(matches);
    // }

  }

  return _itContainsIt;
}
 */
// -----------------------------------------------------------------------------
bool stringContainsSubStringRegExp({
  String string,
  String subString,
  bool caseSensitive = false,
  // bool multiLine = false
}) {
  bool _itContainsIt = false;

  if (string != null && subString != null) {

    final RegExp pattern = RegExp(subString,
      caseSensitive: caseSensitive,
      // multiLine: multiLine // mesh shaghal w mesh wa2to
    );
    final Iterable matches = pattern.allMatches(string);

    if (matches.isNotEmpty) {
      _itContainsIt = true;
    }

  }

  return _itContainsIt;
}
// -----------------------------------------------------------------------------

/// SEARCH TRIGGERS

// -------------------------------------
/// TESTED : WORKS PERFECT
bool triggerIsSearching({
  @required String text,
  @required bool isSearching,
  int minCharLimit = 3,
}){

  bool _output;

      if (text.length >= minCharLimit){
        
        _output = true;

      }
      else {
        _output = false;
      }

  return  _output;
}
// -------------------------------------
/// TESTED : WORKS PERFECT
void triggerIsSearchingNotifier({
  @required String text,
  @required ValueNotifier<bool> isSearching,
  int minCharLimit = 3,
  Function onSwitchOff,
  Function onResume,
}){

  /// WHEN GOING MORE THAN MIN LENGTH
  if (text.length >= minCharLimit){

    /// ONLY SWITCH ON SEARCHING IF ITS NOT ALREADY ON
    if (isSearching.value != true){
      isSearching.value = true;
    }

    /// SHOULD FIRE WITH EACH TEXT CHANGE WHILE SEARCHING
    if (onResume != null){
      onResume();
    }

  }

  /// WHEN GOING LESS THAN MIN LENGTH
  else {

    /// ONLY SWITCH OFF SEARCHING IF ITS NOT ALREADY OFF
    if (isSearching.value != false){

      isSearching.value = false;

      /// SHOULD FIRE ONCE ON SWITCHING ON EVENT
      if (onSwitchOff != null){
        onSwitchOff();
      }

    }

  }

}
// -----------------------------------------------------------------------------
