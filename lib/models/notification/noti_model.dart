import 'package:flutter/foundation.dart';

enum NotiType{
  onMessage,
  onResume,
  onLaunch,
}



enum NotiSubject{
  ad,
  welcome,
  newFlyerPublishedByFollowedBz,
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
  scheduled,

}

enum NotiSender {
  bz,
  author,
  user,
  bldrs,
}

class NotiModel{
  final NotiSubject subject;
  /// timing describes the condition "when" something happens to trigger the notification
  final String timing;
  /// sudo code for condition logic
  final String Condition;
  /// timeStamp
  final DateTime timeStamp;
  ///
  final NotiReciever reciever;
  final NotiSender sender;
  final String senderPicURL;
  ///
  final CityState cityState;
  /// {notification: {body: Bldrs.net is super Awesome, title: Bldrs.net}, data: {}}
  /// should not exceed max 30 characters including spaces
  final String title;
  /// max 80 characters including spaces
  final String body;
  /// Actually, it is of type : InternalLinkedHashMap<dynamic, dynamic>
  final dynamic metaData;
  /// sends notification automatically, if false, should manually be triggered by onTap event
  final bool autoFire;

  NotiModel({
    this.subject,
    this.timing,
    this.Condition,
    this.timeStamp,
    this.reciever,
    @required this.sender,
    @required this.senderPicURL,
    this.cityState,
    this.autoFire,
    @required this.title,
    @required this.body,
    @required this.metaData,
  });
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap(){
    return
        {
          'subject' : subject,
          'timing' : timing,
          'Condition' : Condition,
          'timeStamp' : timeStamp,
          'reciever' : reciever,
          'sender' : sender,
          'senderPicURL' : senderPicURL,
          'cityState' : cityState,
          'autoFire' : autoFire,
          'notification' : {
            'title' : title,
            'body' : body,
          },
          'metaData' : metaData,

  };

  }
// -----------------------------------------------------------------------------
  static NotiModel decipherNotiModel(dynamic map){
    NotiModel _noti;

    if (map != null){

      _noti = NotiModel(
        subject: map['subject'],
        timing: map['timing'],
        Condition: map['Condition'],
        timeStamp: map['timeStamp'],
        reciever: map['reciever'],
        sender: map['sender'],
        senderPicURL: map['senderPicURL'],
        cityState: map['cityState'],
        autoFire: map['autoFire'],
        body: map['notification.body'],
        title: map['notification.title'],
        metaData: map['data'],
      );
    }

    return _noti;
  }
// -----------------------------------------------------------------------------

}