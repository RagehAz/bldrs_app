// ignore_for_file: constant_identifier_names

import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:flutter/foundation.dart';
/// => TAMAM
@immutable
class FlyerCounterModel {
  // -----------------------------------------------------------------------------
  /// ON FLYER CREATION => CLOUD FUNCTION = > CREATE FLYER COUNTER OBJECT ON DB
  /// ON RECORD CREATION => CLOUD  FUNCTION => INCREMENT - DECREMENT
  // -----------------------------------------------------------------------------
  const FlyerCounterModel({
    required this.flyerID,
    required this.saves,
    required this.shares,
    required this.views,
    required this.reviews,
  });
  // --------------------
  final String? flyerID;
  final int? saves;
  final int? shares;
  final int? views;
  final int? reviews;
  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const String field_saves = 'saves';
  static const String field_shares = 'shares';
  static const String field_views = 'views';
  static const String field_reviews = 'reviews';
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static FlyerCounterModel createInitialModel(String flyerID){
    return FlyerCounterModel(
      flyerID: flyerID,
      saves: 0,
      shares: 0,
      views: 0,
      reviews: 0,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  FlyerCounterModel copyWith({
    String? flyerID,
    int? saves,
    int? shares,
    int? views,
    int? reviews,
  }){

    return FlyerCounterModel(
      flyerID: flyerID ?? this.flyerID,
      saves: saves ?? this.saves,
      shares: shares ?? this.shares,
      views: views ?? this.views,
      reviews: reviews ?? this.reviews,
    );

  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap(){
    return {
      // 'flyerID' : flyerID,
      'saves' : saves,
      'shares' : shares,
      'views' : views,
      'reviews' : reviews,
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static FlyerCounterModel? decipherCounterMap({
    required Map<String, dynamic>? map,
    required String? flyerID,
  }){

    FlyerCounterModel? _model;

    if (map != null){
      _model = FlyerCounterModel(
        flyerID: flyerID ?? map['flyerID'],
        saves: map['saves'],
        shares: map['shares'],
        views: map['views'],
        reviews: map['reviews'],
      );
    }

    return _model;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogCounter(){

    blog(
        'FlyerCounterModel : flyerID: $flyerID - '
            'saves: $saves - '
            'shares: $shares - '
            'views: $views - '
            'reviews: $reviews -'
    );

  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkFlyerCounterModelsAreIdentical({
    required FlyerCounterModel? counter1,
    required FlyerCounterModel? counter2,
  }){
    bool _areIdentical = false;

    if (counter1 == null && counter2 == null){
      _areIdentical = true;
    }
    else if (counter1 != null && counter2 != null){

      if (
          counter1.flyerID == counter2.flyerID &&
          counter1.saves == counter2.saves &&
          counter1.shares == counter2.shares &&
          counter1.views == counter2.views &&
          counter1.reviews == counter2.reviews
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
      FlyerCounterModel(
        flyerID: $flyerID
        saves: $saves
        shares: $shares
        views: $views
        reviews: $reviews
      )
      ''';
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is FlyerCounterModel){
      _areIdentical = checkFlyerCounterModelsAreIdentical(
        counter1: this,
        counter2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      flyerID.hashCode^
      saves.hashCode^
      shares.hashCode^
      views.hashCode^
      reviews.hashCode;
  // -----------------------------------------------------------------------------
}
