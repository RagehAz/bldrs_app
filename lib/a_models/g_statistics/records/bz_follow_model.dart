import 'package:basics/helpers/classes/time/timers.dart';
import 'package:flutter/material.dart';
/// => TAMAM
@immutable
class BzFollowModel{
  // -----------------------------------------------------------------------------
  const BzFollowModel({
    required this.userID,
    required this.time,
  });
  // --------------------
  final String userID;
  final DateTime? time;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  BzFollowModel copyWith({
    String? userID,
    DateTime? time,
  }){

    return BzFollowModel(
      userID: userID ?? this.userID,
      time: time ?? this.time,
    );

  }
  // -----------------------------------------------------------------------------

  /// CIPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  int? toPairValue(){

    if (time == null){
      return null;
    }

    else {
      return Timers.cipherTime(
        time: time,
        toJSON: true,
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  String toPairKey(){
    return userID;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BzFollowModel decipherFollow({
    required String userID,
    required int cipheredTime,
  }){

    return BzFollowModel(
      userID: userID,
      time: Timers.decipherTime(
          time: cipheredTime,
          fromJSON: true,
      ),
    );

  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkBzFollowModelsAreIdentical({
    required BzFollowModel? model1,
    required BzFollowModel? model2,
  }){
    bool _areIdentical = false;

    if (model1 == null && model2 == null){
      _areIdentical = true;
    }
    else if (model1 != null && model2 != null){

      if (
          model1.userID == model2.userID &&
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
      BzFollowModel(
        userID: $userID
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
    if (other is BzFollowModel){
      _areIdentical = checkBzFollowModelsAreIdentical(
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
      time.hashCode;
  // -----------------------------------------------------------------------------
}
