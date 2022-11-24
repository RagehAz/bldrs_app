// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

import 'package:bldrs/a_models/d_zone/zoning/a_zone_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/provider/zone_provider.dart';
import 'package:bldrs/e_back_end/a_rest/rest.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/words.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

// -----------------------------------------------------------------------------

/// FORMATTING

// --------------------
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
// -----------------------------------------------------------------------------
enum TimeAccuracy{
  year,
  month,
  week,
  day,
  hour,
  minute,
  second,
  millisecond,
  microSecond,
}

class Timers {
  // -----------------------------------------------------------------------------

  const Timers();

  // -----------------------------------------------------------------------------
  /// "2019-07-19 8:40:23"
  static DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static dynamic cipherTime({
    @required DateTime time,
    @required bool toJSON,
  }){
    return toJSON ? _cipherDateTimeIso8601(time) : time;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DateTime decipherTime({
    @required dynamic time,
    @required bool fromJSON,
  }){

    // blog('decipherTime : type : ${time.runtimeType} : time : $time');

    if (time == null){
      return null;
    }
    else {
      if (fromJSON == true){
        return _decipherDateTimeIso8601(time);
      }
      else if (time?.runtimeType.toString() == 'Timestamp'){
        return time?.toDate();
      }
      else if (time?.runtimeType.toString() == 'DateTime'){
        return time;
      }
      else {
        return time;
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<dynamic> cipherTimes({
    @required List<DateTime> times,
    @required bool toJSON,
  }){
    final List<dynamic> _times = <String>[];

    if (Mapper.checkCanLoopList(times)){

      for (final DateTime time in times){
        _times.add(cipherTime(
          time: time,
          toJSON: toJSON,
        ));
      }

    }

    return _times;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<DateTime> decipherTimes({
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static String _cipherDateTimeIso8601(DateTime dateTime){
    String _string;

    if (dateTime != null){
      _string = dateTime.toIso8601String();
    }

    return _string;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DateTime _decipherDateTimeIso8601(String cipheredDateTimeIso8601){
    DateTime _time;

    if (cipheredDateTimeIso8601 != null){
      _time = DateTime.tryParse(cipheredDateTimeIso8601);
    }

    return _time;
  }
  // --------------------
  static Timestamp decipherDateTimeIso8601ToTimeStamp(String cipheredDateTimeIso8601){

    ///  NOTE : we may revise datetimes timestamps isoStrings for firebase, sembast & sql

    Timestamp _time;

    if (cipheredDateTimeIso8601 != null){
      final DateTime _dateTime = _decipherDateTimeIso8601(cipheredDateTimeIso8601);
      _time = Timestamp.fromDate(_dateTime);
    }

    return _time;
  }
  // --------------------
  static String tempCipherDateTimeToString(DateTime dateTime){

    if(dateTime == null){
      return null;
    }

    else {
      return dateFormat?.format(dateTime);
    }

  }
  // --------------------
  static DateTime tempDecipherDateTimeString(String dateTimeString){

    if (dateTimeString == null){
      return null;
    }

    else {
      return dateFormat?.parse(dateTimeString);
    }

  }
  // -----------------------------------------------------------------------------

  /// STRING GENERATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String getMonthPhidByInt(BuildContext context, int month){
    switch (month){
      case 1    :    return  'phid_january'   ; break;
      case 2    :    return  'phid_february'  ; break;
      case 3    :    return  'phid_march'     ; break;
      case 4    :    return  'phid_april'     ; break;
      case 5    :    return  'phid_may'       ; break;
      case 6    :    return  'phid_june'      ; break;
      case 7    :    return  'phid_july'      ; break;
      case 8    :    return  'phid_august'    ; break;
      case 9    :    return  'phid_september' ; break;
      case 10   :    return  'phid_october'   ; break;
      case 11   :    return  'phid_november'  ; break;
      case 12   :    return  'phid_december'  ; break;
      default : return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String generateDayName(BuildContext context, DateTime time){
    return DateFormat('EEEE').format(time);
  }
  // --------------------
  /// GENERATES => [ 'on dd month yyyy' ]
  static String generateString_on_dd_month_yyyy({
    @required BuildContext context,
    @required DateTime time,
  }){
    final String _day = '${time.day}';
    final String _monthPhid = getMonthPhidByInt(context, time.month);
    final String _month = xPhrase(context, _monthPhid);
    final String _year = '${time.year}';
    final String _on = xPhrase(context, 'phid_on_4date');

    return '$_on $_day $_month $_year';
  }
  // --------------------
  /// GENERATES => [ 'dd / MM / yyyy' ]
  static String generateString_dd_I_MM_I_yyyy({
    @required BuildContext context,
    @required DateTime time
  }){
    final String _dd = '${time.day}';
    final String _mm = '${time.month}';
    final String _yyyy = '${time.year}';
    return '$_dd / $_mm / $_yyyy';
  }
  // --------------------
  /// GENERATES => [ 'hh : mm ampm' ]
  static String generateString_hh_i_mm_ampm({
    @required BuildContext context,
    @required DateTime time,
  }){
    final String _hh = DateFormat('h').format(time);
    final String _mm = Numeric.formatNumberWithinDigits(num: time.minute, digits: 2);
    final String _ampm = DateFormat('a').format(time);
    return '$_hh:$_mm $_ampm';
  }
  // --------------------
  static String generateString_in_bldrs_since_month_yyyy(BuildContext context, DateTime time){

    String _output = '';

    if (time != null && time.year != null && time.month != null){
      _output = '${xPhrase( context, 'phid_inn')} '
                '${Words.bldrsShortName(context)} '
                '${xPhrase( context, 'phid_since')} : '
                '${xPhrase(context, getMonthPhidByInt(context, time.month))} '
                '${time.year}';
    }

    return _output;
  }
  // --------------------
  static String generateString_in_bldrs_since_dd_month_yyyy(BuildContext context, DateTime time){

    String _output = '';

    if (
        time != null
        &&
        time.year != null
        &&
        time.month != null
        &&
        time.day != null
    ){
      _output = '${xPhrase( context, 'phid_inn')} '
                '${xPhrase( context, 'phid_phid_bldrsShortName')} '
                '${xPhrase( context, 'phid_since')} : '
                '${time.day} '
                '${xPhrase(context, getMonthPhidByInt(context, time.month))} '
                '${time.year}';
    }

    return _output;

  }
  // --------------------
  static String generateString_hh_i_mm_i_ss(DateTime time){

    String _output = '';

    if (
        time != null
        &&
        time.hour != null
        &&
        time.minute != null
        &&
        time.second != null
    ){

      final String _hours = Numeric.formatNumberWithinDigits(num: time.hour, digits: 2);
      final String _minutes = Numeric.formatNumberWithinDigits(num: time.minute, digits: 2);
      final String _seconds = Numeric.formatNumberWithinDigits(num: time.second, digits: 2);

      _output = '$_hours:$_minutes:$_seconds';
    }

    return _output;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String generateString_hh_i_mm_ampm_day_dd_month_yyyy({
    @required BuildContext context,
    @required DateTime time,
  }){

    String _output = '';

    final bool _timeIsEmpty = checkTimeIsEmpty(
      time: time,
    );

    if (_timeIsEmpty == false){
      final String _hh = DateFormat('h').format(time);
      final String _mm = Numeric.formatNumberWithinDigits(num: time.minute, digits: 2);
      final String _ampm = DateFormat('a').format(time);
      final String _day = generateDayName(context, time);
      final String _dd = '${time.day}';
      final String _monthPhid = getMonthPhidByInt(context, time.month);
      final String _month = xPhrase(context, _monthPhid);
      final String _yyyy = '${time.year}';

      _output = '$_hh:$_mm $_ampm, $_day $_dd $_month $_yyyy';
    }

    return _output;
  }
  // --------------------
  /*
String generateStringsList_hh_i_mm_i_ss(List<DateTime> times){
  String _output = '';

  if (Mapper.canLoopList(times)){

    for (int i = 0; i<times.length; i++){
      final String _string = generateString_hh_i_mm_i_ss(times[i]);

      _output = '$_output$_string\n';
    }

  }

  return _output;
}
  // --------------------
String generateStringsList_index_hh_i_mm_i_ss({
  @required List<DateTime> times,
  @required List<int> indexes,
}){
  String _output = '';

  if (
      Mapper.canLoopList(times) == true
      &&
      Mapper.canLoopList(indexes) == true
  ){

    for (int i = 0; i<times.length; i++){

      final String _indexString = '${indexes[i]} : ';
      final String _timeStampString =  generateString_hh_i_mm_i_ss(times[i]);

      _output = '${_output+_indexString+_timeStampString}\n';
    }

  }

  return _output;
}
 */
  // -----------------------------------------------------------------------------

  /// TRANSLATIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String translateTimeUnit(BuildContext context, TimeAccuracy accuracy){

    String _phid;

    switch(accuracy){
      case TimeAccuracy.year        : _phid = 'phid_time_unit_year'; break;
      case TimeAccuracy.month       : _phid = 'phid_time_unit_month'; break;
      case TimeAccuracy.week        : _phid = 'phid_time_unit_week'; break;
      case TimeAccuracy.day         : _phid = 'phid_time_unit_day'; break;
      case TimeAccuracy.hour        : _phid = 'phid_time_unit_hour'; break;
      case TimeAccuracy.minute      : _phid = 'phid_time_unit_minute'; break;
      case TimeAccuracy.second      : _phid = 'phid_time_unit_second'; break;
      case TimeAccuracy.millisecond : _phid = 'phid_time_unit_millisecond'; break;
      // case TimeAccuracy.microSecond : _phid = 'phid_time_unit_microSecond'; break;
      default: _phid = null;
    }

    return xPhrase(context, _phid);
  }
  // --------------------
  /// GENERATES => [ 'dd month yyyy' ]
  static String translate_dd_month_yyyy({
    @required BuildContext context,
    @required DateTime time
  }){
    final String _day = '${time.day}';
    final String _monthPhid = getMonthPhidByInt(context, time.month);
    final String _month = xPhrase(context, _monthPhid);
    final String _year = '${time.year}';
    return '$_day $_month $_year';
  }
  // -----------------------------------------------------------------------------

  /// CREATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static DateTime createDateTime({
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

    return DateTime(_year, _month, _day, _hour, _minute, _second, _millisecond, _microsecond);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DateTime createDate({
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static DateTime createClock({
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static DateTime createClockFromSeconds(int seconds){

    DateTime _output;

    if (seconds != null){

      final int _hours = (seconds / 3600).floor();
      final int _remainingSeconds = seconds - (_hours * 3600);
      final int _minutes = (_remainingSeconds / 60).floor();
      final int _seconds = seconds - (60 * _minutes);

      _output = createClock(
        hour: _hours,
        minute: _minutes,
        second: _seconds,
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DateTime createDateAndClock({
    @required int year,
    @required int month,
    @required int day,
    @required int hour,
    @required int minute,
    int second,
  }){
    return createDateTime(
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
  // --------------------
  static DateTime createDateTimeAfterNumberOfDays({
    @required int days,
  }){

    final DateTime _now = DateTime.now();

    return createDateAndClock(
      year: _now.year,
      month: _now.month,
      day: _now.day + days,
      hour: 0,
      minute: 0,
    );

  }
  // -----------------------------------------------------------------------------

  /// TIME DIFFERENCE

  // --------------------
  /// TESTED : WORKS PERFECT
  static int calculateTimeDifferenceInSeconds({
    @required DateTime from,
    @required DateTime to,
  }){
    int _output;

    if (to != null && from != null){
      _output = to?.difference(from)?.inSeconds;
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int calculateTimeDifferenceInMinutes({
    @required DateTime from,
    @required DateTime to,
  }){
    int _output;

    if (to != null && from != null){

      // blog('calculateTimeDifferenceInMinutes : from : $from : to : $to');

      _output = to?.difference(from)?.inMinutes;
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int calculateTimeDifferenceInHours({
    @required DateTime from,
    @required DateTime to,
  }){
    int _output;

    if (to != null && from != null){
      _output = to?.difference(from)?.inHours;
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int calculateTimeDifferenceInDays({
    @required DateTime from,
    @required DateTime to,
  }){
    int _output;

    if (to != null && from != null){
      _output = to?.difference(from)?.inDays;
    }

    return Numeric.modulus(_output?.toDouble()).toInt();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int calculateTimeDifferenceInWeeks({
    @required DateTime from,
    @required DateTime to,
  }){
    final int _differenceInDays = calculateTimeDifferenceInDays(from: from, to: to);
    return (_differenceInDays / 7).floor();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int calculateTimeDifferenceInMonths({
    @required DateTime from,
    @required DateTime to,
  }){
    final int _differenceInDays = calculateTimeDifferenceInDays(from: from, to: to);
    return (_differenceInDays / 30).floor();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int calculateTimeDifferenceInYears({
    @required DateTime from,
    @required DateTime to,
  }){
    final int _differenceInDays = calculateTimeDifferenceInDays(from: from, to: to);
    return (_differenceInDays / 365).floor();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String calculateSuperTimeDifferenceString({
    @required BuildContext context,
    @required DateTime from,
    @required DateTime to,
  }) {
    String _string = '...';

    if (from != null){
      final int _seconds = calculateTimeDifferenceInSeconds(from: from, to: to);

      if (_seconds < 60){
        final String _s = translateTimeUnit(context, TimeAccuracy.second);
        _string = '$_seconds $_s';
      }

      /// MINUTE = 60 s
      else if (_seconds >= 60 && _seconds < 3600){
        final String _m = translateTimeUnit(context, TimeAccuracy.minute);
        final int _minutes = calculateTimeDifferenceInMinutes(from: from, to: to);
        _string = '$_minutes $_m';
      }

      /// HOUR = 3'600 s
      else if (_seconds >= 3600 && _seconds < 86400){
        final String _h = translateTimeUnit(context, TimeAccuracy.hour);
        final int _hours = calculateTimeDifferenceInHours(from: from, to: to);
        _string = '$_hours $_h';
      }

      /// DAY = 86'400 s
      else if (_seconds >= 86400 && _seconds < 604800){
        final String _d = translateTimeUnit(context, TimeAccuracy.day);
        final int _days = calculateTimeDifferenceInDays(from: from, to: to);
        _string = '$_days $_d';
      }

      /// WEEK = 604'800 s
      else if (_seconds >= 604800 && _seconds < 2592000){
        final String _w = translateTimeUnit(context, TimeAccuracy.week);
        final int _weeks = calculateTimeDifferenceInWeeks(from: from, to: to);
        _string = '$_weeks $_w';
      }

      /// MONTH = 2'592'000 s
      else if (_seconds >= 2592000 && _seconds < 31536000){
        final String _m = translateTimeUnit(context, TimeAccuracy.month);
        final int _months = calculateTimeDifferenceInMonths(from: from, to: to);
        _string = '$_months $_m';
      }

      /// YEAR = 31'536'000 s
      else {
        final String _y = translateTimeUnit(context, TimeAccuracy.year);
        final int _years = calculateTimeDifferenceInYears(from: from, to: to);
        _string = '$_years $_y';
      }

    }

    return _string;
  }
  // --------------------
  ///
  static String calculateRemainingHoursAndMinutes({
    @required int secondsUntilNow,
  }){

    String _string = '';

    if (secondsUntilNow != null){

      final int _totalMinutes = (secondsUntilNow / 60).floor();
      final int _hours = (_totalMinutes / 60).floor();
      final int _minutesRemaining = _totalMinutes - (_hours*60);

      final String _hourString = Numeric.formatNumberWithinDigits(num: _hours, digits: 2);
      final String _minutesString = Numeric.formatNumberWithinDigits(num: _minutesRemaining, digits: 2);
      _string = '$_hourString:$_minutesString';
    }

    return _string;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGERS

  // --------------------
  static void blogDateTime(DateTime dateTime){
    blog('BLOGGING DATE TIME : $dateTime');
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  static List<DateTime> putTimeInTimes({
    @required DateTime time,
    @required List<DateTime> times,
  }){
    final List<DateTime> _result = times;

    final bool _timesContainIt = checkTimesContainTime(
      times: times,
      time: time,
      // accuracy: 'minute',
    );

    if (_timesContainIt == false){
      _result.add(time);
    }

    return _result;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DateTime offsetTime({
    @required DateTime time,
    @required String offset, // should look like this +00:00
  }){

    DateTime _output;

    if (time != null && offset != null && offset.length == 6){

      final List<String> _splitOffset = offset.split('');
      // blog('_splitOffset : $_splitOffset');

      final bool _isPlus = _splitOffset[0] == '+';
      // blog('_isPlus : $_isPlus');

      final _hoursString = '${_splitOffset[1]}${_splitOffset[2]}';
      // blog('_hoursString : $_hoursString');
      final int _hours = Numeric.transformStringToInt(_hoursString);
      // blog('_hours : $_hours');

      final _minutesString = '${_splitOffset[4]}${_splitOffset[5]}';
      // blog('_minutesString : $_minutesString');
      final int _minutes = Numeric.transformStringToInt(_minutesString);
      // blog('_minutes : $_minutes');

      _output = _isPlus == true ?
      time.add(Duration(hours: _hours, minutes: _minutes))
          :
      time.subtract(Duration(hours: _hours, minutes: _minutes))
      ;

    }


    return _output;
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  static List<DateTime> getHoursAndMinutesFromDateTimes({
    @required List<DateTime> times,
  }){

    List<DateTime> _result = <DateTime>[];

    if (Mapper.checkCanLoopList(times)){

      for (final DateTime time in times){

        final DateTime _hourMinute = createClock(
            hour: time.hour,
            minute: time.minute
        );

        _result = putTimeInTimes(
            time: _hourMinute,
            times: _result
        );

      }

    }

    return _result;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkTimesAreIdentical({
    @required TimeAccuracy accuracy,
    @required DateTime time1,
    @required DateTime time2,
  }){
    bool _areIdentical = false;

    if (time1 == null && time2 == null){
      _areIdentical = true;
    }
    /// XXX - check if both are not nulls
    else if (time1 != null && time2 != null){

      /// A - YEAR
      if (time1.year == time2.year){

        /// A1 - WHEN LEVEL == YEAR
        if (accuracy == TimeAccuracy.year){
          _areIdentical = true;
        }

        /// A2 - ZOOM IN
        else {

          /// B - MONTH
          if (time1.month == time2.month){

            /// B1 - LEVEL == MONTH
            if (accuracy == TimeAccuracy.month){
              _areIdentical = true;
            }

            /// B2 - ZOOM IN
            else {

              /// C - DAY
              if (time1.day == time2.day){

                /// C1 - LEVEL == DAY
                if (accuracy == TimeAccuracy.day){
                  _areIdentical = true;
                }

                /// C2 - ZOOM IN
                else {

                  /// D - HOUR
                  if (time1.hour == time2.hour){

                    /// D1 - LEVEL == HOUR
                    if (accuracy == TimeAccuracy.hour){
                      _areIdentical = true;
                    }

                    /// D2 - ZOOM IN
                    else {

                      /// E - MINUTE
                      if (time1.minute == time2.minute){

                        /// E1 - LEVEL == MINUTE
                        if (accuracy == TimeAccuracy.minute){
                          _areIdentical = true;
                        }

                        /// E2 - ZOOM IN
                        else {

                          /// F - SECOND
                          if (time1.second == time2.second){

                            /// F1 - LEVEL == SECOND
                            if (accuracy == TimeAccuracy.second){
                              _areIdentical = true;
                            }

                            /// F2 - ZOOM IN
                            if (accuracy == TimeAccuracy.millisecond){

                              /// G - MILLISECOND
                              if (time1.millisecond == time2.millisecond){

                                /// G1 - LEVEL == MILLISECOND
                                // if (_level == 'millisecond'){
                                _areIdentical = true;
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
                              if (time1.microsecond == time2.microsecond){

                                /// H1 - LEVEL == MICROSECOND
                                if (accuracy == TimeAccuracy.microSecond){
                                  _areIdentical = true;
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

    // print('timesAreTheSame : $_areIdentical : accuracy : ${accuracy} : timeA ${timeA} : timeB ${timeB}');

    return _areIdentical;
  }
  // --------------------
  static bool checkTimesContainTime({
    @required List<DateTime> times,
    @required DateTime time,
    TimeAccuracy accuracy = TimeAccuracy.minute,
  }){
    bool _contains = false;

    if (Mapper.checkCanLoopList(times) && time != null){

      for (int i =0; i < times.length; i++){

        final bool _timesAreIdentical = checkTimesAreIdentical(
          accuracy: accuracy,
          time1: times[i],
          time2: time,
        );

        if (_timesAreIdentical == true){
          _contains = true;
          break;
        }

      }

    }

    return _contains;
  }
  // --------------------
  static bool checkTimeIsAfter({
    @required DateTime existing,
    @required DateTime timeAfter,
  }){
    bool _isAfter = false;

    if (existing != null && timeAfter != null){

      _isAfter = timeAfter.isAfter(existing);

    }

    return _isAfter;
  }
  // --------------------
  static bool checkTimeIsEmpty({
    @required DateTime time,
    // @required TimeAccuracy accuracy,
  }){
    bool _isEmpty = true;

    if (time != null){
      _isEmpty = false;
    }

    return _isEmpty;
  }
  // -----------------------------------------------------------------------------

  /// DEVICE TIME

  // --------------------
  ///
  static Future<bool> checkDeviceTimeIsCorrect({
    @required BuildContext context,
    @required bool showIncorrectTimeDialog,
    Function onRestart,
  }) async {

    final Map<String, dynamic> _InternetUTCTimeMap = await getInternetUTCTime();

    final DateTime _dateTimeReceived = _InternetUTCTimeMap['dateTime'];
    final DateTime _dateTime = Timers.createDateTime(
      year: _dateTimeReceived.year,
      month: _dateTimeReceived.month,
      day: _dateTimeReceived.day,
      hour: _dateTimeReceived.hour,
      minute: _dateTimeReceived.minute,
      second: _dateTimeReceived.second,
      millisecond: 0,
      microsecond: 0,
    );

    final String _timezone = _InternetUTCTimeMap['timezone'];

    final DateTime _now = DateTime.now();

    bool _isCorrect = Timers.checkTimesAreIdentical(
      accuracy: TimeAccuracy.minute,
      time1: _now,
      time2: _dateTime,
    );

    if (showIncorrectTimeDialog == true && _isCorrect == false){

      final int _diff = Timers.calculateTimeDifferenceInMinutes(from: _now, to: _dateTime);
      final double _num = Numeric.modulus(_diff.toDouble());
      final bool _differenceIsBig = _num > 2;

      if (_differenceIsBig == true){
        blogDateTime(_now);
        blogDateTime(_dateTime);
        blog('calculateTimeDifferenceInMinutes : ${_now.minute - _dateTime.minute}');
        blog('checkDeviceTimeIsCorrect : _diff : ( $_diff ) : modulus : $_num : _differenceIsBig : $_differenceIsBig');

        /*
        case
            [log] BLOGGING DATE TIME : 2022-10-11 13:27:29.139045
            [log] BLOGGING DATE TIME : 2022-10-11 13:28:10.320371Z
            [log] calculateTimeDifferenceInMinutes : -1
         */

        final String _dd_month_yyy_actual = Timers.translate_dd_month_yyyy(context: context, time: _dateTime);
        final String _hh_i_mm_ampm_actual = Timers.generateString_hh_i_mm_ampm(context: context, time: _dateTime);

        final String _dd_month_yyy_device = Timers.translate_dd_month_yyyy(context: context, time: _now);
        final String _hh_i_mm_ampm_device = Timers.generateString_hh_i_mm_ampm(context: context, time: _now);

        Verse _zoneLine = ZoneModel.translateZoneString(
            context: context,
            zoneModel: ZoneProvider.proGetCurrentZone(context: context, listen: false),
        );
        _zoneLine = _zoneLine.text != '...' ? _zoneLine : Verse(
          /// PLAN : THIS NEEDS TRANSLATION : IN COMES LIKE THIS 'Africa/Cairo'
          text: 'in $_timezone',
          translate: false,
        );

        await CenterDialog.showCenterDialog(
          context: context,
          titleVerse: const Verse(
            text: 'phid_device_time_incorrect',
            translate: true,
          ),
          bodyVerse: Verse(
            // pseudo: 'Please adjust you device clock and restart again\n\n$_secondLine\n$_thirdLine',
              text: '${xPhrase(context, 'phid_adjust_your_clock')}\n\n'
                    '${xPhrase(context, 'phid_actual_clock')}\n'
                    '${_zoneLine.text}\n'
                    '$_dd_month_yyy_actual . $_hh_i_mm_ampm_actual\n\n'
                    '${xPhrase(context, 'phid_your_clock')}\n'
                    '$_dd_month_yyy_device . $_hh_i_mm_ampm_device',
              translate: false,
          ),
          confirmButtonVerse: const Verse(
            text: 'phid_i_will_adjust_clock',
            translate: true,
          ),
          onOk: onRestart,
        );

      }

      else {
        _isCorrect = true;
      }

    }

    return _isCorrect;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>> getInternetUTCTime() async {

    DateTime _dateTime;
    String _timezone;

    const String url = 'http://worldtimeapi.org/api/ip';

    final http.Response _response = await Rest.get(
      rawLink: url,
      context: null,
      showErrorDialog: false,
      invoker: 'getInternetUTCTime',
    );

    if (_response != null){

      final String _json = _response.body;

      final Map<String, dynamic> _map = json.decode(_json);

      final String _utcDateTimeString = _map['utc_datetime'];

      final DateTime _utcTime = Timers.decipherTime(
        time: _utcDateTimeString,
        fromJSON: true,
      );

      _dateTime = Timers.offsetTime(
        time: _utcTime,
        offset: _map['utc_offset'],
      );
      _timezone = _map['timezone'];

    }

    else {
      _dateTime = DateTime.now();
    }

    return {
      'dateTime': _dateTime,
      'timezone': _timezone,
    };
  }
  // -----------------------------------------------------------------------------
}
