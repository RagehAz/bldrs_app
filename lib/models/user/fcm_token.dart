import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
// -----------------------------------------------------------------------------
class FCMToken {
  final String token;
  final FieldValue createdAt;
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
}