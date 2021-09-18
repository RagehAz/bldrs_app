import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_checkers.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/helpers/map_model.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_dialog/bottom_dialog_row.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class TimerTest extends StatelessWidget {


  Widget line(String verse){
    return
        SuperVerse(
          verse: verse,
          maxLines: 1,
          size: 2,
          italic: true,
        );
  }

  Map<String, dynamic> _times (BuildContext context){

    DateTime _now = DateTime.now();

    DateTime _ragehBD = Timers.createDate(year: 1987, month: 6, day: 10);

    return
        {
          'DateTime\n.now()': _now,
          'sex' : '',
          'Timers.getString_dd_month_yyy' : Timers.getString_dd_month_yyyy(context: context, time: _now,),
          'Timers.getString_dd_I_mm_I_yyyy' : Timers.getString_dd_I_mm_I_yyyy(context: context, time: _now,),
          'Timers.getString_hh_i_mm:_mm' : Timers.getString_hh_i_mm(context: context, time: _now),
          'Timers.createDateTime(year: 1987, month: 6, day: 10),' : Timers.createDateTime(year: 1987, month: 6, day: 10),
          'Timers.createDate(year: 1987, month: 6, day: 10)' : Timers.createDate(year: 1987, month: 6, day: 10),
          'Timers.createClock(hour: 1987, minute: 6)' : Timers.createClock(hour: 5+12, minute: 30),
          'Timers.getTimeDifferenceInSeconds(from: _yesterday, to: _now)': Timers.getTimeDifferenceInSeconds(from: _ragehBD, to: _now),
          'Timers.getTimeDifferenceInMinutes(from: _yesterday, to: _now)': Timers.getTimeDifferenceInMinutes(from: _ragehBD, to: _now),
          'Timers.getDifferenceInDays(from: _yesterday, to: _now)': Timers.getTimeDifferenceInDays(from: _ragehBD, to: _now),
          'Timers.getDateTimeDifferenceInWeeks(from: _yesterday, to: _now)': Timers.getTimeDifferenceInWeeks(from: _ragehBD, to: _now),
          'Timers.getDateTimeDifferenceInMonths(from: _yesterday, to: _now)': Timers.getTimeDifferenceInMonths(from: _ragehBD, to: _now),
          'Timers.getDateTimeDifferenceInYears(from: _yesterday, to: _now)': Timers.getTimeDifferenceInYears(from: _ragehBD, to: _now),

          'x1' : '',
          'Timers.stringOnDateMonthYear' : Timers.stringOnDateMonthYear(context: context, time: _now,),
          'Timers.dayMonthYearStringer' : Timers.dayMonthYearStringer(context, _now),
          'Timers.cipherDateTimeIso8601' : Timers.cipherDateTimeIso8601(_now),
          'Timers.cipherDateTimeToString' : Timers.cipherDateTimeToString(_now),
          'Timers.hourMinuteSecondStringer' : Timers.hourMinuteSecondStringer(_now),
          'Timers.cipherListOfDateTimes([_now])' : Timers.cipherListOfDateTimes([_now]),
          'Timers.decipherDateTimeIso8601(Timers.cipherDateTimeIso8601(_now))' : Timers.decipherDateTimeIso8601(Timers.cipherDateTimeIso8601(_now)),
          'Timers.decipherDateTimeString(Timers.cipherDateTimeToString(_now))' : Timers.decipherDateTimeString(Timers.cipherDateTimeToString(_now)),
          'Timers.decipherListOfDateTimesStrings(Timers.cipherListOfDateTimes([_now]))' : Timers.decipherListOfDateTimesStrings(Timers.cipherListOfDateTimes([_now])),
          'Timers.getMonthNameByInt(context, 6)' : Timers.getMonthNameByInt(context, 6),
          'Timers.hourMinuteSecondListOfStrings([_now])' : Timers.hourMinuteSecondListOfStrings([_now]),
          'Timers.hourMinuteSecondListOfStringsWithIndexes([_now], [0])' : Timers.hourMinuteSecondListOfStringsWithIndexes([_now], [0]),
          'Timers.monthYearStringer(context, _now)' : Timers.monthYearStringer(context, _now),
          'x1.' : '',
          // 'dateFormat.add_d()': Timers.dateFormat.add_d(),
          // 'dateFormat.dateOnly': Timers.dateFormat.dateOnly,
          // 'dateFormat.digitMatcher': Timers.dateFormat.digitMatcher,
          // 'dateFormat.dateTimeConstructor': Timers.dateFormat.dateTimeConstructor,
          // 'dateFormat.format(_now)': Timers.dateFormat.format(_now),
          // 'dateFormat.formatDuration(_now)': Timers.dateFormat.formatDuration(_now),
          // 'dateFormat.formatDurationFrom(Duration.zero, _now)': Timers.dateFormat.formatDurationFrom(Duration.zero, _now),
          // 'Timers.dateFormat.hashCode': Timers.dateFormat.hashCode,
          // 'dateFormat.pattern': Timers.dateFormat.pattern,
          // 'dateFormat.parse(inputString)': Timers.dateFormat.parse('inputString'),
          // 'dateFormat.parseLoose(inputString)': Timers.dateFormat.parseLoose('inputString'),
          // 'dateFormat.parsePattern(pattern)': Timers.dateFormat.parsePattern('pattern'),
          // 'dateFormat.parseStrict(inputString)': Timers.dateFormat.parseStrict('inputString'),
          // 'dateFormat.parseUTC(inputString)': Timers.dateFormat.parseUTC('inputString'),
          // 'dateFormat.parseUtc(inputString)': Timers.dateFormat.parseUtc('inputString'),
          // 'dateFormat.runtimeType': Timers.dateFormat.runtimeType,
          // 'dateFormat.toString()': Timers.dateFormat.toString(),
          // 'dateFormat.useNativeDigits': Timers.dateFormat.useNativeDigits,
          // 'dateFormat.usesAsciiDigits': Timers.dateFormat.usesAsciiDigits,
          // 'dateFormat.usesNativeDigits': Timers.dateFormat.usesNativeDigits,
          'x2' : '',
          'dateFormat.locale': Timers.dateFormat.locale,
          'dateFormat.localeZero': Timers.dateFormat.localeZero,
          'dateFormat.localeZeroCodeUnit': Timers.dateFormat.localeZeroCodeUnit,
          'x3' : '',
          'dateFormat.dateSymbols.AVAILABLEFORMATS,': Timers.dateFormat.dateSymbols.AVAILABLEFORMATS,
          'dateFormat.dateSymbols.AMPMS,': Timers.dateFormat.dateSymbols.AMPMS,
          'dateFormat.dateSymbols.DATETIMEFORMATS,': Timers.dateFormat.dateSymbols.DATETIMEFORMATS,
          'dateFormat.dateSymbols.DATEFORMATS,': Timers.dateFormat.dateSymbols.DATEFORMATS,
          'dateFormat.dateSymbols.ERAS,': Timers.dateFormat.dateSymbols.ERAS,
          'dateFormat.dateSymbols.ERANAMES,': Timers.dateFormat.dateSymbols.ERANAMES,
          'dateFormat.dateSymbols.FIRSTWEEKCUTOFFDAY,': Timers.dateFormat.dateSymbols.FIRSTWEEKCUTOFFDAY,
          'dateFormat.dateSymbols.FIRSTDAYOFWEEK,': Timers.dateFormat.dateSymbols.FIRSTDAYOFWEEK,
          'dateFormat.dateSymbols.MONTHS,': Timers.dateFormat.dateSymbols.MONTHS,
          'dateFormat.dateSymbols.NARROWWEEKDAYS,': Timers.dateFormat.dateSymbols.NARROWWEEKDAYS,
          'dateFormat.dateSymbols.NARROWMONTHS,': Timers.dateFormat.dateSymbols.NARROWMONTHS,
          'dateFormat.dateSymbols.NAME,': Timers.dateFormat.dateSymbols.NAME,
          'dateFormat.dateSymbols.QUARTERS,': Timers.dateFormat.dateSymbols.QUARTERS,
          'dateFormat.dateSymbols.SHORTMONTHS,': Timers.dateFormat.dateSymbols.SHORTMONTHS,
          'dateFormat.dateSymbols.SHORTWEEKDAYS,': Timers.dateFormat.dateSymbols.SHORTWEEKDAYS,
          'dateFormat.dateSymbols.SHORTQUARTERS,': Timers.dateFormat.dateSymbols.SHORTQUARTERS,
          'dateFormat.dateSymbols.STANDALONEMONTHS,': Timers.dateFormat.dateSymbols.STANDALONEMONTHS,
          'dateFormat.dateSymbols.STANDALONESHORTMONTHS,': Timers.dateFormat.dateSymbols.STANDALONESHORTMONTHS,
          'dateFormat.dateSymbols.STANDALONENARROWMONTHS,': Timers.dateFormat.dateSymbols.STANDALONENARROWMONTHS,
          'dateFormat.dateSymbols.STANDALONEWEEKDAYS,': Timers.dateFormat.dateSymbols.STANDALONEWEEKDAYS,
          'dateFormat.dateSymbols.STANDALONENARROWWEEKDAYS,': Timers.dateFormat.dateSymbols.STANDALONENARROWWEEKDAYS,
          'dateFormat.dateSymbols.STANDALONESHORTWEEKDAYS,': Timers.dateFormat.dateSymbols.STANDALONESHORTWEEKDAYS,
          'dateFormat.dateSymbols.TIMEFORMATS,': Timers.dateFormat.dateSymbols.TIMEFORMATS,
          'dateFormat.dateSymbols.WEEKENDRANGE,': Timers.dateFormat.dateSymbols.WEEKENDRANGE,
          'dateFormat.dateSymbols.WEEKDAYS,': Timers.dateFormat.dateSymbols.WEEKDAYS,
          'dateFormat.dateSymbols.ZERODIGIT,': Timers.dateFormat.dateSymbols.ZERODIGIT,

        };
  }

  @override
  Widget build(BuildContext context) {

    List<MapModel> _mapModels = MapModel.getModelsFromMap(_times(context));

    return MainLayout(
      pageTitle: 'Timers Test',
      // onBldrsTap: (){},
      loading: false,
      appBarType: AppBarType.Basic,
      pyramids: Iconz.DvBlankSVG,
      layoutWidget: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: false,
        padding: const EdgeInsets.only(top: Ratioz.stratosphere, bottom: Ratioz.horizon),
        itemCount: _mapModels.length,
          itemBuilder: (ctx, index){

          MapModel _pair = _mapModels[index];

          bool _isDateFormat = TextChecker.stringContainsSubString(
            caseSensitive: true,
            multiLine: false,
            string: _pair.key,
            subString: 'dateFormat',
          );

          bool _isTimersMethod = TextChecker.stringContainsSubString(
            caseSensitive: true,
            multiLine: false,
            string: _pair.key,
            subString: 'Timers.',
          );

          Color _color =
          _isDateFormat ? Colorz.Black255 :
          _isTimersMethod ? Colorz.Green125 :
          Colorz.BloodTest;

          return

          _pair.value == '' ?
              Container(
                width: Scale.superScreenWidth(context),
                height: 0.5,
                color: Colorz.Yellow255,
                margin: const EdgeInsets.symmetric(vertical: 20),
              )

          :

              DataStrip(
                // width: null,
                dataKey: _pair.key,
                dataValue: _pair.value,
                valueBoxColor: _color,
              );

          }
      ),
    );
  }
}
