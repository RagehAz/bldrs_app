import 'dart:math';

import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
class Numberers {
  /// THE SEPARATOR AFTER EACH 3 DIGITS IN AN INTEGER X'XXX'XXX ...
  static String separateKilos(int number) {
    if (number == null) return '0';
    if (number > -1000 && number < 1000) return number.toString();

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
  static int lastTwoIntegersFromAString(String string) {
    String _lastTwoSubStrings = TextMod.lastTwoSubStringsFromAString(string);
    int _asIntegers = stringToInt(_lastTwoSubStrings);
    return _asIntegers;
  }
// -----------------------------------------------------------------------------
  /// TASK : this method needs testing
  static int createUniqueIntFrom({@required List<int> existingValues}) {
    Random _random = new Random();
    int _randomNumber = _random.nextInt(1000000); // from 0 up to 999'999 included

    if (existingValues == null || existingValues.length == 0){
      _randomNumber = _random.nextInt(1000000);
    }

    else if (existingValues.contains(_randomNumber)) {
      _randomNumber = createUniqueIntFrom(existingValues: existingValues);
    }

    else {
      /// will use initial random number created
    }

    return _randomNumber;
  }
// -----------------------------------------------------------------------------
  static List<int> getValuesFromKeys({@required List<ValueKey> keys}) {
    List<int> _values = new List();

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

    int _newValue = createUniqueIntFrom(existingValues: _numbers);

    List<ValueKey> _newKeys = <ValueKey>[...keys, ValueKey(_newValue)];

    return _newKeys;
  }
// -----------------------------------------------------------------------------
  static ValueKey createUniqueKeyFrom({@required List<ValueKey> existingKeys}) {
    List<int> _existingValues = getValuesFromKeys(keys: existingKeys);

    int _newValue = createUniqueIntFrom(existingValues: _existingValues);

    return ValueKey(_newValue);
  }
// -----------------------------------------------------------------------------
  static List<dynamic> createListWithDummyValue({@required int length, @required int value}){
    List<dynamic> _dummies = new List();

    for (int i = 0; i < length; i++){
      _dummies.add(value);
    }

    return _dummies;
  }
// -----------------------------------------------------------------------------
}