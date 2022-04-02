import 'dart:math' as math;

import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
/// THE SEPARATOR AFTER EACH 3 DIGITS IN AN INTEGER X'XXX'XXX ...
String separateKilos({@required dynamic number, int fractions = 2}) {
  String _result = '0';

  if (number != null) {
    if (number > -1000 && number < 1000) {
      _result = number.toString();
    } else {
      final double _fractions = getFractions(number: number.toDouble());
      final int _number = number.floor();
      final String _digits = _number.abs().toString();
      final StringBuffer _separatedNumberWithoutFractions =
          StringBuffer(_number < 0 ? '-' : '');
      final int _maxDigitIndex = _digits.length - 1;

      for (int i = 0; i <= _maxDigitIndex; i += 1) {
        _separatedNumberWithoutFractions.write(_digits[i]);

        if (i < _maxDigitIndex && (_maxDigitIndex - i) % 3 == 0) {
          _separatedNumberWithoutFractions.write("'");
        }
      }

      if (_fractions > 0) {
        final String _fractionWithoutZero =
            getFractionStringWithoutZero(fraction: _fractions);
        _result = '$_separatedNumberWithoutFractions.$_fractionWithoutZero';
      } else {
        _result = '$_separatedNumberWithoutFractions';
      }
    }

    return _result;
  }

  // if (number == null) return '0';
  // if (number > -1000 && number < 1000) return number.toString();

  final String _digits = number.abs().toString();
  final StringBuffer _resultStringBuffer = StringBuffer(number < 0 ? '-' : '');
  final int maxDigitIndex = _digits.length - 1;

  for (int i = 0; i <= maxDigitIndex; i += 1) {
    _resultStringBuffer.write(_digits[i]);

    if (i < maxDigitIndex && (maxDigitIndex - i) % 3 == 0) {
      _resultStringBuffer.write("'");
    }
  }
  return _resultStringBuffer.toString();
}
// -----------------------------------------------------------------------------
String counterCaliber(BuildContext context, int x) {
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
          ' ${Wordz.thousand(context)}';
    }

    /// FROM 99995 TO 999445
    else if (x >= 99995 && x < 999445) {
      _stringOfCalibratedNumber = '${int.parse((x / 1000).toStringAsFixed(0))}'
          ' ${Wordz.thousand(context)}';
    }

    /// FROM 999445 TO INFINITY
    else if (x >= 999445) {
      _stringOfCalibratedNumber =
          '${(x / 1000000).toStringAsFixed(1).replaceAll(RegExp('0.0'), '0').replaceAll(r'.0', '')}'
          ' ${Wordz.million(context)}';
    } else {
      _stringOfCalibratedNumber = x.toStringAsFixed(0);
    }
  }

  return _stringOfCalibratedNumber;
}
// -----------------------------------------------------------------------------
int stringToInt(String string) {
  int _value;

  if (string != null) {
    _value = int.parse(string);
  }

  return _value;
}
// -----------------------------------------------------------------------------
double stringToDouble(String string) {
  double _value;

  // blog('stringToDouble : string : $string');

  if (string != null && string != '') {
    _value = double.parse(string);
  }

  return _value;
}
// -----------------------------------------------------------------------------
int lastTwoIntegersFromAString(String string) {
  final String _lastTwoSubStrings = TextMod.cutLastTwoCharactersFromAString(string);
  final int _asIntegers = stringToInt(_lastTwoSubStrings);
  return _asIntegers;
}
// -----------------------------------------------------------------------------
int createRandomIndex({int listLength = 999}) {
  final math.Random _random = math.Random();
  return _random.nextInt(listLength);
}
// -----------------------------------------------------------------------------
int createUniqueIndex({
  @required List<int> existingIndexes,
  int maxIndex = 999999,
}) {

  final math.Random _random = math.Random();

  /// from 0 up to 999'999 included if max index is not defined
  int _randomNumber = _random.nextInt(maxIndex + 1);

  // blog('random number is : $_randomNumber');

  if (Mapper.canLoopList(existingIndexes)) {
    if (existingIndexes.contains(_randomNumber)) {
      _randomNumber = createUniqueIndex(
          existingIndexes: existingIndexes,
          maxIndex: maxIndex
      );
    }
  }

  return _randomNumber;
}
// -----------------------------------------------------------------------------
List<int> getValuesFromKeys({@required List<ValueKey<int>> keys}) {
  final List<int> _values = <int>[];

  if (Mapper.canLoopList(keys)) {
    for (final ValueKey<int> key in keys) {
      _values.add(key.value);
    }
  }

  return _values;
}
// -----------------------------------------------------------------------------
List<ValueKey<int>> addUniqueKeyToKeys({@required List<ValueKey<int>> keys}) {
  final List<int> _numbers = getValuesFromKeys(keys: keys);

  final int _newValue = createUniqueIndex(existingIndexes: _numbers);

  final List<ValueKey<int>> _newKeys = <ValueKey<int>>[
    ...keys,
    ValueKey<int>(_newValue)
  ];

  return _newKeys;
}
// -----------------------------------------------------------------------------
ValueKey<int> createUniqueKeyFrom({
  @required List<ValueKey<int>> existingKeys
}) {
  final List<int> _existingValues = getValuesFromKeys(keys: existingKeys);

  final int _newValue = createUniqueIndex(existingIndexes: _existingValues);

  return ValueKey<int>(_newValue);
}
// -----------------------------------------------------------------------------
List<dynamic> createListWithDummyValue({
  @required int length,
  @required int value,
}) {
  final List<dynamic> _dummies = <dynamic>[];

  for (int i = 0; i < length; i++) {
    _dummies.add(value);
  }

  return _dummies;
}
// -----------------------------------------------------------------------------
int createUniqueID() {
  return DateTime.now().microsecondsSinceEpoch;
}
// -----------------------------------------------------------------------------
/// for 1.123 => returns 0.123
double getFractions({
  @required double number,
  int fractionDigits,
}) {
  final String _numberAsString = fractionDigits == null ? number.toString()
      :
  getFractionStringWithoutZero(
      fraction: number,
      fractionDigits: fractionDigits
  );

  final String _fractionsString = TextMod.removeTextBeforeLastSpecialCharacter(_numberAsString, '.');
  final double _fraction = stringToDouble('0.$_fractionsString');
  return _fraction;
}
// -----------------------------------------------------------------------------
double removeFractions({@required double number}) {
  final double _fractions = getFractions(number: number);
  return number - _fractions;
}
// -----------------------------------------------------------------------------
double roundFractions(double value, int fractions) {
  final String _roundedAsString = value.toStringAsFixed(fractions);
  final double _rounded = stringToDouble(_roundedAsString);
  return _rounded;
}
// -----------------------------------------------------------------------------
String getFractionStringWithoutZero({
  @required double fraction,
  int fractionDigits
}) {
  final String _fractionAsString = fraction.toString();
  String _fractionAsStringWithoutZero = TextMod.removeTextBeforeLastSpecialCharacter(_fractionAsString, '.');

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
// -----------------------------------------------------------------------------
int getNumberOfFractions({@required double number}) {
  final double _numberFraction = getFractions(number: number, fractionDigits: 100);
  final String _numberFractionsString = TextMod.removeTextBeforeFirstSpecialCharacter(
          _numberFraction.toString(), '.');
  blog('getNumberOfFractions : _numberFractionsString : $_numberFractionsString');
  final int _numberFractions = _numberFractionsString.trim().length;
  blog('_numberFractions : $_numberFractions');
  return _numberFractions;
}
// -----------------------------------------------------------------------------
int discountPercentage({
  @required double oldPrice,
  @required double currentPrice,
}) {
  final double _percent = ((oldPrice - currentPrice) / oldPrice) * 100;
  return _percent.round();
}
// -----------------------------------------------------------------------------
List<int> getRandomIndexes({
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
/// true => 1; false => 0 else => null => return false instead of null
int cipherBool({@required bool bool}) {
  switch (bool) {
    case true: return 1; break;
    case false: return 0; break;
    default: return 0;
  }
}
// -----------------------------------------------------------------------------
/// 1 => true; 0 => false else => null (returning false instead of null)
bool decipherBool(int int) {
  switch (int) {
    case 1: return true; break;
    case 0: return false; break;
    default: return false;
  }
}
// -----------------------------------------------------------------------------
/// this should put the number within number of digits
/// for digits = 4,, any number should be written like this 0000
/// 0001 -> 0010 -> 0100 -> 1000 -> 9999
/// when num = 10000 => should return 'increase digits to view number'
String getNumberWithinDigits({
  @required int num,
  @required int digits,
}) {

  final int _maxPlusOne = power(num: 10, power: digits);
  final int _maxPossibleNum = _maxPlusOne - 1;

  String _output;

  if (num >= _maxPossibleNum) {
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

  return _output;
}
// -----------------------------------------------------------------------------
/// num = 10; power = 2; => 10^2 = 100,, cheers
int power({
  @required int num,
  @required int power,
}) {
  int _output = 1;

  for (int i = 0; i < power; i++) {
    _output *= num;
  }

  return _output;
}
// -----------------------------------------------------------------------------
double degreeToRadian(double degree){
/// remember that dart starts from angle 0 on the right,, rotates clockWise when
/// incrementing the angle degree,, while rotates counter clockwise when decrementing
/// the angle degree.
/// simply, Negative value goes counter ClockWise
  final double _radian = degree * ( math.pi / 180 );
  return _radian;
}
// -----------------------------------------------------------------------------
int binarySearch({
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
