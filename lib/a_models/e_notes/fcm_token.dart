import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:flutter/foundation.dart';

@immutable
class FCMToken {
  /// --------------------------------------------------------------------------
  const FCMToken({
    @required this.token,
    @required this.createdAt,
    @required this.platform,
  });
  /// --------------------------------------------------------------------------
  final String token;
  final DateTime createdAt;
  final String platform;
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  Map<String, dynamic> toMap({
    @required bool toJSON,
  }) {
    return <String, dynamic>{
      'token': token,
      'createdAt': Timers.cipherTime(time: createdAt, toJSON: toJSON),
      'platform': platform,
    };
  }
  // --------------------
  static FCMToken decipherFCMToken({
    @required Map<String, dynamic> map,
    @required bool fromJSON,
  }) {
    FCMToken _token;

    if (map != null) {
      _token = FCMToken(
        token: map['token'],
        createdAt: Timers.decipherTime(time: map['createdAt'], fromJSON: fromJSON),
        platform: map['platform'],
      );
    }
    return _token;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  static bool checkTokensAreIdentical(FCMToken token1, FCMToken token2){
    bool _identical = false;

    if (token1 == null && token2 == null){
      _identical = true;
    }
    else {

      if (token1 != null && token2 != null){

        if (
            token1.token == token2.token &&
            Timers.checkTimesAreIdentical(accuracy: TimeAccuracy.microSecond, time1: token1.createdAt, time2: token2.createdAt) &&
            token1.platform == token2.platform
        ){
          _identical = true;
        }

      }

    }

    return _identical;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  void blogToken(){
    blog('Token : platform $platform : createdAt : $createdAt : token : $token');
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
    if (other is FCMToken){
      _areIdentical = checkTokensAreIdentical(this, other);
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      token.hashCode^
      createdAt.hashCode^
      platform.hashCode;
// -----------------------------------------------------------------------------
}
