import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:flutter/material.dart';

/// THE SEPARATOR AFTER EACH 3 DIGITS IN AN INTEGER X'XXX'XXX ...
String separateKilos(int number) {
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

String counterCaliber(BuildContext context, int x){
       return
            // FROM 0 TO 999
            x >= 0 && x < 1000 ?
                x.toString()
            :
            // FROM 1000 TO 99995
            x >= 1000 && x < 99995 ?
            '${(x / 1000).toStringAsFixed(1).toString().replaceAll(RegExp('0.0'), '0').replaceAll(r'.0', '')}'
                ' ${getTranslated(context, 'Thousand')}'
                :
            // FROM 99995 TO 999445
            x >= 99995 && x < 999445 ? '${int.parse((x/1000).toStringAsFixed(0))}'
                ' ${getTranslated(context, 'Thousand')}'
                :
            // FROM 999445 TO INFINITY
            x>= 999445 ?
            '${(x / 1000000).toStringAsFixed(1).toString().replaceAll(RegExp('0.0'), '0').replaceAll(r'.0', '')}'
                ' ${getTranslated(context, 'Million')}'
                :
            '${x.toStringAsFixed(0)}';
    }
