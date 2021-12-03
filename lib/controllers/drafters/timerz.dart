import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

/*

DAY                          d
 ABBR_WEEKDAY                 E
 WEEKDAY                      EEEE
 ABBR_STANDALONE_MONTH        LLL
 STANDALONE_MONTH             LLLL
 NUM_MONTH                    M
 NUM_MONTH_DAY                Md
 NUM_MONTH_WEEKDAY_DAY        MEd
 ABBR_MONTH                   MMM
 ABBR_MONTH_DAY               MMMd
 ABBR_MONTH_WEEKDAY_DAY       MMMEd
 MONTH                        MMMM
 MONTH_DAY                    MMMMd
 MONTH_WEEKDAY_DAY            MMMMEEEEd
 ABBR_QUARTER                 QQQ
 QUARTER                      QQQQ
 YEAR                         y
 YEAR_NUM_MONTH               yM
 YEAR_NUM_MONTH_DAY           yMd
 YEAR_NUM_MONTH_WEEKDAY_DAY   yMEd
 YEAR_ABBR_MONTH              yMMM
 YEAR_ABBR_MONTH_DAY          yMMMd
 YEAR_ABBR_MONTH_WEEKDAY_DAY  yMMMEd
 YEAR_MONTH                   yMMMM
 YEAR_MONTH_DAY               yMMMMd
 YEAR_MONTH_WEEKDAY_DAY       yMMMMEEEEd
 YEAR_ABBR_QUARTER            yQQQ
 YEAR_QUARTER                 yQQQQ
 HOUR24                       H
 HOUR24_MINUTE                Hm
 HOUR24_MINUTE_SECOND         Hms
 HOUR                         j
 HOUR_MINUTE                  jm
 HOUR_MINUTE_SECOND           jms
 HOUR_MINUTE_GENERIC_TZ       jmv
 HOUR_MINUTE_TZ               jmz
 HOUR_GENERIC_TZ              jv
 HOUR_TZ                      jz
 MINUTE                       m
 MINUTE_SECOND                ms
 SECOND                       s
Examples Using the US Locale:

 Pattern                           Result
 ----------------                  -------
 new DateFormat.yMd()             -> 7/10/1996
 new DateFormat("yMd")            -> 7/10/1996
 new DateFormat.yMMMMd("en_US")   -> July 10, 1996
 new DateFormat.jm()              -> 5:08 PM
 new DateFormat.yMd().add_jm()    -> 7/10/1996 5:08 PM
 new DateFormat.Hm()              -> 17:08 // force 24 hour time

 */

abstract class Timers {
// -----------------------------------------------------------------------------
  /// "2019-07-19 8:40:23"
  static final DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
// -----------------------------------------------------------------------------
  static dynamic cipherTime({@required DateTime time, @required bool toJSON}){
    final dynamic _output = toJSON ? _cipherDateTimeIso8601(time) : time;
    return _output;
  }
// -----------------------------------------------------------------------------
  static DateTime decipherTime({@required dynamic time, @required bool fromJSON}){
    final DateTime _output = fromJSON == true ? _decipherDateTimeIso8601(time) : time?.toDate();
    return _output;
  }
// -----------------------------------------------------------------------------
  static List<dynamic> cipherTimes({@required List<DateTime> times, @required bool toJSON}){
    final List<dynamic> _times = <String>[];

    if (Mapper.canLoopList(times)){

      for (DateTime time in times){
        _times.add(cipherTime(
          time: time,
          toJSON: toJSON,
        ));
      }

    }

    return _times;
  }
// -----------------------------------------------------------------------------
  static List<DateTime> decipherTimes({@required List<dynamic> times, @required bool fromJSON}){
    final List<DateTime> _dateTimes = <DateTime>[];

    for (dynamic time in times){
      _dateTimes.add(
          decipherTime(
            time: time,
            fromJSON: fromJSON,
          )
      );
    }

    return _dateTimes;
  }
// -----------------------------------------------------------------------------
  static String _cipherDateTimeIso8601(DateTime dateTime){
    String _string;

    if (dateTime != null){
      _string = dateTime.toIso8601String();
    }

    return _string;
  }
// -----------------------------------------------------------------------------
  static DateTime _decipherDateTimeIso8601(String cipheredDateTimeIso8601){
    DateTime _time;

    if (cipheredDateTimeIso8601 != null){
      _time = DateTime.parse(cipheredDateTimeIso8601);
    }

    return _time;
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
  /// we may revise datetimes timestamps isoStrings for firebase, sembast & sql
  static Timestamp decipherDateTimeIso8601ToTimeStamp(String cipheredDateTimeIso8601){
    Timestamp _time;

    if (cipheredDateTimeIso8601 != null){
      DateTime _dateTime = _decipherDateTimeIso8601(cipheredDateTimeIso8601);
      _time = Timestamp.fromDate(_dateTime);
    }

    return _time;
  }
// -----------------------------------------------------------------------------
  static DateTime createDateTime({int year, int month, int day, int hour, int minute, int second, int millisecond, int microsecond}){
     final DateTime _now = DateTime.now();
     final DateTime _localTime = _now.toLocal();

    final int _year = year ?? _localTime.year;
    final int _month = month ?? _localTime.month;
    final int _day = day ?? _localTime.day;
    final int _hour = hour ?? _localTime.hour;
    final int _minute = minute ?? _localTime.minute;
    final int _second = second ?? _localTime.second;
    final int _millisecond = millisecond ?? _localTime.millisecond;
    final int _microsecond = microsecond ?? _localTime.microsecond;

    final DateTime _output = new DateTime(_year, _month, _day, _hour, _minute, _second, _millisecond, _microsecond);

    return _output;
  }
// -----------------------------------------------------------------------------
  static DateTime createDate({@required int year, @required int month, @required int day}){
    return
        createDateTime(
            year: year,
            month: month,
            day: day,
            hour: 0,
            minute: 0,
            second: 0,
            millisecond: 0,
            microsecond: 0,
        );
  }
// -----------------------------------------------------------------------------
  static DateTime createClock({@required int hour, @required int minute, int second}){
    return
      createDateTime(
        year: DateTime.now().toLocal().year,
        month: DateTime.now().toLocal().month,
        day: DateTime.now().toLocal().day,
        hour: hour,
        minute: minute,
        second: second ?? 0,//DateTime.now().toLocal().second,
        millisecond: 0,
        microsecond: 0,
      );
  }
// -----------------------------------------------------------------------------
  static DateTime createDateAndClock({@required int year, @required int month, @required int day, @required int hour, @required int minute, int second}){
    return
      createDateTime(
        year: year,
        month: month,
        day: day,
        hour: hour,
        minute: minute,
        second: second ?? DateTime.now().toLocal().second,
        millisecond: 0,
        microsecond: 0,
      );
  }
// -----------------------------------------------------------------------------
  static int getTimeDifferenceInSeconds({DateTime from, DateTime to}){

    // print('from is : $from');
    // print('to is : $to');

    return (to.difference(from).inSeconds);
  }
// -----------------------------------------------------------------------------
  static int getTimeDifferenceInMinutes({DateTime from, DateTime to}){
    return (to.difference(from).inMinutes);
  }
// -----------------------------------------------------------------------------
  static int getTimeDifferenceInHours({DateTime from, DateTime to}){
    return (to.difference(from).inHours);
  }
// -----------------------------------------------------------------------------
  static int getTimeDifferenceInDays({DateTime from, DateTime to}){
    return (to.difference(from).inDays);
  }
// -----------------------------------------------------------------------------
  static int getTimeDifferenceInWeeks({DateTime from, DateTime to}){
    final int _differenceInDays = getTimeDifferenceInDays(from: from, to: to);
    return (_differenceInDays / 7).floor();
  }
// -----------------------------------------------------------------------------
  static int getTimeDifferenceInMonths({DateTime from, DateTime to}){
    final int _differenceInDays = getTimeDifferenceInDays(from: from, to: to);
    return (_differenceInDays / 30).floor();
  }
// -----------------------------------------------------------------------------
  static int getTimeDifferenceInYears({DateTime from, DateTime to}){
    final int _differenceInDays = getTimeDifferenceInDays(from: from, to: to);
    return (_differenceInDays / 365).floor();
  }
// -----------------------------------------------------------------------------
  static String getSuperTimeDifferenceString({@required DateTime from, @required DateTime to}) {
    String _string = '...';

    if (from != null){
      final int _seconds = getTimeDifferenceInSeconds(from: from, to: to);

      if (_seconds < 60){
        _string = '$_seconds seconds ago';
      }

      /// MINUTE = 60 s
      else if (_seconds >= 60 && _seconds < 3600){
        final int _minutes = getTimeDifferenceInMinutes(from: from, to: to);
        _string = '$_minutes minutes ago';
      }

      /// HOUR = 3'600 s
      else if (_seconds >= 3600 && _seconds < 86400){
        final int _hours = getTimeDifferenceInHours(from: from, to: to);
        _string = '$_hours hours ago';
      }

      /// DAY = 86'400 s
      else if (_seconds >= 86400 && _seconds < 604800){
        final int _days = getTimeDifferenceInDays(from: from, to: to);
        _string = '$_days days ago';
      }

      /// WEEK = 604'800 s
      else if (_seconds >= 604800 && _seconds < 2592000){
        final int _weeks = getTimeDifferenceInWeeks(from: from, to: to);
        _string = '$_weeks weeks ago';
      }

      /// MONTH = 2'592'000 s
      else if (_seconds >= 2592000 && _seconds < 31536000){
        final int _months = getTimeDifferenceInMonths(from: from, to: to);
        _string = '$_months months ago';
      }

      /// YEAR = 31'536'000 s
      else {
        final int _years = getTimeDifferenceInMonths(from: from, to: to);
        _string = '$_years years ago';
      }

    }

    return _string;
  }
// -----------------------------------------------------------------------------
  static String stringOnDateMonthYear({BuildContext context, DateTime time}){
    final String _day = '${(time).day}';
    final String _monthString = Timers.getMonthNameByInt(context, (time).month);
    final String _year = '${(time).year}';
    final String _timeString = 'on ${_day} ${_monthString} ${_year}';

    return _timeString;
  }
// -----------------------------------------------------------------------------
  static String getString_dd_month_yyyy({BuildContext context, DateTime time}){
    final String _day = '${(time).day}';
    final String _monthString = Timers.getMonthNameByInt(context, (time).month);
    final String _year = '${(time).year}';
    final String _timeString = '${_day} ${_monthString} ${_year}';
    return _timeString;
  }
// -----------------------------------------------------------------------------
  static String getString_dd_I_mm_I_yyyy({BuildContext context, DateTime time}){
    final String _day = '${(time).day}';
    final String _year = '${(time).year}';
    final String _timeString = '${_day} / ${(time).month} / ${_year}';
    return _timeString;
  }
// -----------------------------------------------------------------------------
  static String getString_hh_i_mm({BuildContext context, DateTime time}){
    final String _hour = DateFormat("h").format(time);
    final String _minute = '${(time).minute}';
    final String _ampm = DateFormat("a").format(time);
    final String _timeString = '$_hour:$_minute $_ampm';

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

      final String _indexString = '${indexes[i]} : ';
      final String _timeStampString =  '${hourMinuteSecondStringer(times[i])}';

      _output = '${_output+_indexString+_timeStampString}\n';
    }
    return _output;
  }
// -----------------------------------------------------------------------------


  static String tempCipherDateTimeToString(DateTime dateTime){
    if(dateTime == null){
      return null;
    } else {
      return dateFormat?.format(dateTime);
    }
  }

  static DateTime tempDecipherDateTimeString(String dateTimeString){
    if (dateTimeString == null){
      return null;
    } else {
      return dateFormat?.parse(dateTimeString);
    }
  }

}

/*

  ZEBALA



 */