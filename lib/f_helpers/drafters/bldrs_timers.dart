// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/f_helpers/theme/words.dart';
import 'package:devicer/devicer.dart';
import 'package:filers/filers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:numeric/numeric.dart';
import 'package:rest/rest.dart';
import 'package:space_time/space_time.dart';
import 'package:app_settings/app_settings.dart';
/// => TAMAM
class BldrsTimers {
  // -----------------------------------------------------------------------------

  const BldrsTimers();

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
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
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
  /// TESTED : WORKS PERFECT
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
  /// TESTED : WORKS PERFECT
  static String generateString_hh_i_mm_ampm_day_dd_month_yyyy({
    @required BuildContext context,
    @required DateTime time,
  }){

    String _output = '';

    final bool _timeIsEmpty = Timers.checkTimeIsEmpty(
      time: time,
    );

    if (_timeIsEmpty == false){
      final String _hh = DateFormat('h').format(time);
      final String _mm = Numeric.formatNumberWithinDigits(num: time.minute, digits: 2);
      final String _ampm = DateFormat('a').format(time);
      final String _day = Timers.generateDayName(time);
      final String _dd = '${time.day}';
      final String _monthPhid = getMonthPhidByInt(context, time.month);
      final String _month = xPhrase(context, _monthPhid);
      final String _yyyy = '${time.year}';

      _output = '$_hh:$_mm $_ampm, $_day $_dd $_month $_yyyy';
    }

    return _output;
  }
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

    final String _monthPhid = getMonthPhidByInt(context, time?.month);
    final String _month = xPhrase(context, _monthPhid);

    return Timers.generateString_dd_I_MM_I_yyyy(
      time: time,
      monthString: _month,
    );

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
      final int _seconds = Timers.calculateTimeDifferenceInSeconds(from: from, to: to);

      if (_seconds < 60){
        final String _s = translateTimeUnit(context, TimeAccuracy.second);
        _string = '$_seconds $_s';
      }

      /// MINUTE = 60 s
      else if (_seconds >= 60 && _seconds < 3600){
        final String _m = translateTimeUnit(context, TimeAccuracy.minute);
        final int _minutes = Timers.calculateTimeDifferenceInMinutes(from: from, to: to);
        _string = '$_minutes $_m';
      }

      /// HOUR = 3'600 s
      else if (_seconds >= 3600 && _seconds < 86400){
        final String _h = translateTimeUnit(context, TimeAccuracy.hour);
        final int _hours = Timers.calculateTimeDifferenceInHours(from: from, to: to);
        _string = '$_hours $_h';
      }

      /// DAY = 86'400 s
      else if (_seconds >= 86400 && _seconds < 604800){
        final String _d = translateTimeUnit(context, TimeAccuracy.day);
        final int _days = Timers.calculateTimeDifferenceInDays(from: from, to: to);
        _string = '$_days $_d';
      }

      /// WEEK = 604'800 s
      else if (_seconds >= 604800 && _seconds < 2592000){
        final String _w = translateTimeUnit(context, TimeAccuracy.week);
        final int _weeks = Timers.calculateTimeDifferenceInWeeks(from: from, to: to);
        _string = '$_weeks $_w';
      }

      /// MONTH = 2'592'000 s
      else if (_seconds >= 2592000 && _seconds < 31536000){
        final String _m = translateTimeUnit(context, TimeAccuracy.month);
        final int _months = Timers.calculateTimeDifferenceInMonths(from: from, to: to);
        _string = '$_months $_m';
      }

      /// YEAR = 31'536'000 s
      else {
        final String _y = translateTimeUnit(context, TimeAccuracy.year);
        final int _years = Timers.calculateTimeDifferenceInYears(from: from, to: to);
        _string = '$_years $_y';
      }

    }

    return _string;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkDeviceTimeIsCorrect({
    @required BuildContext context,
    @required bool showIncorrectTimeDialog,
    Function onRestart,
  }) async {

    int _diff;
    DateTime _internetTime;
    DateTime _deviceTime;
    String _timezone;

    final bool _isTolerable = await InternetTime.checkDeviceTimeIsAcceptable(
      internetTime: (InternetTime time){
        _internetTime = time?.utc_datetime?.toLocal();
        _timezone = time?.timezone;
        },
      deviceTime: (DateTime time){_deviceTime = time;},
      diff: (int diff){_diff = diff;},
    );
    
    if (showIncorrectTimeDialog == true && _isTolerable == false){

      Timers.blogDateTime(_deviceTime);
      Timers.blogDateTime(_internetTime);
      blog('checkDeviceTimeIsCorrect : _diff : ( $_diff ) : _isTolerable : $_isTolerable');

      final String _dd_month_yyy_actual = translate_dd_month_yyyy(
          context: context,
          time: _internetTime,
      );
      final String _hh_i_mm_ampm_actual = Timers.generateString_hh_i_mm_ampm(
          time: _internetTime,
      );
      final String _dd_month_yyy_device = translate_dd_month_yyyy(
          context: context, 
          time: _deviceTime,
      );
      final String _hh_i_mm_ampm_device = Timers.generateString_hh_i_mm_ampm(
          time: _deviceTime
      );
      Verse _zoneLine = ZoneModel.generateInZoneVerse(
        context: context,
        zoneModel: ZoneProvider.proGetCurrentZone(context: context, listen: false),
      );
      _zoneLine = _zoneLine.id != '...' ? _zoneLine : Verse(
        /// PLAN : THIS NEEDS TRANSLATION : IN COMES LIKE THIS 'Africa/Cairo'
        id: 'in $_timezone',
        translate: false,
      );

      await CenterDialog.showCenterDialog(
        context: context,
        titleVerse: const Verse(
          id: 'phid_device_time_incorrect',
          translate: true,
        ),
        bodyVerse: Verse(
          // pseudo: 'Please adjust you device clock and restart again\n\n$_secondLine\n$_thirdLine',
          id: '${xPhrase(context, 'phid_adjust_your_clock')}\n\n'
              '${xPhrase(context, 'phid_actual_clock')}\n'
              '${_zoneLine.id}\n'
              '$_dd_month_yyy_actual . $_hh_i_mm_ampm_actual\n\n'
              '${xPhrase(context, 'phid_your_clock')}\n'
              '$_dd_month_yyy_device . $_hh_i_mm_ampm_device',
          translate: false,
        ),
        confirmButtonVerse: const Verse(
          id: 'phid_i_will_adjust_clock',
          translate: true,
        ),
        onOk: onRestart,
      );

      if (kIsWeb == false && DeviceChecker.deviceIsWindows() == false){
          await AppSettings.openDateSettings();
      }


    }

    return _isTolerable;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>> getInternetUTCTime() async {

    DateTime _dateTime;
    String _timezone;

    const String url = 'http://worldtimeapi.org/api/ip';

    final http.Response _response = await Rest.get(
      rawLink: url,
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
  // --------------------
}
