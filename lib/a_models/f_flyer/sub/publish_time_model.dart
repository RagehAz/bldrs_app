import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/time/timers.dart';
import 'package:bldrs/a_models/f_flyer/publication_model.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
/// => TAMAM
@immutable
class PublishTime {
  // --------------------------------------------------------------------------
  const PublishTime({
    required this.state,
    required this.time,
  });
  // --------------------------------------------------------------------------
  final PublishState? state;
  final DateTime? time;
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap({
    required bool toJSON,
  }) {
    return <String, dynamic>{
      'state': PublicationModel.cipherPublishState(state),
      'time': Timers.cipherTime(time: time, toJSON: toJSON),
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> cipherTimes({
    required List<PublishTime>? times,
    required bool toJSON,
  }) {
    Map<String, dynamic> _outPut = <String, dynamic>{};

    if (Lister.checkCanLoop(times) == true) {
      for (final PublishTime time in times!) {
        _outPut = Mapper.insertPairInMap(
          map: _outPut,
          key: PublicationModel.cipherPublishState(time.state),
          value: Timers.cipherTime(time: time.time, toJSON: toJSON),
          overrideExisting: true,
        );
      }
    }

    return _outPut;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<PublishTime> decipherTimes({
    required Map<String, dynamic>? map,
    required bool fromJSON,
  }) {
    final List<PublishTime> _times = <PublishTime>[];

    if (map != null) {
      final List<String> _keys = map.keys.toList();
      final List<dynamic> _values = map.values.toList();

      if (Lister.checkCanLoop(_keys) == true && Lister.checkCanLoop(_values) == true) {
        for (int i = 0; i < _keys.length; i++) {

          final PublishState? _flyerStateString = PublicationModel.decipherPublishState(_keys[i]);

          final DateTime? _time = Timers.decipherTime(
              time: _values[i],
              fromJSON: fromJSON,
          );

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

  /// CLONING

  // --------------------
  /*
  ///
  PublishTime clone() {
    final PublishTime _time = PublishTime(state: state, time: time);

    return _time;
  }
  // --------------------
  ///
  static List<PublishTime> cloneTimes(List<PublishTime> times) {
    final List<PublishTime> _times = <PublishTime>[];

    if (Lister.checkCanLoop(times)) {
      for (final PublishTime time in times) {
        _times.add(time.clone());
      }
    }

    return _times;
  }
   */
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogPublishTime(){

    blog('PublishTime : $state : $time');

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogTimes(List<PublishTime>? times){

    if (Lister.checkCanLoop(times) == true){

      for (final PublishTime time in times!){
        time.blogPublishTime();
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogTimesListsDifferences({
    required List<PublishTime>? times1,
    required List<PublishTime>? times2,
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogTimesDifferences({
    required PublishTime? time1,
    required PublishTime? time2,
  }){

    blog('blogTimesDifferences : START');

    if (time1 == null){
      blog('time1 == null');
    }

    if (time2 == null){
      blog('time2 == null');
    }

    if (time1 != null && time2 != null && time1.state != time2.state){
      blog('time1.state != time2.state');
    }
    if (Timers.checkTimesAreIdentical(
        accuracy: TimeAccuracy.microSecond,
        time1: time1?.time,
        time2: time2?.time
    ) == false){
      blog('time1.time != time2.time');
    }

    blog('blogTimesDifferences : END');
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static PublishTime? getPublishTimeFromTimes({
    required PublishState? state,
    required List<PublishTime>? times,
  }) {

    PublishTime? _publishTime;

    if (state != null && Lister.checkCanLoop(times) == true) {
      _publishTime = times!.firstWhereOrNull((PublishTime time) => time.state == state);
    }

    return _publishTime;
  }
  // --------------------
  /*
  /// DEPRECATED
  static PublishTime getLastRecord(List<PublishTime> publishTimes){
    PublishTime _publishTime;

    if (Lister.checkCanLoop(publishTimes) == true){

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
   */
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<PublishTime> addPublishTimeToTimes({
    required List<PublishTime> times,
    required PublishTime newTime,
  }){

    final List<PublishTime> _output = <PublishTime>[];

    if (Lister.checkCanLoop(times) == true){
      _output.addAll(times);
    }

      _output.add(newTime);

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkTimesAreIdentical({
    required PublishTime? time1,
    required PublishTime? time2,
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkTimesListsAreIdentical({
    required List<PublishTime>? times1,
    required List<PublishTime>? times2,
  }){
    bool _identical = false;

    if (times1 == null && times2 == null){
      _identical = true;
    }

    else if (times1 != null && times1.isEmpty == true && times2 != null && times2.isEmpty == true){
      _identical = true;
    }

    else if (
        Lister.checkCanLoop(times1) == true
            &&
        Lister.checkCanLoop(times2) == true
    ){

      if (times1!.length == times2!.length){

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

  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
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
  // --------------------
  @override
  int get hashCode =>
      state.hashCode^
      time.hashCode;
  // -----------------------------------------------------------------------------
}
