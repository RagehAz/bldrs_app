import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:flutter/material.dart';

class PublishTime {
  final FlyerState state;
  final DateTime timeStamp;

  PublishTime({
    @required this.state,
    @required this.timeStamp,
  });
// -----------------------------------------------------------------------------
// Map<String, dynamic> toMap(){
//
// }
// -----------------------------------------------------------------------------
// PublishTime decipherPublishTimeMap(Map<String, dynamic> timeMap){
//
// }
// -----------------------------------------------------------------------------
// List<PublishTime> decipherPublishTimesMaps(List<Map<String, dynamic>> maps){
//
// }
// -----------------------------------------------------------------------------
// List<Map<String, dynamic>> cipherPublishTimes(List<PublishTime> publishTimes){
//
// }
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
      PublishTime _time = times[i];
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