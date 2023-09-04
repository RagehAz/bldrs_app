import 'package:flutter/material.dart';
/// => TAMAM
@immutable
class BzCounterModel {
  /// -----------------------------------------------------------------------------
  const BzCounterModel({
    required this.bzID,
    required this.follows,
    required this.calls,
    required this.allSaves,
    required this.allShares,
    required this.allSlides,
    required this.allViews,
    required this.allReviews,
  });
  /// -----------------------------------------------------------------------------
  final String? bzID;
  final int follows;
  final int calls;
  final int allSaves;
  final int allShares;
  final int allSlides;
  final int allViews;
  final int allReviews;
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static BzCounterModel createInitialModel(String? bzID){
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
  // --------------------
  /// TESTED : WORKS PERFECT
  BzCounterModel copyWith({
    String? bzID,
    int? follows,
    int? calls,
    int? allSaves,
    int? allShares,
    int? allSlides,
    int? allViews,
    int? allReviews,
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

  // --------------------
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static BzCounterModel? decipherCounterMap({
    required Map<String, dynamic>? map,
    required String bzID,
  }){

    BzCounterModel _model = createInitialModel(bzID);

    if (map != null){
      _model = BzCounterModel(
        bzID: bzID,
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
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkBzCounterModelsAreIdentical({
    required BzCounterModel? counter1,
    required BzCounterModel? counter2,
  }){
    bool _areIdentical = false;

    if (counter1 == null && counter2 == null){
      _areIdentical = true;
    }
    else if (counter1 != null && counter2 != null){

      if (
          counter1.bzID == counter2.bzID &&
          counter1.follows == counter2.follows &&
          counter1.calls == counter2.calls &&
          counter1.allSaves == counter2.allSaves &&
          counter1.allShares == counter2.allShares &&
          counter1.allSlides == counter2.allSlides &&
          counter1.allViews == counter2.allViews &&
          counter1.allReviews == counter2.allReviews
      ){
        _areIdentical = true;
      }

    }

    return _areIdentical;
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
    if (other is BzCounterModel){
      _areIdentical = checkBzCounterModelsAreIdentical(
        counter1: this,
        counter2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      bzID.hashCode^
      follows.hashCode^
      calls.hashCode^
      allSaves.hashCode^
      allShares.hashCode^
      allSlides.hashCode^
      allViews.hashCode^
      allReviews.hashCode;
// -----------------------------------------------------------------------------
}
