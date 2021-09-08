import 'package:flutter/foundation.dart';
// -----------------------------------------------------------------------------
class FCMToken {
  final String token;
  final DateTime createdAt;
  final String platform;

  FCMToken({
    @required this.token,
    @required this.createdAt,
    @required this.platform,
});
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap(){

    return
        {
          'token' : token,
          'createdAt' : createdAt,
          'platform' : platform,
        };
  }
// -----------------------------------------------------------------------------
  static FCMToken decipherFCMToken(Map<String, dynamic> map){
    FCMToken _token;

    if (map != null){

      _token = FCMToken(
          token: map['token'],
          createdAt: map['createdAt'].toDate(),
          platform: map['platform'],
      );

    }
    return _token;
  }
// -----------------------------------------------------------------------------
}