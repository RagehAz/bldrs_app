import 'package:bldrs/a_models/secondary_models/map_model.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

enum NoteType {
  /// WHEN BZ AUTHOR SENDS INVITATION TO A USER TO BECOME AN AUTHOR OF THE BZ
  authorship,
  /// WHEN BLDRS.NET SENDS A USER SOME NEWS
  notice,
  /// WHEN FLYER UPDATES ON DB AND NEED TO ACTIVATE [ LOCAL FLYER UPDATE PROTOCOL ]
  flyerUpdate,
  /// WHEN A MASTER AUTHOR DELETES BZ, A NOTE IS SENT TO ALL AUTHORS
  bzDeletion,
}

enum NoteAttachmentType {
  non,
  flyersIDs,
  bzID,
  imageURL,
}

enum NoteSenderOrRecieverType {
  bldrs,
  user,
  // author,
  bz,
  country,
}

// enum NoteReceiverType {
//   user,
//   bz,
// }

enum NoteResponse{
  accepted, /// when receiver accepted
  declined, /// when receiver declines invitation
  pending, /// when receiver has not yet responded
  cancelled, /// when sender cancels invitation
}

enum DuplicatesAlgorithm {
  keepSecond,
  keepBoth,
  keepFirst,
}

@immutable
class NoteModel {
  /// --------------------------------------------------------------------------
  const NoteModel({
    @required this.id,
    @required this.senderID,
    @required this.senderImageURL,
    @required this.senderType,
    @required this.receiverID,
    @required this.receiverType,
    @required this.title,
    @required this.body,
    @required this.metaData,
    @required this.sentTime,
    @required this.attachment,
    @required this.attachmentType,
    @required this.seen,
    @required this.seenTime,
    @required this.sendFCM,
    @required this.type,
    @required this.response,
    @required this.responseTime,
    @required this.buttons,
    @required this.token,
    @required this.topic,
    this.docSnapshot,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final String senderID;
  final String senderImageURL;
  final NoteSenderOrRecieverType senderType;
  final String receiverID;
  final NoteSenderOrRecieverType receiverType;
  final String title; /// max 30 char
  final String body; /// max 80 char
  final Map<String, dynamic> metaData;
  final DateTime sentTime; /// TASK : CREATE NEW FIREBASE QUERY INDEX
  final dynamic attachment;
  final NoteAttachmentType attachmentType;
  final bool seen; /// TASK : CREATE NEW FIREBASE QUERY INDEX
  final DateTime seenTime;
  final bool sendFCM;
  final NoteType type;
  final NoteResponse response;
  final DateTime responseTime;
  final List<String> buttons;
  final String token;
  final String topic;
  final QueryDocumentSnapshot<Object> docSnapshot;
  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const String bldrsLogoURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/usersPics%2FrBjNU5WybKgJXaiBnlcBnfFaQSq1.jpg?alt=media&token=54a23d82-5642-4086-82b3-b4c1cb885b64';
  static const String notiSound = 'default';
  static const String notiStatus = 'done';
  static const String bldrsSenderID = 'Bldrs.net';
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

  // --------------------
  /// TESTED : WORKS PERFECT
  NoteModel copyWith({
    String id,
    String senderID,
    String senderImageURL,
    NoteSenderOrRecieverType senderType,
    String receiverID,
    NoteSenderOrRecieverType receiverType,
    String title,
    String body,
    Map<String, dynamic> metaData,
    DateTime sentTime,
    dynamic attachment,
    NoteAttachmentType attachmentType,
    bool seen,
    DateTime seenTime,
    bool sendFCM,
    NoteType type,
    NoteResponse response,
    DateTime responseTime,
    List<String> buttons,
    String token,
    String topic,
  }){
    return NoteModel(
      id: id ?? this.id,
      senderID: senderID ?? this.senderID,
      senderImageURL: senderImageURL ?? this.senderImageURL,
      senderType: senderType ?? this.senderType,
      receiverID: receiverID ?? this.receiverID,
      receiverType: receiverType ?? this.receiverType,
      title: title ?? this.title,
      body: body ?? this.body,
      metaData: metaData ?? this.metaData,
      sentTime: sentTime ?? this.sentTime,
      attachment: attachment ?? this.attachment,
      attachmentType: attachmentType ?? this.attachmentType,
      seen: seen ?? this.seen,
      seenTime: seenTime ?? this.seenTime,
      sendFCM: sendFCM ?? this.sendFCM,
      type: type ?? this.type,
      response: response ?? this.response,
      responseTime: responseTime ?? this.responseTime,
      buttons: buttons ?? this.buttons,
      token: token ?? this.token,
      topic: topic ?? this.topic,
    );
  }
  // --------------------
  NoteModel nullifyField({
    bool id = false,
    bool senderID = false,
    bool senderImageURL = false,
    bool senderType = false,
    bool receiverID = false,
    bool receiverType = false,
    bool title = false,
    bool body = false,
    bool metaData = false,
    bool sentTime = false,
    bool attachment = false,
    bool attachmentType = false,
    bool seen = false,
    bool seenTime = false,
    bool sendFCM = false,
    bool type = false,
    bool response = false,
    bool responseTime = false,
    bool buttons = false,
    bool token = false,
    bool topic = false,
}){
    return NoteModel(
      id: id == true ? null : this.id,
      senderID: senderID == true ? null : this.senderID,
      senderImageURL: senderImageURL == true ? null : this.senderImageURL,
      senderType: senderType == true ? null : this.senderType,
      receiverID: receiverID == true ? null : this.receiverID,
      receiverType: receiverType == true ? null : this.receiverType,
      title: title == true ? null : this.title,
      body: body == true ? null : this.body,
      metaData: metaData == true ? null : this.metaData,
      sentTime: sentTime == true ? null : this.sentTime,
      attachment: attachment == true ? null : this.attachment,
      attachmentType: attachmentType == true ? null : this.attachmentType,
      seen: seen == true ? null : this.seen,
      seenTime: seenTime == true ? null : this.seenTime,
      sendFCM: sendFCM == true ? null : this.sendFCM,
      type: type == true ? null : this.type,
      response: response == true ? null : this.response,
      responseTime: responseTime == true ? null : this.responseTime,
      buttons: buttons == true ? null : this.buttons,
      token: token == true ? null : this.token,
      topic: topic == true ? null : this.topic,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap({
    @required bool toJSON,
  }) {
    return <String, dynamic>{
      // 'id': id, /// no need
      'senderID': senderID,
      'senderImageURL': senderImageURL,
      'senderType': cipherNoteSenderOrRecieverType(senderType),
      'receiverID': receiverID,
      'receiverType' : cipherNoteSenderOrRecieverType(receiverType),
      /// {notification: {body: Bldrs.net is super Awesome, title: Bldrs.net}, data: {}}
      'notification': _cipherNotificationField(),
      'sentTime': Timers.cipherTime(time: sentTime, toJSON: toJSON),
      'attachment': attachment,
      'attachmentType': cipherNoteAttachmentType(attachmentType),
      'seen': seen,
      'seenTime': Timers.cipherTime(time: seenTime, toJSON: toJSON),
      'sendFCM': sendFCM,
      'type': cipherNoteType(type),
      'response': cipherResponse(response),
      'responseTime': Timers.cipherTime(time: responseTime, toJSON: toJSON),
      'buttons': buttons,
      'token': token,
      'topic': topic,
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> _cipherNotificationField(){
    return <String, dynamic>{
      'notification': <String, dynamic>{
        'title': title,
        'body': body,
      },
      'data': metaData,
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> cipherNotesModels({
    @required List<NoteModel> notes,
    @required bool toJSON,
  }){

    final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

    if (Mapper.checkCanLoopList(notes) == true){

      for (final NoteModel note in notes){
        _maps.add(note.toMap(toJSON: toJSON));
      }

    }

    return _maps;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static NoteModel decipherNote({
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
        senderType: decipherNoteSenderOrReceiverType(map['senderType']),
        receiverID: map['receiverID'],
        receiverType: decipherNoteSenderOrReceiverType(map['receiverType']),
        title: _decipherNotificationField(map: map, titleNotBody: true),
        body: _decipherNotificationField(map: map, titleNotBody: false),
        metaData: _decipherNotificationData(map),
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
        type: decipherNoteType(map['type']),
        response: decipherResponse(map['response']),
        responseTime: Timers.decipherTime(
          time: map['responseTime'],
          fromJSON: fromJSON,
        ),
        buttons: Stringer.getStringsFromDynamics(dynamics: map['buttons']),
        token: map['token'],
        topic: map['topic'],
        docSnapshot: map['docSnapshot'],
      );
    }

    // _noti.blogNotiModel(methodName: 'decipherNotiModel');

    return _noti;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String _decipherNotificationField({
    @required dynamic map,
    @required bool titleNotBody,
  }){
    String _field;
    final String _key = titleNotBody == true ? 'title' : 'body';

    if (map != null){

      // title: map['notification']['notification']['title'],

      final dynamic _notification1 = map['notification'];

      dynamic _notification2;
      if (_notification1 != null){
        _notification2 = _notification1['notification'];
      }

      if (_notification2 != null){
        _field = _notification2[_key];
      }

    }

    return _field;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> _decipherNotificationData(dynamic map){
    Map<String, dynamic> _output;

    if (map != null){
      final dynamic _notification = map['notification'];

      if (_notification != null){
        _output = map['data'];
      }

    }
    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<NoteModel> decipherNotes({
    @required List<Map<String, dynamic>> maps,
    @required bool fromJSON,
  }) {
    final List<NoteModel> _notesModels = <NoteModel>[];

    if (Mapper.checkCanLoopList(maps)) {
      for (final Map<String, dynamic> map in maps) {

        final NoteModel _notiModel = decipherNote(
          map: map,
          fromJSON: fromJSON,
        );

        _notesModels.add(_notiModel);
      }
    }

    return _notesModels;
  }
  // --------------------
  static List<NoteModel> getNotesModelsFromSnapshot(DocumentSnapshot<Object> doc) {
    final Object _maps = doc.data();
    final List<NoteModel> _notiModels = decipherNotes(
      maps: _maps,
      fromJSON: false,
    );
    return _notiModels;
  }
  // -----------------------------------------------------------------------------

  /// NOTE TYPE CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String cipherNoteType(NoteType noteType){
    switch(noteType){
      case NoteType.authorship:   return 'authorship';    break;
      case NoteType.notice:       return 'notice';        break;
      case NoteType.flyerUpdate:  return 'flyerUpdate';   break;
      case NoteType.bzDeletion:   return 'bzDeletion';    break;
      default : return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static NoteType decipherNoteType(String noteType){
    switch(noteType){
      case 'authorship':    return NoteType.authorship;   break;
      case 'notice':        return NoteType.notice;       break;
      case 'flyerUpdate':   return NoteType.flyerUpdate;  break;
      case 'bzDeletion':    return NoteType.bzDeletion;   break;
      default: return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static const List<NoteType> noteTypesList = <NoteType>[
    NoteType.notice,
    NoteType.authorship,
    NoteType.flyerUpdate,
    NoteType.bzDeletion,
  ];
  // -----------------------------------------------------------------------------

  /// ATTACHMENT TYPE CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
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
      final List<String> _strings = Stringer.getStringsFromDynamics(
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static NoteAttachmentType decipherNoteAttachmentType(String attachmentType) {
    switch (attachmentType) {
      case 'non':       return NoteAttachmentType.non;        break;
      case 'flyersIDs': return NoteAttachmentType.flyersIDs;  break;
      case 'bzID':      return NoteAttachmentType.bzID;       break;
      case 'imageURL':  return NoteAttachmentType.imageURL;   break;
      default:          return NoteAttachmentType.non;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String cipherNoteAttachmentType(NoteAttachmentType attachmentType) {
    switch (attachmentType) {
      case NoteAttachmentType.non:          return 'non';       break; /// data type : null
      case NoteAttachmentType.flyersIDs:    return 'flyersIDs'; break; /// data type : List<String> flyersIDs
      case NoteAttachmentType.imageURL:     return 'imageURL';  break; /// data type : String imageURL
      case NoteAttachmentType.bzID:         return 'bzID';      break; /// data type : String bzID
      default:return 'non';
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static const List<NoteAttachmentType> noteAttachmentTypesList = <NoteAttachmentType>[
    NoteAttachmentType.non,
    NoteAttachmentType.flyersIDs,
    NoteAttachmentType.imageURL,
    NoteAttachmentType.bzID,
  ];
  // -----------------------------------------------------------------------------

  /// NOTE SENDER TYPE CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String cipherNoteSenderOrRecieverType(NoteSenderOrRecieverType type){
    switch (type) {
      case NoteSenderOrRecieverType.bz:           return 'bz';      break; /// data type : String bzID
    // case NoteSenderOrRecieverType.author:       return 'author';  break; /// data type : String authorID
      case NoteSenderOrRecieverType.user:         return 'user';    break; /// data type : String userID
      case NoteSenderOrRecieverType.country:      return 'country'; break; /// data type : String countryID
      case NoteSenderOrRecieverType.bldrs:        return 'bldrs';   break; /// data type : String graphicID
      default:return 'non';
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static NoteSenderOrRecieverType decipherNoteSenderOrReceiverType(String type){
    switch (type) {
      case 'bldrs':   return NoteSenderOrRecieverType.bldrs;    break;
      case 'user':    return NoteSenderOrRecieverType.user;     break;
    // case 'author':  return NoteSenderOrRecieverType.author;   break;
      case 'bz':      return NoteSenderOrRecieverType.bz;       break;
      case 'country': return NoteSenderOrRecieverType.country;  break;
      default:        return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static const List<NoteSenderOrRecieverType> noteSenderTypesList = <NoteSenderOrRecieverType>[
    NoteSenderOrRecieverType.bz,
    // NoteSenderOrRecieverType.author,
    NoteSenderOrRecieverType.user,
    NoteSenderOrRecieverType.country,
    NoteSenderOrRecieverType.bldrs,
  ];
  // -----------------------------------------------------------------------------

  /// NOTE SENDER TYPE CYPHERS

  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static String cipherNoteReceiverType(NoteReceiverType type){
    switch (type) {
      case NoteReceiverType.bz:           return 'bz';      break; /// data type : String bzID
      case NoteReceiverType.user:         return 'user';    break; /// data type : String userID
      default: return null;
    }
  }
   */
  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static NoteReceiverType decipherNoteReceiverType(String type){
    switch (type) {
      case 'user':    return NoteReceiverType.user;     break;
      case 'bz':      return NoteReceiverType.bz;       break;
      default:        return null;
    }
  }
   */
  // --------------------

  /// TESTED : WORKS PERFECT
  static const List<NoteSenderOrRecieverType> noteReceiverTypesList = <NoteSenderOrRecieverType>[
    NoteSenderOrRecieverType.bz,
    NoteSenderOrRecieverType.user,
  ];
// -----------------------------------------------------------------------------

  /// RESPONSE CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String cipherResponse(NoteResponse response){
    switch (response){
      case NoteResponse.accepted:   return 'accepted'; break;
      case NoteResponse.declined:   return 'declines'; break;
      case NoteResponse.pending:    return 'pending'; break;
      case NoteResponse.cancelled:  return 'cancelled'; break;
      default: return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static NoteResponse decipherResponse(String response){
    switch (response){
      case 'accepted':  return NoteResponse.accepted; break;
      case 'declines':  return NoteResponse.declined; break;
      case 'pending':   return NoteResponse.pending; break;
      case 'cancelled':   return NoteResponse.cancelled; break;
      default: return null;
    }
  }
  // --------------------
  static NoteResponse getNoteResponseByPhid(String phid){
    switch (phid){
      case 'phid_accept':     return NoteResponse.accepted;   break;
      case 'phid_decline':    return NoteResponse.declined;   break;
      case 'phid_pending':    return NoteResponse.pending;    break;
      case 'phid_cancel':     return NoteResponse.cancelled;  break;
      default: return null;
    }
  }
  // --------------------
  static String getPhidByResponse(NoteResponse response){
    switch (response){
      case NoteResponse.accepted:   return 'phid_accept'; break;
      case NoteResponse.declined:   return 'phid_decline'; break;
      case NoteResponse.pending:    return 'phid_pending'; break;
      case NoteResponse.cancelled:  return 'phid_cancel'; break;
      default: return null;
    }
  }
  // --------------------
  static List<String> generateAcceptDeclineButtons(){
    final String accept = getPhidByResponse(NoteResponse.accepted);
    final String decline = getPhidByResponse(NoteResponse.declined);
    return <String>[accept, decline];
  }
// -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  void blogNoteModel({
    String methodName,
  }) {
    blog('BLOGGING NoteModel : $methodName -------------------------------- START -- ');

    blog('id : $id');
    blog('senderID : $senderID');
    blog('senderImageURL : $senderImageURL');
    blog('senderType : $senderType');
    blog('receiverID : $receiverID');
    blog('receiverType : $receiverType');
    blog('title : $title');
    blog('body : $body');
    blog('metaData : $metaData');
    blog('sentTime : $sentTime');
    blog('attachment : ${attachment?.toString()}');
    blog('attachmentType : $attachmentType');
    blog('seen : $seen');
    blog('seenTime : $seenTime');
    blog('sendFCM : $sendFCM');
    blog('type : $type');
    blog('response : $response');
    blog('responseTime : $responseTime');
    blog('buttons : ${buttons?.toString()}');
    blog('token: $token');
    blog('topic: $topic');
    blog('docSnapshot : $docSnapshot');

    blog('BLOGGING NoteModel : $methodName -------------------------------- END -- ');
  }
  // --------------------
  static void blogNotes({
    @required List<NoteModel> notes,
    String methodName,
  }){

    if (Mapper.checkCanLoopList(notes) == true){

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

  // --------------------
  static List<String> getReceiversIDs({
    @required List<NoteModel> notes,
  }){

    final List<String> _output = <String>[];

    if (Mapper.checkCanLoopList(notes) == true){

      for (final NoteModel note in notes){
        _output.add(note.receiverID);
      }

    }

    return _output;
  }
  // --------------------
  static NoteModel getFirstNoteByRecieverID({
    @required List<NoteModel> notes,
    @required String receiverID,
  }){

    NoteModel _output;

    if (Mapper.checkCanLoopList(notes) == true && receiverID != null){

      _output = notes.firstWhere(
              (note) => note.receiverID == receiverID,
          orElse: ()=> null
      );

    }

    return _output;
  }
  // --------------------
  static int getNumberOfUnseenNotes(List<NoteModel> notes){
    int _count;
    if (Mapper.checkCanLoopList(notes) == true){
      final List<NoteModel> _unSeens = notes.where((note) => note.seen != true).toList();
      _count = _unSeens.length;
    }
    return _count;
  }
  // --------------------
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

      if (note.senderType == null){
        _missingFields.add('senderType');
      }

      if (note.receiverID == null){
        _missingFields.add('receiverID');
      }

      if (TextCheck.isEmpty(note.title) == true){
        _missingFields.add('title');
      }

      if (TextCheck.isEmpty(note.body) == true){
        _missingFields.add('body');
      }

      if (note.metaData == null){
        _missingFields.add('metaData');
      }

      if (note.sendFCM == null){
        _missingFields.add('sendFCM');
      }

      if (note.type == null){
        _missingFields.add('type');
      }

      /// IF NOT ONLY ESSENTIAL FIELDS REQUIRED TO SEND A NOTE ARE TO BE CONSIDERED
      if (considerAllFields == true){

        if (note.sentTime == null){
          _missingFields.add('sentTime');
        }

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

        if (note.topic == null){
          _missingFields.add('topic');
        }

      }

    }

    return _missingFields;
  }
  // --------------------
  static List<NoteModel> getUnseenNotesByReceiverID({
    @required List<NoteModel> notes,
    @required String receiverID,
  }){
    final List<NoteModel> _notes = <NoteModel>[];

    if (Mapper.checkCanLoopList(notes) == true){

      final List<NoteModel> _found = notes.where((note){

        return note.receiverID == receiverID && note.seen == false;
      }).toList();

      if (Mapper.checkCanLoopList(_found) == true){
        _notes.addAll(_found);
      }

    }

    return _notes;
  }
  // --------------------
  static List<NoteModel> getNotesByReceiverID({
    @required List<NoteModel> notes,
    @required String receiverID,
  }){
    final List<NoteModel> _notes = <NoteModel>[];

    if (Mapper.checkCanLoopList(notes) == true){

      final List<NoteModel> _found = notes.where((note){

        return note.receiverID == receiverID;
      }).toList();

      if (Mapper.checkCanLoopList(_found) == true){
        _notes.addAll(_found);
      }

    }

    return _notes;
  }
  // --------------------
  static List<NoteModel> getOnlyUnseenNotes({
    @required List<NoteModel> notes,
  }){

    final List<NoteModel> _output = <NoteModel>[];

    if (Mapper.checkCanLoopList(notes) == true){

      for (final NoteModel note in notes){
        if (note.seen != true){
          _output.add(note);
        }
      }


    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<NoteModel> getNotesFromNotesByNoteType({
    @required List<NoteModel> notes,
    @required NoteType noteType,
  }){
    final List<NoteModel> _output = <NoteModel>[];

    if (Mapper.checkCanLoopList(notes) == true){

      for (final NoteModel note in notes){

        if (note.type == noteType){
          _output.add(note);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  static bool checkThereAreUnSeenNotes(List<NoteModel> notes){
    bool _thereAreUnseenNotes = false;

    if (Mapper.checkCanLoopList(notes) == true){

      for (final NoteModel note in notes){

        if (note.seen != true){
          _thereAreUnseenNotes = true;
          break;
        }

      }

    }

    return _thereAreUnseenNotes;
  }
  // --------------------
  static bool checkIsUnSeen(NoteModel note){
    return note?.seen == false;
  }
  // --------------------
  static bool checkCanSendNote(NoteModel noteModel){
    bool _canSend = false;

    if (noteModel != null){

      if (
      // noteModel.id != null &&
      noteModel.senderID != null &&
          noteModel.senderImageURL != null &&
          noteModel.senderType != null &&
          noteModel.receiverID != null &&
          noteModel.title != null &&
          noteModel.body != null &&
          noteModel.metaData != null &&
          // noteModel.sentTime != null &&
          // noteModel.attachment != null &&
          // noteModel.attachmentType != null &&
          // noteModel.seen != null &&
          // noteModel.seenTime != null &&
          noteModel.sendFCM != null &&
          noteModel.type != null
      // && noteModel.response != null &&
      // noteModel.responseTime != null &&
      // noteModel.buttons != null
      ){
        _canSend = true;
      }

    }

    return _canSend;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkNotesAreIdentical({
    @required NoteModel note1,
    @required NoteModel note2,
  }){
    bool _areIdentical = false;

    if (note1 != null && note2 != null){

      if (
          note1.id == note2.id &&
          note1.senderID == note2.senderID &&
          note1.senderImageURL == note2.senderImageURL &&
          note1.senderType == note2.senderType &&
          note1.receiverID == note2.receiverID &&
          note1.receiverType == note2.receiverType &&
          note1.title == note2.title &&
          note1.body == note2.body &&
          Mapper.checkMapsAreIdentical(map1: note1.metaData, map2: note2.metaData) == true &&
          Timers.checkTimesAreIdentical(accuracy: TimeAccuracy.microSecond, time1: note1.sentTime, time2: note2.sentTime) &&
          note1.attachment == note2.attachment &&
          note1.attachmentType == note2.attachmentType &&
          note1.seen == note2.seen &&
          Timers.checkTimesAreIdentical(accuracy: TimeAccuracy.microSecond, time1: note1.seenTime, time2: note2.seenTime) &&
          note1.sendFCM == note2.sendFCM &&
          note1.type == note2.type &&
          note1.response == note2.response &&
          Timers.checkTimesAreIdentical(accuracy: TimeAccuracy.microSecond, time1: note1.responseTime, time2: note2.responseTime) &&
          Mapper.checkListsAreIdentical(list1: note1.buttons, list2: note2.buttons) &&
          note1.token == note2.token &&
          note1.topic == note2.topic
      ){
        _areIdentical = true;
      }

    }

    return _areIdentical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkNotesListsAreIdentical({
    @required List<NoteModel> notes1,
    @required List<NoteModel> notes2,
  }){
    bool _areIdentical = true;

    if (Mapper.checkCanLoopList(notes1) == true && Mapper.checkCanLoopList(notes2) == true){

      if (notes1.length != notes2.length){
        _areIdentical = false;
      }

      else {
        for (int i = 0; i < notes1.length; i++){

          final note1 = notes1[i];
          final note2 = notes2[i];

          final bool _identical = checkNotesAreIdentical(
              note1: note1,
              note2: note2
          );

          if (_identical == false){
            _areIdentical = false;
            break;
          }

        }
      }

    }

    return _areIdentical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkNotesContainNote({
    @required List<NoteModel> notes,
    @required String noteID,
  }){

    bool _contains = false;

    if (Mapper.checkCanLoopList(notes) == true && noteID != null){

      for (final NoteModel noteModel in notes){
        if (noteModel.id == noteID){
          _contains = true;
          break;
        }
      }

    }

    return _contains;
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<NoteModel> removeNoteFromNotes({
    @required List<NoteModel> notes,
    @required String noteID,
  }){

    final List<NoteModel> _output = notes == null ?
    <NoteModel>[]
        :
    <NoteModel>[...notes];

    // blog('removeNoteFromNotes : notes : ${_output.length}');

    if (Mapper.checkCanLoopList(notes) == true){

      final int _index = notes.indexWhere((note) => note.id == noteID);

      if (_index != -1){
        // blog('removeNoteFromNotes : removing note _index : $_index');
        _output.removeAt(_index);
      }

    }

    // blog('removeNoteFromNotes : notes : ${_output.length}');

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<NoteModel> removeNotesFromNotes({
    @required List<NoteModel> notesToRemove,
    @required List<NoteModel> sourceNotes,
  }){

    List<NoteModel> _output = sourceNotes ?? <NoteModel>[];

    if (Mapper.checkCanLoopList(notesToRemove) == true && Mapper.checkCanLoopList(_output) == true){

      for (final NoteModel note in notesToRemove){

        _output = removeNoteFromNotes(
          notes: _output,
          noteID: note.id,
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<NoteModel> insertNoteIntoNotes({
    @required List<NoteModel> notesToGet,
    @required NoteModel note,
    @required DuplicatesAlgorithm duplicatesAlgorithm,
  }){

    final List<NoteModel> _output = notesToGet ?? <NoteModel>[];

    final bool _contains = checkNotesContainNote(
      notes: _output,
      noteID: note.id,
    );

    /// IF NOT EXISTENT
    if (_contains == false){
      _output.add(note);
    }

    /// IF EXISTS
    else {

      /// if SHOULD REPLACE
      if (duplicatesAlgorithm == DuplicatesAlgorithm.keepSecond){
        final int _index = _output.indexWhere((n) => n.id == note.id);
        _output.removeAt(_index);
        _output.insert(_index, note);
      }

      else if (duplicatesAlgorithm == DuplicatesAlgorithm.keepBoth){
        _output.add(note);
      }

      /// IF SHOULD IGNORE
      // else if (duplicatesAlgorithm == DuplicatesAlgorithm.keepFirst){
      //   /// do nothing
      // }
      // else {
      //   /// do nothing
      // }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<NoteModel> insertNotesInNotes({
    @required List<NoteModel> notesToGet,
    @required List<NoteModel> notesToInsert,
    @required DuplicatesAlgorithm duplicatesAlgorithm,
  }){
    List<NoteModel> _output = notesToGet ?? <NoteModel>[];

    if (Mapper.checkCanLoopList(notesToInsert) == true){

      for (final NoteModel note in notesToInsert){

        _output = insertNoteIntoNotes(
          notesToGet: notesToGet,
          note: note,
          duplicatesAlgorithm: duplicatesAlgorithm,
        );

      }

    }

    return _output;
  }
  // --------------------
  static List<NoteModel> orderNotesBySentTime(List<NoteModel> notes){
    if (Mapper.checkCanLoopList(notes) == true){
      notes.sort((NoteModel a, NoteModel b) => b.sentTime.compareTo(a.sentTime));
    }
    return notes;
  }
  // --------------------
  static Map<String, List<NoteModel>> updateNoteInBzzNotesMap({
    @required NoteModel note,
    @required Map<String, List<NoteModel>> bzzNotesMap,
  }){

    Map<String, List<NoteModel>> _output;

    final List<String> _bzzIDs = bzzNotesMap.keys.toList();

    if (Mapper.checkCanLoopList(_bzzIDs) == true){

      for (final String bzID in _bzzIDs){

        final List<NoteModel> _bzNotes = bzzNotesMap[bzID];

        final bool _noteFound = checkNotesContainNote(
          notes: _bzNotes,
          noteID: note.id,
        );

        if (_noteFound == true){

          final List<NoteModel> _updatedList = replaceNoteInNotes(
            notes: _bzNotes,
            noteToReplace: note,
          );

          _output = bzzNotesMap;
          _output[bzID] = _updatedList;
          break;

        }

      }

    }

    return _output ?? bzzNotesMap;
  }
  // --------------------
  static List<NoteModel> replaceNoteInNotes({
    @required List<NoteModel> notes,
    @required NoteModel noteToReplace,
  }){
    final List<NoteModel> _output = <NoteModel>[];

    if (Mapper.checkCanLoopList(notes) == true){

      _output.addAll(notes);

      final int _index = _output.indexWhere((n) => n.id == noteToReplace.id);

      if (_index != -1){
        _output.removeAt(_index);
        _output.insert(_index, noteToReplace);
      }

    }

    return _output;
  }
  // --------------------
  static Map<String, List<NoteModel>> removeNoteFromBzzNotesMap({
    @required String noteID,
    @required Map<String, List<NoteModel>> bzzNotesMap
  }){
    Map<String, List<NoteModel>> _output;

    final List<String> _bzzIDs = bzzNotesMap.keys.toList();

    if (Mapper.checkCanLoopList(_bzzIDs) == true){

      for (final String bzID in _bzzIDs){

        final List<NoteModel> _bzNotes = bzzNotesMap[bzID];

        final bool _noteFound = checkNotesContainNote(
          notes: _bzNotes,
          noteID: noteID,
        );

        if (_noteFound == true){

          final List<NoteModel> _updatedList = removeNoteFromNotes(
            notes: _bzNotes,
            noteID: noteID,
          );

          _output = bzzNotesMap;
          _output[bzID] = _updatedList;
          break;

        }

      }

    }

    return _output ?? bzzNotesMap;
  }
  // -----------------------------------------------------------------------------

  /// DUMMIES

  // --------------------
  static const String dummyTopic = 'dummyTopic';
  // --------------------
  /// TESTED : WORKS PERFECT
  static NoteModel dummyNote(){
    return NoteModel(
      id: 'id',
      senderID: 'senderID',
      senderImageURL: 'senderImageURL',
      senderType: NoteSenderOrRecieverType.bldrs,
      receiverID: 'receiverID',
      receiverType: NoteSenderOrRecieverType.user,
      title: 'title',
      body: 'body',
      metaData: const {'metaData' : 'thing'},
      sentTime: Timers.createClock(hour: 12, minute: 10),
      attachment: 'attachment',
      attachmentType: NoteAttachmentType.bzID,
      seen: true,
      seenTime: Timers.createDate(year: 1950, month: 10, day: 6),
      sendFCM: true,
      type: NoteType.notice,
      response: NoteResponse.pending,
      responseTime: Timers.createClock(hour: 10, minute: 50),
      buttons: const <String>['Fuck', 'You'],
      token: null,
      topic: dummyTopic,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<NoteModel> dummyNotes(){

    return <NoteModel>[
      dummyNote(),
      dummyNote(),
      dummyNote(),
    ];

  }
  // -----------------------------------------------------------------------------

  /// TOPICS

  // --------------------
  static String generateTopic({
    @required TopicType topicType,
    @required String id,
  }){
    return '$topicType/$id/';
  }
  // --------------------
  static List<TopicType> getAllBzzTopics(){
    return <TopicType>[
      TopicType.flyerVerification, // 'flyerVerification/bzID/'
      TopicType.flyerUpdate, // 'flyerUpdate/bzID/'
      TopicType.authorshipAcceptance, // 'authorshipAcceptance/bzID/'
      TopicType.authorRoleChanged, // 'authorRoleChanged/bzID/'
      TopicType.authorDeletion, // 'authorDeletion/bzID/'
      TopicType.generalBzNotes, // 'generalBzNotes/bzID/'

    ];
  }
  // -----------------------------------------------------------------------------

  /// VALIDATION

  // --------------------
  static String receiverVsNoteTypeValidator({
    @required NoteSenderOrRecieverType receiverType,
    @required NoteType noteType,
  }){

    if (receiverType == NoteSenderOrRecieverType.user){
      switch (noteType){
        case NoteType.notice        : return null; break; /// user can receive notice
        case NoteType.authorship    : return null; break; /// only user receive authorship
        case NoteType.bzDeletion    : return null; break; /// only user receive bzDeletion
        case NoteType.flyerUpdate   : return 'User does not receive flyer update note'; break;
        default: return null;
      }
    }
    else if (receiverType == NoteSenderOrRecieverType.bz){
      switch (noteType){
        case NoteType.notice  : return null; break; /// bz can receive notice
        case NoteType.authorship    : return 'Only User receive authorship note'; break;
        case NoteType.bzDeletion    : return 'Only user can receive bzDeletion note'; break;
        case NoteType.flyerUpdate   : return null; break; /// bz can receive flyerUpdate
        default: return null;
      }
    }
    else {
      return 'Receiver can only be a user or a bz';
    }

  }
  // --------------------
  static String senderVsNoteTypeValidator({
    @required NoteSenderOrRecieverType senderType,
    @required NoteType noteType,
  }){

    /// USER
    if (senderType == NoteSenderOrRecieverType.user){
      switch (noteType){
        case NoteType.notice        : return null; break; /// user can send notice
        case NoteType.authorship    : return 'Only Bz can send Authorship note'; break;
        case NoteType.bzDeletion    : return 'Only Bldrs can send bzDeletion notes'; break;
        case NoteType.flyerUpdate   : return 'User can not send flyerUpdate note'; break;
        default: return null;
      }
    }

    /// BZ
    else if (senderType == NoteSenderOrRecieverType.bz){
      switch (noteType){
        case NoteType.notice        : return null; break; /// bz can send notice
        case NoteType.authorship    : return null; break; /// only bz send authorship
        case NoteType.bzDeletion    : return 'Only Bldrs can send bzDeletion notes'; break;
        case NoteType.flyerUpdate   : return null; break; /// bz can send flyerUpdate note
        default: return null;
      }
    }

    /// BLDRS
    else if (senderType == NoteSenderOrRecieverType.bldrs){
      switch (noteType){
        case NoteType.notice        : return null; break; /// Bldrs can send notice
        case NoteType.authorship    : return 'Only Bz can send Authorship note'; break;
        case NoteType.bzDeletion    : return null; break; /// only Bldrs send bzDeletion
        case NoteType.flyerUpdate   : return null; break; /// Bldrs can send flyerUpdate note
        default: return null;
      }
    }

    /// COUNTRY
    else if (senderType == NoteSenderOrRecieverType.country){
      switch (noteType){
        case NoteType.notice        : return null; break; /// Country can send notice
        case NoteType.authorship    : return 'Only Bz can send Authorship note'; break;
        case NoteType.bzDeletion    : return 'Only Bldrs can send bzDeletion notes'; break;
        case NoteType.flyerUpdate   : return 'Country can not send FlyerUpdate note'; break;
        default: return null;
      }
    }

    /// OTHERWISE
    else {
      return 'Sender can not be null';
    }

  }
  // --------------------
  static String receiverVsSenderValidator({
    @required NoteSenderOrRecieverType senderType,
    @required NoteSenderOrRecieverType receiverType,
  }){

    /// USER
    if (receiverType == NoteSenderOrRecieverType.user){

      switch(senderType){
        case NoteSenderOrRecieverType.user     : return null; break; /// user can receive from user
        case NoteSenderOrRecieverType.bz       : return null; break; /// user can receive from bz
        case NoteSenderOrRecieverType.bldrs    : return null; break; /// user can receive from bldrs
        case NoteSenderOrRecieverType.country  : return null; break; /// user can receive from country
        default: return null;
      }

    }

    /// BZ
    else if (receiverType == NoteSenderOrRecieverType.bz){

      switch(senderType){
        case NoteSenderOrRecieverType.user     : return null; break; /// bz can receive from user
        case NoteSenderOrRecieverType.bz       : return null; break; /// bz can receive from bz
        case NoteSenderOrRecieverType.bldrs    : return null; break; /// bz can receive from bldrs
        case NoteSenderOrRecieverType.country  : return null; break; /// bz can receive from country
        default: return null;
      }

    }

    /// OTHERWISE
    else {
      return 'receiver can only be a user or a bz';
    }

  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is NoteModel){
      _areIdentical = checkNotesAreIdentical(
        note1: this,
        note2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      id.hashCode^
      senderID.hashCode^
      senderImageURL.hashCode^
      senderType.hashCode^
      receiverID.hashCode^
      receiverType.hashCode^
      title.hashCode^
      body.hashCode^
      metaData.hashCode^
      sentTime.hashCode^
      attachment.hashCode^
      attachmentType.hashCode^
      seen.hashCode^
      seenTime.hashCode^
      sendFCM.hashCode^
      type.hashCode^
      response.hashCode^
      responseTime.hashCode^
      buttons.hashCode^
      token.hashCode^
      topic.hashCode^
      docSnapshot.hashCode;
  // -----------------------------------------------------------------------------
}

enum TopicType {
  /// authors notified on their any new flyer getting verified
  flyerVerification, // 'flyerVerification/bzID/'

  /// authors notifier on any of bz flyers got updated
  flyerUpdate, // 'flyerUpdate/bzID/'

  /// authors notified on new user joined their team
  authorshipAcceptance, // 'authorshipAcceptance/bzID/'

  /// authors notified on any of them got his role changed
  authorRoleChanged, // 'authorRoleChanged/bzID/'

  /// authors notified on any of them got removed from the team
  authorDeletion, // 'authorDeletion/bzID/'

  /// authors notified on this general topic for general bz related notes
  generalBzNotes, // 'generalBzNotes/bzID/'
}
