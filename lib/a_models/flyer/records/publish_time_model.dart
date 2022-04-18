import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:flutter/material.dart';

class PublishTime {
  /// --------------------------------------------------------------------------
  const PublishTime({
    @required this.state,
    @required this.time,
  });
  /// --------------------------------------------------------------------------
  final FlyerState state;
  final DateTime time;
// -----------------------------------------------------------------------------

  /// CLONING

// -------------------------------------
  PublishTime clone() {
    final PublishTime _time = PublishTime(state: state, time: time);

    return _time;
  }
// -----------------------------------------------------------------------------
  static List<PublishTime> cloneTimes(List<PublishTime> times) {
    final List<PublishTime> _times = <PublishTime>[];

    if (Mapper.canLoopList(times)) {
      for (final PublishTime time in times) {
        _times.add(time.clone());
      }
    }

    return _times;
  }
// -----------------------------------------------------------------------------

  /// CYPHERS

// -------------------------------------
  Map<String, dynamic> toMap({
    @required bool toJSON,
  }) {
    return <String, dynamic>{
      'state': FlyerModel.cipherFlyerState(state),
      'time': Timers.cipherTime(time: time, toJSON: toJSON),
    };
  }
// -------------------------------------
  static Map<String, dynamic> cipherPublishTimesToMap({
    @required List<PublishTime> times,
    @required bool toJSON,
  }) {
    Map<String, dynamic> _outPut = <String, dynamic>{};

    if (Mapper.canLoopList(times)) {
      for (final PublishTime time in times) {
        _outPut = Mapper.insertPairInMap(
          map: _outPut,
          key: FlyerModel.cipherFlyerState(time.state),
          value: Timers.cipherTime(time: time.time, toJSON: toJSON),
        );
      }
    }

    return _outPut;
  }
// -------------------------------------
  static List<PublishTime> decipherPublishTimesFromMap({
    @required Map<String, dynamic> map,
    @required bool fromJSON,
  }) {
    final List<PublishTime> _times = <PublishTime>[];

    if (map != null) {
      final List<String> _keys = map.keys.toList();
      final List<dynamic> _values = map.values.toList();

      if (Mapper.canLoopList(_keys) && Mapper.canLoopList(_values)) {
        for (int i = 0; i < _keys.length; i++) {
          final FlyerState _flyerStateString =
          FlyerModel.decipherFlyerState(_keys[i]);
          final DateTime _time =
          Timers.decipherTime(time: _values[i], fromJSON: fromJSON);

          _times.add(
            PublishTime(
              state: _flyerStateString,
              time: _time,
            ),
          );
        }
      }
    }

    return _times;
  }
// -----------------------------------------------------------------------------

  /// CHECKERS

// -------------------------------------
  static bool flyerIsBanned(List<PublishTime> times) {
    bool _flyerIsBanned = false;

    if (times != null) {
      for (int i = 0; i < times.length; i++) {
        final PublishTime _time = times[i];
        if (_time.state == FlyerState.banned) {
          _flyerIsBanned = true;
          break;
        }
      }
    }

    return _flyerIsBanned;
  }
// -----------------------------------------------------------------------------

  /// GETTERS

// -------------------------------------
  static PublishTime getPublishTimeFromTimes({
    FlyerState state,
    List<PublishTime> times,
  }) {

    PublishTime _publishTime;

    if (times != null) {
      _publishTime = times
          .firstWhere((PublishTime time) => time.state == state,
              orElse: () => null);
    }

    return _publishTime;
  }
// -------------------------------------
  static PublishTime getLastRecord(List<PublishTime> publishTimes){
    PublishTime _publishTime;

    if (Mapper.canLoopList(publishTimes) == true){

      _publishTime = publishTimes[0];

      for (final PublishTime publishTime in publishTimes){

        if (Timers.timeIsAfter(
          existing: _publishTime.time,
          timeAfter: publishTime.time,
        ) == true){
          _publishTime = publishTime;
        }

      }

    }

    return _publishTime;
  }
// -------------------------------------

}

/*

ZEBALA

  static PublishTime oldDecipherPublishTimeMap({@required Map<String, dynamic> map, @required bool fromJSON}){
    PublishTime _time;

    if (map != null){
      _time = PublishTime(
        state: FlyerModel.decipherFlyerState(map['state']),
        time: Timers.decipherTime(time: map['time'], fromJSON: fromJSON),
      );
    }

    return _time;
  }
// -----------------------------------------------------------------------------
  static List<Map<String, dynamic>> oldCipherPublishTimes({@required List<PublishTime> publishTimes, @required bool toJSON}){
    final List<Map<String, dynamic>> maps = <Map<String, dynamic>>[];

    if (Mapper.canLoopList(publishTimes)){

      for (PublishTime time in publishTimes){

        final Map<String, dynamic> _map = time.toMap(toJSON: toJSON);

        maps.add(_map);
      }

    }

    return maps;
  }
// -----------------------------------------------------------------------------
  static List<PublishTime> oldDecipherPublishTimes({@required List<Map<String, dynamic>> maps, @required bool fromJSON}){
    final List<PublishTime> _times = <PublishTime>[];

    if(Mapper.canLoopList(maps)){

      for (var map in maps){

        final PublishTime _time = oldDecipherPublishTimeMap(map: map, fromJSON: fromJSON);
        _times.add(_time);

      }

    }

    return _times;
  }
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
  static Map<String, dynamic> fixListOfPublishTimesMapsToOneMap(List<Map<String, dynamic>> maps){

    Map<String, dynamic> _fixedMap;

    if (Mapper.canLoopList(maps)){

      List<PublishTime> times = oldDecipherPublishTimes(maps: maps, fromJSON: false);

      _fixedMap = cipherPublishTimesToMap(times: times, toJSON: false);


    }

    return _fixedMap;
  }

 */
