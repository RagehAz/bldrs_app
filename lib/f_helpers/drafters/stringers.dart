import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/foundation.dart';

class Stringer {
// -----------------------------------------------------------------------------

  const Stringer();

// -----------------------------------------------------------------------------

  /// CLONING

// -------------------------------------
  static List<String> cloneListOfStrings(List<String> list) {
    final List<dynamic> _newList = <dynamic>[];

    for (final String x in list) {
      _newList.add(x);
    }
    return _newList;
  }
// -----------------------------------------------------------------------------

  /// CHECKERS

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static bool checkStringIsEmpty(String val) {
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
  static bool checkStringIsNotEmpty(String val) {
    return !checkStringIsEmpty(val);
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static bool checkStringsContainString({
    @required List<String> strings,
    @required String string,
  }) {
    bool _containsIt = false;

    if (Mapper.checkCanLoopList(strings) == true && string != null) {
      _containsIt = strings.contains(string);
    }

    return _containsIt;
  }
// -----------------------------------------------------------------------------

  /// MODIFIERS

// ----------------------------
  /// TESTED : WORKS PERFECT
  static List<String> addStringToListIfDoesNotContainIt({
    @required List<String> strings,
    @required String stringToAdd,
  }) {

    List<String> _output = <String>[];

    if (Mapper.checkCanLoopList(strings) == true){
      _output = <String>[...strings];
    }

    final bool _containsIt = checkStringsContainString(
      strings: _output,
      string: stringToAdd,
    );

    if (_containsIt == false) {
      _output.add(stringToAdd);
    }

    return _output;
  }
// ----------------------------
  /// TESTED : WORKS PERFECT
  static List<String> addStringsToStringsIfDoNotContainThem({
    @required List<String> listToTake,
    @required List<String> listToAdd,
  }){

    List<String> _output = <String>[];

    if (Mapper.checkCanLoopList(listToTake) == true){
      _output = listToTake;
    }

    if (Mapper.checkCanLoopList(listToAdd) == true){

      for (final String string in listToAdd){

        _output = addStringToListIfDoesNotContainIt(
            strings: _output,
            stringToAdd: string
        );

      }

    }

    return _output;
  }
// ----------------------------
  /// TESTED : WORKS PERFECT
  static List<String> addOrRemoveStringToStrings({
    @required List<String> strings,
    @required String string,
  }){

    List<String> _output = <String>[];

    if (Mapper.checkCanLoopList(strings) == true){
      _output = <String>[...strings];
    }

    final bool _containsIt = checkStringsContainString(
        strings: _output,
        string: string
    );

    if (_containsIt == true){
      _output.remove(string);
    }
    else {
      _output.add(string);
    }

    return _output;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<String> removeStringsFromStrings({
    @required List<String> removeFrom,
    @required List<String> removeThis,
  }){

    final List<String> _output = <String>[];

    if (Mapper.checkCanLoopList(removeFrom) == true){

      for (final String string in removeFrom){

        final bool _canRemove = checkStringsContainString(
            strings: removeThis,
            string: string
        );

        if (_canRemove == true){
          blog('removeStringsFromStrings : removing : $string');
        }
        else {
          _output.add(string);
        }

      }

    }

    return _output;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<String> putStringInStringsIfAbsent({
    @required List<String> strings,
    @required String string,
  }){

    List<String> _output = <String>[];

    if (Mapper.checkCanLoopList(strings) == true){

      _output = <String>[...strings];

    }

    final bool _contains = checkStringsContainString(
      strings: _output,
      string: string,
    );

    if (_contains == false){
      _output.add(string);
    }


    return _output;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<String> cleanDuplicateStrings({
    @required List<String> strings,
  }){
    final List<String> _output = <String>[];

    if (Mapper.checkCanLoopList(strings) == true){

      for (final String string in strings){

        if (_output.contains(string) == false){
          _output.add(string);
        }

      }

    }

    return _output;
  }
// -----------------------------------------------------------------------------

  /// SORTING STRINGS

// -------------------------------------
  /*
  static List<String> sortAlphabetically(List<String> inputList) {
    inputList.sort();
    return inputList;
  }
   */
// -------------------------------------
  /*
  /// TESTED : WORKS PERFECT
  static List<String> sortAlphabetically2(List<String> inputList) {
    // List<String> _outputList = <String>[];

    inputList.sort((String a, String b) => a.compareTo(b));

    return inputList;
  }
 */
// -----------------------------------------------------------------------------

  /// TRANSFORMERS

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<String> transformDynamicsToStrings({
    @required List<dynamic> dynamics,
  }) {
    final List<String> _strings = <String>[];

    if (Mapper.checkCanLoopList(dynamics)) {
      for (final dynamic thing in dynamics) {
        if (thing is String == true) {
          _strings.add(thing);
        } else {
          _strings.add(thing.toString());
        }
      }
    }

    // blog('getStringsFromDynamics : _strings : $_strings');

    return _strings;
  }
// -----------------------------------------------------------------------------

  /// TRIGRAM

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<String> createTrigram({
    @required String input,
    bool removeSpaces = false,
  }){
    List<String> _trigram = <String>[];

    if (input != null){

      const int maxTrigramLength = Standards.maxTrigramLength;

      /// 0 - to lower cases
      final String _lowerCased = input.toLowerCase();

      /// 1 - first add each word separately
      final List<String> _splitWords = _lowerCased.trim().split(' ');
      _trigram.addAll(_splitWords);

      /// 2 - start trigramming after clearing spaces
      String _withoutSpaces = TextMod.removeSpacesFromAString(_lowerCased);
      if (removeSpaces == true){
        _withoutSpaces = TextMod.removeSpacesFromAString(_lowerCased);
      }
      else {
        _withoutSpaces = _lowerCased;
      }

      /// 3 - split characters into a list
      final List<String> _characters = _withoutSpaces.split('');
      final int _charactersLength = _characters.length;
      final int _maxTrigramLength = maxTrigramLength ?? _charactersLength;

      /// 4 - loop through trigram length 3 -> 4 -> 5 -> ... -> _charactersLength
      for (int trigramLength = 3; trigramLength <= _maxTrigramLength; trigramLength++){

        final int _difference = trigramLength - 1;

        /// 5 - loop in characters
        for (int i = 0; i < _charactersLength - _difference; i++){

          String _combined = '';

          /// 6 - combine
          for (int c = 0; c < trigramLength;c++){
            final String _char = _characters[i + c];
            _combined = '$_combined$_char';
          }

          /// 7 - add combination
          _trigram = Stringer.addStringToListIfDoesNotContainIt(strings : _trigram, stringToAdd : _combined,);
        }

      }

      // /// 3 - generate the triplets
      // for (int i = 0; i < _charactersLength - 2; i++){
      //   String _first = _characters[i];
      //   String _second = _characters[i+1];
      //   String _third = _characters[i+2];
      //   String _combined = '$_first$_second$_third';
      //   _trigram = TextMod.addStringToListIfDoesNotContainIt(strings : _trigram, stringToAdd : _combined,);
      // }

      // _trigramLength = 4;
      // /// 4 - generate quadruplets
      // for (int i = 0; i < _characters.length - 3; i++){
      //   String _first = _characters[i];
      //   String _second = _characters[i+1];
      //   String _third = _characters[i+2];
      //   String _fourth = _characters[i+3];
      //   String _combined = '$_first$_second$_third$_fourth';
      //   _trigram = TextMod.addStringToListIfDoesNotContainIt(strings : _trigram, stringToAdd : _combined,);
      // }

      // _trigramLength = 5;
      // /// 5 - generate Quintuplets
      // for (int i = 0; i < _characters.length - 4; i++){
      //   String _first = _characters[i];
      //   String _second = _characters[i+1];
      //   String _third = _characters[i+2];
      //   String _fourth = _characters[i+3];
      //   String _fifth = _characters[i+4];
      //   String _combined = '$_first$_second$_third$_fourth$_fifth';
      //   _trigram = TextMod.addStringToListIfDoesNotContainIt(strings : _trigram, stringToAdd : _combined,);
      // }

      // _trigramLength = 6;
      // /// 6 - generate Sextuplets
      // for (int i = 0; i < _characters.length - 5; i++){
      //   String _first = _characters[i];
      //   String _second = _characters[i+1];
      //   String _third = _characters[i+2];
      //   String _fourth = _characters[i+3];
      //   String _fifth = _characters[i+4];
      //   String _sixth = _characters[i+5];
      //   String _combined = '$_first$_second$_third$_fourth$_fifth$_sixth';
      //   _trigram = TextMod.addStringToListIfDoesNotContainIt(strings : _trigram, stringToAdd : _combined,);
      // }

    }

    return _trigram;
  }
// -----------------------------------------------------------------------------

  /// GENERATORS

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static String generateStringFromStrings({
    @required List<String> strings,
    String stringsSeparator = ', ',
  }){
    /// CREATES ONE STRING OF ALL STRINGS IN LIST AND SEPARATES THEM WITH ', '

    String _output = '';

    if (Mapper.checkCanLoopList(strings) == true){

      for (final String _string in strings){


        if (_output == ''){
          _output = _string;
        }

        else {
          _output = '$_output$stringsSeparator$_string';
        }

      }

    }

    if (_output == ''){
      _output = null;
    }

    return _output;
  }
// -----------------------------------------------------------------------------
}
