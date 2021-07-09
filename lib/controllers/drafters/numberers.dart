import 'dart:math';

import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
class Numberers{
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
  static String counterCaliber(BuildContext context, int x){
       return
         x == null ? 0 :
         // FROM 0 TO 999
         x >= 0 && x < 1000 ?
         x.toString()
             :
         // FROM 1000 TO 99995
         x >= 1000 && x < 99995 ?
         '${(x / 1000).toStringAsFixed(1).toString().replaceAll(RegExp('0.0'), '0').replaceAll(r'.0', '')}'
             ' ${Wordz.thousand(context)}'
             :
         // FROM 99995 TO 999445
         x >= 99995 && x < 999445 ? '${int.parse((x/1000).toStringAsFixed(0))}'
             ' ${Wordz.thousand(context)}'
             :
         // FROM 999445 TO INFINITY
         x>= 999445 ?
         '${(x / 1000000).toStringAsFixed(1).toString().replaceAll(RegExp('0.0'), '0').replaceAll(r'.0', '')}'
             ' ${Wordz.million(context)}'
             :
         '${x.toStringAsFixed(0)}';
}
// -----------------------------------------------------------------------------
  static int stringToInt(String string){
  return int.parse(string);
}
// -----------------------------------------------------------------------------
  static int lastTwoIntegersFromAString(String string){
  String _lastTwoSubStrings = lastTwoSubStringsFromAString(string);
  int _asIntegers = stringToInt(_lastTwoSubStrings);
  return _asIntegers;
}
// -----------------------------------------------------------------------------
  static int getRandomIntNotInList({@required List<int> list}) {
  Random _random = new Random();
  int _randomNumber = _random.nextInt(1000000); // from 0 up to 999'999 included

  if (_randomNumber == null) {
    _randomNumber = getRandomIntNotInList(list: list);
  }

  else if (list != null && list.contains(_randomNumber)) {
    _randomNumber = getRandomIntNotInList(list: list);
  }

  else {
    _randomNumber = null;
  }

  return _randomNumber;
}
// -----------------------------------------------------------------------------
  static List<ValueKey> AddRandomIntToListOfKeys({@required List<ValueKey> keys}){
    List<int> _numbers = new List();

    if (keys !=null){
      keys.forEach((key) {
        _numbers.add(key.value);
      });
    }

    int _newValue = getRandomIntNotInList(list: _numbers);

    List<ValueKey> _newKeys = <ValueKey>[...keys, ValueKey(_newValue)];

    return _newKeys;
  }
// -----------------------------------------------------------------------------
}
