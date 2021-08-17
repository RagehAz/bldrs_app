import 'package:flutter/foundation.dart';
import 'package:bldrs/models/notification/noti_notification.dart';

enum NotiType{
  onMessage,
  onResume,
  onLaunch,
}

class NotiModel{
  /// {notification: {body: Bldrs.net is super Awesome, title: Bldrs.net}, data: {}}
  final NotiNotification notification;
  /// Actually, it is of type : InternalLinkedHashMap<dynamic, dynamic>
  final dynamic data;

  NotiModel({
    @required this.notification,
    @required this.data,
  });
// -----------------------------------------------------------------------------
  static NotiModel decipherNotiModel(dynamic map){
    NotiModel _noti;

    if (map != null){

      _noti = NotiModel(
        notification: NotiNotification.decipherNotiNotification(map['notification']),
        data: map['data'],
      );

    }

    return _noti;
  }
// -----------------------------------------------------------------------------
}