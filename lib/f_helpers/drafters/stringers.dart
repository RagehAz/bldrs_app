import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
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

  /// TESTED : WORKS PERFECT
  static List<String> sortAlphabetically2(List<String> inputList) {
    // List<String> _outputList = <String>[];

    inputList.sort((String a, String b) => a.compareTo(b));

    return inputList;
  }

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

  /// BLOGGING

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static void blogStrings({
    @required List<String> strings,
    String invoker,
  }){
    blog('blogStrings : START --- : $invoker');
    if (Mapper.checkCanLoopList(strings) == true){
      

      for (int i = 0; i <strings.length; i++){

        final int _length = strings.length;
        final int _numberOfDigits = Numeric.concludeNumberOfDigits(_length);
        final String _index = Numeric.formatNumberWithinDigits(
            num: i+1,
            digits: _numberOfDigits
        );

        blog('$_index : [ ${strings[i]} ]');
        
      }
      
    }
    else {
      blog('blogStrings : strings can not be blogged');
    }
    
    blog('blogStrings : END --- : $invoker');
    
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static void blogStringsListsDifferences({
    @required List<String> strings1,
    @required List<String> strings2,
  }){

    blog('blogStringsListsDifferences : START');

    if (strings1 == null){
      blog('0 - strings1 is null');
    }
    if (strings2 == null){
      blog('0 - strings1 is null');
    }
    if (strings1?.isEmpty == true){
      blog('0 - strings1 is Empty');
    }
    if (strings2?.isNotEmpty == null){
      blog('0 - strings1 is Empty');
    }
    if (Mapper.checkCanLoopList(strings1) == true && Mapper.checkCanLoopList(strings2) == true){

      final bool _listsAreIdentical = Mapper.checkListsAreIdentical(
        list1: strings1,
        list2: strings2,
      );

      /// LISTS ARE IDENTICAL ALREADY
      if (_listsAreIdentical == true){
        blog('1 - strings lists are PERFECTLY identical and of length : ${strings1.length}');
      }

      /// LISTS ARE NOT IDENTICAL
      else {
        blog('1 - strings lists are NOT identical');

        final bool _sortedAreIdentical = Mapper.checkListsAreIdentical(
          list1: Stringer.sortAlphabetically2(strings1),
          list2: Stringer.sortAlphabetically2(strings2),
        );

        /// LISTS JUST NEEDED SORTING
        if (_sortedAreIdentical == true){
          blog('2 - strings lists just needed sorting to be identical, and has length of : ${strings1.length}');
        }

        else {
          blog('2 - SORTED strings lists are NOT identical AS WELL');

          List<String> _longer;
          List<String> _shorter;
          if (strings1.length > strings2.length){
            _longer = <String>[...strings1];
            _shorter = <String>[...strings2];
            blog('3 - [ strings 1 length ( ${strings1.length} ) ] > [ strings 2 length ( ${strings2.length} ) ] : '
                '${_longer.length} - ${_shorter.length} = ${_longer.length - _shorter.length}');
          }
          else if (strings1.length < strings2.length){
            _longer = <String>[...strings2];
            _shorter = <String>[...strings1];
            blog('3 - [ strings 2 length ( ${strings2.length} ) ] > [ strings 1 length ( ${strings1.length} ) ] : '
                '${_longer.length} - ${_shorter.length} = ${_longer.length - _shorter.length}');
          }
          else if (strings1.length == strings2.length){
            blog('3 - strings lengths are identical of ( ${strings2.length} )');
            _longer = <String>[...strings2];
            _shorter = <String>[...strings1];
          }
          else {
            blog('3 - a77a : something is wrong here');
          }

          for (int i = 0; i < _longer.length; i++){

            final String _string = _longer[i];

            final bool _shorterContains = checkStringsContainString(
              strings: _shorter,
              string: _string,
            );

            if (_shorterContains == false){
              blog('4 - shorter strings do not have : index : ( $i / ${_longer.length} ) : string : ( $_string )');
            }
            // else {
            //   blog('shorter has  : index : ( $i ) : string : ( $_string )');
            // }

          }


        }



      }


    }

    blog('blogStringsListsDifferences : END');

  }
// -----------------------------------------------------------------------------
}
