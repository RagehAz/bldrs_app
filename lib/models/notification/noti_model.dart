import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:bldrs/models/notification/noti_content.dart';

enum NotiType{
  onMessage,
  onResume,
  onLaunch,
}

enum NotiReason{
  ad,
  event,
  reminder,
  education,
}

enum NotiReciever{
  user,
  users,
  author,
  authors,
}

enum CityState{
  private, /// app shows bzz only ,, all flyers hidden to public,, currently building content
  public, /// app shows all
  any,
}

enum NotiChannel{
  basic,

}

class NotiModel{
  final NotiReason reason;
  /// timing describes the condition "when" something happens to trigger the notification
  final String timing;
  /// sudo code for condition logic
  final String Condition;
  /// timeStamp
  final String dayHour;
  ///
  final NotiReciever reciever;
  ///
  final CityState cityState;
  /// {notification: {body: Bldrs.net is super Awesome, title: Bldrs.net}, data: {}}
  final NotiContent notiContent;
  /// Actually, it is of type : InternalLinkedHashMap<dynamic, dynamic>
  final dynamic metaData;
  /// sends notification automatically, if false, should manually be triggered by onTap event
  final bool autoFire;

  NotiModel({
    this.reason,
    this.timing,
    this.Condition,
    this.dayHour,
    this.reciever,
    this.cityState,
    this.autoFire,
    @required this.notiContent,
    @required this.metaData,
  });
// -----------------------------------------------------------------------------
  static NotiModel decipherNotiModel(dynamic map){
    NotiModel _noti;

    if (map != null){

      _noti = NotiModel(
        notiContent: NotiContent.decipherNotiNotification(map['notification']),
        metaData: map['data'],
      );

    }

    return _noti;
  }
// -----------------------------------------------------------------------------
  static String notiChannelName(NotiChannel channel){
    switch (channel){
      case NotiChannel.basic: return 'Basic Notifications'; break;
      default: return 'Basic Notifications';
    }
  }

// -----------------------------------------------------------------------------

}