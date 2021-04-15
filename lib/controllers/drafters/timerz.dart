import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
// -----------------------------------------------------------------
/// "2019-07-19 8:40:23"
DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
// -----------------------------------------------------------------
String cipherDateTimeToString(DateTime dateTime){
  if(dateTime == null){
    return null;
  } else {
    return dateFormat?.format(dateTime);
  }
}
// -----------------------------------------------------------------
List<String> cipherListOfDateTimes(List<DateTime> dateTimes){
  List<String> _dateTimesStringsList = new List();

  for (var dateTime in dateTimes){
    _dateTimesStringsList.add(cipherDateTimeToString(dateTime));
  }

  return _dateTimesStringsList;
}
// -----------------------------------------------------------------
DateTime decipherDateTimeString(String dateTimeString){
  if (dateTimeString == null){
    return null;
  } else {
    return dateFormat?.parse(dateTimeString);
  }
}
// -----------------------------------------------------------------
List<DateTime> decipherListOfDateTimesStrings(List<dynamic> dateTimesStrings){
  List<DateTime> _dateTimes = new List();

  for (var string in dateTimesStrings){
    _dateTimes.add(decipherDateTimeString(string));
  }

  return _dateTimes;
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
