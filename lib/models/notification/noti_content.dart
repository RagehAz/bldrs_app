import 'package:flutter/foundation.dart';

class NotiContent{
  /// should not exceed max 30 characters including spaces
  final String title;
  /// max 80 characters including spaces
  final String body;

  NotiContent ({
    @required this.body,
    @required this.title,
  });
// -----------------------------------------------------------------------------
  static NotiContent decipherNotiNotification(dynamic map){
    NotiContent _notiMessage;

    if (map != null){

      _notiMessage = NotiContent(
        body: map['body'],
        title: map['title'],
      );

    }
    return _notiMessage;
  }
// -----------------------------------------------------------------------------
}
