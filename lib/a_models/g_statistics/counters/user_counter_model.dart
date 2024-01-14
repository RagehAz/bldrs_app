// ignore_for_file: constant_identifier_names
import 'package:basics/helpers/checks/tracers.dart';
import 'package:flutter/material.dart';
/// => TAMAM
@immutable
class UserCounterModel {
  // -----------------------------------------------------------------------------
  const UserCounterModel({
    required this.userID,
    required this.sessions,
    required this.views,
    required this.saves,
    required this.reviews,
    required this.shares,
    required this.follows,
    required this.calls,
  });
  // --------------------
  final String userID;
  final int sessions;
  final int views;
  final int saves;
  final int reviews;
  final int shares;
  final int follows;
  final int calls;
  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const String field_sessions = 'sessions';
  static const String field_views = 'views';
  static const String field_saves = 'saves';
  static const String field_reviews = 'reviews';
  static const String field_shares = 'shares';
  static const String field_follows = 'follows';
  static const String field_calls = 'calls';
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static UserCounterModel createInitialModel(String userID){
    return UserCounterModel(
      userID: userID,
      sessions: 0,
      views: 0,
      saves: 0,
      reviews: 0,
      shares: 0,
      follows: 0,
      calls: 0,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  UserCounterModel copyWith({
    String? userID,
    int? sessions,
    int? views,
    int? saves,
    int? reviews,
    int? shares,
    int? follows,
    int? calls,
  }){

    return UserCounterModel(
      userID: userID ?? this.userID,
      sessions: sessions ?? this.sessions,
      views: views ?? this.views,
      saves: saves ?? this.saves,
      reviews: reviews ?? this.reviews,
      shares: shares ?? this.shares,
      follows: follows ?? this.follows,
      calls: calls ?? this.calls,
    );

  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap(){
    return {
      // 'userID' : userID,
      'sessions' : sessions,
      'views' : views,
      'saves' : saves,
      'reviews' : reviews,
      'shares' : shares,
      'follows' : follows,
      'calls' : calls,
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static UserCounterModel? decipherUserCounter({
    required Map<String, dynamic>? map,
    required String? userID,
  }){

    if (map == null || userID == null){
      return null;
    }

    else {
      return UserCounterModel(
        userID: userID,
        sessions: map['sessions'] ?? 0,
        views: map['views'] ?? 0,
        saves: map['saves'] ?? 0,
        reviews: map['reviews'] ?? 0,
        shares: map['shares'] ?? 0,
        follows: map['follows'] ?? 0,
        calls: map['calls'] ?? 0,
      );
    }

  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogCounter(){
    blog(
            'UserCounterModel(\n'
            '   userID: $userID\n'
            '   sessions: $sessions\n'
            '   views: $views\n'
            '   saves: $saves\n'
            '   reviews: $reviews\n'
            '   shares: $shares\n'
            '   follows: $follows\n'
            '   calls: $calls\n'
            ')'
    );
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkUsersCounterModelsAreIdentical({
    required UserCounterModel? counter1,
    required UserCounterModel? counter2,
  }){
    bool _areIdentical = false;

    if (counter1 == null && counter2 == null){
      _areIdentical = true;
    }
    else if (counter1 != null && counter2 != null){

      if (
          counter1.userID == counter2.userID &&
          counter1.sessions == counter2.sessions &&
          counter1.views == counter2.views &&
          counter1.saves == counter2.saves &&
          counter1.reviews == counter2.reviews &&
          counter1.shares == counter2.shares &&
          counter1.follows == counter2.follows &&
          counter1.calls == counter2.calls
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
      UserCounterModel(
        userID: $userID
        sessions: $sessions
        views: $views
        saves: $saves
        reviews: $reviews
        shares: $shares
        follows: $follows
        calls: $calls
      )
      ''';
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is UserCounterModel){
      _areIdentical = checkUsersCounterModelsAreIdentical(
        counter1: this,
        counter2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      userID.hashCode^
      sessions.hashCode^
      views.hashCode^
      saves.hashCode^
      reviews.hashCode^
      shares.hashCode^
      follows.hashCode^
      calls.hashCode;
  // -----------------------------------------------------------------------------
}
