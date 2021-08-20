import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Timers {
// -----------------------------------------------------------------------------
  /// "2019-07-19 8:40:23"
  static DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
// -----------------------------------------------------------------------------
  static String cipherDateTimeToString(DateTime dateTime){
    if(dateTime == null){
      return null;
    } else {
      return dateFormat?.format(dateTime);
    }
  }
// -----------------------------------------------------------------------------
  static List<String> cipherListOfDateTimes(List<DateTime> dateTimes){
    List<String> _dateTimesStringsList = new List();

    for (var dateTime in dateTimes){
      _dateTimesStringsList.add(cipherDateTimeToString(dateTime));
    }

    return _dateTimesStringsList;
  }
// -----------------------------------------------------------------------------
  static DateTime decipherDateTimeString(String dateTimeString){
    if (dateTimeString == null){
      return null;
    } else {
      return dateFormat?.parse(dateTimeString);
    }
  }
// -----------------------------------------------------------------------------
  static List<DateTime> decipherListOfDateTimesStrings(List<dynamic> dateTimesStrings){
    List<DateTime> _dateTimes = new List();

    for (var string in dateTimesStrings){
      _dateTimes.add(decipherDateTimeString(string));
    }

    return _dateTimes;
  }
// -----------------------------------------------------------------------------
  static String getMonthNameByInt(BuildContext context, int month){
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
// -----------------------------------------------------------------------------
  static String cipherDateTimeIso8601(DateTime dateTime){
    return dateTime.toIso8601String();
  }
// -----------------------------------------------------------------------------
  static DateTime decipherDateTimeIso8601(String cipheredDateTimeIso8601){
    return DateTime.parse(cipheredDateTimeIso8601);
  }
// -----------------------------------------------------------------------------
  static String stringOnDateMonthYear({BuildContext context, DateTime time}){
    String _day = '${(time).day}';
    String _monthString = Timers.getMonthNameByInt(context, (time).month);
    String _year = '${(time).year}';
    String _timeString = 'on ${_day} ${_monthString} ${_year}';

    return _timeString;
  }
// -----------------------------------------------------------------------------
  static String monthYearStringer(BuildContext context, DateTime time){
    return
      '${Wordz.inn(context)} ${Wordz.bldrsShortName(context)} since : ${Timers.getMonthNameByInt(context, (time).month)} ${(time).year}';
  }
// -----------------------------------------------------------------------------
  static String dayMonthYearStringer(BuildContext context, DateTime time){
    return
      '${Wordz.inn(context)} ${Wordz.bldrsShortName(context)} since : ${(time).day} ${Timers.getMonthNameByInt(context, (time).month)} ${(time).year}';
  }
// -----------------------------------------------------------------------------
  static String hourMinuteSecondStringer(DateTime time){
    return
      '${time.hour}:${time.minute}:${time.second}';
  }
// -----------------------------------------------------------------------------
  static String hourMinuteSecondListOfStrings(List<DateTime> times){
    String _output = '';

    for (int i = 0; i<times.length; i++){
      _output = '${_output+hourMinuteSecondStringer(times[i])}\n';
    }
    return _output;
  }
// -----------------------------------------------------------------------------
  static String hourMinuteSecondListOfStringsWithIndexes(List<DateTime> times, List<int> indexes){
    String _output = '';

    for (int i = 0; i<times.length; i++){

      String _indexString = '${indexes[i]} : ';
      String _timeStampString =  '${hourMinuteSecondStringer(times[i])}';

      _output = '${_output+_indexString+_timeStampString}\n';
    }
    return _output;
  }

}