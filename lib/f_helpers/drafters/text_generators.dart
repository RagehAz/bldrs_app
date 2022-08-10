import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/c_protocols/phrase_protocols/a_phrase_protocols.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';

class TextGen {
// -----------------------------------------------------------------------------

  const TextGen();

// -----------------------------------------------------------------------------
  static String functionStringer(Function function) {
    final String _functionNameAsAString = function.toString();
    final int _s = _functionNameAsAString.indexOf("'");
    final int _e = _functionNameAsAString.lastIndexOf("'");
    // print('functionNameAsAString : ${functionNameAsAString.substring(s + 1, e)}');
    return _functionNameAsAString.substring(_s+1, _e);  // return functionNameAsAString;
  }
// -----------------------------------------------------------------------------
  static String askHinter (BuildContext context, BzType bzType){
    final String _askHint =
    bzType == BzType.developer ? xPhrase(context, 'phid_askHint_developer') :
    bzType == BzType.broker ? xPhrase(context, 'phid_askHint_broker') :
    bzType == BzType.manufacturer ? xPhrase(context, 'phid_askHint_manufacturer') :
    bzType == BzType.supplier ? xPhrase(context, 'phid_askHint_supplier') :
    bzType == BzType.designer ? xPhrase(context, 'phid_askHint_designer') :
    bzType == BzType.contractor ? xPhrase(context, 'phid_askHint_contractor') :
    bzType == BzType.craftsman ? xPhrase(context, 'phid_askHint_craftsman') :
    xPhrase(context, 'phid_askHint');
    return _askHint;
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
          _trigram = TextMod.addStringToListIfDoesNotContainIt(strings : _trigram, stringToAdd : _combined,);
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
