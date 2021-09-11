import 'package:bldrs/models/notification/noti_sudo.dart';
import 'package:flutter/foundation.dart';

enum NotiType{
  onMessage,
  onResume,
  onLaunch,
}

enum NotiAttachmentType{
  non,
  flyers,
  bz,
  banner,
  buttons,
}

enum NotiChannel{
  basic,
  scheduled,

}

enum NotiPicType {
  bz,
  author,
  user,
  bldrs,
  country,
}

class NotiModel{
  final String id;
  final String name;
  final NotiSudo sudo; /// sudo description for /// event trigger : /// scheduled timing : /// if statement /// cityState :

  final String senderID;
  final String pic;
  final NotiPicType picType;
  final String title; /// max 30 char
  final DateTime timeStamp;
  final String body; /// max 80 char
  final dynamic attachment;
  final NotiAttachmentType attachmentType;

  final bool dismissed;
  final bool sendFCM;
  final dynamic metaData; /// of type : InternalLinkedHashMap<dynamic, dynamic>

  NotiModel({
    @required this.id,
    @required this.name,
    @required this.sudo,

    @required this.senderID,
    @required this.pic,
    @required this.picType,
    @required this.title,
    @required this.timeStamp,
    @required this.body,
    @required this.attachment,
    @required this.attachmentType,

    @required this.dismissed,
    @required this.sendFCM,
    @required this.metaData,
  });
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap(){
    return
        {
          'id' : id,
          'name' : name,
          'sudo' : sudo,

          'senderID' : senderID,
          'pic' : pic,
          'picType' : cipherNotiPicType(picType),
          'timeStamp' : timeStamp,
          /// {notification: {body: Bldrs.net is super Awesome, title: Bldrs.net}, data: {}}
          'notification' : {
            'notification' : {
              'title' : title,
              'body' : body,
            },
            'data' : metaData,
          },
          'attachment' : attachment,
          'attachmentType' : cipherNotiAttachmentType(attachmentType),

          'dismissed' : dismissed,
          'sendFCM' : sendFCM,
  };

  }
// -----------------------------------------------------------------------------
  static NotiModel decipherNotiModel(dynamic map){
    NotiModel _noti;

    if (map != null){

      _noti = NotiModel(
        id: map['id'],
        name: map['name'],
        sudo: map['sudo'],

        senderID: map['senderID'],
        pic: map['pic'],
        picType: decipherNotiPicType(map['picType']),
        title: map['notification.notification.title'],
        timeStamp: map['timeStamp'],
        body: map['notification.notification.body'],
        attachment: map['attachment'],
        attachmentType: decipherNotiAttachmentType(map['attachmentType']),

        dismissed: map['seen'],
        sendFCM: map['sendFCM'],
        metaData: map['notification.data'],
      );
    }

    return _noti;
  }
// -----------------------------------------------------------------------------
  static String cipherNotiPicType(NotiPicType sender){
    switch (sender){
      case NotiPicType.bldrs   : return 'bldrs'; break;
      case NotiPicType.bz      : return 'bz'; break;
      case NotiPicType.user    : return 'user'; break;
      case NotiPicType.author  : return 'author'; break;
      case NotiPicType.country    : return 'country'; break;
      default: return 'bldrs';
    }
  }
// -----------------------------------------------------------------------------
  static NotiPicType decipherNotiPicType(String sender){
    switch (sender){
      case 'bldrs'    : return NotiPicType.bldrs; break;
      case 'bz'       : return NotiPicType.bz   ; break;
      case 'user'     : return NotiPicType.user ; break;
      case 'author'   : return NotiPicType.author; break;
      case 'country'     : return NotiPicType.country; break;
      default: return NotiPicType.bldrs;
    }
  }
// -----------------------------------------------------------------------------
  static NotiAttachmentType decipherNotiAttachmentType(String attachmentType){
    switch (attachmentType){
      case 'non'  : return NotiAttachmentType.non; break;
      case 'flyers' : return NotiAttachmentType.flyers; break;
      case 'banner' : return NotiAttachmentType.banner; break;
      case 'bz' : return NotiAttachmentType.bz; break;
      case 'buttons' : return NotiAttachmentType.buttons; break;
      default: return NotiAttachmentType.non;
    }
  }
// -----------------------------------------------------------------------------
  static String cipherNotiAttachmentType(NotiAttachmentType attachmentType){
    switch (attachmentType){
      case NotiAttachmentType.non : return 'non'; break;
      case NotiAttachmentType.flyers : return 'flyers'; break;
      case NotiAttachmentType.banner : return 'banner'; break;
      case NotiAttachmentType.bz : return 'bz'; break;
      case NotiAttachmentType.buttons : return 'buttons'; break;
      default: return 'non';
    }
  }

}