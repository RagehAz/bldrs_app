import 'package:flutter/foundation.dart';

class NotiNotification{
  final String body;
  final String title;

  NotiNotification ({
    @required this.body,
    @required this.title,
  });
// -----------------------------------------------------------------------------
  static NotiNotification decipherNotiNotification(dynamic map){
    NotiNotification _notiMessage;

    if (map != null){

      _notiMessage = NotiNotification(
        body: map['body'],
        title: map['title'],
      );

    }
    return _notiMessage;
  }
// -----------------------------------------------------------------------------
}
