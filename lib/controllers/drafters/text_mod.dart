
import 'package:flutter/foundation.dart';

class TextMod {
// -----------------------------------------------------------------------------
  static List<String> addStringToListIfDoesNotContainIt({List<String> strings, String stringToAdd}){

    List<String> _result = strings;

    final bool _containsIt = strings.contains(stringToAdd) == true;

    if (_containsIt == false){
      _result = <String> [...strings, stringToAdd];
    }

    return _result;
  }
// -----------------------------------------------------------------------------
  static List<String> sortAlphabetically(List<String> inputList){
  List<String> _outputList = <String>[];
  inputList.sort();
  _outputList = inputList;
  return _outputList;
}
// -----------------------------------------------------------------------------
  static List<String> sortAlphabetically2(List<String> inputList){
  // List<String> _outputList = <String>[];

  inputList.sort((a, b) => a.toString().compareTo(b.toString()));

  return inputList;
}
// -----------------------------------------------------------------------------
  static String firstCharacterAfterRemovingSpacesFromAString(String string){
  String _output;

  final String _stringTrimmed = string.trim();

  final String _stringWithoutSpaces = removeSpacesFromAString(_stringTrimmed);

  final String _firstCharacter = firstCharacterOfAString(_stringWithoutSpaces);

  _output =
  _stringWithoutSpaces == null || _stringWithoutSpaces == '' || _stringWithoutSpaces == ' '? null :
  _firstCharacter == '' ? null : _firstCharacter;

  // print('string($string) - _stringTrimmed($_stringTrimmed) - _stringWithoutSpaces($_stringWithoutSpaces) - _firstCharacter($_firstCharacter) - _output($_output)');
  return
    _output;
}
// -----------------------------------------------------------------------------
  static String removeFirstCharacterFromAString(String string){
    final String stringWithoutFirstCharacter = string.length >0 ? string?.substring(1) : null;
  return stringWithoutFirstCharacter;
}
// -----------------------------------------------------------------------------
  static String removeNumberOfCharactersFromBeginningOfAString(String string, int numberOfCharacters){
  String _stringTrimmed;
  if (numberOfCharacters > string.length){
    print('can not remove ($numberOfCharacters) from the given string because : numberOfCharacters > string.length');
    throw('can not remove ($numberOfCharacters) from the given string because');
  } else {
    _stringTrimmed = string.length >0 ? string?.substring(numberOfCharacters) : null;
  }
  return _stringTrimmed;
}
// -----------------------------------------------------------------------------
  static String removeNumberOfCharactersFromEndOfAString(String string, int numberOfCharacters){
    String _stringTrimmed;
    // if (numberOfCharacters > string.length){
    //   print('can not remove ($numberOfCharacters) from the given string because : numberOfCharacters > string.length');
    //   throw('can not remove ($numberOfCharacters) from the given string because');
    // } else {}

    print('string length ${string.trim().length} and : numberOfCharacters : $numberOfCharacters');

    if (string != null && string.trim().length != 0){

      if (string.trim().length == numberOfCharacters){
        _stringTrimmed = '';
      }

      else if (string.trim().length > numberOfCharacters){
        _stringTrimmed = string.substring(0, string.trim().length - numberOfCharacters);
      }

      else {
        _stringTrimmed = '';
      }
    }


    return _stringTrimmed;
  }
// -----------------------------------------------------------------------------
  static String removeSpacesFromAString(String string){
    String _output5;

    if (string != null){
      /// solution 1,, won't work, not tested
      // string.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
      /// solution 2
      // string.replaceAll(new RegExp(r"\s+"), "");
      /// solution 3
      // string.replaceAll(' ', '');
      /// solution 4
      // string.split(" ").join("");
      /// solution 5
      final String _output = string.toLowerCase().replaceAll(' ', '');
      /// solution 6
      /// String replaceWhitespacesUsingRegex(String s, String replace) {
      ///   if (s == null) {
      ///     return null;
      ///   }
      ///
      ///   // This pattern means "at least one space, or more"
      ///   // \\s : space
      ///   // +   : one or more
      ///   final pattern = RegExp('\\s+');
      ///   return s.replaceAll(pattern, replace);
      ///
      /// ---> I'm just going to shortcut the above method here below
      // string?.replaceAll(new RegExp('\\s+'),'');
      final String _output2 = _output?.replaceAll('‎', '');
      final String _output3 = _output2?.replaceAll('‏', '');
      final String _output4 = _output3?.replaceAll('‎ ', '');
      _output5 = _output4?.replaceAll(' ‏', '');
    }

  return
    _output5;
}
// -----------------------------------------------------------------------------
  static String firstCharacterOfAString(String string){
    final String _output = string == null || string.length == 0 || string == '' || string == ' '? null :
  string?.substring(0,1);


  return
    _output == null || _output == '' || _output == "" ? null : _output;

}
// -----------------------------------------------------------------------------
  static String lastTwoSubStringsFromAString(String string){
    final List<String> _stringSplit = string.split('');
    final int _listLength = _stringSplit.length;
    final int _lastIndex = _listLength - 1;
    final int _beforeLastIndex = _listLength - 2;

  return
    _listLength == 0 ? null :
    '${_stringSplit[_beforeLastIndex]}${_stringSplit[_lastIndex]}';
}
// -----------------------------------------------------------------------------
  static String trimTextAfterFirstSpecialCharacter(String verse, String specialCharacter){
    // int _position = verse == null ? null : verse.indexOf(specialCharacter);

    final String _result = verse == null ? null : verse.substring(0, verse.indexOf(specialCharacter));
  return _result;
}
// -----------------------------------------------------------------------------
  static String trimTextBeforeFirstSpecialCharacter(String verse, String specialCharacter){
    final int _position = verse == null ? null : verse.indexOf(specialCharacter);
    final String _result = verse == null ? null : (_position != -1)? verse.substring(_position+1, verse.length): verse;
    return _result;
}
// -----------------------------------------------------------------------------
  static String trimTextAfterLastSpecialCharacter(String verse, String specialCharacter){
    final String _result = verse == null ? null : verse.substring(0, verse.lastIndexOf(specialCharacter));
  return _result;
}
// -----------------------------------------------------------------------------
  static String trimTextBeforeLastSpecialCharacter(String verse, String specialCharacter){
    final int _position = verse == null ? null : verse.lastIndexOf(specialCharacter);
    final String _result = verse == null ? null : (_position != -1)? verse.substring(_position+1, verse.length): verse;
  return _result;
}
// -----------------------------------------------------------------------------
/// this trims paths like 'assets/xx/pp_sodic/builds_1.jpg' to 'builds_1.jpg'
  static String getFileNameFromAsset(String asset){
    final String _fileName = trimTextBeforeLastSpecialCharacter(asset, '/');
  return _fileName;
}
// -----------------------------------------------------------------------------
  /// converts list of strings to map of keywords with true map value
  static Future<Map<String, dynamic>> getKeywordsMap(List<dynamic> list) async {
    /// example
    ///
    /// List<String> listExample = <String>['construction', 'architecture', 'decor'];
    /// will result a map like this :-
    /// {
    ///   construction : true,
    ///   architecture : true,
    ///   decor        : true,
    /// }
    ///
    /// UPDATE
    ///
    /// MAP SHOULD LOOK LIKE THIS
    /// {
    ///   construction : 0 ,
    ///   architecture : 1 ,
    ///   decor : 2 ,
    /// }

  // old solution
  // Map<String, dynamic> _result = { for (var keyword in list) keyword : true };

  // new solution won't work as key value should be string on firestore
  // Map<int, String> _result = list.asMap();

  // mirroring the map
  Map<String, dynamic> _stringIndexMap = {};
  int _index = 0;
  await Future.forEach(list, (keyword){

    _stringIndexMap.addAll({
      keyword : _index,
    });
    _index++;

  });

  return _stringIndexMap;
}
// -----------------------------------------------------------------------------
  static Map<String, dynamic> getValueAndTrueMap(List<String> list){
    final Map<String, dynamic> _result = { for (var string in list) string : true };
  return _result;
}
// -----------------------------------------------------------------------------
  static List<dynamic> getValuesFromValueAndTrueMap(Map<String, dynamic> map){
    final List<dynamic> _flyersIDs = map.keys.toList();
    return _flyersIDs;
}
// -----------------------------------------------------------------------------
  static String lowerCase(String val){
    return val.toLowerCase();
  }
// -----------------------------------------------------------------------------
  static List<String> createTrigram({@required String input, int maxTrigramLength}){
    List<String> _trigram = <String>[];

    /// 0 - to lower cases
    final String _lowerCased = input.toLowerCase();

    /// 1 - first add each word separately
    final List<String> _splitWords = _lowerCased.trim().split(' ');
    _trigram.addAll(_splitWords);

    /// 2 - start trigramming after clearing spaces
    final String _withoutSpaces = TextMod.removeSpacesFromAString(_lowerCased);

    /// 3 - split characters into a list
    final List<String> _characters = _withoutSpaces.split('');
    final int _charactersLength = _characters.length;
    int _maxTrigramLength = maxTrigramLength ?? _charactersLength;

    /// 4 - loop through trigram length 3 -> 4 -> 5 -> ... -> _charactersLength
    for (int trigramLength = 3; trigramLength <= _maxTrigramLength; trigramLength++){

      final int _difference = trigramLength - 1;

      /// 5 - loop in characters
      for (int i = 0; i < _charactersLength - _difference; i++){

        String _combined = '';

        /// 6 - combine
        for (int c = 0; c < trigramLength;c++){
          String _char = _characters[i + c];
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

    return _trigram;
  }
// -----------------------------------------------------------------------------
  static String sqlCipherStrings(List<String> strings){
    String _output;

    if (strings != null && strings.length != 0){

      for (String string in strings){

        if (_output == null){
          _output = '$string';
        }
        else {
          _output = '${_output}__$string';
        }

      }

    }

    return _output;
  }
// -----------------------------------------------------------------------------
  static List<String> sqlDecipherStrings(String text){
    List<String> _strings;

    if (text != null){
      _strings = text.split('__');
    }

    return _strings;
  }
// -----------------------------------------------------------------------------
}

