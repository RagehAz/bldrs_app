
import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/text_checkers.dart';
import 'package:flutter/foundation.dart';

abstract class TextMod {
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

  inputList.sort((String a, String b) => a.toString().compareTo(b.toString()));

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
  static String removeTextAfterFirstSpecialCharacter(String verse, String specialCharacter){
    String _result;

    final bool _verseContainsChar = TextChecker.stringContainsSubString(
      string: verse,
      subString: specialCharacter,
      caseSensitive: false,
      multiLine: true,
    );

    if (_verseContainsChar == true){
      _result = verse == null ? null : verse.substring(0, verse.indexOf(specialCharacter));
    }

    else {
      _result = '';
    }

  return _result;
}
// -----------------------------------------------------------------------------
  static String removeTextBeforeFirstSpecialCharacter(String verse, String specialCharacter){
    String _result;

    final bool _verseContainsChar = TextChecker.stringContainsSubString(
      string: verse,
      subString: specialCharacter,
      caseSensitive: false,
      multiLine: true,
    );

    if (_verseContainsChar == true){
      final int _position = verse == null ? null : verse.indexOf(specialCharacter);
       _result = verse == null ? null : (_position != -1)? verse.substring(_position+1, verse.length): verse;
    }

    else {
      _result = '';
    }

    return _result;
}
// -----------------------------------------------------------------------------
  static String removeTextAfterLastSpecialCharacter(String verse, String specialCharacter){
    String _result;

    final bool _verseContainsChar = TextChecker.stringContainsSubString(
      string: verse,
      subString: specialCharacter,
      caseSensitive: false,
      multiLine: true,
    );

    if (_verseContainsChar == true){
      _result = verse == null ? null : verse.substring(0, verse.lastIndexOf(specialCharacter));
    }

    else {
      _result = '';
    }

  return _result;
}
// -----------------------------------------------------------------------------
  static String removeTextBeforeLastSpecialCharacter(String verse, String specialCharacter){
    String _result;

    final bool _verseContainsChar = TextChecker.stringContainsSubString(
      string: verse,
      subString: specialCharacter,
      caseSensitive: false,
      multiLine: true,
    );

    if (_verseContainsChar == true){
      final int _position = verse == null ? null : verse.lastIndexOf(specialCharacter);
      _result = verse == null ? null : (_position != -1)? verse.substring(_position+1, verse.length): verse;
    }

    else {
      _result = '';
    }

  return _result;
}
// -----------------------------------------------------------------------------
/// this trims paths like 'assets/xx/pp_sodic/builds_1.jpg' to 'builds_1.jpg'
  static String getFileNameFromAsset(String asset){
    final String _fileName = removeTextBeforeLastSpecialCharacter(asset, '/');
  return _fileName;
}
// -----------------------------------------------------------------------------
  /// converts list of strings to map of keywords with true map value
  static Future<Map<String, dynamic>> getKeywordsMap(List<String> keywordsIDs) async {
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
  Map<String, dynamic> _stringIndexMap = <String, dynamic>{};
  int _index = 0;
  await Future.forEach(keywordsIDs, (String keywordID){

    _stringIndexMap.addAll(
        <String, dynamic>{
          keywordID : _index,
        }
        );
    _index++;

  });

  return _stringIndexMap;
}
// -----------------------------------------------------------------------------
  static Map<String, dynamic> getValueAndTrueMap(List<String> list){
    final Map<String, dynamic> _result = <String, dynamic>{ for (String string in list) string : true };
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
  static String sqlCipherStrings(List<String> strings){
    String _output;

    if (Mapper.canLoopList(strings)){

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
  static String replaceAllCharactersWith({@required String CharacterToReplace, @required String replacement, @required String input}){

    final String _output = input.replaceAll(CharacterToReplace, replacement);

    return _output;
  }
// -----------------------------------------------------------------------------
  static String removeAllCharactersAfterNumberOfCharacters({@required String input, @required int numberOfCharacters}){

    String _output = input;

    if (input != null && numberOfCharacters !=null && input.length > 0 && numberOfCharacters > 0 && input.length > numberOfCharacters){

      _output = input.substring(0, numberOfCharacters);

    }

    return _output;
  }
// -----------------------------------------------------------------------------
  static String fixArabicText(String input){

    /// TASK : alef hamza issue
    /// TASK : ya2 w alef maksoura issue
    /// TASK : ha2 w ta2 marbouta issue

    return 'Bokra isa';
  }
// -----------------------------------------------------------------------------
/*

ENCODE AND DECODE STRINGS for encryption

https://stackoverflow.com/questions/56201074/how-to-encode-and-decode-base64-and-base64url-in-flutter-dart

String credentials = "username:password";
Codec<String, String> stringToBase64 = utf8.fuse(base64);
String encoded = stringToBase64.encode(credentials);      // dXNlcm5hbWU6cGFzc3dvcmQ=
String decoded = stringToBase64.decode(encoded);          // username:password

 */

}

// class DoubleFromStringTest {
//
//   /// lets just make a method that takes dynamic and returns double
//   /// and it should process the strings and doubles
//   static double getDoubleIfPossible(dynamic input){
//     double _output;
//
//     print('starting : getDoubleIfPossible : input : ${input}');
//     print('starting : getDoubleIfPossible : input.runtimeType : ${input.runtimeType}');
//
//     /// some safety layer first
//     if (input != null){
//
//       /// when its already a double,, we are good
//       if (input.runtimeType == double){
//
//         _output = input;
//       }
//
//       /// when its a string
//       else if (input.runtimeType == String){
//
//         /// we need to make sure that it's a double inside a string,, and not a combination of doubles & characters in one string like '15X8wS'
//         /// so lets do an another method and call it here
//         bool _inputIsDoubleInsideAString = _objectIsDoubleInString(input);
//
//         if (_inputIsDoubleInsideAString == true){
//
//           /// so its a double inside a string,, then we can get the double now without firing an error
//           _output = _stringToDouble(input);
//
//         }
//
//         // else {
//         //   /// input is not a double in a string
//         //   /// will do nothing,, and the _output shall return null
//         //   /// so I will comment these unnecessary lines
//         // }
//
//
//       }
//
//       // /// it not a string and its not a double
//       // else {
//       //   /// do nothing and return null
//       //   /// so I will comment these unnecessary lines
//       // }
//
//     }
//
//     return _output;
//   }
//
//   static bool _objectIsDoubleInString(dynamic string) {
//
//     bool _objectIsDoubleInString;
//     double _double;
//
//     if (string != null){
//       _double = double.tryParse(string.trim());
//     }
//
//     if (_double == null){
//       _objectIsDoubleInString = false;
//     } else {
//       _objectIsDoubleInString = true;
//     }
//
//     print('objectIsDoubleInString : _double is : $_double');
//
//     return _objectIsDoubleInString;
//
//   }
//
//   static double _stringToDouble(String string){
//     double _value;
//
//     if (string != null){
//       _value = double.parse(string);
//     }
//
//     return _value;
//   }
//
// }