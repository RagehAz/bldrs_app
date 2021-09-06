
class TextMod {
// -----------------------------------------------------------------------------
  static List<String> sortAlphabetically(List<String> inputList){
  List<String> _outputList = [];
  inputList.sort();
  _outputList = inputList;
  return _outputList;
}
// -----------------------------------------------------------------------------
  static List<String> sortAlphabetically2(List<String> inputList){
  List<String> _outputList = [];

  inputList.sort((a, b) => a.toString().compareTo(b.toString()));

  return _outputList;
}
// -----------------------------------------------------------------------------
  static String firstCharacterAfterRemovingSpacesFromAString(String string){
  String _output;

  String _stringTrimmed = string.trim();

  String _stringWithoutSpaces = removeSpacesFromAString(_stringTrimmed);

  String _firstCharacter = firstCharacterOfAString(_stringWithoutSpaces);

  _output =
  _stringWithoutSpaces == null || _stringWithoutSpaces == '' || _stringWithoutSpaces == ' '? null :
  _firstCharacter == '' ? null : _firstCharacter;

  // print('string($string) - _stringTrimmed($_stringTrimmed) - _stringWithoutSpaces($_stringWithoutSpaces) - _firstCharacter($_firstCharacter) - _output($_output)');
  return
    _output;
}
// -----------------------------------------------------------------------------
  static String removeFirstCharacterFromAString(String string){
  String stringWithoutFirstCharacter = string.length >0 ? string?.substring(1) : null;
  return stringWithoutFirstCharacter;
}
// -----------------------------------------------------------------------------
  static String removeNumberOfCharactersFromAString(String string, int numberOfCharacters){
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
      String _output = string.toLowerCase().replaceAll(' ', '');
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
      String _output2 = _output?.replaceAll('‎', '');
      String _output3 = _output2?.replaceAll('‏', '');
      String _output4 = _output3?.replaceAll('‎ ', '');
      _output5 = _output4?.replaceAll(' ‏', '');
    }

  return
    _output5;
}
// -----------------------------------------------------------------------------
  static String firstCharacterOfAString(String string){
  String _output = string == null || string.length == 0 || string == '' || string == ' '? null :
  string?.substring(0,1);


  return
    _output == null || _output == '' || _output == "" ? null : _output;

}
// -----------------------------------------------------------------------------
  static String lastTwoSubStringsFromAString(String string){
  List<String> _stringSplit = string.split('');
  int _listLength = _stringSplit.length;
  int _lastIndex = _listLength - 1;
  int _beforeLastIndex = _listLength - 2;

  return
    _listLength == 0 ? null :
    '${_stringSplit[_beforeLastIndex]}${_stringSplit[_lastIndex]}';
}
// -----------------------------------------------------------------------------
  static String trimTextAfterFirstSpecialCharacter(String verse, String specialCharacter){
    // int _position = verse == null ? null : verse.indexOf(specialCharacter);

    String _result = verse == null ? null : verse.substring(0, verse.indexOf(specialCharacter));
  return _result;
}
// -----------------------------------------------------------------------------
  static String trimTextBeforeFirstSpecialCharacter(String verse, String specialCharacter){
  int _position = verse == null ? null : verse.indexOf(specialCharacter);
  String _result = verse == null ? null : (_position != -1)? verse.substring(_position+1, verse.length): verse;
  return _result;
}
// -----------------------------------------------------------------------------
  static String trimTextAfterLastSpecialCharacter(String verse, String specialCharacter){
  String _result = verse == null ? null : verse.substring(0, verse.lastIndexOf(specialCharacter));
  return _result;
}
// -----------------------------------------------------------------------------
  static String trimTextBeforeLastSpecialCharacter(String verse, String specialCharacter){
  int _position = verse == null ? null : verse.lastIndexOf(specialCharacter);
  String _result = verse == null ? null : (_position != -1)? verse.substring(_position+1, verse.length): verse;
  return _result;
}
// -----------------------------------------------------------------------------
/// this trims paths like
/// 'assets/xx/pp_sodic/builds_1.jpg' to 'builds_1.jpg'
  static String getFileNameFromAsset(String asset){
  String _fileName = trimTextBeforeLastSpecialCharacter(asset, '/');
  return _fileName;
}
// -----------------------------------------------------------------------------
  /// converts list of strings to map of keywords with true map value
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
  static Future<Map<String, dynamic>> getKeywordsMap(List<dynamic> list) async {
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
  Map<String, dynamic> _result = { for (var string in list) string : true };
  return _result;
}
// -----------------------------------------------------------------------------
  static List<dynamic> getValuesFromValueAndTrueMap(Map<String, dynamic> map){
    List<dynamic> _flyersIDs = map.keys.toList();
    return _flyersIDs;
}
// -----------------------------------------------------------------------------
  static String lowerCase(String val){
    return val.toLowerCase();
  }
// -----------------------------------------------------------------------------
}

