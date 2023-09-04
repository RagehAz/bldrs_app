import 'package:basics/helpers/classes/time/timers.dart';
import 'package:flutter/material.dart';
/// => TAMAM
@immutable
class FlyerShareModel {
  // -----------------------------------------------------------------------------
  const FlyerShareModel({
    required this.id,
    required this.time,
    required this.index,
    required this.userID,
  });
  // --------------------
  final String id;
  final DateTime? time;
  final int index;
  final String userID;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  FlyerShareModel copyWith({
    String? id,
    DateTime? time,
    int? index,
    String? userID,
  }){

    return FlyerShareModel(
      id: id ?? this.id,
      time: time ?? this.time,
      index: index ?? this.index,
      userID: userID ?? this.userID,
    );

  }
  // -----------------------------------------------------------------------------

  /// CIPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap(){
    return {
      'userID': userID,
      'index': index,
      'time': Timers.cipherTime(time: time, toJSON: true),
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static FlyerShareModel? decipher({
    required Map<String, dynamic>? map,
    required String id,
  }){

    if (map == null){
      return null;
    }
    else {
      return FlyerShareModel(
        id: id,
        userID: map['userID'],
        index: map['index'],
        time: Timers.decipherTime(time: map['time'], fromJSON: true),
      );
    }

  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkShareModelsAreIdentical({
    required FlyerShareModel? model1,
    required FlyerShareModel? model2,
  }){
    bool _areIdentical = false;

    if (model1 == null && model2 == null){
      _areIdentical = true;
    }
    else if (model1 != null && model2 != null){

      if (
          model1.userID == model2.userID &&
          model1.index == model2.index &&
          model1.id == model2.id &&
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
      FlyerShareModel(
        id: $id
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
    if (other is FlyerShareModel){
      _areIdentical = checkShareModelsAreIdentical(
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
      id.hashCode^
      time.hashCode;
  // -----------------------------------------------------------------------------
}
