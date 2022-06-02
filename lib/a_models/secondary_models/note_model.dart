import 'package:bldrs/a_models/secondary_models/map_model.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
// -----------------------------------------------------------------------------
enum NoteType {
  /// WHEN BZ AUTHOR SENDS INVITATION TO A USER TO BECOME AN AUTHOR OF THE BZ
  authorship,
  /// WHEN BLDRS.NET SENDS A USER SOME NEWS
  announcement,

}
// ------------------------
enum NoteAttachmentType {
  non,
  flyersIDs,
  bzID,
  imageURL,
}
// ------------------------
enum NoteSenderType {
  bldrs,
  user,
  // author,
  bz,
  country,
}
// -----------------------------------------------------------------------------
class NoteModel {
  /// --------------------------------------------------------------------------
  const NoteModel({
    @required this.id,
    @required this.senderID,
    @required this.senderImageURL,
    @required this.noteSenderType,
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
    @required this.buttons,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final String senderID;
  final String senderImageURL;
  final NoteSenderType noteSenderType;
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
  final List<String> buttons;
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
  static const MapModel bldrsSenderModel =  MapModel(
    key: 'Bldrs.net',
    value: Iconz.bldrsNameEn,
  );
  static const List<String> noteButtonsList = <String>[
    'phid_accept',
    'phid_decline',
  ];
// -----------------------------------------------------------------------------

  /// CLONING

// -------------------------------------
  NoteModel copyWith({
    String id,
    String senderID,
    String senderImageURL,
    NoteSenderType noteSenderType,
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
    List<String> buttons,
}){
    return NoteModel(
      id: id ?? this.id,
      senderID: senderID ?? this.senderID,
      senderImageURL: senderImageURL ?? this.senderImageURL,
      noteSenderType: noteSenderType ?? this.noteSenderType,
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
      buttons: buttons ?? this.buttons,
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
      'senderImageURL': senderImageURL,
      'noteSenderType': cipherNoteSenderType(noteSenderType),
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
      'buttons': buttons,
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
        senderImageURL: map['senderImageURL'],
        noteSenderType: decipherNoteSenderType(map['noteSenderType']),
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
        buttons: Mapper.getStringsFromDynamics(dynamics: map['buttons']),
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
      case NoteType.authorship:   return 'authorship';    break;
      case NoteType.announcement: return 'announcement';  break;
      default : return null;
    }
  }
// -------------------------------------
  static NoteType decipherNoteType(String noteType){
    switch(noteType){
      case 'authorship': return NoteType.authorship;      break;
      case 'announcement': return NoteType.announcement;  break;
      default: return null;
    }
  }

  static const List<NoteType> noteTypesList = <NoteType>[
    NoteType.announcement,
    NoteType.authorship,
  ];
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
    else if (
    attachmentType == NoteAttachmentType.flyersIDs
    ){
      final List<String> _strings = Mapper.getStringsFromDynamics(
        dynamics: attachment,
      );
      _output = _strings;
    }
    /// banner  : data type : String imageURL
    /// bz      : data type : String bzID
    else {
      _output = attachment;
    }

  return _output;
  }
// -------------------------------------
  static NoteAttachmentType decipherNoteAttachmentType(String attachmentType) {
    switch (attachmentType) {
      case 'non':       return NoteAttachmentType.non;        break;
      case 'flyersIDs': return NoteAttachmentType.flyersIDs;  break;
      case 'bzID':      return NoteAttachmentType.bzID;       break;
      case 'imageURL':  return NoteAttachmentType.imageURL;   break;
      default:          return NoteAttachmentType.non;
    }
  }
// -------------------------------------
  static String cipherNoteAttachmentType(NoteAttachmentType attachmentType) {
    switch (attachmentType) {
      case NoteAttachmentType.non:          return 'non';       break; /// data type : null
      case NoteAttachmentType.flyersIDs:    return 'flyersIDs'; break; /// data type : List<String> flyersIDs
      case NoteAttachmentType.imageURL:     return 'imageURL';  break; /// data type : String imageURL
      case NoteAttachmentType.bzID:         return 'bzID';      break; /// data type : String bzID
      default:return 'non';
    }
  }
// -------------------------------------
  static const List<NoteAttachmentType> noteAttachmentTypesList = <NoteAttachmentType>[
      NoteAttachmentType.non,
      NoteAttachmentType.flyersIDs,
      NoteAttachmentType.imageURL,
      NoteAttachmentType.bzID,
    ];
// -----------------------------------------------------------------------------

  /// NOTE SENDER TYPE CYPHERS

// -------------------------------------
  static String cipherNoteSenderType(NoteSenderType type){
    switch (type) {
      case NoteSenderType.bz:           return 'bz';      break; /// data type : String bzID
      // case NoteSenderType.author:       return 'author';  break; /// data type : String authorID
      case NoteSenderType.user:         return 'user';    break; /// data type : String userID
      case NoteSenderType.country:      return 'country'; break; /// data type : String countryID
      case NoteSenderType.bldrs:        return 'bldrs';   break; /// data type : String graphicID
      default:return 'non';
    }
  }
// -------------------------------------
  static NoteSenderType decipherNoteSenderType(String type){
    switch (type) {
      case 'bldrs':   return NoteSenderType.bldrs;    break;
      case 'user':    return NoteSenderType.user;     break;
      // case 'author':  return NoteSenderType.author;   break;
      case 'bz':      return NoteSenderType.bz;       break;
      case 'country': return NoteSenderType.country;  break;
      default:        return null;
    }
  }
// -------------------------------------
  static const List<NoteSenderType> noteSenderTypesList = <NoteSenderType>[
    NoteSenderType.bz,
    // NoteSenderType.author,
    NoteSenderType.user,
    NoteSenderType.country,
    NoteSenderType.bldrs,
  ];
// -----------------------------------------------------------------------------

  /// BLOGGING

// -------------------------------------
  void blogNoteModel({
    String methodName,
  }) {
    blog('BLOGGING NoteModel : $methodName -------------------------------- START -- ');

    blog('id : $id');
    blog('senderID : $senderID');
    blog('senderImageURL : $senderImageURL');
    blog('noteSenderType : $noteSenderType');
    blog('receiverID : $receiverID');
    blog('title : $title');
    blog('body : $body');
    blog('metaData : $metaData');
    blog('sentTime : $sentTime');
    blog('attachment : ${attachment?.toString()}');
    blog('attachmentType : $attachmentType');
    blog('seen : $seen');
    blog('seenTime : $seenTime');
    blog('sendFCM : $sendFCM');
    blog('noteType : $noteType');
    blog('response : $response');
    blog('responseTime : $responseTime');
    blog('buttons : ${buttons?.toString()}');

    blog('BLOGGING NoteModel : $methodName -------------------------------- END -- ');
  }
// -------------------------------------
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
static int getNumberOfUnseenNotes(List<NoteModel> notes){
    int _count;
    if (Mapper.canLoopList(notes) == true){
      final List<NoteModel> _unSeens = notes.where((note) => note.seen != true).toList();
      _count = _unSeens.length;
    }
    return _count;
}
// -------------------------------------
static List<String> getMissingNoteFields({
  @required NoteModel note,
  /// if consider all fields is false, this will get only fields required to send a note
  @required bool considerAllFields,
}){
    List<String> _missingFields;

    if (note != null){

      _missingFields = <String>[];

      if (note.senderID == null) {
        _missingFields.add('senderID');
      }

      if (note.senderImageURL == null){
        _missingFields.add('senderImageURL');
      }

      if (note.noteSenderType == null){
        _missingFields.add('noteSenderType');
      }

      if (note.receiverID == null){
        _missingFields.add('receiverID');
      }

      if (stringIsEmpty(note.title) == true){
        _missingFields.add('title');
      }

      if (stringIsEmpty(note.body) == true){
        _missingFields.add('body');
      }

      if (note.metaData == null){
        _missingFields.add('metaData');
      }

      if (note.sentTime == null){
        _missingFields.add('sentTime');
      }

      if (note.sendFCM == null){
        _missingFields.add('sendFCM');
      }

      if (note.noteType == null){
        _missingFields.add('noteType');
      }

      /// IF NOT ONLY ESSENTIAL FIELDS REQUIRED TO SEND A NOTE ARE TO BE CONSIDERED
      if (considerAllFields == true){

        if (note.id == null) {
          _missingFields.add('id');
        }

        if (note.attachment == null){
          _missingFields.add('attachment');
        }

        if (note.attachmentType == null){
          _missingFields.add('attachmentType');
        }

        if (note.seen == null){
          _missingFields.add('seen');
        }

        if (note.seenTime == null){
          _missingFields.add('seenTime');
        }

        if (note.response == null){
          _missingFields.add('response');
        }

        if (note.responseTime == null){
          _missingFields.add('responseTime');
        }

        if (note.buttons == null){
          _missingFields.add('buttons');
        }

      }

    }

    return _missingFields;
}
// -----------------------------------------------------------------------------

  /// CHECKERS

// -------------------------------------
static bool checkThereAreUnSeenNotes(List<NoteModel> notes){
    bool _thereAreUnseenNotes = false;

    if (Mapper.canLoopList(notes) == true){

      for (final NoteModel note in notes){

        if (note.seen != true){
          _thereAreUnseenNotes = true;
          break;
        }

      }

    }

    return _thereAreUnseenNotes;
}
// -------------------------------------
static bool checkCanSendNote(NoteModel noteModel){
    bool _canSend = false;

    if (noteModel != null){

      if (
      // noteModel.id != null &&
      noteModel.senderID != null &&
      noteModel.senderImageURL != null &&
      noteModel.noteSenderType != null &&
      noteModel.receiverID != null &&
      noteModel.title != null &&
      noteModel.body != null &&
      noteModel.metaData != null &&
      noteModel.sentTime != null &&
      // noteModel.attachment != null &&
      // noteModel.attachmentType != null &&
      // noteModel.seen != null &&
      // noteModel.seenTime != null &&
      noteModel.sendFCM != null &&
      noteModel.noteType != null
      // && noteModel.response != null &&
      // noteModel.responseTime != null &&
      // noteModel.buttons != null
      ){
        _canSend = true;
      }

    }

    return _canSend;
}
}
// -----------------------------------------------------------------------------
