// ignore_for_file: avoid_bool_literals_in_conditional_expressions

import 'package:bldrs/a_models/b_bz/author/pending_author_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poll_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poster_model.dart';
import 'package:bldrs/a_models/e_notes/aa_topic_model.dart';
import 'package:bldrs/a_models/e_notes/aa_trigger_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/auth_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum DuplicatesAlgorithm {
  keepSecond,
  keepBoth,
  keepFirst,
}

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

@immutable
class NoteModel {
  /// --------------------------------------------------------------------------
  const NoteModel({
    @required this.id,
    @required this.parties,
    @required this.title,
    @required this.body,
    @required this.sentTime,
    this.dismissible = true,
    this.seen = false,
    this.topic,
    this.sendFCM = true,
    this.sendNote = true,
    this.poster,
    this.poll,
    this.trigger,
    this.progress,
    this.token,
    this.docSnapshot,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final NoteParties parties;
  final String title; /// max 30 char
  final String body; /// max 80 char
  final DateTime sentTime;
  final PosterModel poster;
  final PollModel poll;
  final bool sendFCM;
  final bool sendNote;
  final String topic;
  final TriggerModel trigger;
  final bool seen;
  final int progress;
  final bool dismissible;
  final String token;
  final QueryDocumentSnapshot<Object> docSnapshot;
  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const String fcmSound = 'default';
  static const String fcmStatus = 'done';
  // --------------------
  /*
  static const dynamic defaultMetaData = <String, dynamic>{
    'click_action': 'FLUTTER_NOTIFICATION_CLICK',
    'sound': fcmSound,
    'status': fcmStatus,
    'screen': '',
  };
   */
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
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
    bool sendNote,
    String token,
    String topic,
    TriggerModel trigger,
    bool seen,
    int progress,
    bool dismissible,
  }){
    return NoteModel(
      id: id ?? this.id,                              // String id,
      parties: parties ?? this.parties,               // NoteParties parties,
      title: title ?? this.title,                     // String title,
      body: body ?? this.body,                        // String body,
      sentTime: sentTime ?? this.sentTime,            // DateTime sentTime,
      sendFCM: sendFCM ?? this.sendFCM,               // bool sendFCM,
      sendNote: sendNote ?? this.sendNote,            // bool sendNote,
      poster: poster ?? this.poster,                  // PosterModel poster,
      poll: poll ?? this.poll,                        // PollModel poll,
      token: token ?? this.token,                     // String token,
      topic: topic ?? this.topic,                     // String topic,
      trigger: trigger ?? this.trigger,               // TriggerModel trigger,
      seen: seen ?? this.seen,                        // bool seen,
      progress: progress ?? this.progress,            // int progress,
      dismissible: dismissible ?? this.dismissible,   // bool dismissible,

    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
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
    bool sendNote = false,
    bool token = false,
    bool topic = false,
    bool trigger = false,
    bool seen = false,
    bool progress = false,
    bool dismissible = false,
  }){
    return NoteModel(
      id: id == true ? null : this.id,
      parties: parties == true ? null : this.parties,
      title: title == true ? null : this.title,
      body: body == true ? null : this.body,
      sentTime: sentTime == true ? null : this.sentTime,
      poster: poster == true ? null : this.poster,
      sendFCM: sendFCM == true ? null : this.sendFCM,
      sendNote: sendNote == true ? null : this.sendNote,
      poll: poll == true ? null : this.poll,
      token: token == true ? null : this.token,
      topic: topic == true ? null : this.topic,
      trigger: trigger == true ? null : this.trigger,
      seen: seen == true ? null : this.seen,
      progress: progress == true ? null : this.progress,
      dismissible: dismissible == true ? null : this.dismissible,
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
      'token': token,
      'id' : id,
      'senderID': parties.senderID,
      'senderImageURL': parties.senderImageURL,
      'senderType': NoteParties.cipherPartyType(parties.senderType),
      'receiverID': parties.receiverID,
      'receiverType': NoteParties.cipherPartyType(parties.receiverType),
      'title' : title,
      'body' : body,
      'sentTime': Timers.cipherTime(time: sentTime, toJSON: toJSON),
      'posterModelID': poster?.modelID,
      'posterType': PosterModel.cipherPosterType(poster?.type),
      'posterURL': poster?.url,
      'buttons': PollModel.cipherButtons(poll?.buttons),
      'reply' : poll?.reply,
      'replyTime' : poll?.replyTime,
      'sendFCM': sendFCM,
      'sendNote': sendNote,
      'topic': topic,
      'triggerName': trigger?.name,
      'triggerArgument': trigger?.argument,
      'triggerDone': trigger?.done,
      'seen': seen,
      'progress': progress,
      'dismissible' : dismissible,
      'docSnapshot' : docSnapshot,
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

      _noti = NoteModel(

        token: map['token'],
        id: map['id'],
        parties: NoteParties(
          senderID: map['senderID'],
          senderImageURL: map['senderImageURL'],
          senderType: NoteParties.decipherPartyType(map['senderType']),
          receiverID: map['receiverID'],
          receiverType: NoteParties.decipherPartyType(map['receiverType']),
        ),
        title: map['title'],
        body: map['body'],
        sentTime: Timers.decipherTime(time: map['sentTime'], fromJSON: fromJSON,),
        poster: PosterModel(
          modelID: map['posterModelID'],
          type: PosterModel.decipherPosterType(map['posterType']),
          url: map['posterURL'],
        ),
        poll: PollModel(
          buttons: PollModel.decipherButtons(map['buttons']),
          reply: map['reply'],
          replyTime: Timers.decipherTime(time: map['replyTime'], fromJSON: fromJSON,)
        ),
        sendFCM: map['sendFCM'],
        sendNote: map['sendNote'],
        topic: map['topic'],
        trigger: TriggerModel(
          name: map['triggerName'],
          argument: map['triggerArgument'],
          done: map['triggerDone'],
        ),
        seen: map['seen'],
        progress: map['progress'],
        dismissible: map['dismissible'],
        docSnapshot: map['docSnapshot'],
      );

    }

    return _noti;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<NoteModel> decipherNotes({
    @required List<Map<String, dynamic>> maps,
    @required bool fromJSON,
  }) {
    final List<NoteModel> _notesModels = <NoteModel>[];

    if (Mapper.checkCanLoopList(maps) == true) {
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
  // -----------------------------------------------------------------------------

  /// REMOTE MSG - NOOT

  // --------------------
  /// TESTED : WORKS PERFECT
  static NoteModel decipherRemoteMessage({
    @required Map<String, dynamic> map,
  }) {
    NoteModel _note;

    if (map != null){

      String get(String field){
        return Stringer.nullifyNullString(map[field]);
      }

      bool getBool(String field){
        return map[field] == 'true' ? true : false;
      }

      _note = NoteModel(
        token: get('token'),
        id: get('id'),
        parties: NoteParties(
          senderID: get('senderID'),
          senderImageURL: get('senderImageURL'),
          senderType: NoteParties.decipherPartyType(get('senderType')),
          receiverID: get('receiverID'),
          receiverType: NoteParties.decipherPartyType(get('receiverType')),
        ),
        title:
        get('title'),
        body: get('body'),
        sentTime: Timers.decipherTime(time: get('sentTime'), fromJSON: true),
        poster: PosterModel(
          modelID: get('posterModelID'),
          type: PosterModel.decipherPosterType(get('posterType')),
          url: get('posterURL'),
        ),
        poll: PollModel(
            buttons: PollModel.decipherButtons(get('buttons')),
            reply: get('reply'),
            replyTime: Timers.decipherTime(time: get('replyTime'), fromJSON: true,)
        ),
        sendFCM: getBool('sendFCM'),
        sendNote: getBool('sendNote'),
        topic: get('topic'),
        trigger: TriggerModel(
          name: get('triggerName'),
          argument: get('triggerArgument'),
          done: getBool('triggerDone'),
        ),
        seen: getBool('seen'),
        progress: Numeric.transformStringToInt(get('progress')),
        dismissible: getBool('dismissible'),

      );

    }

    return _note;

  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogNoteModel({
    String invoker,
  }) {

    blog('=> BLOGGING NoteModel : $invoker -------------------------------- START -- ');
    blog('O : id : $id : seen: $seen : docSnapshotExists : ${docSnapshot != null}');
    blog('O : topic: $topic : token: $token');
    blog('O : ~ ~ ~ ~ ~ ~');
    blog('O : title : $title');
    blog('O : body : $body');
    blog('O : ~ ~ ~ ~ ~ ~');
    blog('O : sentTime : $sentTime : seen: $seen');
    blog('O : sendFCM : $sendFCM : sendNote: $sendNote : dismissible: $dismissible');
    blog('O : ~ ~ ~ ~ ~ ~');
    blog('O : parties : senderID : ${parties?.senderID} : ${NoteParties.cipherPartyType(parties?.senderType)} : ${parties?.senderImageURL}');
    blog('O : parties : receiverID : ${parties?.receiverID} : ${NoteParties.cipherPartyType(parties?.receiverType)} ');
    blog('O : ~ ~ ~ ~ ~ ~');
    blog('O : poster : id : ${poster?.modelID} : type : ${PosterModel.cipherPosterType(poster?.type)} : url : ${poster?.url}');
    blog('O : poll : button : ${poll?.buttons} : reply : ${poll?.reply} : replyTime : ${poll?.replyTime}');
    blog('O : trigger : functionName : ${trigger?.name} : argument : ${trigger?.argument}');
    blog('O : ~ ~ ~ ~ ~ ~');
    blog('<= BLOGGING NoteModel : $invoker -------------------------------- END -- ');
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
          invoker: methodName,
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
  ///
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
  ///
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

        if (note.trigger?.name == triggerFunctionName){
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

      if (note.sendFCM == null){
        _missingFields.add('sendFCM');
      }

      if (note.sendNote == null){
        _missingFields.add('sendNote');
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

        if (note.progress == null){
          _missingFields.add('progress');
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
  /// TESTED : WORKS PERFECT
  static bool checkNoteIsSendable(NoteModel noteModel){
    bool _canSend = false;

    if (noteModel != null){

      if (

      /// NECESSARY
      noteModel.parties.receiverID != null &&
      noteModel.parties.receiverType != null &&
      noteModel.parties.senderID != null &&
      noteModel.parties.senderType != null &&
      noteModel.parties.senderImageURL != null &&
      noteModel.title != null &&
      noteModel.body != null &&
      noteModel.topic != null &&
      (noteModel.sendNote == true || noteModel.sendFCM == true)

      /// WILL BE RECREATED
      // noteModel.id != null &&
      // noteModel.sentTime != null &&

      /// ARE OPTIONAL
      // noteModel.poster != null &&
      // noteModel.dismissible != null &&
      // noteModel.poll != null &&
      // noteModel.trigger != null &&
      // noteModel.progress != null &&

     /// SHOULD BE NULL WHILE SENDING
     //  noteModel.seen != null &&
     //  noteModel.docSnapshot != null

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

    if (note1 == null && note2 == null){
      _areIdentical = true;
    }

    else if (note1 != null && note2 != null){

      if (
          note1.id == note2.id &&
          NoteParties.checkPartiesAreIdentical(parties1: note1.parties, parties2: note2.parties) &&
          note1.title == note2.title &&
          note1.body == note2.body &&
          Timers.checkTimesAreIdentical(accuracy: TimeAccuracy.microSecond, time1: note1.sentTime, time2: note2.sentTime) &&
          PosterModel.checkPostersAreIdentical(poster1: note1.poster, poster2: note2.poster) &&
          PollModel.checkPollsAreIdentical(poll1: note1.poll, poll2: note2.poll) &&
          note1.sendFCM == note2.sendFCM &&
          note1.sendNote == note2.sendNote &&
          note1.token == note2.token &&
          note1.topic == note2.topic &&
          TriggerModel.checkTriggersAreIdentical(note1.trigger, note2.trigger) &&
          note1.seen == note2.seen &&
          note1.progress == note2.progress &&
          note1.dismissible == note2.dismissible
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
  // --------------------
  ///
  static bool checkIsAuthorshipNote(NoteModel noteModel){
    bool _isAuthorship = false;

    if (noteModel != null) {
      if (
          noteModel.topic == TopicModel.bzInvitations
          &&
          // noteModel.trigger?.name == TriggerModel.refetchBz
          // &&
          noteModel.parties?.senderType == PartyType.bz
      ) {
        _isAuthorship = true;
      }
    }

    return _isAuthorship;
  }
  // --------------------
  ///
  static Future<bool> checkCanShowAuthorshipButtons({
    @required BuildContext context,
    @required NoteModel noteModel,
  }) async {

    bool _can = false;

    if (noteModel != null){

      final bool _isAuthorshipNote = NoteModel.checkIsAuthorshipNote(noteModel);

      if (_isAuthorshipNote == true){

        if (noteModel.parties.senderType == PartyType.bz){

          final BzModel _bzModel = await BzProtocols.fetch(
            context: context,
            bzID: noteModel.parties.senderID,
          );

          final bool _imPendingAuthor = PendingAuthor.checkIsPendingAuthor(
            bzModel: _bzModel,
            userID: AuthFireOps.superUserID(),
          );

          if (_imPendingAuthor == true){

            if (noteModel.poll.reply == null){

              _can = true;

            }

          }

        }


      }

    }

    return _can;
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
  /// TESTED : WORKS PERFECT
  static const NoteModel initialNoteForCreation = NoteModel(
    id: null,
    parties: NoteParties(
      senderID: NoteParties.bldrsSenderID, //NoteModel.bldrsSenderModel.key,
      senderImageURL: NoteParties.bldrsLogoStaticURL, //NoteModel.bldrsSenderModel.value,
      senderType: PartyType.bldrs,
      receiverID: null,
      receiverType: null,
    ),
    title: null,
    body: null,
    sentTime: null,
    // sendFCM: true,
    // dismissible: true,
  );
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
        senderType: PartyType.bldrs,
        receiverID: 'receiverID',
        receiverType: PartyType.user,
      ),
      title: 'title',
      body: 'body',
      sentTime: DateTime.now(),
      poll: PollModel.dummyPoll(),
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
  /// TESTED : WORKS PERFECT
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
        senderType: PartyType.bldrs,
        receiverType: PartyType.user,

      ),
      sentTime: DateTime.now(),
      token: 'will be auto adjusted on NoteFireOps.create.adjustToken',
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
  /// TESTED : WORKS PERFECT
  static String receiverVsSenderValidator({
    @required PartyType senderType,
    @required PartyType receiverType,
  }){

    /// USER
    if (receiverType == PartyType.user){

      switch(senderType){
        case PartyType.user     : return null; break; /// user can receive from user
        case PartyType.bz       : return null; break; /// user can receive from bz
        case PartyType.bldrs    : return null; break; /// user can receive from bldrs
        case PartyType.country  : return null; break; /// user can receive from country
        default: return null;
      }

    }

    /// BZ
    else if (receiverType == PartyType.bz){

      switch(senderType){
        case PartyType.user     : return null; break; /// bz can receive from user
        case PartyType.bz       : return null; break; /// bz can receive from bz
        case PartyType.bldrs    : return null; break; /// bz can receive from bldrs
        case PartyType.country  : return null; break; /// bz can receive from country
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
      sentTime.hashCode^
      poster.hashCode^
      poll.hashCode^
      sendFCM.hashCode^
      sendNote.hashCode^
      token.hashCode^
      topic.hashCode^
      trigger.hashCode^
      seen.hashCode^
      progress.hashCode^
      docSnapshot.hashCode;
  // -----------------------------------------------------------------------------
}
