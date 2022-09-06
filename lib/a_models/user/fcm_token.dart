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

  /// BLOGGING

  // --------------------
  void blogToken(){
    blog('Token : platform $platform : createdAt : $createdAt : token : $token');
  }
  // -----------------------------------------------------------------------------
}
