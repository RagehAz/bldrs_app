

import 'package:flutter/foundation.dart';


/// ON FLYER CREATION => CLOUD FUNCTION = > CREATE FLYER STATS OBJECT ON DB
/// ON RECORD CREATION => CLOUD  FUNCTION => INCREMENT - DECREMENT
class FlyerCounterModel {
  /// -----------------------------------------------------------------------------
  FlyerCounterModel({
    @required this.flyerID,
    @required this.saves,
    @required this.shares,
    @required this.views,
    @required this.reviews,
});
/// -----------------------------------------------------------------------------
  final String flyerID;
  final int saves;
  final int shares;
  final int views;
  final int reviews;
// -----------------------------------------------------------------------------

  /// INITIALIZATION

// ----------------------------------------
  static FlyerCounterModel createInitialModel(String flyerID){
    return FlyerCounterModel(
        flyerID: flyerID,
        saves: 0,
        shares: 0,
        views: 0,
        reviews: 0,
    );
  }
// ----------------------------------------
  FlyerCounterModel copyWith({
    String flyerID,
    int saves,
    int shares,
    int views,
    int reviews,
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

// ----------------------------------------
  Map<String, dynamic> toMap(){
    return {
      'flyerID' : flyerID,
      'saves' : saves,
      'shares' : shares,
      'views' : views,
      'reviews' : reviews,
    };
  }
// ----------------------------------------
  static FlyerCounterModel decipherStatsModel(Map<String, dynamic> map){

    FlyerCounterModel _model;

    if (map != null){
      _model = FlyerCounterModel(
          flyerID: map['flyerID'],
          saves: map['saves'],
          shares: map['shares'],
          views: map['views'],
          reviews: map['reviews'],
      );
    }

    return _model;
  }
// ----------------------------------------

}
