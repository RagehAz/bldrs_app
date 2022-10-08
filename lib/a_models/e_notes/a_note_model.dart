import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poster_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poll_model.dart';
import 'package:bldrs/a_models/e_notes/aa_trigger_model.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

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
    @required this.parties,
    @required this.title,
    @required this.body,
    @required this.metaData,
    @required this.sentTime,
    @required this.poster,
    @required this.poll,
    @required this.sendFCM,
    @required this.token,
    @required this.topic,
    @required this.trigger,
    @required this.seen,
    this.docSnapshot,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final NoteParties parties;
  final String title; /// max 30 char
  final String body; /// max 80 char
  final Map<String, dynamic> metaData;
  final DateTime sentTime;
  final PosterModel poster;
  final PollModel poll;
  final bool sendFCM;
  final String token;
  final String topic;
  final TriggerModel trigger;
  final bool seen;
  final QueryDocumentSnapshot<Object> docSnapshot;
  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const String fcmSound = 'default';
  static const String fcmStatus = 'done';
  // --------------------
  static const dynamic defaultMetaData = <String, dynamic>{
    'click_action': 'FLUTTER_NOTIFICATION_CLICK',
    'sound': fcmSound,
    'status': fcmStatus,
    'screen': '',
  };
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  ///
  NoteModel copyWith({
    String id,
    NoteParties parties,
    String title,
    String body,
    Map<String, dynamic> metaData,
    DateTime sentTime,
    PosterModel poster,
    PollModel poll,
    bool sendFCM,
    String token,
    String topic,
    TriggerModel trigger,
    bool seen,
  }){
    return NoteModel(
      id: id ?? this.id,
      parties: parties ?? this.parties,
      title: title ?? this.title,
      body: body ?? this.body,
      metaData: metaData ?? this.metaData,
      sentTime: sentTime ?? this.sentTime,
      poster: poster ?? this.poster,
      sendFCM: sendFCM ?? this.sendFCM,
      poll: poll ?? this.poll,
      token: token ?? this.token,
      topic: topic ?? this.topic,
      trigger: trigger ?? this.trigger,
      seen: seen ?? this.seen,
    );
  }
  // --------------------
  ///
  NoteModel nullifyField({
    bool id = false,
    bool parties = false,
    bool title = false,
    bool body = false,
    bool metaData = false,
    bool sentTime = false,
    bool poster = false,
    bool poll = false,
    bool sendFCM = false,
    bool token = false,
    bool topic = false,
    bool trigger = false,
    bool seen = false,
  }){
    return NoteModel(
      id: id == true ? null : this.id,
      parties: parties == true ? null : this.parties,
      title: title == true ? null : this.title,
      body: body == true ? null : this.body,
      metaData: metaData == true ? null : this.metaData,
      sentTime: sentTime == true ? null : this.sentTime,
      poster: poster == true ? null : this.poster,
      sendFCM: sendFCM == true ? null : this.sendFCM,
      poll: poll == true ? null : this.poll,
      token: token == true ? null : this.token,
      topic: topic == true ? null : this.topic,
      trigger: trigger == true ? null : this.trigger,
      seen: seen == true ? null : this.seen,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  ///
  Map<String, dynamic> toMap({
    @required bool toJSON,
  }) {
    return <String, dynamic>{
      'id': toJSON == true ? id : null,
      'parties': parties.toMap(),
      'notification': _cipherNotificationField(),
      'sentTime': Timers.cipherTime(time: sentTime, toJSON: toJSON),
      'poster': poster.toMap(),
      'poll': poll.toMap(toJSON: toJSON),
      'sendFCM': sendFCM,
      'token': token,
      'topic': topic,
      'trigger': trigger?.toMap(),
      'seen': seen,
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
  ///
  static NoteModel decipherNote({
    @required dynamic map,
    @required bool fromJSON
  }) {
    NoteModel _noti;

    if (map != null) {

      _noti = NoteModel(
        id: map['id'],
        parties: NoteParties.decipherParties(map['parties']),
        title: _decipherNotificationField(map: map, titleNotBody: true),
        body: _decipherNotificationField(map: map, titleNotBody: false),
        metaData: _decipherNotificationData(map),
        sentTime: Timers.decipherTime(
          time: map['sentTime'],
          fromJSON: fromJSON,
        ),
        poster: PosterModel.decipher(map['poster']),
        sendFCM: map['sendFCM'],
        poll: PollModel.decipherPoll(
          map: map['poll'],
          fromJSON: fromJSON,
        ),
        token: map['token'],
        topic: map['topic'],
        trigger: TriggerModel.decipherTrigger(map['trigger']),
        seen: map['seen'],
        docSnapshot: map['docSnapshot'],
      );
    }

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

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogNoteModel({
    String methodName,
  }) {
    blog('BLOGGING NoteModel : $methodName -------------------------------- START -- ');

    blog('id : $id');
    blog('title : $title');
    blog('body : $body');
    blog('sentTime : $sentTime');
    blog('sendFCM : $sendFCM');
    blog('token: $token');
    blog('topic: $topic');
    blog('seen: $seen');
    parties?.blogParties();
    poster?.blogPoster();
    poll?.blogPoll();
    trigger?.blogTrigger();
    Mapper.blogMap(metaData, invoker: 'blogNoteModel');
    blog('docSnapshot : $docSnapshot');

    blog('BLOGGING NoteModel : $methodName -------------------------------- END -- ');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
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
  /// TESTED : WORKS PERFECT
  static List<String> getReceiversIDs({
    @required List<NoteModel> notes,
  }){

    final List<String> _output = <String>[];

    if (Mapper.checkCanLoopList(notes) == true){

      for (final NoteModel note in notes){
        _output.add(note.parties.receiverID);
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
              (note) => note.parties.receiverID == receiverID,
          orElse: ()=> null
      );

    }

    return _output;
  }
  // --------------------
  static List<NoteModel> getNotesByReceiverID({
    @required List<NoteModel> notes,
    @required String receiverID,
  }){
    final List<NoteModel> _notes = <NoteModel>[];

    if (Mapper.checkCanLoopList(notes) == true){

      final List<NoteModel> _found = notes.where((note){

        return note.parties.receiverID == receiverID;
      }).toList();

      if (Mapper.checkCanLoopList(_found) == true){
        _notes.addAll(_found);
      }

    }

    return _notes;
  }
  // --------------------
  ///
  static List<NoteModel> getNotesContainingTrigger({
    @required List<NoteModel> notes,
    @required String triggerFunctionName,
  }){
    final List<NoteModel> _output = <NoteModel>[];

    if (Mapper.checkCanLoopList(notes) == true){

      for (final NoteModel note in notes){

        if (note.trigger?.functionName == triggerFunctionName){
          _output.add(note);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// UNSEEN GETTERS

  // --------------------
  ///
  static int getNumberOfUnseenNotes(List<NoteModel> notes){
    int _count = 0;

    if (Mapper.checkCanLoopList(notes) == true){

      for (final NoteModel note in notes){
        if (note.seen == false){
          _count++;
        }
      }

    }

    return _count;
  }
  // --------------------
  ///
  static List<NoteModel> getUnseenNotesByReceiverID({
    @required List<NoteModel> notes,
    @required String receiverID,
  }){
    final List<NoteModel> _notes = <NoteModel>[];

    if (Mapper.checkCanLoopList(notes) == true){

      for (final NoteModel note in notes){

        if(note.parties.receiverID == receiverID){
          if (note.seen == false){
            _notes.add(note);
          }
        }

      }

    }

    return _notes;
  }
  // --------------------
  ///
  static List<NoteModel> getOnlyUnseenNotes({
    @required List<NoteModel> notes,
  }){
    final List<NoteModel> _output = <NoteModel>[];

    if (Mapper.checkCanLoopList(notes) == true){

      for (final NoteModel note in notes){

        if (note.seen == false){
          _output.add(note);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// MISSING FIELDS GETTERS

  // --------------------
  ///
  static List<String> getMissingNoteFields({
    @required NoteModel note,
    /// if consider all fields is false, this will get only fields required to send a note
    @required bool considerAllFields,
  }){
    List<String> _missingFields;

    if (note != null){

      _missingFields = <String>[];

      if (note.parties.senderID == null) {
        _missingFields.add('senderID');
      }

      if (note.parties.senderImageURL == null){
        _missingFields.add('senderImageURL');
      }

      if (note.parties.senderType == null){
        _missingFields.add('senderType');
      }

      if (note.parties.receiverID == null){
        _missingFields.add('receiverID');
      }

      if (note.parties.receiverType == null){
        _missingFields.add('receiverType');
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

      if (note.seen == null){
        _missingFields.add('seen');
      }


      /// IF NOT ONLY ESSENTIAL FIELDS REQUIRED TO SEND A NOTE ARE TO BE CONSIDERED
      if (considerAllFields == true){

        if (note.sentTime == null){
          _missingFields.add('sentTime');
        }

        if (note.id == null) {
          _missingFields.add('id');
        }

        if (note.poster == null){
          _missingFields.add('poster');
        }

        if (note.trigger == null){
          _missingFields.add('trigger');
        }

        if (note.poll == null){
          _missingFields.add('poll');
        }

        if (note.token == null){
          _missingFields.add('token');
        }

        if (note.topic == null){
          _missingFields.add('topic');
        }

      }

    }

    return _missingFields;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  ///
  static bool checkThereAreUnSeenNotes(List<NoteModel> notes){
    bool _thereAreUnseenNotes = false;

    if (Mapper.checkCanLoopList(notes) == true){

      for (final NoteModel note in notes){

        if (note.seen == false){
          _thereAreUnseenNotes = true;
          break;
        }

      }

    }

    return _thereAreUnseenNotes;
  }
  // --------------------
  ///
  static bool checkCanSendNote(NoteModel noteModel){
    bool _canSend = false;

    if (noteModel != null){

      if (
          // noteModel.id != null &&
          noteModel.parties.senderID != null &&
          noteModel.parties.senderImageURL != null &&
          noteModel.parties.senderType != null &&
          noteModel.parties.receiverID != null &&
          noteModel.parties.receiverType != null &&
          noteModel.title != null &&
          noteModel.body != null &&
          noteModel.metaData != null &&
          // noteModel.sentTime != null &&
          // noteModel.poster != null &&
          // noteModel.poll != null &&
          // noteModel.token != null &&
          // noteModel.topic != null &&
          // noteModel.trigger != null &&
          // noteModel.seen != null &&
          noteModel.sendFCM != null
      ){
        _canSend = true;
      }

    }

    return _canSend;
  }
  // --------------------
  ///
  static bool checkNotesAreIdentical({
    @required NoteModel note1,
    @required NoteModel note2,
  }){
    bool _areIdentical = false;

    if (note1 == null && note2 == null){
      _areIdentical = true;
    }

    else if (note1 != null && note2 != null){

      if (
          note1.id == note2.id &&
          NoteParties.checkPartiesAreIdentical(parties1: note1.parties, parties2: note2.parties) &&
          note1.title == note2.title &&
          note1.body == note2.body &&
          Mapper.checkMapsAreIdentical(map1: note1.metaData, map2: note2.metaData) == true &&
          Timers.checkTimesAreIdentical(accuracy: TimeAccuracy.microSecond, time1: note1.sentTime, time2: note2.sentTime) &&
          PosterModel.checkPostersAreIdentical(poster1: note1.poster, poster2: note2.poster) &&
          PollModel.checkPollsAreIdentical(poll1: note1.poll, poll2: note2.poll) &&
          note1.sendFCM == note2.sendFCM &&
          note1.token == note2.token &&
          note1.topic == note2.topic &&
          TriggerModel.checkTriggersAreIdentical(note1.trigger, note2.trigger) &&
          note1.seen == note2.seen
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
  ///
  static List<NoteModel> orderNotesBySentTime(List<NoteModel> notes){
    if (Mapper.checkCanLoopList(notes) == true){
      notes.sort((NoteModel a, NoteModel b) => b.sentTime.compareTo(a.sentTime));
    }
    return notes;
  }
  // --------------------
  ///
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
  ///
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
  ///
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
      parties: const NoteParties(
        senderID: NoteParties.bldrsSenderID,
        senderImageURL: NoteParties.bldrsLogoStaticURL,
        senderType: NotePartyType.bldrs,
        receiverID: 'receiverID',
        receiverType: NotePartyType.user,
      ),
      title: 'title',
      body: 'body',
      metaData: defaultMetaData,
      sentTime: DateTime.now(),
      poster: null,
      trigger: null,
      sendFCM: true,
      poll: PollModel.dummyPoll(),
      token: null,
      topic: null,
      seen: false,
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
  // --------------------
  static NoteModel quickUserNotice({
    @required String userID,
    @required String title,
    @required String body
  }){
    return NoteModel(
      title: title,
      body: body,
      id: 'x',
      parties: NoteParties(
        receiverID: userID,
        senderID: NoteParties.bldrsSenderID,
        senderImageURL: NoteParties.bldrsLogoStaticURL,
        senderType: NotePartyType.bldrs,
        receiverType: NotePartyType.user,

      ),
      metaData: NoteModel.defaultMetaData,
      sentTime: DateTime.now(),
      poster: null,
      sendFCM: true,
      poll: null,
      trigger: null,
      token: 'will be auto adjusted on NoteFireOps.create.adjustToken',
      topic: null,
      seen: false,
    );
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
      TopicType.authorshipReply, // 'authorshipAcceptance/bzID/'
      TopicType.authorRoleChanged, // 'authorRoleChanged/bzID/'
      TopicType.authorDeletion, // 'authorDeletion/bzID/'
      TopicType.generalBzNotes, // 'generalBzNotes/bzID/'

    ];
  }
  // -----------------------------------------------------------------------------

  /// VALIDATION

  // --------------------
  /*
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
   */
  // --------------------
  /*
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
   */
  // --------------------
  static String receiverVsSenderValidator({
    @required NotePartyType senderType,
    @required NotePartyType receiverType,
  }){

    /// USER
    if (receiverType == NotePartyType.user){

      switch(senderType){
        case NotePartyType.user     : return null; break; /// user can receive from user
        case NotePartyType.bz       : return null; break; /// user can receive from bz
        case NotePartyType.bldrs    : return null; break; /// user can receive from bldrs
        case NotePartyType.country  : return null; break; /// user can receive from country
        default: return null;
      }

    }

    /// BZ
    else if (receiverType == NotePartyType.bz){

      switch(senderType){
        case NotePartyType.user     : return null; break; /// bz can receive from user
        case NotePartyType.bz       : return null; break; /// bz can receive from bz
        case NotePartyType.bldrs    : return null; break; /// bz can receive from bldrs
        case NotePartyType.country  : return null; break; /// bz can receive from country
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
      parties.hashCode^
      title.hashCode^
      body.hashCode^
      metaData.hashCode^
      sentTime.hashCode^
      poster.hashCode^
      poll.hashCode^
      sendFCM.hashCode^
      token.hashCode^
      topic.hashCode^
      trigger.hashCode^
      seen.hashCode^
      docSnapshot.hashCode;
  // -----------------------------------------------------------------------------
}

// -----------------------------------------------------------------------------
enum TopicType {
  /// authors notified on their any new flyer getting verified
  flyerVerification, // 'flyerVerification/bzID/'

  /// authors notifier on any of bz flyers got updated
  flyerUpdate, // 'flyerUpdate/bzID/'

  /// authors notified on new user joined their team
  authorshipReply, // 'authorshipAcceptance/bzID/'

  /// authors notified on any of them got his role changed
  authorRoleChanged, // 'authorRoleChanged/bzID/'

  /// authors notified on any of them got removed from the team
  authorDeletion, // 'authorDeletion/bzID/'

  /// authors notified on this general topic for general bz related notes
  generalBzNotes, // 'generalBzNotes/bzID/'
}
// -----------------------------------------------------------------------------
/*

WHEN DO WE HAVE NOTIFICATIONS

-- USER RECEIVE
    -> authorship request
    -> my reviews [review received reply - review received agree]

-- USERS RECEIVE AT ONCE
    -> followed bzz flyers [followed bz publish new flyer]
    -> saved flyers [saved flyer updated - saved flyer received new review]
    -> general news

-- AUTHORS (BZ) RECEIVE
    -> bz flyer note : [flyer verification note - flyer update note]
    -> bz team notes : [authorship reply - author role changes - author deletion]
    -> new followers
    -> user-flyer interaction [new flyer share - new flyer save - new flyer review]
    -> general bz related news

    -----> my bz is deleted

 */
// -----------------------------------------------------------------------------
/*
// /// should be re-named and properly handled to become { triggers / function triggers }
// enum NoteType {
//   /// WHEN BZ AUTHOR SENDS INVITATION TO A USER TO BECOME AN AUTHOR OF THE BZ
//   authorship,
//   /// WHEN BLDRS.NET SENDS A USER SOME NEWS
//   notice,
//   /// WHEN FLYER UPDATES ON DB AND NEED TO ACTIVATE [ LOCAL FLYER UPDATE PROTOCOL ]
//   flyerUpdate,
//   /// WHEN A MASTER AUTHOR DELETES BZ, A NOTE IS SENT TO ALL AUTHORS
//   bzDeletion,
// }
 */
// -----------------------------------------------------------------------------
/*
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
   */
// -----------------------------------------------------------------------------
