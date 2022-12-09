import 'dart:math' as math;

import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class Numeric {
  // -----------------------------------------------------------------------------

  const Numeric();

  // -----------------------------------------------------------------------------

  /// FORMATTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String formatNumToSeparatedKilos({
    @required dynamic number,
    int fractions = 2,
    String separator = "'",
  }) {

    assert(number is int || number is double || number == null, 'number is neither int nor double');

    /// THE SEPARATOR AFTER EACH 3 DIGITS IN AN INTEGER X'XXX'XXX ...
    String _result = '0';
    final String _fractions = Numeric.getFractionStringWithoutZero(
      number: number?.toDouble() ?? 0,
      fractionDigits: fractions,
    );

    if (number != null) {

      int _numAsInt;
      if (number is double){
        _numAsInt = number.toInt();
      }
      else {
        _numAsInt = number;
      }

      /// -999 < x < 999
      if (_numAsInt > -1000 && _numAsInt < 1000) {
        _result = _numAsInt.toString();
      }

      /// 1000 < x
      else {

        final double _fractions = getFractions(
          number: _numAsInt.toDouble(),
        );

        final int _number = _numAsInt; //.floor();
        final String _digits = _number.abs().toString();
        final StringBuffer _separatedNumberWithoutFractions = StringBuffer(_number < 0 ? '-' : '');
        final int _maxDigitIndex = _digits.length - 1;

        for (int i = 0; i <= _maxDigitIndex; i += 1) {
          _separatedNumberWithoutFractions.write(_digits[i]);

          if (i < _maxDigitIndex && (_maxDigitIndex - i) % 3 == 0) {
            _separatedNumberWithoutFractions.write("'");
          }

        }

        if (_fractions > 0) {

          final String _fractionWithoutZero = getFractionStringWithoutZero(
            number: _fractions,
          );

          _result = '$_separatedNumberWithoutFractions.$_fractionWithoutZero';

        }

        else {
          _result = '$_separatedNumberWithoutFractions';
        }

      }

      // if (number == null) return '0';
      // if (number > -1000 && number < 1000) return number.toString();

      final String _digits = _numAsInt.abs().toString();
      final StringBuffer _resultStringBuffer = StringBuffer(_numAsInt < 0 ? '-' : '');
      final int maxDigitIndex = _digits.length - 1;

      for (int i = 0; i <= maxDigitIndex; i += 1) {

        _resultStringBuffer.write(_digits[i]);

        if (i < maxDigitIndex && (maxDigitIndex - i) % 3 == 0) {
          _resultStringBuffer.write(separator);
        }

      }
      _result =  _resultStringBuffer.toString();

    }

    if (TextCheck.isEmpty(_fractions) == false){
      return '$_result.$_fractions';
    }
    else {
      return _result;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String formatNumToCounterCaliber(BuildContext context, int x) {
    String _stringOfCalibratedNumber = '0';

    if (x != null) {
      /// FROM 0 TO 999
      if (x >= 0 && x < 1000) {
        _stringOfCalibratedNumber = x.toString();
      }

      /// FROM 1000 TO 99995
      else if (x >= 1000 && x < 99995) {
        _stringOfCalibratedNumber =
        '${(x / 1000).toStringAsFixed(1).replaceAll(RegExp('0.0'), '0').replaceAll(r'.0', '')}'
            ' ${xPhrase(context, 'phid_thousand')}';
      }

      /// FROM 99995 TO 999445
      else if (x >= 99995 && x < 999445) {
        _stringOfCalibratedNumber = '${int.parse((x / 1000).toStringAsFixed(0))}'
            ' ${xPhrase(context, 'phid_thousand')}';
      }

      /// FROM 999445 TO INFINITY
      else if (x >= 999445) {
        _stringOfCalibratedNumber =
        '${(x / 1000000).toStringAsFixed(1).replaceAll(RegExp('0.0'), '0').replaceAll(r'.0', '')}'
            ' ${xPhrase(context, 'phid_million')}';
      } else {
        _stringOfCalibratedNumber = x.toStringAsFixed(0);
      }
    }

    return _stringOfCalibratedNumber;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String formatNumberWithinDigits({
    @required int num,
    @required int digits,
  }) {

    /// this should put the number within number of digits
    /// for digits = 4,, any number should be written like this 0000
    /// 0001 -> 0010 -> 0100 -> 1000 -> 9999
    /// when num = 10000 => should return 'increase digits to view number'


    String _output;

    if (num != null){

      final int _maxPlusOne = calculateIntegerPower(num: 10, power: digits);
      final int _maxPossibleNum = _maxPlusOne - 1;

      if (num > _maxPossibleNum) {
        _output = 'XXXX';
      }

      else {

        String _numAsText = num.toString();

        for (int i = 1; i <= digits; i++) {

          if (_numAsText.length < digits) {
            _numAsText = '0$_numAsText';
          }

          else {
            break;
          }

        }

        _output = _numAsText;
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int concludeNumberOfDigits(int length){
    final int _length = length == null || length <= 0 ? 0 : length - 1;
    return _length.toString().length;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String formatIndexDigits({
    @required int index,
    @required int listLength,
  }){

    return formatNumberWithinDigits(
      digits: concludeNumberOfDigits(listLength),
      num: index,
    );

  }
  // -----------------------------------------------------------------------------

  /// TRANSFORMERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static int transformStringToInt(String string) {
    int _value;

    if (string != null) {
      _value = int.tryParse(string);
    }

    return _value;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double transformStringToDouble(String string) {
    double _value;

    // blog('stringToDouble : string : $string');

    if (string != null && string != '') {
      _value = double.tryParse(string);
    }

    return _value;
  }
  // -----------------------------------------------------------------------------

  /// CREATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static int createRandomIndex({
    int listLength = 1001, /// FOR 1000 ITEMS => ONLY VALUES FROM ( 0 -> 999 ) MAY RESULT
  }) {
    return math.Random().nextInt(listLength);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int createUniqueIndex({
    @required List<int> existingIndexes,
    int maxIndex = 999999,
  }) {

    /// from 0 up to 999'999 included if max index is not defined
    int _randomNumber = math.Random().nextInt(maxIndex + 1);

    // blog('random number is : $_randomNumber');

    if (Mapper.checkCanLoopList(existingIndexes)) {
      if (existingIndexes.contains(_randomNumber)) {
        _randomNumber = createUniqueIndex(
            existingIndexes: existingIndexes,
            maxIndex: maxIndex
        );
      }
    }

    return _randomNumber;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int createUniqueID({
    int maxDigitsCount = 16, // 8'640'000'000'000'000'000
  }) {
    assert(maxDigitsCount > 0 && maxDigitsCount <= 16, 'Take care : 0 < maxDigitsCount <= 16',);

    /// some smart ass stunt online said : DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final String _string = DateTime.now().microsecondsSinceEpoch.toString();

    final String _trimmed = TextMod.removeNumberOfCharactersFromBeginningOfAString(
      string: _string,
      numberOfCharacters: _string.length - maxDigitsCount,
    );


    return transformStringToInt(_trimmed);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static ValueKey<int> createUniqueKeyFrom({
    @required List<ValueKey<int>> existingKeys
  }) {

    final List<int> _existingValues = getValuesFromKeys(
        keys: existingKeys
    );

    final int _newValue = createUniqueIndex(existingIndexes: _existingValues);

    return ValueKey<int>(_newValue);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<dynamic> createListWithDummyValue({
    @required int length,
    @required int value,
  }) {
    final List<dynamic> _dummies = <dynamic>[];

    for (int i = 0; i < length; i++) {
      _dummies.add(value);
    }

    return _dummies;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<int> createRandomIndexes({
    @required int numberOfIndexes,
    @required int maxIndex,
  }) {
    final List<int> _indexes = <int>[];

    for (int i = 0; i < numberOfIndexes; i++) {

      final int _newIndex = createUniqueIndex(
          existingIndexes: _indexes,
          maxIndex: maxIndex
      );

      _indexes.add(_newIndex);
    }
    return _indexes;
  }
  // -----------------------------------------------------------------------------

  /// BOOL CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static int cipherBool({
    @required bool bool,
  }) {
    /// true => 1; false => 0 else => null => return false instead of null
    switch (bool) {
      case true: return 1; break;
      case false: return 0; break;
      default: return 0;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool decipherBool(int int) {
    /// 1 => true; 0 => false else => null (returning false instead of null)
    switch (int) {
      case 1: return true; break;
      case 0: return false; break;
      default: return false;
    }
  }
  // -----------------------------------------------------------------------------

  /// VALUE KEYS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<int> getValuesFromKeys({
    @required List<ValueKey<int>> keys,
  }) {
    final List<int> _values = <int>[];

    if (Mapper.checkCanLoopList(keys)) {
      for (final ValueKey<int> key in keys) {
        _values.add(key.value);
      }
    }

    return _values;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<ValueKey<int>> addUniqueKeyToKeys({
    @required List<ValueKey<int>> keys
  }) {
    final List<int> _numbers = getValuesFromKeys(keys: keys);

    final int _newValue = createUniqueIndex(existingIndexes: _numbers);

    final List<ValueKey<int>> _newKeys = <ValueKey<int>>[
      ...keys,
      ValueKey<int>(_newValue)
    ];

    return _newKeys;
  }
  // -----------------------------------------------------------------------------

  /// FRACTION

  // --------------------
  /// TESTED : WORKS PERFECT
  static double getFractions({
    @required double number,
    int fractionDigits,
  }) {

    /// NOTE : for 1.123 => returns 0.123

    final String _numberAsString =
    fractionDigits == null ? number.toString()
        :
    getFractionStringWithoutZero(
        number: number,
        fractionDigits: fractionDigits
    );

    final String _fractionsString = TextMod.removeTextBeforeLastSpecialCharacter(_numberAsString, '.');

    return transformStringToDouble('0.$_fractionsString');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double removeFractions({
    @required double number,
  }) {
    final double _fractions = getFractions(number: number);
    return number - _fractions;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double roundFractions(double value, int fractions) {
    final String _roundedAsString = value?.toStringAsFixed(fractions);
    return transformStringToDouble(_roundedAsString);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getFractionStringWithoutZero({
    @required double number,
    int fractionDigits
  }) {
    final String _numberAsString = number.toString();
    String _fractionAsStringWithoutZero = TextMod.removeTextBeforeLastSpecialCharacter(_numberAsString, '.');

    if (fractionDigits != null) {
      final int _fractionStringLength = _fractionAsStringWithoutZero.length;
      final int _trimmingLength = _fractionStringLength - fractionDigits;
      if (_trimmingLength >= 0) {
        _fractionAsStringWithoutZero =
            TextMod.removeNumberOfCharactersFromEndOfAString(
                _fractionAsStringWithoutZero, _trimmingLength);
      }
    }

    return _fractionAsStringWithoutZero;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int getNumberOfFractions({
    @required double number,
  }) {

    final double _numberFraction = getFractions(
        number: number,
        fractionDigits: 100,
    );

    final String _numberFractionsString = TextMod.removeTextBeforeFirstSpecialCharacter(
        _numberFraction.toString(), '.');

    return _numberFractionsString.trim().length;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkNumberAsStringHasInvalidDigits({
    @required String numberAsText,
    @required int maxDigits,
  }){
    bool _hasInvalidDigits = false;

    if (TextCheck.isEmpty(numberAsText) == false){
      final String _fractionsStrings = TextMod.removeTextBeforeFirstSpecialCharacter(numberAsText, '.');
      final int _numberOfFractions = _fractionsStrings.length;
      _hasInvalidDigits = _numberOfFractions > maxDigits;
    }

    return _hasInvalidDigits;
  }
  // -----------------------------------------------------------------------------

  /// CALCULATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static int calculateDiscountPercentage({
    @required double oldPrice,
    @required double currentPrice,
  }) {
    final double _percent = ((oldPrice - currentPrice) / oldPrice) * 100;
    return _percent.round();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int calculateIntegerPower({
    @required int num,
    @required int power,
  }) {

    /// NOTE :  num = 10; power = 2; => 10^2 = 100,, cheers
    int _output = 1;

    for (int i = 0; i < power; i++) {
      _output *= num;
    }

    return _output;
  }
  // --------------------
  static double calculateDoublePower({
    @required double num,
    @required int power,
  }) {

    /// NOTE :  num = 10; power = 2; => 10^2 = 100,, cheers
    double _output = 1;

    for (int i = 0; i < power; i++) {
      _output *= num;
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// ANGLES

  // --------------------
  /// TESTED : WORKS PERFECT
  static double  degreeToRadian(double degree){
    /// remember that dart starts from angle 0 on the right,, rotates clockWise when
    /// incrementing the angle degree,, while rotates counter clockwise when decrementing
    /// the angle degree.
    /// simply, Negative value goes counter ClockWise
    return degree * ( math.pi / 180 );
  }
  // -----------------------------------------------------------------------------

  /// BINARY SEARCH

  // --------------------
  /// TESTED : WORKS PERFECT
  static int binarySearch({
    @required List<int> list,
    @required int searchedValue, /// looking for which index in list is equal to 5 masalan
  }){

    int _min = 0;
    int _max = list.length - 1;

    int _output;

    while(_min <= _max){

      final int _mid = ((_min + _max)/ 2).floor();

      if (searchedValue == list[_mid]){

        blog('Found searchedValue at index $_mid');
        _output =  _mid;
      }

      else if (searchedValue < list[_mid]){
        _max = _mid - 1;
      }

      else {
        _min = _mid + 1;
      }

    }

    if (_output == null){
      blog('Not Found');
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// MODULUS

  // --------------------
  /// TESTED : WORKS PERFECT
  static double modulus(double num){
    double _val;

    /// NOTE : GETS THE ABSOLUTE VALUE OF A DOUBLE

    if (num != null){
      _val = math.sqrt(calculateDoublePower(num: num, power: 2));
    }

    return _val;
  }
  // -----------------------------------------------------------------------------

  /// INDEX MANIPULATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static int reverseIndex({
    @required int listLength,
    @required int index,
  }){

    List<int> _indexes = <int>[];
    for (int i = 0; i < listLength; i++){
      _indexes.add(i);
    }
    _indexes = _indexes.reversed.toList();

    final int _reversedIndex = _indexes.indexOf(index);

    return _reversedIndex;
  }
  // -----------------------------------------------------------------------------
}
