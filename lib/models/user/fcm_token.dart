import 'package:bldrs/controllers/drafters/timerz.dart' as Timers;
import 'package:flutter/foundation.dart';
// -----------------------------------------------------------------------------
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
  /// --------------------------------------------------------------------------
  Map<String, dynamic> toMap({@required bool toJSON}){

    return
      <String, dynamic>{
          'token' : token,
          'createdAt' : Timers.cipherTime(time: createdAt, toJSON: toJSON),
          'platform' : platform,
        };
  }
// -----------------------------------------------------------------------------
  static FCMToken decipherFCMToken({@required Map<String, dynamic> map, @required bool fromJSON}){
    FCMToken _token;

    if (map != null){


      _token = FCMToken(
          token: map['token'],
          createdAt: Timers.decipherTime(time: map['createdAt'], fromJSON: fromJSON),
          platform: map['platform'],
      );

    }
    return _token;
  }
// -----------------------------------------------------------------------------
}
