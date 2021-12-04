import 'package:bldrs/controllers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/controllers/drafters/timerz.dart' as Timers;
import 'package:bldrs/models/notification/noti_sudo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

enum NotiType{
  onMessage,
  onResume,
  onLaunch,
}

enum NotiAttachmentType{
  non,
  flyers,
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
  final NotiPicType notiPicType;
  final String title; /// max 30 char
  final DateTime timeStamp; // NEVER CHANGE THIS VAR NAME -> OR CREATE NEW FIREBASE QUERY INDEX
  final String body; /// max 80 char
  final dynamic attachment;
  final NotiAttachmentType attachmentType;

  final bool dismissed; // NEVER CHANGE THIS VAR NAME -> OR CREATE NEW FIREBASE QUERY INDEX
  final bool sendFCM;
  final dynamic metaData; /// of type : InternalLinkedHashMap<dynamic, dynamic>

  const NotiModel({
    @required this.id,
    @required this.name,
    @required this.sudo,

    @required this.senderID,
    @required this.pic,
    @required this.notiPicType,
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
  Map<String, dynamic> toMap({@required bool toJSON}){
    return
      <String, dynamic>{
          'id' : id,
          'name' : name,
          'sudo' : sudo?.toMap(),

          'senderID' : senderID,
          'pic' : pic,
          'picType' : cipherNotiPicType(notiPicType),
          'timeStamp' : Timers.cipherTime(time: timeStamp, toJSON: toJSON),
          /// {notification: {body: Bldrs.net is super Awesome, title: Bldrs.net}, data: {}}
          'notification' : <String, dynamic>{
            'notification' : <String, dynamic>{
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
  static NotiModel decipherNotiModel({@required dynamic map, @required bool fromJSON}){
    NotiModel _noti;

    if (map != null){

      _noti = NotiModel(
        id: map['id'],
        name: map['name'],
        sudo: NotiSudo.decipherNotiSudo(map['sudo']),

        senderID: map['senderID'],
        pic: map['pic'],
        notiPicType: decipherNotiPicType(map['picType']),
        title: map['notification']['notification']['title'],
        timeStamp: Timers.decipherTime(time: map['timeStamp'], fromJSON: fromJSON),
        body: map['notification']['notification']['body'],
        attachment: map['attachment'],
        attachmentType: decipherNotiAttachmentType(map['attachmentType']),

        dismissed: map['dismissed'],
        sendFCM: map['sendFCM'],
        metaData: map['notification']['data'],
      );
    }

    print('the damn damn damn noti boy is : $_noti');

    _noti.printNotiModel(methodName: 'bitchhh');

    return _noti;
  }
// -----------------------------------------------------------------------------
  static List<NotiModel> decipherNotiModels({@required List<Map<String, dynamic>> maps, @required bool fromJSON}){
    final List<NotiModel> _notiModels = <NotiModel>[];

    if (Mapper.canLoopList(maps)){

      for (Map<String, dynamic> map in maps){

        final NotiModel _notiModel = decipherNotiModel(
          map: map,
          fromJSON: fromJSON,
        );

        _notiModels.add(_notiModel);

      }

    }

    return _notiModels;
  }
// -----------------------------------------------------------------------------
  static String cipherNotiPicType(NotiPicType picType){
    switch (picType){
      case NotiPicType.bldrs   : return 'bldrs'; break;
      case NotiPicType.bz      : return 'bz'; break;
      case NotiPicType.user    : return 'user'; break;
      case NotiPicType.author  : return 'author'; break;
      case NotiPicType.country    : return 'country'; break;
      default: return 'bldrs';
    }
  }
// -----------------------------------------------------------------------------
  static NotiPicType decipherNotiPicType(String picType){
    switch (picType){
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
      case NotiAttachmentType.buttons : return 'buttons'; break;
      default: return 'non';
    }
  }
// -----------------------------------------------------------------------------
  static List<NotiAttachmentType> notiAttachmentTypesList(){
    return const <NotiAttachmentType>[
      NotiAttachmentType.non,
      NotiAttachmentType.flyers,
      NotiAttachmentType.banner,
      NotiAttachmentType.buttons,
    ];
  }
// -----------------------------------------------------------------------------
  void printNotiModel({String methodName}){
    print('$methodName : PRINTING NotiModel ---------------- START -- ');

    print('id : ${id.toString()}');
    print('name : ${name.toString()}');
    print('sudo : ${sudo.toString()}');
    print('senderID : ${senderID.toString()}');
    print('pic : ${pic.toString()}');
    print('notiPicType : ${notiPicType.toString()}');
    print('title : ${title.toString()}');
    print('timeStamp : ${timeStamp.toString()}');
    print('body : ${body.toString()}');
    print('attachment : ${attachment.toString()}');
    print('attachmentType : ${attachmentType.toString()}');
    print('dismissed : ${dismissed.toString()}');
    print('sendFCM : ${sendFCM.toString()}');
    print('metaData : ${metaData.toString()}');

    print('$methodName : PRINTING NotiModel ---------------- END -- ');
  }
// -----------------------------------------------------------------------------
  static List<NotiModel> getNotiModelsFromSnapshot(DocumentSnapshot<Object> doc){
    final Object _maps = doc.data();
    final List<NotiModel> _notiModels = decipherNotiModels(
      maps: _maps,
      fromJSON: false,
    );
    return _notiModels;
  }
// -----------------------------------------------------------------------------

}