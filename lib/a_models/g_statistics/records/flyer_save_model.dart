import 'package:basics/helpers/classes/time/timers.dart';
import 'package:flutter/material.dart';
/// => TAMAM
@immutable
class FlyerSaveModel {
  // -----------------------------------------------------------------------------
  const FlyerSaveModel({
    required this.time,
    required this.index,
    required this.userID,
  });
  // --------------------
  final DateTime? time;
  final int index;
  final String userID;
  // -----------------------------------------------------------------------------

  /// CIPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap(){
    return {
      'index': index,
      'time': Timers.cipherTime(time: time, toJSON: true),
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static FlyerSaveModel? decipher({
    required String userID,
    required Map<String, dynamic>? map,
  }){

    if (map == null){
      return null;
    }
    else {
      return FlyerSaveModel(
        userID: userID,
        index: map['index'],
        time: Timers.decipherTime(time: map['time'], fromJSON: true),
      );
    }

  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkViewsModelsAreIdentical({
    required FlyerSaveModel? model1,
    required FlyerSaveModel? model2,
  }){
    bool _areIdentical = false;

    if (model1 == null && model2 == null){
      _areIdentical = true;
    }
    else if (model1 != null && model2 != null){

      if (
          model1.userID == model2.userID &&
          model1.index == model2.index &&
          Timers.checkTimesAreIdentical(
              accuracy: TimeAccuracy.second,
              time1: model1.time,
              time2: model1.time
          ) == true
      ){
        _areIdentical = true;
      }

    }

    return _areIdentical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  @override
  String toString() =>
      '''
      FlyerSaveModel(
        userID: $userID
        index: $index
        time: $time
      )
      ''';
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is FlyerSaveModel){
      _areIdentical = checkViewsModelsAreIdentical(
        model1: this,
        model2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      userID.hashCode^
      index.hashCode^
      time.hashCode;
  // -----------------------------------------------------------------------------
}
