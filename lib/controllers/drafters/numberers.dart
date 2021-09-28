import 'dart:math';

import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
class Numberers {
  /// THE SEPARATOR AFTER EACH 3 DIGITS IN AN INTEGER X'XXX'XXX ...
  static String separateKilos({dynamic number, int fractions = 2}) {

    String _result = '0';

    if (number != null){

      if (number > -1000 && number < 1000){
        _result = number.toString();
      }

      else {

        final double _fractions = getFractions(number: number);
        final _number = number.floor();
        final String _digits = _number.abs().toString();
        final StringBuffer _separatedNumberWithoutFractions = StringBuffer(_number < 0 ? '-' : '');
        final int maxDigitIndex = _digits.length - 1;

        for (int i = 0; i <= maxDigitIndex; i += 1) {
          _separatedNumberWithoutFractions.write(_digits[i]);
          if (i < maxDigitIndex && (maxDigitIndex - i) % 3 == 0) _separatedNumberWithoutFractions.write('\'');
        }

        if (_fractions > 0){
          final String _fractionWithoutZero = getFractionStringWithoutZero(fraction: _fractions);
          _result = '$_separatedNumberWithoutFractions.$_fractionWithoutZero';
        }
        else {
          _result = '$_separatedNumberWithoutFractions';
        }

      }

      return _result;
    }

    // if (number == null) return '0';
    // if (number > -1000 && number < 1000) return number.toString();

    final String digits = number.abs().toString();
    final StringBuffer result = StringBuffer(number < 0 ? '-' : '');
    final int maxDigitIndex = digits.length - 1;
    for (int i = 0; i <= maxDigitIndex; i += 1) {
      result.write(digits[i]);
      if (i < maxDigitIndex && (maxDigitIndex - i) % 3 == 0) result.write('\'');
    }
    return result.toString();
  }
// -----------------------------------------------------------------------------
  static String counterCaliber(BuildContext context, int x) {

    String _stringOfCalibratedNumber = '0';

    if(x != null){

      /// FROM 0 TO 999
      if (x >= 0 && x < 1000 ){
        _stringOfCalibratedNumber = x.toString();
      }

      /// FROM 1000 TO 99995
      else if(x >= 1000 && x < 99995){
        _stringOfCalibratedNumber = '${(x / 1000).toStringAsFixed(1).toString()
            .replaceAll(RegExp('0.0'), '0')
            .replaceAll(r'.0', '')}'
            ' ${Wordz.thousand(context)}';
      }

      /// FROM 99995 TO 999445
      else if (x >= 99995 && x < 999445 ){
        _stringOfCalibratedNumber = '${int.parse((x / 1000).toStringAsFixed(0))}'
            ' ${Wordz.thousand(context)}';
      }

      /// FROM 999445 TO INFINITY
      else if (x >= 999445){
        _stringOfCalibratedNumber = '${(x / 1000000).toStringAsFixed(1).toString().replaceAll(
            RegExp('0.0'), '0').replaceAll(r'.0', '')}'
            ' ${Wordz.million(context)}';
      }

      else {
        _stringOfCalibratedNumber = '${x.toStringAsFixed(0)}';
      }

    }

    return _stringOfCalibratedNumber;
  }
// -----------------------------------------------------------------------------
  static int stringToInt(String string) {
    return int.parse(string);
  }
// -----------------------------------------------------------------------------
  static double stringToDouble(String string){
    return double.parse(string);
  }
// -----------------------------------------------------------------------------
  static int lastTwoIntegersFromAString(String string) {
    String _lastTwoSubStrings = TextMod.lastTwoSubStringsFromAString(string);
    int _asIntegers = stringToInt(_lastTwoSubStrings);
    return _asIntegers;
  }
// -----------------------------------------------------------------------------
  static int createRandomIndex({int listLength}){
    Random _random = new Random();
    return _random.nextInt(listLength);
  }
// -----------------------------------------------------------------------------
  static int createUniqueIndex({@required List<int> existingIndexes, int maxIndex = 999999}) {
    Random _random = new Random();

    /// from 0 up to 999'999 included
    int _randomNumber = _random.nextInt(maxIndex+1);

    // print('random number is : $_randomNumber');

    if (existingIndexes != null && existingIndexes.length != 0){
      if (existingIndexes.contains(_randomNumber)){
        _randomNumber = createUniqueIndex(existingIndexes: existingIndexes, maxIndex: maxIndex);
      }
    }

    return _randomNumber;
  }
// -----------------------------------------------------------------------------
  static List<int> getValuesFromKeys({@required List<ValueKey> keys}) {
    List<int> _values = [];

    if (keys != null && keys.length != 0) {
      keys.forEach((key) {
        _values.add(key.value);
      });
    }

    return _values;
  }
// -----------------------------------------------------------------------------
  static List<ValueKey> addUniqueKeyToKeys({@required List<ValueKey> keys}) {
    List<int> _numbers = getValuesFromKeys(keys: keys);

    int _newValue = createUniqueIndex(existingIndexes: _numbers);

    List<ValueKey> _newKeys = <ValueKey>[...keys, ValueKey(_newValue)];

    return _newKeys;
  }
// -----------------------------------------------------------------------------
  static ValueKey createUniqueKeyFrom({@required List<ValueKey> existingKeys}) {
    List<int> _existingValues = getValuesFromKeys(keys: existingKeys);

    int _newValue = createUniqueIndex(existingIndexes: _existingValues);

    return ValueKey(_newValue);
  }
// -----------------------------------------------------------------------------
  static List<dynamic> createListWithDummyValue({@required int length, @required int value}){
    List<dynamic> _dummies = [];

    for (int i = 0; i < length; i++){
      _dummies.add(value);
    }

    return _dummies;
  }
// -----------------------------------------------------------------------------
  static int createUniqueID(){
    return DateTime.now().microsecondsSinceEpoch;
  }
// -----------------------------------------------------------------------------
  /// for 1.123 => returns 0.123
  static double getFractions({double number, int fractionDigits}){

    final String _numberAsString = fractionDigits == null ? number.toString() : getFractionStringWithoutZero(fraction: number, fractionDigits: fractionDigits);
    final String _fractionsString = TextMod.trimTextBeforeLastSpecialCharacter(_numberAsString, '.');
    final double _fraction = stringToDouble('0.$_fractionsString');
    return _fraction;
  }
// -----------------------------------------------------------------------------
  static removeFractions({double number}){
    final double _fractions = getFractions(number: number);
    return number - _fractions;
  }
// -----------------------------------------------------------------------------
  static double roundFractions(double value, int fractions){
    String _roundedAsString = value.toStringAsFixed(fractions);
    double _rounded = stringToDouble(_roundedAsString);
    return _rounded;
  }
// -----------------------------------------------------------------------------
  static String getFractionStringWithoutZero({double fraction, int fractionDigits}){
    final String _fractionAsString = fraction.toString();
    String _fractionAsStringWithoutZero = TextMod.trimTextBeforeLastSpecialCharacter(_fractionAsString, '.');

    if (fractionDigits != null){
      final int _fractionStringLength = _fractionAsStringWithoutZero.length;
      final int _trimmingLength = _fractionStringLength - fractionDigits;
      if(_trimmingLength >= 0){
        _fractionAsStringWithoutZero = TextMod.removeNumberOfCharactersFromEndOfAString(_fractionAsStringWithoutZero, _trimmingLength);
      }
    }

    return _fractionAsStringWithoutZero;
  }
// -----------------------------------------------------------------------------
  static int discountPercentage({double oldPrice, double currentPrice}){
    double percent = ((oldPrice - currentPrice) / oldPrice ) * 100;
    return percent.round();
  }
// -----------------------------------------------------------------------------
  static List<int> getRandomIndexes({int numberOfIndexes, @required int maxIndex}){
    List<int> _indexes = [];
    for (int i = 0; i < numberOfIndexes; i++) {
      int _newIndex = createUniqueIndex(existingIndexes: _indexes, maxIndex: maxIndex);
      _indexes.add(_newIndex);
    }
    return _indexes;
  }
// -----------------------------------------------------------------------------
}