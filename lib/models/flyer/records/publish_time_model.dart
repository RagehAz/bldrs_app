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
  Map<String, dynamic> toMap({@required bool toJSON}){
    return {
      'state': FlyerModel.cipherFlyerState(state),
      'timeStamp': Timers.cipherTime(time: timeStamp, toJSON: toJSON),
    };
  }
// -----------------------------------------------------------------------------
  static PublishTime decipherPublishTimeMap({@required Map<String, dynamic> map, @required bool fromJSON}){
    PublishTime _time;

    if (map != null){
      _time = PublishTime(
        state: FlyerModel.decipherFlyerState(map['state']),
        timeStamp: Timers.decipherTime(time: map['timeStamp'], fromJSON: fromJSON),
      );
    }

    return _time;
  }
// -----------------------------------------------------------------------------
  static List<Map<String, dynamic>> cipherPublishTimes({@required List<PublishTime> publishTimes, @required bool toJSON}){
    final List<dynamic> maps = <dynamic>[];

    if (publishTimes != null && publishTimes.length != 0){

      for (PublishTime time in publishTimes){

        final Map<String, dynamic> _map = time.toMap(toJSON: toJSON);

        maps.add(_map);
      }

    }

    return maps;
  }
// -----------------------------------------------------------------------------
  static List<PublishTime> decipherPublishTimes({@required List<Map<String, dynamic>> maps, @required bool fromJSON}){
    final List<PublishTime> _times = <PublishTime>[];

    if(maps != null && maps.length != 0){

      for (var map in maps){

        final PublishTime _time = decipherPublishTimeMap(map: map, fromJSON: fromJSON);
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
}