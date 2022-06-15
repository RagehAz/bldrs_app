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
// ------------------------
enum NoteReceiverType {
  user,
  bz,
}
// ------------------------
enum NoteResponse{
  accepted, /// when receiver accepted
  declined, /// when receiver declines invitation
  pending, /// when receiver has not yet responded
  cancelled, /// when sender cancels invitation
}
// -----------------------------------------------------------------------------
@immutable
class NoteModel {
  /// --------------------------------------------------------------------------
  const NoteModel({
    @required this.id,
    @required this.senderID,
    @required this.senderImageURL,
    @required this.noteSenderType,
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
    @required this.noteType,
    @required this.response,
    @required this.responseTime,
    @required this.buttons,
    this.docSnapshot,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final String senderID;
  final String senderImageURL;
  final NoteSenderType noteSenderType;
  final String receiverID;
  final NoteReceiverType receiverType;
  final String title; /// max 30 char
  final String body; /// max 80 char
  final Map<String, dynamic> metaData;
  final DateTime sentTime; /// TASK : CREATE NEW FIREBASE QUERY INDEX
  final dynamic attachment;
  final NoteAttachmentType attachmentType;
  final bool seen; /// TASK : CREATE NEW FIREBASE QUERY INDEX
  final DateTime seenTime;
  final bool sendFCM;
  final NoteType noteType;
  final NoteResponse response;
  final DateTime responseTime;
  final List<String> buttons;
  final QueryDocumentSnapshot<Object> docSnapshot;
  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // -------------------------------------
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

  // -------------------------------------
  NoteModel copyWith({
    String id,
    String senderID,
    String senderImageURL,
    NoteSenderType noteSenderType,
    String receiverID,
    NoteReceiverType receiverType,
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
    NoteResponse response,
    DateTime responseTime,
    List<String> buttons,
  }){
    return NoteModel(
      id: id ?? this.id,
      senderID: senderID ?? this.senderID,
      senderImageURL: senderImageURL ?? this.senderImageURL,
      noteSenderType: noteSenderType ?? this.noteSenderType,
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
      'receiverType' : cipherNoteReceiverType(receiverType),
      /// {notification: {body: Bldrs.net is super Awesome, title: Bldrs.net}, data: {}}
      'notification': _cipherNotificationField(),
      'sentTime': Timers.cipherTime(time: sentTime, toJSON: toJSON),
      'attachment': attachment,
      'attachmentType': cipherNoteAttachmentType(attachmentType),
      'seen': seen,
      'seenTime': Timers.cipherTime(time: seenTime, toJSON: toJSON),
      'sendFCM': sendFCM,
      'noteType': cipherNoteType(noteType),
      'response': cipherResponse(response),
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
        receiverType: decipherNoteReceiverType(map['receiverType']),
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
        response: decipherResponse(map['response']),
        responseTime: Timers.decipherTime(
          time: map['responseTime'],
          fromJSON: fromJSON,
        ),
        buttons: Mapper.getStringsFromDynamics(dynamics: map['buttons']),
        docSnapshot: map['docSnapshot'],
      );
    }

    // _noti.blogNotiModel(methodName: 'decipherNotiModel');

    return _noti;
  }
  // -------------------------------------
  static List<NoteModel> decipherNotes({
    @required List<Map<String, dynamic>> maps,
    @required bool fromJSON,
  }) {
    final List<NoteModel> _notesModels = <NoteModel>[];

    if (Mapper.checkCanLoopList(maps)) {
      for (final Map<String, dynamic> map in maps) {

        final NoteModel _notiModel = decipherNoteModel(
          map: map,
          fromJSON: fromJSON,
        );

        _notesModels.add(_notiModel);
      }
    }

    return _notesModels;
  }
  // -------------------------------------
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

  /// NOTE SENDER TYPE CYPHERS

  // -------------------------------------
  static String cipherNoteReceiverType(NoteReceiverType type){
    switch (type) {
      case NoteReceiverType.bz:           return 'bz';      break; /// data type : String bzID
      case NoteReceiverType.user:         return 'user';    break; /// data type : String userID
      default: return null;
    }
  }
  // -------------------------------------
  static NoteReceiverType decipherNoteReceiverType(String type){
    switch (type) {
      case 'user':    return NoteReceiverType.user;     break;
      case 'bz':      return NoteReceiverType.bz;       break;
      default:        return null;
    }
  }
  // -------------------------------------
  static const List<NoteReceiverType> noteReceiverTypesList = <NoteReceiverType>[
    NoteReceiverType.bz,
    NoteReceiverType.user,
  ];
// -----------------------------------------------------------------------------

  /// RESPONSE CYPHERS

// ---------------------------------
  static String cipherResponse(NoteResponse response){
    switch (response){
      case NoteResponse.accepted:   return 'accepted'; break;
      case NoteResponse.declined:   return 'declines'; break;
      case NoteResponse.pending:    return 'pending'; break;
      case NoteResponse.cancelled:  return 'cancelled'; break;
      default: return null;
    }
  }
// ---------------------------------
  static NoteResponse decipherResponse(String response){
    switch (response){
      case 'accepted':  return NoteResponse.accepted; break;
      case 'declines':  return NoteResponse.declined; break;
      case 'pending':   return NoteResponse.pending; break;
      case 'cancelled':   return NoteResponse.cancelled; break;
      default: return null;
    }
  }
// ---------------------------------
  static NoteResponse getNoteResponseByPhid(String phid){
    switch (phid){
      case 'phid_accept':     return NoteResponse.accepted;   break;
      case 'phid_decline':    return NoteResponse.declined;   break;
      case 'phid_pending':    return NoteResponse.pending;    break;
      case 'phid_cancel':     return NoteResponse.cancelled;  break;
      default: return null;
    }
  }
// ---------------------------------
  static String getPhidByResponse(NoteResponse response){
    switch (response){
      case NoteResponse.accepted:   return 'phid_accept'; break;
      case NoteResponse.declined:   return 'phid_decline'; break;
      case NoteResponse.pending:    return 'phid_pending'; break;
      case NoteResponse.cancelled:  return 'phid_cancel'; break;
      default: return null;
    }
  }
// ---------------------------------
  static List<String> generateAcceptDeclineButtons(){
    final String accept = getPhidByResponse(NoteResponse.accepted);
    final String decline = getPhidByResponse(NoteResponse.declined);
    return <String>[accept, decline];
  }
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
    blog('noteType : $noteType');
    blog('response : $response');
    blog('responseTime : $responseTime');
    blog('buttons : ${buttons?.toString()}');
    blog('docSnapshot : $docSnapshot');

    blog('BLOGGING NoteModel : $methodName -------------------------------- END -- ');
  }
  // -------------------------------------
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

  // -------------------------------------
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
  // -------------------------------------
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
  // -------------------------------------
  static int getNumberOfUnseenNotes(List<NoteModel> notes){
    int _count;
    if (Mapper.checkCanLoopList(notes) == true){
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

      if (note.sendFCM == null){
        _missingFields.add('sendFCM');
      }

      if (note.noteType == null){
        _missingFields.add('noteType');
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

      }

    }

    return _missingFields;
  }
  // -------------------------------------
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
  // -------------------------------------
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
  // -------------------------------------
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
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // -------------------------------------
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
  // -------------------------------------
  static bool checkIsUnSeen(NoteModel note){
    return note?.seen == false;
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
          // noteModel.sentTime != null &&
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
  // -----------------------------------
  /// TESTED : WORKS PERFECT
  static bool checkNotesAreTheSame({
    @required NoteModel note1,
    @required NoteModel note2,
  }){
    bool _areTheSame = false;

    if (note1 != null && note2 != null){

      if (
      note1.id == note2.id &&
          note1.senderID == note2.senderID &&
          note1.senderImageURL == note2.senderImageURL &&
          note1.noteSenderType == note2.noteSenderType &&
          note1.receiverID == note2.receiverID &&
          note1.title == note2.title &&
          note1.body == note2.body &&
          Mapper.checkMapsAreTheSame(map1: note1.metaData, map2: note2.metaData) == true &&
          Timers.timesAreTheSame(accuracy: Timers.TimeAccuracy.microSecond, timeA: note1.sentTime, timeB: note2.sentTime) &&
          note1.attachment == note2.attachment &&
          note1.attachmentType == note2.attachmentType &&
          note1.seen == note2.seen &&
          Timers.timesAreTheSame(accuracy: Timers.TimeAccuracy.microSecond, timeA: note1.seenTime, timeB: note2.seenTime) &&
          note1.sendFCM == note2.sendFCM &&
          note1.noteType == note2.noteType &&
          note1.response == note2.response &&
          Timers.timesAreTheSame(accuracy: Timers.TimeAccuracy.microSecond, timeA: note1.responseTime, timeB: note2.responseTime) &&
          Mapper.checkListsAreTheSame(list1: note1.buttons, list2: note2.buttons)
      ){
        _areTheSame = true;
      }

    }

    return _areTheSame;
  }
  // -----------------------------------
  /// TESTED : WORKS PERFECT
  static bool checkNotesListsAreTheSame({
    @required List<NoteModel> notes1,
    @required List<NoteModel> notes2,
  }){
    bool _areTheSame = true;

    if (Mapper.checkCanLoopList(notes1) == true && Mapper.checkCanLoopList(notes2) == true){

      if (notes1.length != notes2.length){
        _areTheSame = false;
      }

      else {
        for (int i = 0; i < notes1.length; i++){

          final note1 = notes1[i];
          final note2 = notes2[i];

          final bool _theSame = checkNotesAreTheSame(
              note1: note1,
              note2: note2
          );

          if (_theSame == false){
            _areTheSame = false;
            break;
          }

        }
      }

    }

    return _areTheSame;
  }
  // -----------------------------------
  static bool checkNotesContainNote({
    @required List<NoteModel> notes,
    @required NoteModel note,
  }){

    bool _contains = false;

    if (Mapper.checkCanLoopList(notes) == true && note != null){

      for (final NoteModel noteModel in notes){
        if (noteModel.id == note.id){
          _contains = true;
          break;
        }
      }

    }

    return _contains;
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<NoteModel> removeNoteFromNotes({
    @required List<NoteModel> notes,
    @required NoteModel noteModel,
  }){

    final List<NoteModel> _output = notes == null ?
    <NoteModel>[]
        :
    <NoteModel>[...notes];

    // blog('removeNoteFromNotes : notes : ${_output.length}');

    if (Mapper.checkCanLoopList(notes) == true){

      final int _index = notes.indexWhere((note) => note.id == noteModel.id);

      if (_index != -1){
        // blog('removeNoteFromNotes : removing note _index : $_index');
        _output.removeAt(_index);
      }

    }

    // blog('removeNoteFromNotes : notes : ${_output.length}');

    return _output;
  }
  // -------------------------------------
  static List<NoteModel> removeNotesFromNotes({
    @required List<NoteModel> notesToRemove,
    @required List<NoteModel> sourceNotes,
  }){

    List<NoteModel> _output = sourceNotes ?? <NoteModel>[];

    if (Mapper.checkCanLoopList(notesToRemove) == true && Mapper.checkCanLoopList(_output) == true){

      for (final NoteModel note in notesToRemove){

        _output = removeNoteFromNotes(
          notes: _output,
          noteModel: note,
        );

      }

    }

    return _output;
  }
  // -------------------------------------
  static List<NoteModel> insertNoteIntoNotes({
    @required List<NoteModel> notesToGet,
    @required NoteModel note,
    @required DuplicatesAlgorithm duplicatesAlgorithm,
  }){

    final List<NoteModel> _output = notesToGet ?? <NoteModel>[];

    final bool _contains = checkNotesContainNote(
      notes: _output,
      note: note,
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
  // -------------------------------------
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
  // -----------------------------------------------------------------------------

  /// DUMMIES

  // -------------------------------------
  /// TESTED : WORKS PERFECT
  static NoteModel dummyNote(){
    return NoteModel(
      id: 'id',
      senderID: 'senderID',
      senderImageURL: 'senderImageURL',
      noteSenderType: NoteSenderType.bldrs,
      receiverID: 'receiverID',
      receiverType: NoteReceiverType.user,
      title: 'title',
      body: 'body',
      metaData: const {'metaData' : 'thing'},
      sentTime: Timers.createClock(hour: 12, minute: 10),
      attachment: 'attachment',
      attachmentType: NoteAttachmentType.bzID,
      seen: true,
      seenTime: Timers.createDate(year: 1950, month: 10, day: 6),
      sendFCM: true,
      noteType: NoteType.announcement,
      response: NoteResponse.pending,
      responseTime: Timers.createClock(hour: 10, minute: 50),
      buttons: const <String>['Fuck', 'You'],
    );
  }
  // -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<NoteModel> dummyNotes(){

    return <NoteModel>[
      dummyNote(),
      dummyNote(),
      dummyNote(),
    ];

  }
// -----------------------------------------------------------------------------
}
// -----------------------------------------------------------------------------

enum DuplicatesAlgorithm {
  keepSecond,
  keepBoth,
  keepFirst,
}
