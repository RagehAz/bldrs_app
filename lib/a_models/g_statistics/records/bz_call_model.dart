import 'package:basics/helpers/time/timers.dart';
import 'package:flutter/material.dart';
/// => TAMAM
@immutable
class BzCallModel {
  // -----------------------------------------------------------------------------
  const BzCallModel({
    required this.id,
    required this.userID,
    required this.authorID,
    required this.time,
    required this.contact,
  });
  // --------------------
  final String? id;
  final String userID;
  final String? authorID;
  final DateTime? time;
  final String? contact;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  BzCallModel copyWith({
    String? id,
    String? userID,
    String? authorID,
    DateTime? time,
    String? contact,
  }){

    return BzCallModel(
      id: id ?? this.id,
      userID: userID ?? this.userID,
      authorID: authorID ?? this.authorID,
      time: time ?? this.time,
      contact: contact ?? this.contact,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'userID': userID,
      'authorID': authorID,
      'time': Timers.cipherTime(time: time, toJSON: true),
      'contact': contact,
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BzCallModel? decipherCall({
    required Map<String, dynamic>? map,
  }){

    if (map == null){
      return null;
    }
    else {
      return BzCallModel(
        id: map['id'],
        userID: map['userID'],
        authorID: map['authorID'],
        time: Timers.decipherTime(time: map['time'], fromJSON: true),
        contact: map['contact'],
      );
    }

  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkBzCallModelsAreIdentical({
    required BzCallModel? model1,
    required BzCallModel? model2,
  }){
    bool _areIdentical = false;

    if (model1 == null && model2 == null){
      _areIdentical = true;
    }
    else if (model1 != null && model2 != null){

      if (
          model1.userID == model2.userID &&
          model1.authorID == model2.authorID &&
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
      BzCallModel(
        userID: $userID
        authorID: $authorID
        time: $time
        contact: $contact
      )
      ''';
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is BzCallModel){
      _areIdentical = checkBzCallModelsAreIdentical(
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
      authorID.hashCode^
      time.hashCode^
      contact.hashCode;
  // -----------------------------------------------------------------------------
}
