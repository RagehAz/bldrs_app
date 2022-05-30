import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
// -----------------------------------------------------------------------------
enum NoteType {
  /// WHEN BZ AUTHOR SENDS INVITATION TO A USER TO BECOME AN AUTHOR OF THE BZ
  authorship,
}
// -----------------------------------------------------------------------------
enum NoteAttachmentType {
  non,
  flyers,
  banner,
  buttons,
  bz,
  author,
  user,
  country,
  bldrs,
}
// -----------------------------------------------------------------------------
class NoteModel {
  /// --------------------------------------------------------------------------
  const NoteModel({
    @required this.id,
    @required this.senderID,
    @required this.receiverID,
    @required this.title,
    @required this.body,
    @required this.metaData,
    @required this.sentTime,
    @required this.attachment,
    @required this.attachmentType,
    @required this.seen,
    @required this.seenTime,
    @required this.sendFCM,
    @required this.noteType,
    @required this.response,
    @required this.responseTime,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final String senderID;
  final String receiverID;
  final String title; /// max 30 char
  final String body; /// max 80 char
  final dynamic metaData;
  final DateTime sentTime; /// TASK : CREATE NEW FIREBASE QUERY INDEX
  final dynamic attachment;
  final NoteAttachmentType attachmentType;
  final bool seen; /// TASK : CREATE NEW FIREBASE QUERY INDEX
  final DateTime seenTime;
  final bool sendFCM;
  final NoteType noteType;
  final String response;
  final DateTime responseTime;
  // final UserBalloon
// -----------------------------------------------------------------------------

  /// CONSTANTS

// -------------------------------------
  static const String bldrsLogoURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/usersPics%2FrBjNU5WybKgJXaiBnlcBnfFaQSq1.jpg?alt=media&token=54a23d82-5642-4086-82b3-b4c1cb885b64';
  static const String notiSound = 'default';
  static const String notiStatus = 'done';
  static const String bldrsSenderID = 'bldrs';
  static const dynamic defaultMetaData = <String, dynamic>{
    'click_action': 'FLUTTER_NOTIFICATION_CLICK',
    'sound': notiSound,
    'status': notiStatus,
    'screen': '',
  };
// -----------------------------------------------------------------------------

  /// CLONING

// -------------------------------------
  NoteModel copyWith({
    String id,
    String senderID,
    String receiverID,
    String title,
    String body,
    dynamic metaData,
    DateTime sentTime,
    dynamic attachment,
    NoteAttachmentType attachmentType,
    bool seen,
    DateTime seenTime,
    bool sendFCM,
    NoteType noteType,
    dynamic response,
    DateTime responseTime,
}){
    return NoteModel(
      id: id ?? this.id,
      senderID: senderID ?? this.senderID,
      receiverID: receiverID ?? this.receiverID,
      title: title ?? this.title,
      body: body ?? this.body,
      metaData: metaData ?? this.metaData,
      sentTime: sentTime ?? this.sentTime,
      attachment: attachment ?? this.attachment,
      attachmentType: attachmentType ?? this.attachmentType,
      seen: seen ?? this.seen,
      seenTime: seenTime ?? this.seenTime,
      sendFCM: sendFCM ?? this.sendFCM,
      noteType: noteType ?? this.noteType,
      response: response ?? this.response,
      responseTime: responseTime ?? this.responseTime,
    );
}
// -----------------------------------------------------------------------------

/// MODEL CYPHERS

// -------------------------------------
  Map<String, dynamic> toMap({
    @required bool toJSON,
  }) {
    return <String, dynamic>{
      // 'id': id, /// no need
      'senderID': senderID,
      'receiverID': receiverID,
      /// {notification: {body: Bldrs.net is super Awesome, title: Bldrs.net}, data: {}}
      'notification': _cipherNotificationField(),
      'sentTime': Timers.cipherTime(time: sentTime, toJSON: toJSON),
      'attachment': attachment,
      'attachmentType': cipherNoteAttachmentType(attachmentType),
      'seen': seen,
      'seenTime': Timers.cipherTime(time: seenTime, toJSON: toJSON),
      'sendFCM': sendFCM,
      'noteType': cipherNoteType(noteType),
      'response': response,
      'responseTime': Timers.cipherTime(time: responseTime, toJSON: toJSON),
    };
  }
// -------------------------------------
  Map<String, dynamic> _cipherNotificationField(){
    return <String, dynamic>{
      'notification': <String, dynamic>{
        'title': title,
        'body': body,
      },
      'data': metaData,
    };
  }
// -------------------------------------
  static NoteModel decipherNoteModel({
    @required dynamic map,
    @required bool fromJSON
  }) {
    NoteModel _noti;

    if (map != null) {

      final NoteAttachmentType _attachmentType = decipherNoteAttachmentType(map['attachmentType']);

      _noti = NoteModel(
        id: map['id'],
        senderID: map['senderID'],
        receiverID: map['receiverID'],
        title: map['notification']['notification']['title'],
        body: map['notification']['notification']['body'],
        metaData: map['notification']['data'],
        sentTime: Timers.decipherTime(
          time: map['sentTime'],
          fromJSON: fromJSON,
        ),
        attachment: decipherNoteAttachment(
          attachmentType: _attachmentType,
          attachment: map['attachment'],
        ),
        attachmentType: _attachmentType,
        seen: map['seen'],
        seenTime: Timers.decipherTime(
          time: map['seenTime'],
          fromJSON: fromJSON,
        ),
        sendFCM: map['sendFCM'],
        noteType: decipherNoteType(map['noteType']),
        response: map['response'],
        responseTime: Timers.decipherTime(
          time: map['responseTime'],
          fromJSON: fromJSON,
        ),
      );
    }

    // _noti.blogNotiModel(methodName: 'decipherNotiModel');

    return _noti;
  }
// -------------------------------------
  static List<NoteModel> decipherNotesModels({
    @required List<Map<String, dynamic>> maps,
    @required bool fromJSON,
  }) {
    final List<NoteModel> _notiModels = <NoteModel>[];

    if (Mapper.canLoopList(maps)) {
      for (final Map<String, dynamic> map in maps) {

        final NoteModel _notiModel = decipherNoteModel(
          map: map,
          fromJSON: fromJSON,
        );

        _notiModels.add(_notiModel);
      }
    }

    return _notiModels;
  }
// -------------------------------------
  static List<NoteModel> getNotesModelsFromSnapshot(DocumentSnapshot<Object> doc) {
    final Object _maps = doc.data();
    final List<NoteModel> _notiModels = decipherNotesModels(
      maps: _maps,
      fromJSON: false,
    );
    return _notiModels;
  }
// -----------------------------------------------------------------------------

  /// NOTE TYPE CYPHERS

// -------------------------------------
  static String cipherNoteType(NoteType noteType){
    switch(noteType){
      case NoteType.authorship: return 'authorship'; break;
      default : return null;
    }
  }
// -------------------------------------
  static NoteType decipherNoteType(String noteType){
    switch(noteType){
      case 'authorship': return NoteType.authorship; break;
      default: return null;
    }
  }
// -----------------------------------------------------------------------------

  /// ATTACHMENT TYPE CYPHERS

// -------------------------------------
  static dynamic decipherNoteAttachment({
  @required NoteAttachmentType attachmentType,
  @required dynamic attachment,
}){

    dynamic _output;

    /// non     : data type : null
    if (attachmentType == NoteAttachmentType.non){
      // output is null
    }
    /// flyers  : data type : List<String> flyersIDs
    /// buttons : data type : List<String> buttonsIDs
    else if (
    attachmentType == NoteAttachmentType.flyers
    ||
    attachmentType == NoteAttachmentType.buttons
    ){
      final List<String> _strings = Mapper.getStringsFromDynamics(
        dynamics: attachment,
      );
      _output = _strings;
    }
    /// banner  : data type : String imageURL
    /// bz      : data type : String bzID
    /// author  : data type : String authorID
    /// user    : data type : String userID
    /// country : data type : String countryID
    /// bldrs   : data type : String graphicID
    else {
      _output = attachment;
    }

  return _output;
  }
// -------------------------------------
  static NoteAttachmentType decipherNoteAttachmentType(String attachmentType) {
    switch (attachmentType) {
      case 'non':     return NoteAttachmentType.non;      break;
      case 'flyers':  return NoteAttachmentType.flyers;   break;
      case 'banner':  return NoteAttachmentType.banner;   break;
      case 'buttons': return NoteAttachmentType.buttons;  break;
      case 'bz':      return NoteAttachmentType.bz;       break;
      case 'author':  return NoteAttachmentType.author;   break;
      case 'user':    return NoteAttachmentType.user;     break;
      case 'country': return NoteAttachmentType.country;  break;
      case 'bldrs':   return NoteAttachmentType.bldrs;    break;
      default:        return NoteAttachmentType.non;
    }
  }
// -------------------------------------
  static String cipherNoteAttachmentType(NoteAttachmentType attachmentType) {
    switch (attachmentType) {
      case NoteAttachmentType.non:          return 'non';     break; /// data type : null
      case NoteAttachmentType.flyers:       return 'flyers';  break; /// data type : List<String> flyersIDs
      case NoteAttachmentType.banner:       return 'banner';  break; /// data type : String imageURL
      case NoteAttachmentType.buttons:      return 'buttons'; break; /// data type : List<String> buttonsIDs
      case NoteAttachmentType.bz:           return 'bz';      break; /// data type : String bzID
      case NoteAttachmentType.author:       return 'author';  break; /// data type : String authorID
      case NoteAttachmentType.user:         return 'user';    break; /// data type : String userID
      case NoteAttachmentType.country:      return 'country'; break; /// data type : String countryID
      case NoteAttachmentType.bldrs:        return 'bldrs';   break; /// data type : String graphicID
      default:return 'non';
    }
  }
// -------------------------------------
  static const List<NoteAttachmentType> notiAttachmentTypesList = <NoteAttachmentType>[
      NoteAttachmentType.non,
      NoteAttachmentType.flyers,
      NoteAttachmentType.banner,
      NoteAttachmentType.buttons,
      NoteAttachmentType.bz,
      NoteAttachmentType.author,
      NoteAttachmentType.user,
      NoteAttachmentType.country,
      NoteAttachmentType.bldrs,
      NoteAttachmentType.non,
    ];
// -----------------------------------------------------------------------------

  /// BLOGGING

// -------------------------------------
  void blogNoteModel({String methodName}) {
    blog('BLOGGING NoteModel : $methodName ---------------- START -- ');

    blog('id : $id');
    blog('senderID : $senderID');
    blog('receiverID : $receiverID');
    blog('title : $title');
    blog('body : $body');
    blog('metaData : ${metaData.toString()}');
    blog('sentTime : ${sentTime.toString()}');
    blog('attachment : ${attachment.toString()}');
    blog('attachmentType : ${attachmentType.toString()}');
    blog('seen : $seen');
    blog('seenTime : $seenTime');
    blog('sendFCM : ${sendFCM.toString()}');

    blog('BLOGGING NoteModel : $methodName ---------------- END -- ');
  }

  static void blogNotes({
    @required List<NoteModel> notes,
    String methodName,
  }){

    if (Mapper.canLoopList(notes) == true){

      for (final NoteModel note in notes){

        note.blogNoteModel(
          methodName: methodName,
        );

      }

    }

    else {
      blog('NOTES ARE EMPTY AND NOTHING TO BLOG HERE');
    }

  }
// -----------------------------------------------------------------------------

  /// GETTERS

// -------------------------------------
static List<String> getReceiversIDs({
  @required List<NoteModel> notes,
}){

    final List<String> _output = <String>[];

    if (Mapper.canLoopList(notes) == true){

      for (final NoteModel note in notes){
        _output.add(note.receiverID);
      }

    }

    return _output;
}
// -------------------------------------
static NoteModel getFirstNoteByRecieverID({
  @required List<NoteModel> notes,
  @required String receiverID,
}){

    NoteModel _output;

    if (Mapper.canLoopList(notes) == true && receiverID != null){

      _output = notes.firstWhere(
              (note) => note.receiverID == receiverID,
          orElse: ()=> null
      );

    }

    return _output;
}
// -------------------------------------
}
// -----------------------------------------------------------------------------
