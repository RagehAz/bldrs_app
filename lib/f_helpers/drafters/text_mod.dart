// ignore_for_file: always_put_control_body_on_new_line
import 'package:bldrs/a_models/d_zone/b_country/flag.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class TextMod {
  // -----------------------------------------------------------------------------

  const TextMod();

  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  static String modifyAllCharactersWith({
    @required String characterToReplace,
    @required String replacement,
    @required String input,
  }) {
    return input.replaceAll(characterToReplace, replacement);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String obscureText({
    @required String text,
    String obscurityCharacter = '*',
  }){
    String _output = '';

    if (text.isNotEmpty == true){
      for (int i = 0; i < text.length; i++){
        _output = '$_output$obscurityCharacter';
      }

    }

    return _output;
  }
  // --------------------
  /// TASK TEST ME
  static String idifyString(String text){
    String _output;

    if (TextCheck.isEmpty(text) == false){

      _output = TextMod.modifyAllCharactersWith(
        characterToReplace: ' ',
        replacement: '_',
        input: text.trim().toLowerCase(),
      );

      _output = fixCountryName(_output);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// TEXT TAGS MODIFIER

  // --------------------
  /// TEXT VARIABLE TAGS
  static const String userNameVarTag1 = '<USERNAME1>';
  static const String userNameVarTag2 = '<USERNAME2>';
  static const String bzNameVarTag1 = '<BZNAME1>';
  static const String bzNameVarTag2 = '<BZNAME2>';
  static const String authorNameVarTag1 = '<AUTHORNAME1>';
  static const String authorNameVarTag2 = '<AUTHORNAME2>';
  static const String numberVarTag1 = '<NUMBER1>';
  static const String numberVarTag2 = '<NUMBER2>';
  // --------------------
  static const List<String> varTags = <String>[
    userNameVarTag1,
    userNameVarTag2,
    bzNameVarTag1,
    bzNameVarTag2,
    authorNameVarTag1,
    authorNameVarTag2,
    numberVarTag1,
    numberVarTag2,
  ];
  // --------------------
  static String replaceVarTag({
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

  // --------------------
  /// TESTED : WORKS PERFECT
  static String cutFirstCharacterAfterRemovingSpacesFromAString(String string) {

    final String _stringWithoutSpaces = removeSpacesFromAString(string?.trim());
    final String _firstCharacter = cutNumberOfCharactersOfAStringBeginning(_stringWithoutSpaces, 1);

    if (_stringWithoutSpaces == null || _stringWithoutSpaces == '' || _stringWithoutSpaces == ' '){
      return null;
    }
    else if (_firstCharacter == ''){
      return null;
    }
    else {
      return _firstCharacter;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String cutNumberOfCharactersOfAStringBeginning(String string, int number) {

    if (string == null || string?.isEmpty == true || string == '' || string == ' '){
      return null;
    }
    else {
      return string?.substring(0, number);

    }

  }
  // --------------------
  static String cutLastTwoCharactersFromAString(String string) {

    final List<String> _stringSplit = string.split('');
    final int _listLength = _stringSplit.length;

    if (_listLength == 0){
      return null;
    }

    else {
      final int _lastIndex = _listLength - 1;
      final int _beforeLastIndex = _listLength - 2;
      return '${_stringSplit[_beforeLastIndex]}${_stringSplit[_lastIndex]}';
    }

  }
  // -----------------------------------------------------------------------------

  /// REMOVERS

  // --------------------
  static String removeFirstCharacterFromAString(String string) {
    return string.isNotEmpty ? string?.substring(1) : null;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String removeNumberOfCharactersFromBeginningOfAString({
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
  // --------------------
  static String removeNumberOfCharactersFromEndOfAString(String string, int numberOfCharacters) {

    // if (numberOfCharacters > string.length){
    //   blog('can not remove ($numberOfCharacters) from the given string because : numberOfCharacters > string.length');
    //   throw('can not remove ($numberOfCharacters) from the given string because');
    // } else {}
    // blog('string length ${string.trim().length} and : numberOfCharacters : $numberOfCharacters');

    if (string != null && string.trim().isNotEmpty) {

      if (string.trim().length == numberOfCharacters) {
        return '';
      }

      else if (string.trim().length > numberOfCharacters) {
        return string.substring(0, string.trim().length - numberOfCharacters);
      }

      else {
        return '';
      }

    }

    else {
      return null;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String removeSpacesFromAString(String string) {
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static String removeTextAfterFirstSpecialCharacter(String verse, String specialCharacter) {
    String _result = verse;

    if (TextCheck.isEmpty(verse) == false){

      final bool _verseContainsChar = TextCheck.stringContainsSubString(
        string: verse,
        subString: specialCharacter,
      );

      if (_verseContainsChar == true) {
        _result = verse?.substring(0, verse.indexOf(specialCharacter));
      }

    }

    return _result;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String removeTextBeforeFirstSpecialCharacter(String verse, String specialCharacter) {
    String _result = verse;

    if (TextCheck.isEmpty(verse) == false){

      final bool _verseContainsChar = TextCheck.stringContainsSubString(
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

    }

    return _result;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String removeTextAfterLastSpecialCharacter(String verse, String specialCharacter) {
    String _result = verse;

    if (TextCheck.isEmpty(verse) == false){

      final bool _verseContainsChar = TextCheck.stringContainsSubString(
        string: verse,
        subString: specialCharacter,
      );

      if (_verseContainsChar == true) {
        _result = verse?.substring(0, verse.lastIndexOf(specialCharacter));
      }

    }

    return _result;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String removeTextBeforeLastSpecialCharacter(String verse, String specialCharacter) {
    String _result = verse;

    if (TextCheck.isEmpty(verse) == false){

      final bool _verseContainsChar = TextCheck.stringContainsSubString(
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

    }

    return _result;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String removeAllCharactersAfterNumberOfCharacters({
    @required String input,
    @required int numberOfChars,
  }) {
    String _output = input;

    if (input != null &&
        numberOfChars != null &&
        input.isNotEmpty &&
        numberOfChars > 0 &&
        input.length > numberOfChars) {
      _output = input.substring(0, numberOfChars);
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /*
  /// TASK DEPRECATED
  static String sqlCipherStrings(List<String> strings) {
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
   */
  // --------------------
  /// TASK DEPRECATED
  /*
  static List<String> sqlDecipherStrings(String text) {
    List<String> _strings;

    if (text != null) {
      _strings = text.split('__');
    }

    return _strings;
  }

   */

  /*
    test('sqlCipherStrings and sqlDecipherStrings', () {
    final List<String> strings = <String>['aa', 'bb', 'cc'];

    final String string = TextMod.sqlCipherStrings(strings);

    final List<String> _toListAgain = TextMod.sqlDecipherStrings(string);

    final List<String> _expected = strings;

    expect(_toListAgain, _expected);
  });
   */
  // -----------------------------------------------------------------------------

  /// TRANSFORMERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String getFileNameFromAsset(String asset) {
  /// this trims paths like 'assets/xx/pp_sodic/builds_1.jpg' to 'builds_1.jpg'
    return removeTextBeforeLastSpecialCharacter(asset, '/');
  }
  // --------------------
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
  // --------------------
  static Map<String, dynamic> getValueAndTrueMap(List<String> list) {
    final Map<String, dynamic> _result = <String, dynamic>{
      for (String string in list) string: true
    };
    return _result;
  }
  // --------------------
  /*
  // static List<dynamic> getValuesFromValueAndTrueMap(Map<String, dynamic> map) {
  //   return map.keys.toList();
  // }
   */
  // -----------------------------------------------------------------------------

  /// FIXERS

  // --------------------
  static String fixArabicText(String input) {
    /// TASK : alef hamza issue
    /// TASK : ya2 w alef maksoura issue
    /// TASK : ha2 w ta2 marbouta issue

    return 'Bokra isa';
  }
  // --------------------
  /// only user with country names, city names, districts names
  static String fixCountryName(String input) {
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
  // --------------------
  static String fixSearchText(String input){
    String _output;

    if (input != null && input != ''){

      _output = input.trim().toLowerCase();
      _output = removeSpacesFromAString(_output);
      // _output = fixArabicText(_output);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// TEXT CONTROLLERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static void controllerClear(TextEditingController controller){
    controller.text = '';
  }
  // --------------------
  static Future<String> paste() async {
    final String _text = await FlutterClipboard.paste();
    return _text;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> controllerPaste(TextEditingController controller) async {
    controller.text = await FlutterClipboard.paste();
  }
  // --------------------
  static Future<void> controllerCopy(BuildContext context, String value) async {
    await Keyboard.copyToClipboard(
      context: context,
      copy: value,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void setControllerSelectionAtEnd(TextEditingController controller){
    if (controller != null){
      controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
    }
  }
  // --------------------
  /// PHONE NUMBER
  // --------------------
  /// TESTED : WORKS PERFECT
  static String initializePhoneNumber({
    @required String number,
    @required String countryID,
  }){
    String initialNumber;

    /// NO NUMBER GIVEN
    if (TextCheck.isEmpty(number) == true){

      final String _code = Flag.getCountryPhoneCode(countryID);

      if (TextCheck.isEmpty(_code) == false){
        initialNumber = _code;
      }

    }

    /// NUMBER IS GIVEN
    else {
      initialNumber = number;
    }

    return initialNumber;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String nullifyNumberIfOnlyCountryCode({
    @required String number,
    @required String countryID,
  }){
    String _output;

    if (number != null && countryID != null){

      final String _code = Flag.getCountryPhoneCode(countryID);

      if (_code != number){
        _output = TextMod.removeSpacesFromAString(number);
      }

    }

    return _output;
  }
  // --------------------
  /// WEB LINK
  // --------------------
  static const String httpsCode = 'https://';
  // --------------------
  /// TESTED : WORKS PERFECT
  static String initializeWebLink({
    @required String url,
  }){
    String _initialText;

    /// NO URL GIVEN
    if (TextCheck.isEmpty(url) == true){
      _initialText = httpsCode;
    }

    /// URL IS GIVEN
    else {
      _initialText = url;
    }

    return _initialText;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String nullifyUrlLinkIfOnlyHTTPS({
    @required String url,
  }){
    String _output;

    /// URL IS DEFINED
    if (TextCheck.isEmpty(url) == false){

      if (httpsCode != url){
        _output = removeSpacesFromAString(url);
      }

    }

    return _output;
  }
  // --------------------

}

/*

ENCODE AND DECODE STRINGS for encryption

https://stackoverflow.com/questions/56201074/how-to-encode-and-decode-base64-and-base64url-in-flutter-dart

String credentials = "username:password";
Codec<String, String> stringToBase64 = utf8.fuse(base64);
String encoded = stringToBase64.encode(credentials);      // dXNlcm5hbWU6cGFzc3dvcmQ=
String decoded = stringToBase64.decode(encoded);          // username:password

 */
