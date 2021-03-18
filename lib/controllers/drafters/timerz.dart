import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
// -----------------------------------------------------------------
/// "2019-07-19 8:40:23"
DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
// -----------------------------------------------------------------
String cipherDateTimeToString(DateTime dateTime){
  return dateFormat?.format(dateTime);
}
// -----------------------------------------------------------------
DateTime decipherDateTimeString(String dateTimeString){
  return dateFormat?.parse(dateTimeString);
}
// -----------------------------------------------------------------
String getMonthNameByInt(BuildContext context, int month){
  switch (month){
    case 1    :    return  Wordz.january(context);  break;
    case 2    :    return  Wordz.february(context);  break;
    case 3    :    return  Wordz.march(context);  break;
    case 4    :    return  Wordz.april(context);  break;
    case 5    :    return  Wordz.may(context);  break;
    case 6    :    return  Wordz.june(context);  break;
    case 7    :    return  Wordz.july(context);  break;
    case 8    :    return  Wordz.august(context);  break;
    case 9    :    return  Wordz.september(context);  break;
    case 11   :    return  Wordz.november(context);  break;
    case 12   :    return  Wordz.december(context);  break;
    default : return null;
  }
}
// -----------------------------------------------------------------
String cipherDateTimeIso8601(DateTime dateTime){
  return dateTime.toIso8601String();
}
// -----------------------------------------------------------------
DateTime decipherDateTimeIso8601(String cipheredDateTimeIso8601){
  return DateTime.parse(cipheredDateTimeIso8601);
}
// -----------------------------------------------------------------
