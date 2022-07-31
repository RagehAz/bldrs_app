// ignore_for_file: always_put_control_body_on_new_line
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/foundation.dart';
// -----------------------------------------------------------------------------

/// STRINGS LIST MODIFIERS

// ----------------------------
/// TESTED : WORKS PERFECT
List<String> addStringToListIfDoesNotContainIt({
  @required List<String> strings,
  @required String stringToAdd,
}) {

  List<String> _output = <String>[];

  if (Mapper.checkCanLoopList(strings) == true){
    _output = <String>[...strings];
  }

  final bool _containsIt = Mapper.checkStringsContainString(
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
List<String> addStringsToStringsIfDoNotContainThem({
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
List<String> addOrRemoveStringToStrings({
  @required List<String> strings,
  @required String string,
}){

  List<String> _output = <String>[];

  if (Mapper.checkCanLoopList(strings) == true){
    _output = <String>[...strings];
  }

  final bool _containsIt = Mapper.checkStringsContainString(
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
// -----------------------------------------------------------------------------

/// SORTERS

// ----------------------------
List<String> sortAlphabetically(List<String> inputList) {
  inputList.sort();
  return inputList;
}
// ----------------------------
List<String> sortAlphabetically2(List<String> inputList) {
  // List<String> _outputList = <String>[];

  inputList.sort((String a, String b) => a.compareTo(b));

  return inputList;
}
// -----------------------------------------------------------------------------

/// MODIFIERS

// ----------------------------
String modifyAllCharactersWith({
  @required String characterToReplace,
  @required String replacement,
  @required String input,
}) {
  final String _output = input.replaceAll(characterToReplace, replacement);

  return _output;
}
// ----------------------------
String obscureText({
  @required String text,
  String obscurityCharacter = '*',
}){

  String _output = '';

  final int _length = text.length;

  if (_length != 0){
    for (int i = 0; i < _length; i++){
      _output = '$_output$obscurityCharacter';
    }

  }

  return _output;
}
// -----------------------------------------------------------------------------

/// TEXT TAGS MODIFIER

// ----------------------------
/// TEXT VARIABLE TAGS
const String userNameVarTag1 = '<USERNAME1>';
const String userNameVarTag2 = '<USERNAME2>';
const String bzNameVarTag1 = '<BZNAME1>';
const String bzNameVarTag2 = '<BZNAME2>';
const String authorNameVarTag1 = '<AUTHORNAME1>';
const String authorNameVarTag2 = '<AUTHORNAME2>';
const String numberVarTag1 = '<NUMBER1>';
const String numberVarTag2 = '<NUMBER2>';
// ----------------------------
final List<String> varTags = <String>[
  userNameVarTag1,
  userNameVarTag2,
  bzNameVarTag1,
  bzNameVarTag2,
  authorNameVarTag1,
  authorNameVarTag2,
  numberVarTag1,
  numberVarTag2,
];
// ----------------------------
String replaceVarTag({
  @required String input,
  String userName1,
  String userName2,
  String bzName1,
  String bzName2,
  String authorName1,
  String authorName2,
  String number1,
  String number2,
  String customTag,
  String customValue,
}){
  String _output = input;

  Map<String, dynamic> _varTagsMap = {};

  /// USER NAME 1
  if (userName1 != null){
    _varTagsMap = Mapper.insertPairInMap(
        map: _varTagsMap,
        key: userNameVarTag1,
        value: userName1
    );
  }
  /// USER NAME 2
  if (userName2 != null){
    _varTagsMap = Mapper.insertPairInMap(
        map: _varTagsMap,
        key: userNameVarTag2,
        value: userName2
    );
  }
  /// BZ NAME 1
  if (bzName1 != null){
    _varTagsMap = Mapper.insertPairInMap(
        map: _varTagsMap,
        key: bzNameVarTag1,
        value: bzName1,
    );
  }
  /// BZ NAME 2
  if (bzName2 != null){
    _varTagsMap = Mapper.insertPairInMap(
      map: _varTagsMap,
      key: bzNameVarTag2,
      value: bzName2,
    );
  }
  /// AUTHOR NAME 1
  if (authorName1 != null){
    _varTagsMap = Mapper.insertPairInMap(
      map: _varTagsMap,
      key: authorNameVarTag1,
      value: authorName1,
    );
  }
  /// AUTHOR NAME 2
  if (authorName2 != null){
    _varTagsMap = Mapper.insertPairInMap(
      map: _varTagsMap,
      key: authorNameVarTag2,
      value: authorName2,
    );
  }
  /// NUMBER 1
  if (number1 != null){
    _varTagsMap = Mapper.insertPairInMap(
      map: _varTagsMap,
      key: numberVarTag1,
      value: number1,
    );
  }
  /// NUMBER 2
  if (number2 != null){
    _varTagsMap = Mapper.insertPairInMap(
      map: _varTagsMap,
      key: numberVarTag2,
      value: number2,
    );
  }
  /// CUSTOM
  if (customTag != null){
    _varTagsMap = Mapper.insertPairInMap(
      map: _varTagsMap,
      key: customTag,
      value: customValue,
    );
  }


  final List<String> _keys = _varTagsMap.keys.toList();

  if (Mapper.checkCanLoopList(_keys) == true){

    for (final String key in _keys){

      _output = modifyAllCharactersWith(
          input: _output,
          characterToReplace: key,
          replacement: _varTagsMap[key],
      );

    }


  }

  return _output;
}
// -----------------------------------------------------------------------------

/// CUTTERS

// ----------------------------
/// TESTED : WORKS PERFECT
String cutFirstCharacterAfterRemovingSpacesFromAString(String string) {
  final String _stringTrimmed = string.trim();

  final String _stringWithoutSpaces = removeSpacesFromAString(_stringTrimmed);

  final String _firstCharacter = cutFirstCharacterOfAString(_stringWithoutSpaces);

  final String _output =
  _stringWithoutSpaces == null || _stringWithoutSpaces == '' || _stringWithoutSpaces == ' ' ?
  null
      :
  _firstCharacter == '' ? null
          :
  _firstCharacter;

  // blog('string($string) - _stringTrimmed($_stringTrimmed) - _stringWithoutSpaces($_stringWithoutSpaces) - _firstCharacter($_firstCharacter) - _output($_output)');
  return _output;
}
// ----------------------------
/// TESTED : WORKS PERFECT
String cutFirstCharacterOfAString(String string) {
  final String _output = string == null || string.isEmpty || string == '' || string == ' ' ?
  null
      :
  string?.substring(0, 1);

  return _output == null || _output == '' || _output == '' ? null : _output;
}
// ----------------------------
String cutLastTwoCharactersFromAString(String string) {
  final List<String> _stringSplit = string.split('');
  final int _listLength = _stringSplit.length;
  final int _lastIndex = _listLength - 1;
  final int _beforeLastIndex = _listLength - 2;

  return _listLength == 0 ?
  null
      :
  '${_stringSplit[_beforeLastIndex]}${_stringSplit[_lastIndex]}';
}
// -----------------------------------------------------------------------------

/// REMOVERS

// ----------------------------
String removeFirstCharacterFromAString(String string) {
  final String stringWithoutFirstCharacter = string.isNotEmpty ? string?.substring(1) : null;
  return stringWithoutFirstCharacter;
}
// ----------------------------
/// TESTED : WORKS PERFECT
String removeNumberOfCharactersFromBeginningOfAString({
  @required String string,
  @required int numberOfCharacters,
}) {
  String _stringTrimmed;
  if (numberOfCharacters > string.length) {
    blog('can not remove ($numberOfCharacters) from the given string because : numberOfCharacters > string.length');
    final Error _error = ArgumentError(
        'can not remove ($numberOfCharacters) from the given string because',
        'removeNumberOfCharactersFromBeginningOfAString');
    throw _error;
  }

  else {
    _stringTrimmed = string.isNotEmpty ? string?.substring(numberOfCharacters) : null;
  }

  return _stringTrimmed;
}
// ----------------------------
String removeNumberOfCharactersFromEndOfAString(String string, int numberOfCharacters) {
  String _stringTrimmed;
  // if (numberOfCharacters > string.length){
  //   blog('can not remove ($numberOfCharacters) from the given string because : numberOfCharacters > string.length');
  //   throw('can not remove ($numberOfCharacters) from the given string because');
  // } else {}

  // blog('string length ${string.trim().length} and : numberOfCharacters : $numberOfCharacters');

  if (string != null && string.trim().isNotEmpty) {
    if (string.trim().length == numberOfCharacters) {
      _stringTrimmed = '';
    }
    else if (string.trim().length > numberOfCharacters) {
      _stringTrimmed = string.substring(0, string.trim().length - numberOfCharacters);
    }
    else {
      _stringTrimmed = '';
    }
  }

  return _stringTrimmed;
}
// ----------------------------
/// TESTED : WORKS PERFECT
String removeSpacesFromAString(String string) {
  String _output5;

  if (string != null) {
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

  return _output5;
}
// ----------------------------
/// TESTED : WORKS PERFECT
String removeTextAfterFirstSpecialCharacter(String verse, String specialCharacter) {
  String _result = verse;

  final bool _verseContainsChar = TextChecker.stringContainsSubString(
    string: verse,
    subString: specialCharacter,
  );

  if (_verseContainsChar == true) {
    _result = verse?.substring(0, verse.indexOf(specialCharacter));
  }

  return _result;
}
// ----------------------------
/// TESTED : WORKS PERFECT
String removeTextBeforeFirstSpecialCharacter(String verse, String specialCharacter) {
  String _result = verse;

  final bool _verseContainsChar = TextChecker.stringContainsSubString(
    string: verse,
    subString: specialCharacter,
  );

  if (_verseContainsChar == true) {
    final int _position = verse?.indexOf(specialCharacter);
    _result = verse == null ?
    null
        :
    (_position != -1) ?
    verse.substring(_position + 1, verse.length)
        :
    verse;
  }

  return _result;
}
// ----------------------------
/// TESTED : WORKS PERFECT
String removeTextAfterLastSpecialCharacter(String verse, String specialCharacter) {
  String _result = verse;

  final bool _verseContainsChar = TextChecker.stringContainsSubString(
    string: verse,
    subString: specialCharacter,
  );

  if (_verseContainsChar == true) {
    _result = verse?.substring(0, verse.lastIndexOf(specialCharacter));
  }

  return _result;
}
// ----------------------------
/// TESTED : WORKS PERFECT
String removeTextBeforeLastSpecialCharacter(String verse, String specialCharacter) {
  String _result = verse;

  final bool _verseContainsChar = TextChecker.stringContainsSubString(
    string: verse,
    subString: specialCharacter,
  );

  if (_verseContainsChar == true) {
    final int _position = verse?.lastIndexOf(specialCharacter);
    _result = verse == null ? null
        :
    (_position != -1) ? verse.substring(_position + 1, verse.length)
        :
    verse;
  }

  return _result;
}
// ----------------------------
/// TESTED : WORKS PERFECT
String removeAllCharactersAfterNumberOfCharacters({
  @required String input,
  @required int numberOfCharacters,
}) {
  String _output = input;

  if (input != null &&
      numberOfCharacters != null &&
      input.isNotEmpty &&
      numberOfCharacters > 0 &&
      input.length > numberOfCharacters) {
    _output = input.substring(0, numberOfCharacters);
  }

  return _output;
}
// -----------------------------------------------------------------------------

/// CYPHERS

// ----------------------------
String sqlCipherStrings(List<String> strings) {
  String _output;

  if (Mapper.checkCanLoopList(strings)) {
    for (final String string in strings) {
      if (_output == null) {
        _output = string;
      }

      else {
        _output = '${_output}__$string';
      }
    }
  }

  return _output;
}
// ----------------------------
List<String> sqlDecipherStrings(String text) {
  List<String> _strings;

  if (text != null) {
    _strings = text.split('__');
  }

  return _strings;
}
// -----------------------------------------------------------------------------

/// TRANSFORMERS

// ----------------------------
/// this trims paths like 'assets/xx/pp_sodic/builds_1.jpg' to 'builds_1.jpg'
String getFileNameFromAsset(String asset) {
  final String _fileName = removeTextBeforeLastSpecialCharacter(asset, '/');
  return _fileName;
}
// ----------------------------
/// converts list of strings to map of keywords with true map value
Future<Map<String, dynamic>> getKeywordsMap(List<String> keywordsIDs) async {
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
  final Map<String, dynamic> _stringIndexMap = <String, dynamic>{};
  int _index = 0;
  await Future.forEach(keywordsIDs, (String keywordID) {
    _stringIndexMap.addAll(<String, dynamic>{
      keywordID: _index,
    });
    _index++;
  });

  return _stringIndexMap;
}
// ----------------------------
Map<String, dynamic> getValueAndTrueMap(List<String> list) {
  final Map<String, dynamic> _result = <String, dynamic>{
    for (String string in list) string: true
  };
  return _result;
}
// ----------------------------
List<dynamic> getValuesFromValueAndTrueMap(Map<String, dynamic> map) {
  final List<dynamic> _flyersIDs = map.keys.toList();
  return _flyersIDs;
}
// -----------------------------------------------------------------------------

/// FIXERS

// ----------------------------
String fixArabicText(String input) {
  /// TASK : alef hamza issue
  /// TASK : ya2 w alef maksoura issue
  /// TASK : ha2 w ta2 marbouta issue

  return 'Bokra isa';
}
// ----------------------------
/// only user with country names, city names, districts names
String fixCountryName(String input) {
  String _output;

  if (input != null) {
    final String _countryNameTrimmed = modifyAllCharactersWith(
      input: input.toLowerCase().trim(),
      characterToReplace: ' ',
      replacement: '_',
    );

    final String _countryNameTrimmed2 = modifyAllCharactersWith(
      input: _countryNameTrimmed,
      characterToReplace: '-',
      replacement: '_',
    );

    final String _countryNameTrimmed3 = modifyAllCharactersWith(
      input: _countryNameTrimmed2,
      characterToReplace: ',',
      replacement: '',
    );

    final String _countryNameTrimmed4 = modifyAllCharactersWith(
      input: _countryNameTrimmed3,
      characterToReplace: '(',
      replacement: '',
    );

    final String _countryNameTrimmed5 = modifyAllCharactersWith(
      input: _countryNameTrimmed4,
      characterToReplace: ')',
      replacement: '',
    );

    final String _countryNameTrimmed6 = modifyAllCharactersWith(
      input: _countryNameTrimmed5,
      characterToReplace: '’',
      replacement: '',
    );

    final String _countryNameTrimmed7 = modifyAllCharactersWith(
      input: _countryNameTrimmed6,
      characterToReplace: 'ô',
      replacement: 'o',
    );

    final String _countryNameTrimmed8 = modifyAllCharactersWith(
      input: _countryNameTrimmed7,
      characterToReplace: '`',
      replacement: '',
    );

    final String _countryNameTrimmed9 = modifyAllCharactersWith(
      input: _countryNameTrimmed8,
      characterToReplace: "'",
      replacement: '',
    );

    final String _countryNameTrimmed10 = modifyAllCharactersWith(
      input: _countryNameTrimmed9,
      characterToReplace: '.',
      replacement: '',
    );

    final String _countryNameTrimmed11 = modifyAllCharactersWith(
      input: _countryNameTrimmed10,
      characterToReplace: '/',
      replacement: '',
    );

    _output = _countryNameTrimmed11;
  }

  return _output;
}
// ----------------------------
String fixSearchText(String input){
  String _output;

  if (input != null && input != ''){

    _output = input.trim().toLowerCase();
    _output = removeSpacesFromAString(_output);
    // _output = fixArabicText(_output);

  }

  return _output;
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


// class DoubleFromStringTest {
//
//   /// lets just make a method that takes dynamic and returns double
//   /// and it should process the strings and doubles
//   double getDoubleIfPossible(dynamic input){
//     double _output;
//
//     blog('starting : getDoubleIfPossible : input : ${input}');
//     blog('starting : getDoubleIfPossible : input.runtimeType : ${input.runtimeType}');
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
//   bool _objectIsDoubleInString(dynamic string) {
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
//     blog('objectIsDoubleInString : _double is : $_double');
//
//     return _objectIsDoubleInString;
//
//   }
//
//   double _stringToDouble(String string){
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
