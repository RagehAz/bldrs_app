import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

@immutable
class PublishTime {
  /// --------------------------------------------------------------------------
  const PublishTime({
    @required this.state,
    @required this.time,
  });
  /// --------------------------------------------------------------------------
  final PublishState state;
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

    if (Mapper.checkCanLoopList(times)) {
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
      'state': FlyerModel.cipherPublishState(state),
      'time': Timers.cipherTime(time: time, toJSON: toJSON),
    };
  }
// -------------------------------------
  static Map<String, dynamic> cipherPublishTimesToMap({
    @required List<PublishTime> times,
    @required bool toJSON,
  }) {
    Map<String, dynamic> _outPut = <String, dynamic>{};

    if (Mapper.checkCanLoopList(times)) {
      for (final PublishTime time in times) {
        _outPut = Mapper.insertPairInMap(
          map: _outPut,
          key: FlyerModel.cipherPublishState(time.state),
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

      if (Mapper.checkCanLoopList(_keys) && Mapper.checkCanLoopList(_values)) {
        for (int i = 0; i < _keys.length; i++) {
          final PublishState _flyerStateString =
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
  /*
  static bool flyerIsBanned(AuditState auditState) {

    return  auditState == AuditState.banned;

  }
   */
// -------------------------------------

  static bool checkTimesAreIdentical({
    @required PublishTime time1,
    @required PublishTime time2,
  }){
    bool _identical = false;

    if (time1 == null && time2 == null){
      _identical = true;
    }

    else if (time1 != null && time2 != null){

      if (
      Timers.checkTimesAreIdentical(accuracy: TimeAccuracy.second, time1: time1.time, time2: time2.time) &&
      time1.state == time2.state
      ){
        _identical = true;
      }

    }

    if (_identical == false){
      blogTimesDifferences(
        time1: time1,
        time2: time2,
      );
    }

    return _identical;
  }
// -------------------------------------
  static bool checkTimesListsAreIdentical({
    @required List<PublishTime> times1,
    @required List<PublishTime> times2,
  }){
    bool _identical = false;

    if (times1 == null && times2 == null){
      _identical = true;
    }

    else if (times1?.isEmpty == true && times2?.isEmpty == true){
      _identical = true;
    }

    else if (
      Mapper.checkCanLoopList(times1) == true &&
      Mapper.checkCanLoopList(times2) == true
    ){

      if (times1.length == times2.length){

        for (int i = 0; i < times1.length; i++){

          final bool _timesAreIdentical = checkTimesAreIdentical(
            time1: times1[i],
            time2: times2[i],
          );

          if (_timesAreIdentical == true && i + 1 == times1.length){
            _identical = true;
          }
          else if (_timesAreIdentical == false){
            _identical = false;
            break;
          }

        }

      }

    }

    if (_identical == false){
      blogTimesListsDifferences(
        times1: times1,
        times2: times2,
      );
    }

    return _identical;
  }
// -----------------------------------------------------------------------------

  /// BLOGGING

// -------------------------------------
  void blogPublishTime(){

    blog('PublishTime : $state : $time');

  }
// -------------------------------------
  static void blogTimes(List<PublishTime> times){

    if (Mapper.checkCanLoopList(times) == true){

      for (final PublishTime time in times){
        time.blogPublishTime();
      }

    }

  }
// -------------------------------------
  static void blogTimesListsDifferences({
    @required List<PublishTime> times1,
    @required List<PublishTime> times2,
  }){

    if (times1 == null){
      blog('times1 == null');
    }
    if (times2 == null){
      blog('times2 == null');
    }
    if (times1?.length != times2?.length){
      blog('times1.length [ ${times1?.length} ] != [ ${times2?.length} ] times2.length');
    }

  }
// -------------------------------------

  static void blogTimesDifferences({
    @required PublishTime time1,
    @required PublishTime time2,
  }){

    blog('blogTimesDifferences : START');

    if (time1 == null){
      blog('time1 == null');
    }

    if (time2 == null){
      blog('time2 == null');
    }

    if (time1.state != time2.state){
      blog('time1.state != time2.state');
    }
    if (Timers.checkTimesAreIdentical(accuracy: TimeAccuracy.microSecond, time1: time1.time, time2: time2.time) == false){
      blog('time1.time != time2.time');
    }

    blog('blogTimesDifferences : END');
  }
// -----------------------------------------------------------------------------

  /// GETTERS

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static PublishTime getPublishTimeFromTimes({
    PublishState state,
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

    if (Mapper.checkCanLoopList(publishTimes) == true){

      _publishTime = publishTimes[0];

      for (final PublishTime publishTime in publishTimes){

        if (Timers.checkTimeIsAfter(
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
  /// TESTED : WORKS PERFECT
  static List<PublishTime> addPublishTimeToTimes({
    @required List<PublishTime> times,
    @required PublishTime newTime,
  }){

    final List<PublishTime> _output = <PublishTime>[];

    if (Mapper.checkCanLoopList(times) == true){
      _output.addAll(times);
    }

      _output.add(newTime);

    return _output;
  }
// -----------------------------------------------------------------------------

  /// OVERRIDES

// ----------------------------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
// ----------------------------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is PublishTime){
      _areIdentical = checkTimesAreIdentical(
        time1: this,
        time2: other,
      );
    }

    return _areIdentical;
  }
// ----------------------------------------
  @override
  int get hashCode =>
      state.hashCode^
      time.hashCode;
// -----------------------------------------------------------------------------
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
