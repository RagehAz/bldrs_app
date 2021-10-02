import 'package:bldrs/controllers/drafters/numeric.dart';
import 'package:bldrs/controllers/drafters/text_mod.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:flutter/material.dart';

class PublishTime {
  final FlyerState state;
  final DateTime timeStamp;

  const PublishTime({
    @required this.state,
    @required this.timeStamp,
  });
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap(){
    return {
      'state': FlyerModel.cipherFlyerState(state),
      'timeStamp': timeStamp,
    };
  }
// -----------------------------------------------------------------------------
  static PublishTime decipherPublishTimeMap(Map<String, dynamic> map){
    PublishTime _time;

    if (map != null){
      _time = PublishTime(
        state: FlyerModel.decipherFlyerState(map['state']),
        timeStamp: map['timeStamp'].toDate(),
      );
    }

    return _time;
  }
// -----------------------------------------------------------------------------
  static List<Map<String, dynamic>> cipherPublishTimes(List<PublishTime> publishTimes){
    final List<dynamic> maps = <dynamic>[];

    if (publishTimes != null && publishTimes.length != 0){

      for (PublishTime time in publishTimes){

        final Map<String, dynamic> _map = time.toMap();

        maps.add(_map);
      }

    }

    return maps;
  }
// -----------------------------------------------------------------------------
  static List<PublishTime> decipherPublishTimes(List<Map<String, dynamic>> maps){
    final List<PublishTime> _times = <PublishTime>[];

    if(maps != null && maps.length != 0){

      for (var map in maps){

        final PublishTime _time = decipherPublishTimeMap(map);
        _times.add(_time);

      }

    }

    return _times;
  }
// -----------------------------------------------------------------------------
  static DateTime getPublishTimeFromTimes({FlyerState state, List<PublishTime> times}){
    DateTime _time;

    if (times != null){
      _time = times.firstWhere((time) => time.state == state, orElse: () => null)?.timeStamp;
    }

    return _time;
  }
// -----------------------------------------------------------------------------
  static bool flyerIsBanned(List<PublishTime> times) {
  bool _flyerIsBanned = false;

  if (times != null){
    for (int i = 0; i < times.length; i++){
      final PublishTime _time = times[i];
      if (_time.state == FlyerState.Banned){
        _flyerIsBanned = true;
        break;
      }

    }
  }

  return _flyerIsBanned;
}
// -----------------------------------------------------------------------------
  static String sqlCipherPublishTime(PublishTime time){
    String _output;

    if (time != null){
      final String _state = '${FlyerModel.cipherFlyerState(time.state)}';
      final String _timeString = Timers.cipherDateTimeIso8601(time.timeStamp);

      _output = '${_state}#${_timeString}';
    }

    return _output;
  }
// -----------------------------------------------------------------------------
  static PublishTime sqlDecipherPublishTime(String sqkTimeString){
    PublishTime time;

    if (sqkTimeString != null){
      final String _stateString = TextMod.trimTextAfterFirstSpecialCharacter(sqkTimeString, '#');
      final int _stateInt = Numeric.stringToInt(_stateString);
      final FlyerState _state = FlyerModel.decipherFlyerState(_stateInt);
      final String _timeString = TextMod.trimTextBeforeFirstSpecialCharacter(sqkTimeString, '#');
      final DateTime _time = Timers.decipherDateTimeIso8601(_timeString);

      time = PublishTime(
        state: _state,
        timeStamp: _time,
      );

    }

    return time;
  }
// -----------------------------------------------------------------------------
  static String sqlCipherPublishTimes(List<PublishTime> times){
    String _output;

    if (times != null && times.length != 0){

      final List<String> _sqlTimesStrings = <String>[];

      for (PublishTime time in times){
        final _sqlString = sqlCipherPublishTime(time);
        _sqlTimesStrings.add(_sqlString);
      }

      _output = TextMod.sqlCipherStrings(_sqlTimesStrings);

    }

    return _output;
  }
// -----------------------------------------------------------------------------
  static List<PublishTime> sqlDecipherPublishTimes(String timesString){
    final List<PublishTime> _times = <PublishTime>[];

    if (timesString != null){

      List<String> _sqlStrings = TextMod.sqlDecipherStrings(timesString);

      for (String sqlString in _sqlStrings){
        final PublishTime _time = sqlDecipherPublishTime(sqlString);
        _times.add(_time);
      }

    }

    return _times;
  }
// -----------------------------------------------------------------------------
}