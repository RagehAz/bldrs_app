import 'package:flutter/material.dart';

class BzCounterModel {
  /// -----------------------------------------------------------------------------
  const BzCounterModel({
    @required this.bzID,
    @required this.follows,
    @required this.calls,
    @required this.allSaves,
    @required this.allShares,
    @required this.allSlides,
    @required this.allViews,
    @required this.allReviews,
  });
  /// -----------------------------------------------------------------------------
  final String bzID;
  final int follows;
  final int calls;
  final int allSaves;
  final int allShares;
  final int allSlides;
  final int allViews;
  final int allReviews;
// -----------------------------------------------------------------------------

  /// INITIALIZATION

  // ----------------------------------
  /// TESTED : WORKS PERFECT
  static BzCounterModel createInitialModel(String bzID){
    return BzCounterModel(
        bzID:  bzID,
        follows: 0,
        calls: 0,
        allSaves: 0,
        allShares: 0,
        allSlides: 0,
        allViews: 0,
        allReviews: 0,
    );
  }
  // ----------------------------------
  /// TESTED : WORKS PERFECT
  BzCounterModel copyWith({
    String bzID,
    int follows,
    int calls,
    int allSaves,
    int allShares,
    int allSlides,
    int allViews,
    int allReviews,
  }){

    return BzCounterModel(
      bzID: bzID ?? this.bzID,
      follows: follows ?? this.follows,
      calls: calls ?? this.calls,
      allSaves: allSaves ?? this.allSaves,
      allShares: allShares ?? this.allShares,
      allSlides: allSlides ?? this.allSlides,
      allViews: allViews ?? this.allViews,
      allReviews: allReviews ?? this.allReviews,
    );

  }
// -----------------------------------------------------------------------------

  /// CYPHERS

  // ----------------------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap(){
    return {
      'bzID': bzID,
      'follows': follows,
      'calls': calls,
      'allSaves': allSaves,
      'allShares': allShares,
      'allSlides': allSlides,
      'allViews': allViews,
      'allReviews': allReviews,
    };
  }
  // ----------------------------------
  /// TESTED : WORKS PERFECT
  static BzCounterModel decipherCounterMap(Map<String, dynamic> map){

    BzCounterModel _model = createInitialModel(null);

    if (map != null){
      _model = BzCounterModel(
        bzID: map['bzID'],
        follows: map['follows'] ?? 0,
        calls: map['calls'] ?? 0,
        allSaves: map['allSaves'] ?? 0,
        allShares: map['allShares'] ?? 0,
        allSlides: map['allSlides'] ?? 0,
        allViews: map['allViews'] ?? 0,
        allReviews: map['allReviews'] ?? 0,
      );
    }

    return _model;
  }
// ----------------------------------------

}
