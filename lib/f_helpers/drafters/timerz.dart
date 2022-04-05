// ignore_for_file: non_constant_identifier_names

import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
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

/// "2019-07-19 8:40:23"
final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
// -----------------------------------------------------------------------------
dynamic cipherTime({
  @required DateTime time,
  @required bool toJSON,
}){
  final dynamic _output = toJSON ? _cipherDateTimeIso8601(time) : time;
  return _output;
}
// -----------------------------------------------------------------------------
DateTime decipherTime({
  @required dynamic time,
  @required bool fromJSON,
}){
  final DateTime _output = fromJSON == true ? _decipherDateTimeIso8601(time) : time?.toDate();
  return _output;
}
// -----------------------------------------------------------------------------
List<dynamic> cipherTimes({
  @required List<DateTime> times,
  @required bool toJSON,
}){
  final List<dynamic> _times = <String>[];

  if (Mapper.canLoopList(times)){

    for (final DateTime time in times){
      _times.add(cipherTime(
        time: time,
        toJSON: toJSON,
      ));
    }

  }

  return _times;
}
// -----------------------------------------------------------------------------
List<DateTime> decipherTimes({
  @required List<dynamic> times,
  @required bool fromJSON,
}){
  final List<DateTime> _dateTimes = <DateTime>[];

  for (final dynamic time in times){
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
String _cipherDateTimeIso8601(DateTime dateTime){
  String _string;

  if (dateTime != null){
    _string = dateTime.toIso8601String();
  }

  return _string;
}
// -----------------------------------------------------------------------------
DateTime _decipherDateTimeIso8601(String cipheredDateTimeIso8601){
  DateTime _time;

  if (cipheredDateTimeIso8601 != null){
    _time = DateTime.parse(cipheredDateTimeIso8601);
  }

  return _time;
}
// -----------------------------------------------------------------------------
String getMonthNameByInt(BuildContext context, int month){
  switch (month){
    case 1    :    return  superPhrase(context, 'phid_january'); break;
    case 2    :    return  superPhrase(context, 'phid_february'); break;
    case 3    :    return  superPhrase(context, 'phid_march'); break;
    case 4    :    return  superPhrase(context, 'phid_april'); break;
    case 5    :    return  superPhrase(context, 'phid_may'); break;
    case 6    :    return  superPhrase(context, 'phid_june'); break;
    case 7    :    return  superPhrase(context, 'phid_july'); break;
    case 8    :    return  superPhrase(context, 'phid_august'); break;
    case 9    :    return  superPhrase(context, 'phid_september'); break;
    case 11   :    return  superPhrase(context, 'phid_november'); break;
    case 12   :    return  superPhrase(context, 'phid_december'); break;
    default : return null;
  }
}
// -----------------------------------------------------------------------------
/// we may revise datetimes timestamps isoStrings for firebase, sembast & sql
Timestamp decipherDateTimeIso8601ToTimeStamp(String cipheredDateTimeIso8601){
  Timestamp _time;

  if (cipheredDateTimeIso8601 != null){
    final DateTime _dateTime = _decipherDateTimeIso8601(cipheredDateTimeIso8601);
    _time = Timestamp.fromDate(_dateTime);
  }

  return _time;
}
// -----------------------------------------------------------------------------
DateTime createDateTime({
  int year,
  int month,
  int day,
  int hour,
  int minute,
  int second,
  int millisecond,
  int microsecond,
}){
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

  final DateTime _output = DateTime(_year, _month, _day, _hour, _minute, _second, _millisecond, _microsecond);

  return _output;
}
// -----------------------------------------------------------------------------
DateTime createDate({
  @required int year,
  @required int month,
  @required int day,
}){
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
DateTime createClock({
  @required int hour,
  @required int minute,
  int second,
}){
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
DateTime createDateAndClock({
  @required int year,
  @required int month,
  @required int day,
  @required int hour,
  @required int minute,
  int second,
}){
  return
    createDateTime(
      year: year,
      month: month,
      day: day,
      hour: hour,
      minute: minute,
      second: 0,//second ?? DateTime.now().toLocal().second,
      millisecond: 0,
      microsecond: 0,
    );
}
// -----------------------------------------------------------------------------
int getTimeDifferenceInSeconds({
  @required DateTime from,
  @required DateTime to,
}){

  // print('from is : $from');
  // print('to is : $to');

  return to.difference(from).inSeconds;
}
// -----------------------------------------------------------------------------
int getTimeDifferenceInMinutes({
  @required DateTime from,
  @required DateTime to,
}){
  return to.difference(from).inMinutes;
}
// -----------------------------------------------------------------------------
int getTimeDifferenceInHours({
  @required DateTime from,
  @required DateTime to,
}){
  return to.difference(from).inHours;
}
// -----------------------------------------------------------------------------
int getTimeDifferenceInDays({
  @required DateTime from,
  @required DateTime to,
}){
  return to.difference(from).inDays;
}
// -----------------------------------------------------------------------------
int getTimeDifferenceInWeeks({
  @required DateTime from,
  @required DateTime to,
}){
  final int _differenceInDays = getTimeDifferenceInDays(from: from, to: to);
  return (_differenceInDays / 7).floor();
}
// -----------------------------------------------------------------------------
int getTimeDifferenceInMonths({
  @required DateTime from,
  @required DateTime to,
}){
  final int _differenceInDays = getTimeDifferenceInDays(from: from, to: to);
  return (_differenceInDays / 30).floor();
}
// -----------------------------------------------------------------------------
int getTimeDifferenceInYears({
  @required DateTime from,
  @required DateTime to,
}){
  final int _differenceInDays = getTimeDifferenceInDays(from: from, to: to);
  return (_differenceInDays / 365).floor();
}
// -----------------------------------------------------------------------------
String getSuperTimeDifferenceString({
  @required DateTime from,
  @required DateTime to,
}) {
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
      final int _years = getTimeDifferenceInYears(from: from, to: to);
      _string = '$_years years ago';
    }

  }

  return _string;
}
// -----------------------------------------------------------------------------
String stringOnDateMonthYear({
  @required BuildContext context,
  @required DateTime time,
}){
  final String _day = '${time.day}';
  final String _monthString = getMonthNameByInt(context, time.month);
  final String _year = '${time.year}';
  final String _timeString = 'on $_day $_monthString $_year';

  return _timeString;
}
// -----------------------------------------------------------------------------
String getString_dd_month_yyyy({
  @required BuildContext context,
  @required DateTime time
}){
  final String _day = '${time.day}';
  final String _monthString = getMonthNameByInt(context, time.month);
  final String _year = '${time.year}';
  final String _timeString = '$_day $_monthString $_year';
  return _timeString;
}
// -----------------------------------------------------------------------------
String getString_dd_I_mm_I_yyyy({
  @required BuildContext context,
  @required DateTime time
}){
  final String _day = '${time.day}';
  final String _year = '${time.year}';
  final String _timeString = '$_day / ${time.month} / $_year';
  return _timeString;
}
// -----------------------------------------------------------------------------
String getString_hh_i_mm({
  @required BuildContext context,
  @required DateTime time,
}){
  final String _hour = DateFormat('h').format(time);
  final String _minute = '${time.minute}';
  final String _ampm = DateFormat('a').format(time);
  final String _timeString = '$_hour:$_minute $_ampm';

  return _timeString;
}
// -----------------------------------------------------------------------------
String monthYearStringer(BuildContext context, DateTime time){

  String _output = '';

  if (time != null && time.year != null && time.month != null){
    _output =
        '${superPhrase(context, 'phid_inn')} '
        '${Wordz.bldrsShortName(context)} '
        '${superPhrase(context, 'phid_since')} : '
        '${getMonthNameByInt(context, time.month)} '
        '${time.year}';
  }

  return _output;
}
// -----------------------------------------------------------------------------
String dayMonthYearStringer(BuildContext context, DateTime time){

  String _output = '';

  if (time != null && time.year != null && time.month != null && time.day != null){
    _output =
    '${superPhrase(context, 'phid_inn')} '
        '${superPhrase(context, 'phid_phid_bldrsShortName')} '
        '${superPhrase(context, 'phid_since')} : '
        '${time.day} '
        '${getMonthNameByInt(context, time.month)} '
        '${time.year}';
  }

  return _output;

}
// -----------------------------------------------------------------------------
String hourMinuteSecondStringer(DateTime time){

  String _output = '';

  if (time != null && time.hour != null && time.minute != null && time.second != null){
    _output = '${time.hour}:${time.minute}:${time.second}';
  }

  return _output;

}
// -----------------------------------------------------------------------------
String hourMinuteSecondListOfStrings(List<DateTime> times){
  String _output = '';

  if (Mapper.canLoopList(times)){

    for (int i = 0; i<times.length; i++){
      final String _string = hourMinuteSecondStringer(times[i]);

      _output = '$_output$_string\n';
    }

  }

  return _output;
}
// -----------------------------------------------------------------------------
String hourMinuteSecondListOfStringsWithIndexes(List<DateTime> times, List<int> indexes){
  String _output = '';

  if (Mapper.canLoopList(times) == true && Mapper.canLoopList(indexes) == true){

    for (int i = 0; i<times.length; i++){

      final String _indexString = '${indexes[i]} : ';
      final String _timeStampString =  hourMinuteSecondStringer(times[i]);

      _output = '${_output+_indexString+_timeStampString}\n';
    }

  }

  return _output;
}
// -----------------------------------------------------------------------------
String tempCipherDateTimeToString(DateTime dateTime){

  if(dateTime == null){
    return null;
  }

  else {
    return dateFormat?.format(dateTime);
  }

}
// -----------------------------------------------------------------------------
DateTime tempDecipherDateTimeString(String dateTimeString){

  if (dateTimeString == null){
    return null;
  }

  else {
    return dateFormat?.parse(dateTimeString);
  }

}
// -----------------------------------------------------------------------------
DateTime createDateTimeAfterNumberOfDays({@required int days}){

  final DateTime _now = DateTime.now();

  final DateTime _dayAndClock = createDateAndClock(
      year: _now.year,
      month: _now.month,
      day: _now.day + days,
      hour: 0,
      minute: 0,
  );

  return _dayAndClock;
}
// -----------------------------------------------------------------------------
void blogDateTime(DateTime dateTime){
  blog('BLOGGING DATE TIME : $dateTime');
}
// -----------------------------------------------------------------------------
bool timesAreTheSame({
  @required String accuracy,
  @required DateTime timeA,
  @required DateTime timeB,
}){
  bool _areTheSame = false;

  final String _level = accuracy?.toLowerCase()?.trim() ?? 'minute';

  /// XXX - check if both are not nulls
  if (timeA != null && timeB != null){

    /// A - YEAR
    if (timeA.year == timeB.year){

      /// A1 - WHEN LEVEL == YEAR
      if (_level == 'year'){
        _areTheSame = true;
      }

      /// A2 - ZOOM IN
      else {

        /// B - MONTH
        if (timeA.month == timeB.month){

          /// B1 - LEVEL == MONTH
          if (_level == 'month'){
            _areTheSame = true;
          }

          /// B2 - ZOOM IN
          else {

            /// C - DAY
            if (timeA.day == timeB.day){

              /// C1 - LEVEL == DAY
              if (_level == 'day'){
                _areTheSame = true;
              }

              /// C2 - ZOOM IN
              else {

                /// D - HOUR
                if (timeA.hour == timeB.hour){

                  /// D1 - LEVEL == HOUR
                  if (_level == 'hour'){
                    _areTheSame = true;
                  }

                  /// D2 - ZOOM IN
                  else {

                    /// E - MINUTE
                    if (timeA.minute == timeB.minute){

                      /// E1 - LEVEL == MINUTE
                      if (_level == 'minute'){
                        _areTheSame = true;
                      }

                      /// E2 - ZOOM IN
                      else {

                        /// F - SECOND
                        if (timeA.second == timeB.second){

                          /// F1 - LEVEL == SECOND
                          if (_level == 'second'){
                            _areTheSame = true;
                          }

                          /// F2 - ZOOM IN
                          if (_level == 'millisecond'){

                            /// G - MILLISECOND
                            if (timeA.millisecond == timeB.millisecond){

                              /// G1 - LEVEL == MILLISECOND
                              // if (_level == 'millisecond'){
                                _areTheSame = true;
                              // }

                              // /// G2 - ZOOM IN
                              // if (_level != 'millisecond') {
                              //
                              //
                              // }

                            }

                          }

                          else {

                            /// H - MICROSECOND
                            if (timeA.microsecond == timeB.microsecond){

                              /// H1 - LEVEL == MICROSECOND
                              if (_level == 'microsecond'){
                                _areTheSame = true;
                              }

                            }

                          }

                        }

                      }

                    }

                  }

                }

              }

            }


          }

        }

      }

    }

  }

  // print('timesAreTheSame : $_areTheSame : accuracy : ${accuracy} : timeA ${timeA} : timeB ${timeB}');

  return _areTheSame;
}
// -----------------------------------------------------------------------------
List<DateTime> putTimeInTimes({
  @required DateTime time,
  @required List<DateTime> times,
}){
  final List<DateTime> _result = times;

  final bool _timesContainIt = timesContainTime(
      times: times,
      time: time,
      // accuracy: 'minute',
  );

  if (_timesContainIt == false){
    _result.add(time);
  }

  return _result;
}
// -----------------------------------------------------------------------------
bool timesContainTime({
  @required List<DateTime> times,
  @required DateTime time,
  String accuracy = 'minute'
}){
  bool _contains = false;

  if (Mapper.canLoopList(times) && time != null){

    for (int i =0; i < times.length; i++){

      if (timesAreTheSame(accuracy: accuracy, timeA: times[i], timeB: time) == true){
        _contains = true;
        break;
      }

    }

  }

  return _contains;
}
// -----------------------------------------------------------------------------
List<DateTime> getHoursAndMinutesFromDateTimes({@required List<DateTime> times,}){

  List<DateTime> _result = <DateTime>[];

  if (Mapper.canLoopList(times)){

    for (final DateTime time in times){

      final DateTime _hourMinute = createClock(hour: time.hour, minute: time.minute);
      _result = putTimeInTimes(time: _hourMinute, times: _result);
    }

  }

  return _result;
}
// -----------------------------------------------------------------------------
