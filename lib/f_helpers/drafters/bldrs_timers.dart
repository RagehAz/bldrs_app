// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

import 'package:app_settings/app_settings.dart';
import 'package:basics/helpers/classes/checks/device_checker.dart';
import 'package:basics/helpers/classes/checks/errorize.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';
import 'package:basics/helpers/classes/rest/rest.dart';
import 'package:basics/helpers/classes/time/internet_time.dart';
import 'package:basics/helpers/classes/time/timers.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
/// => TAMAM
class BldrsTimers {
  // -----------------------------------------------------------------------------

  const BldrsTimers();

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getMonthPhidByInt(int? month){
    switch (month){
      case 1    :    return  'phid_january'   ;
      case 2    :    return  'phid_february'  ;
      case 3    :    return  'phid_march'     ;
      case 4    :    return  'phid_april'     ;
      case 5    :    return  'phid_may'       ;
      case 6    :    return  'phid_june'      ;
      case 7    :    return  'phid_july'      ;
      case 8    :    return  'phid_august'    ;
      case 9    :    return  'phid_september' ;
      case 10   :    return  'phid_october'   ;
      case 11   :    return  'phid_november'  ;
      case 12   :    return  'phid_december'  ;
      default : return null;
    }
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static String generateString_in_bldrs_since_month_yyyy(DateTime? time){

    String _output = '';

    if (time != null){
      _output = '${getWord('phid_inn')} '
                '${getWord('phid_bldrsShortName')} '
                '${getWord('phid_since')} : '
                '${getWord(getMonthPhidByInt(time.month))} '
                '${time.year}';
    }

    return _output;
  }
    // --------------------
  /// TESTED : WORKS PERFECT
  static String generateString_in_bldrs_since_dd_month_yyyy(DateTime? time){

    String _output = '';

    if (
        time != null
        // &&
        // time.year != null
        // &&
        // time.month != null
        // &&
        // time.day != null
    ){
      _output = '${getWord('phid_inn')} '
                '${getWord('phid_bldrsShortName')} '
                '${getWord('phid_since')} : '
                '${time.day} '
                '${getWord(getMonthPhidByInt(time.month))} '
                '${time.year}';
    }

    return _output;

  }
  // --------------------
  /// GENERATES => [ 'on dd month yyyy' ]
  static String generateString_on_dd_month_yyyy({
    required DateTime time,
  }){
    final String _day = '${time.day}';
    final String? _monthPhid = getMonthPhidByInt(time.month);
    final String? _month = getWord(_monthPhid);
    final String _year = '${time.year}';
    final String? _on = getWord('phid_on_4date');

    return '$_on $_day $_month $_year';
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String generateString_hh_i_mm_ampm_day_dd_month_yyyy({
    required DateTime? time,
  }){

    String _output = '';

    final bool _timeIsEmpty = Timers.checkTimeIsEmpty(
      time: time,
    );

    if (_timeIsEmpty == false){
      final String? _hh = DateFormat('h').format(time!);
      final String? _mm = Numeric.formatNumberWithinDigits(num: time.minute, digits: 2);
      final String? _ampm = DateFormat('a').format(time);
      final String? _day = Timers.generateDayName(time);
      final String? _dd = '${time.day}';
      final String? _monthPhid = getMonthPhidByInt(time.month);
      final String? _month = getWord(_monthPhid);
      final String? _yyyy = '${time.year}';

      _output = '$_hh:$_mm $_ampm, $_day $_dd $_month $_yyyy';
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String generateString_in_bldrs_since_xx({
    required DateTime? time,
  }){
    String _output = '';

    if (
        time != null
    ){

      final String _time = BldrsTimers.calculateSuperTimeDifferenceString(
        from: time,
        to: DateTime.now(),
      );

      _output = '${getWord('phid_inn')} '
                '${getWord('phid_bldrsShortName')} '
                '${getWord('phid_since')} : '
                '$_time';
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// TRANSLATIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? translateTimeUnit(TimeAccuracy? accuracy){

    String? _phid;

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

    return getWord(_phid);
  }
  // --------------------
  /// GENERATES => [ 'dd month yyyy' ]
  static String? translate_dd_month_yyyy({
    required DateTime? time
  }){

    final String? _monthPhid = getMonthPhidByInt(time?.month);
    final String? _month = getWord(_monthPhid);

    return Timers.generateString_dd_I_MM_I_yyyy(
      time: time,
      monthString: _month,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String calculateSuperTimeDifferenceString({
    required DateTime? from,
    required DateTime? to,
  }) {
    String _string = '...';

    if (from != null){
      final int _seconds = Timers.calculateTimeDifferenceInSeconds(from: from, to: to);

      if (_seconds < 60){
        final String? _s = translateTimeUnit(TimeAccuracy.second);
        _string = '$_seconds $_s';
      }

      /// MINUTE = 60 s
      else if (_seconds >= 60 && _seconds < 3600){
        final String? _m = translateTimeUnit(TimeAccuracy.minute);
        final int _minutes = Timers.calculateTimeDifferenceInMinutes(from: from, to: to);
        _string = '$_minutes $_m';
      }

      /// HOUR = 3'600 s
      else if (_seconds >= 3600 && _seconds < 86400){
        final String? _h = translateTimeUnit(TimeAccuracy.hour);
        final int _hours = Timers.calculateTimeDifferenceInHours(from: from, to: to);
        _string = '$_hours $_h';
      }

      /// DAY = 86'400 s
      else if (_seconds >= 86400 && _seconds < 604800){
        final String? _d = translateTimeUnit(TimeAccuracy.day);
        final int _days = Timers.calculateTimeDifferenceInDays(from: from, to: to);
        _string = '$_days $_d';
      }

      /// WEEK = 604'800 s
      else if (_seconds >= 604800 && _seconds < 2592000){
        final String? _w = translateTimeUnit(TimeAccuracy.week);
        final int _weeks = Timers.calculateTimeDifferenceInWeeks(from: from, to: to);
        _string = '$_weeks $_w';
      }

      /// MONTH = 2'592'000 s
      else if (_seconds >= 2592000 && _seconds < 31536000){
        final String? _m = translateTimeUnit(TimeAccuracy.month);
        final int _months = Timers.calculateTimeDifferenceInMonths(from: from, to: to);
        _string = '$_months $_m';
      }

      /// YEAR = 31'536'000 s
      else {
        final String? _y = translateTimeUnit(TimeAccuracy.year);
        final int _years = Timers.calculateTimeDifferenceInYears(from: from, to: to);
        _string = '$_years $_y';
      }

    }

    return _string;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkDeviceTimeIsCorrect({
    required BuildContext context,
    required bool showIncorrectTimeDialog,
    required bool canThrowError,
    Function? onRestart,
  }) async {

    // int _diff;
    DateTime? _internetTime;
    DateTime? _deviceTime;
    String? _timezone;

    final bool _isTolerable = await InternetTime.checkDeviceTimeIsAcceptable(
      internetTime: (InternetTime? time){

        _internetTime = time?.utc_datetime?.toLocal();
        _timezone = time?.timezone;
        },
      deviceTime: (DateTime? time){_deviceTime = time;},
      diff: (int? diff){
        // _diff = diff;
        },
    );
    
    if (showIncorrectTimeDialog == true && _isTolerable == false){

      // Timers.blogDateTime(_deviceTime);
      // Timers.blogDateTime(_internetTime);
      // blog('checkDeviceTimeIsCorrect : _diff : ( $_diff ) : _isTolerable : $_isTolerable');

      final String? _dd_month_yyy_actual = translate_dd_month_yyyy(
          time: _internetTime,
      );
      final String? _hh_i_mm_ampm_actual = Timers.generateString_hh_i_mm_ampm(
          time: _internetTime,
      );
      final String? _dd_month_yyy_device = translate_dd_month_yyyy(
          time: _deviceTime,
      );
      final String? _hh_i_mm_ampm_device = Timers.generateString_hh_i_mm_ampm(
          time: _deviceTime
      );
      Verse _zoneLine = ZoneModel.generateInZoneVerse(
        zoneModel: ZoneProvider.proGetCurrentZone(context: getMainContext(), listen: false),
      );
      _zoneLine = _zoneLine.id != '...' ? _zoneLine : Verse(
        /// PLAN : THIS NEEDS TRANSLATION : IN COMES LIKE THIS 'Africa/Cairo'
        id: '${getWord('phid_inn')} $_timezone',
        translate: false,
      );

      _throwTimeError(
        canThrowError: canThrowError,
        deviceTime: _deviceTime,
        internetTime: _internetTime,
        timeZone: _timezone,
        isTolerable: _isTolerable,
        dd_month_yyy_actual: _dd_month_yyy_actual,
        hh_i_mm_ampm_actual: _hh_i_mm_ampm_actual,
        dd_month_yyy_device: _dd_month_yyy_device,
        hh_i_mm_ampm_device: _hh_i_mm_ampm_device,
      );

      await BldrsCenterDialog.showCenterDialog(
        titleVerse: const Verse(
          id: 'phid_device_time_incorrect',
          translate: true,
        ),
        bodyVerse: Verse(
          // pseudo: 'Please adjust you device clock and restart again\n\n$_secondLine\n$_thirdLine',
          id: '${getWord('phid_adjust_your_clock')}\n\n'
              '${getWord('phid_actual_clock')}\n'
              '${_zoneLine.id}\n'
              '$_dd_month_yyy_actual . $_hh_i_mm_ampm_actual\n\n'
              '${getWord('phid_your_clock')}\n'
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
          await AppSettings.openAppSettings(
            type: AppSettingsType.date,
          );
      }


    }

    return _isTolerable;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>> getInternetUTCTime() async {

    DateTime? _dateTime;
    String? _timezone;

    const String url = 'https://worldtimeapi.org/api/ip';

    final http.Response? _response = await Rest.get(
      rawLink: url,
      invoker: 'getInternetUTCTime',
    );

    if (_response != null){

      final String _json = _response.body;

      final Map<String, dynamic> _map = json.decode(_json);

      final String _utcDateTimeString = _map['utc_datetime'];

      final DateTime? _utcTime = Timers.decipherTime(
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
  static _throwTimeError({
    required bool canThrowError,
    required DateTime? internetTime,
    required DateTime? deviceTime,
    required bool isTolerable,
    required String? timeZone,
    required String? dd_month_yyy_actual,
    required String? hh_i_mm_ampm_actual,
    required String? dd_month_yyy_device,
    required String? hh_i_mm_ampm_device,
  }) {

      if (canThrowError == true){

        final UserModel? _user = UsersProvider.proGetMyUserModel(
          context: getMainContext(),
          listen: false,
        );

        final Map<String, dynamic>? _maw = _user?.toMap(toJSON: true);

        Errorize.throwMaps(
          invoker: 'user had wrong clock',
          maps: [
            {
              'now': Timers.cipherTime(time: deviceTime, toJSON: false),
              'internet': Timers.cipherTime(time: internetTime, toJSON: false),
              'isTolerable': isTolerable,
              'timeZone': timeZone,
              'dd_month_yyy_actual': dd_month_yyy_actual,
              'hh_i_mm_ampm_actual': hh_i_mm_ampm_actual,
              'dd_month_yyy_device': dd_month_yyy_device,
              'hh_i_mm_ampm_device': hh_i_mm_ampm_device,
            },
            {
              'user': _maw,
            },
          ],
        );

      }

    }
  // -----------------------------------------------------------------------------
}
