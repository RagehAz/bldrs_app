// ignore_for_file: avoid_bool_literals_in_conditional_expressions

import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/pending_author_model.dart';
import 'package:bldrs/a_models/c_chain/aa_chain_path_converter.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poll_model.dart';
import 'package:bldrs/a_models/e_notes/aa_topic_model.dart';
import 'package:bldrs/a_models/e_notes/aa_trigger_model.dart';
import 'package:bldrs/a_models/j_poster/poster_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/f_helpers/router/a_route_name.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:collection/collection.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';
import 'package:basics/helpers/classes/time/timers.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';

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
    required this.id,
    required this.parties,
    required this.title,
    required this.body,
    required this.sentTime,
    required this.topic,
    required this.navTo,
    this.function,
    this.dismissible = true,
    this.seen = false,
    this.sendFCM = true,
    this.sendNote = true,
    this.poster,
    this.poll,
    this.progress,
    this.token,
    this.docSnapshot,
  });
  /// --------------------------------------------------------------------------
  final String? id;
  final NoteParties? parties;
  final String? title; /// max 30 char
  final String? body; /// max 80 char
  final DateTime? sentTime;
  final String? topic;
  final TriggerModel? navTo;
  final TriggerModel? function;
  final PosterModel? poster;
  final PollModel? poll;
  final bool? sendFCM;
  final bool? sendNote;
  final bool? seen;
  final int? progress;
  final bool? dismissible;
  final String? token;
  final QueryDocumentSnapshot<Object>? docSnapshot;
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
    String? id,
    NoteParties? parties,
    String? title,
    String? body,
    Map<String, dynamic>? metaData,
    DateTime? sentTime,
    PosterModel? poster,
    PollModel? poll,
    bool? sendFCM,
    bool? sendNote,
    String? token,
    String? topic,
    TriggerModel? function,
    TriggerModel? navTo,
    bool? seen,
    int? progress,
    bool? dismissible,
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
      function: function ?? this.function,               // TriggerModel trigger,
      navTo: navTo ?? this.navTo,                  // TriggerModel router,
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
    bool function = false,
    bool navTo = false,
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
      function: function == true ? null : this.function,
      navTo: navTo == true ? null : this.navTo,
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
    required bool toJSON,
  }) {
    return <String, dynamic>{
      'token': token,
      'id' : id,
      'senderID': parties?.senderID,
      'senderImageURL': parties?.senderImageURL,
      'senderType': NoteParties.cipherPartyType(parties?.senderType),
      'receiverID': parties?.receiverID,
      'receiverType': NoteParties.cipherPartyType(parties?.receiverType),
      'title' : title,
      'body' : body,
      'sentTime': Timers.cipherTime(time: sentTime, toJSON: toJSON),
      'posterModelID': poster?.modelID,
      'posterType': PosterModel.cipherPosterType(poster?.type),
      'posterURL': poster?.path,
      'buttons': PollModel.cipherButtons(poll?.buttons),
      'reply' : poll?.reply,
      'replyTime' : poll?.replyTime,
      'sendFCM': sendFCM,
      'sendNote': sendNote,
      'topic': topic,
      'functionName': function?.name,
      'functionArgument': function?.argument,
      'functionDone': ChainPathConverter.combinePathNodes(function?.done),
      'navToName': navTo?.name,
      'navToArgument': navTo?.argument,
      // 'navToDone': [], // ChainPathConverter.combinePathNodes(navTo?.done), no Need, it should always fire
      'seen': seen,
      'progress': progress,
      'dismissible' : dismissible,
      'docSnapshot' : docSnapshot,
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> cipherNotesModels({
    required List<NoteModel> notes,
    required bool toJSON,
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
  static NoteModel? decipherNote({
    required dynamic map,
    required bool fromJSON
  }) {
    NoteModel? _noti;

    if (map != null) {

      // blog('======>>>>>> map[functionDone] : ${map['functionDone'].runtimeType} : ${map['functionDone']}');

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
          path: map['posterURL'],
        ),
        poll: PollModel(
          buttons: PollModel.decipherButtons(map['buttons']),
          reply: map['reply'],
          replyTime: Timers.decipherTime(time: map['replyTime'], fromJSON: fromJSON,)
        ),
        sendFCM: map['sendFCM'],
        sendNote: map['sendNote'],
        topic: map['topic'],
        function: TriggerModel(
          name: map['functionName'],
          argument: map['functionArgument'],
          done: ChainPathConverter.splitPathNodes(map['functionDone']),
        ),
        navTo: TriggerModel(
          name: map['navToName'],
          argument: map['navToArgument'],
          done: const [], // no need to pass map['navToDone'] as it should always fire trigger
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
    required List<Map<String, dynamic>>? maps,
    required bool fromJSON,
  }) {
    final List<NoteModel> _notesModels = <NoteModel>[];

    if (Mapper.checkCanLoopList(maps) == true) {
      for (final Map<String, dynamic> map in maps!) {

        final NoteModel? _notiModel = decipherNote(
          map: map,
          fromJSON: fromJSON,
        );

        if (_notiModel != null){
          _notesModels.add(_notiModel);
        }

      }
    }

    return _notesModels;
  }
  // -----------------------------------------------------------------------------

  /// REMOTE MSG - NOOT

  // --------------------
  /// TESTED : WORKS PERFECT
  static NoteModel? decipherRemoteMessage({
    required Map<String, dynamic>? map,
  }) {
    NoteModel? _note;

    if (map != null){

      String? get(String field){
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
          path: get('posterURL'),
        ),
        poll: PollModel(
            buttons: PollModel.decipherButtons(get('buttons')),
            reply: get('reply'),
            replyTime: Timers.decipherTime(time: get('replyTime'), fromJSON: true,)
        ),
        sendFCM: getBool('sendFCM'),
        sendNote: getBool('sendNote'),
        topic: get('topic'),
        function: TriggerModel(
          name: get('functionName'),
          argument: get('functionArgument'),
          done: ChainPathConverter.splitPathNodes(get('functionDone')),
        ),
        navTo: TriggerModel(
          name: get('navToName'),
          argument: get('navToArgument'),
          done: const [], /// so navTo trigger will always fire
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
    String? invoker,
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
    blog('O : poster : id : ${poster?.modelID} : type : ${PosterModel.cipherPosterType(poster?.type)} : url : ${poster?.path}');
    blog('O : poll : button : ${poll?.buttons} : reply : ${poll?.reply} : replyTime : ${poll?.replyTime}');
    blog('O : function : name : ${function?.name} : argument : ${function?.argument} : done : ${function?.done}');
    blog('O : navTo : name : ${navTo?.name} : argument : ${navTo?.argument}');
    blog('O : ~ ~ ~ ~ ~ ~');
    blog('<= BLOGGING NoteModel : $invoker -------------------------------- END -- ');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogNotes({
    required List<NoteModel>? notes,
    String? invoker,
  }){

    if (Mapper.checkCanLoopList(notes) == true){

      for (final NoteModel note in notes!){

        note.blogNoteModel(
          invoker: invoker,
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
    required List<NoteModel>? notes,
  }){

    final List<String> _output = <String>[];

    if (Mapper.checkCanLoopList(notes) == true){

      for (final NoteModel note in notes!){
        if (note.parties?.receiverID != null){
          _output.add(note.parties!.receiverID!);
        }
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static NoteModel? getFirstNoteByRecieverID({
    required List<NoteModel>? notes,
    required String? receiverID,
  }){

    NoteModel? _output;

    if (Mapper.checkCanLoopList(notes) == true && receiverID != null){

      _output = notes!.firstWhereOrNull(
              (note) => note.parties?.receiverID == receiverID
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<NoteModel> getNotesByReceiverID({
    required List<NoteModel>? notes,
    required String? receiverID,
  }){
    final List<NoteModel> _notes = <NoteModel>[];

    if (Mapper.checkCanLoopList(notes) == true){

      final List<NoteModel>? _found = notes?.where((note){

        return note.parties?.receiverID == receiverID;
      }).toList();

      if (Mapper.checkCanLoopList(_found) == true){
        _notes.addAll(_found!);
      }

    }

    return _notes;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<NoteModel> getNotesContainingTrigger({
    required List<NoteModel> notes,
    required String triggerFunctionName,
  }){
    final List<NoteModel> _output = <NoteModel>[];

    if (Mapper.checkCanLoopList(notes) == true){

      for (final NoteModel note in notes){

        if (note.function?.name == triggerFunctionName){
          _output.add(note);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// UNSEEN GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
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
  /// TESTED : WORKS PERFECT
  static List<NoteModel> getUnseenNotesByReceiverID({
    required List<NoteModel> notes,
    required String receiverID,
  }){
    final List<NoteModel> _notes = <NoteModel>[];

    if (Mapper.checkCanLoopList(notes) == true){

      for (final NoteModel note in notes){

        if(note.parties?.receiverID == receiverID){
          if (note.seen == false){
            _notes.add(note);
          }
        }

      }

    }

    return _notes;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<NoteModel> getOnlyUnseenNotes({
    required List<NoteModel> notes,
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
  /// TASK : TEST ME
  static List<String>? getMissingNoteFields({
    required NoteModel? note,
    /// if consider all fields is false, this will get only fields required to send a note
    required bool considerAllFields,
  }){
    List<String>? _missingFields;

    if (note != null){

      _missingFields = <String>[];

      if (note.parties?.senderID == null) {
        _missingFields.add('senderID');
      }

      if (note.parties?.senderImageURL == null){
        _missingFields.add('senderImageURL');
      }

      if (note.parties?.senderType == null){
        _missingFields.add('senderType');
      }

      if (note.parties?.receiverID == null){
        _missingFields.add('receiverID');
      }

      if (note.parties?.receiverType == null){
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

        if (note.function == null){
          _missingFields.add('function');
        }

        if (note.navTo == null){
          _missingFields.add('navTo');
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
  /// TESTED : WORKS PERFECT
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
  static bool checkNoteIsSendable(NoteModel? noteModel){
    bool _canSend = false;

    if (noteModel != null){

      final bool _canSendNote = noteModel.sendNote != null && noteModel.sendNote! == true;
      final bool _canSendFCM = noteModel.sendFCM != null && noteModel.sendFCM! == true;

      if (

      /// NECESSARY
      noteModel.parties?.receiverID != null &&
      noteModel.parties?.receiverType != null &&
      noteModel.parties?.senderID != null &&
      noteModel.parties?.senderType != null &&
      noteModel.parties?.senderImageURL != null &&
      noteModel.title != null &&
      noteModel.body != null &&
      noteModel.topic != null &&
      (_canSendNote == true || _canSendFCM == true)

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
  static bool checkNotesContainNote({
    required List<NoteModel>? notes,
    required String? noteID,
  }){

    bool _contains = false;

    if (Mapper.checkCanLoopList(notes) == true && noteID != null){

      for (final NoteModel noteModel in notes!){
        if (noteModel.id == noteID){
          _contains = true;
          break;
        }
      }

    }

    return _contains;
  }
  // --------------------
  /// TASK : TEST ME
  static bool checkIsAuthorshipNote(NoteModel? noteModel){
    bool _isAuthorship = false;

    if (noteModel != null) {
      if (
          noteModel.topic == TopicModel.userAuthorshipsInvitations
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
  /// TASK : TEST ME
  static Future<bool> checkCanShowAuthorshipButtons({
    required NoteModel? noteModel,
  }) async {

    bool _can = false;

    if (noteModel != null){

      final bool _isAuthorshipNote = NoteModel.checkIsAuthorshipNote(noteModel);

      blog('checkCanShowAuthorshipButtons : _isAuthorshipNote : $_isAuthorshipNote');

      if (_isAuthorshipNote == true){

        if (noteModel.parties?.senderType == PartyType.bz){

          final BzModel? _bzModel = await BzProtocols.fetchBz(
            bzID: noteModel.parties?.senderID,
          );

          final bool _imPendingAuthor = PendingAuthor.checkIsPendingAuthor(
            bzModel: _bzModel,
            userID: Authing.getUserID(),
          );

          blog('checkCanShowAuthorshipButtons : _imPendingAuthor : $_imPendingAuthor');

          if (_imPendingAuthor == true){

            if (noteModel.poll?.reply == null){

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
  static List<NoteModel> insertNoteIntoNotes({
    required List<NoteModel>? notesToGet,
    required NoteModel? note,
    required DuplicatesAlgorithm? duplicatesAlgorithm,
  }){
    final List<NoteModel> _output = notesToGet ?? <NoteModel>[];

    if (note != null){

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
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<NoteModel> insertNotesInNotes({
    required List<NoteModel>? notesToGet,
    required List<NoteModel>? notesToInsert,
    required DuplicatesAlgorithm duplicatesAlgorithm,
  }){
    List<NoteModel> _output = notesToGet ?? <NoteModel>[];

    if (Mapper.checkCanLoopList(notesToInsert) == true){

      for (final NoteModel note in notesToInsert!){

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
  /// TESTED : WORKS PERFECT
  static List<NoteModel> removeNoteFromNotes({
    required List<NoteModel>? notes,
    required String? noteID,
  }){

    final List<NoteModel> _output = notes == null ?
    <NoteModel>[]
        :
    <NoteModel>[...notes];

    // blog('removeNoteFromNotes : notes : ${_output.length}');

    if (Mapper.checkCanLoopList(notes) == true){

      final int _index = notes!.indexWhere((note) => note.id == noteID);

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
    required List<NoteModel> notesToRemove,
    required List<NoteModel>? sourceNotes,
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
  static List<NoteModel> replaceNoteInNotes({
    required List<NoteModel> notes,
    required NoteModel noteToReplace,
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
  // -----------------------------------------------------------------------------

  /// BZ NOTES MAP

  // --------------------
  /// UNUSED
  /*
  ///
  static Map<String, List<NoteModel>> updateNoteInBzzNotesMap({
    required NoteModel note,
    required Map<String, List<NoteModel>> bzzNotesMap,
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
   */
  // --------------------
  /// UNUSED
  /*
  static Map<String, List<NoteModel>> removeNoteFromBzzNotesMap({
    required String noteID,
    required Map<String, List<NoteModel>> bzzNotesMap
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
   */
  // -----------------------------------------------------------------------------

  /// SORTING

  // --------------------
  /// UNUSED
  /*
  /// TESTED : WORKS PERFECT
  static List<NoteModel> sortNotesBySentTime(List<NoteModel> notes){
    if (Mapper.checkCanLoopList(notes) == true){
      notes.sort((NoteModel a, NoteModel b) => b.sentTime.compareTo(a.sentTime));
    }
    return notes;
  }
   */
  // -----------------------------------------------------------------------------

  /// DUMMIES

  // --------------------
  /// TESTED : WORKS PERFECT
  static NoteModel initialNoteForCreation = NoteModel(
    id: null,
    parties: NoteParties(
      senderID: Standards.bldrsNotificationSenderID,
      senderImageURL: Standards.bldrsNotificationIconURL,
      senderType: PartyType.bldrs,
      receiverID: Authing.getUserID(),
      receiverType: PartyType.user,
    ),
    title: 'Hello',
    body: 'Bldrs',
    sentTime: null,
    topic: TopicModel.userGeneralNews,
    navTo: null,
    // navTo: const TriggerModel(
    //   name: Routing.myUserNotesPage,
    //   done: [],
    //   argument: null,
    // ),
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
      parties: NoteParties(
        senderID: Standards.bldrsNotificationSenderID,
        senderImageURL: Standards.bldrsNotificationIconURL,
        senderType: PartyType.bldrs,
        receiverID: Authing.getUserID(),
        receiverType: PartyType.user,
      ),
      title: 'title',
      body: 'body',
      sentTime: DateTime.now(),
      poll: PollModel.dummyPoll(),
      topic: TopicModel.userGeneralNews,
      navTo: const TriggerModel(
        name: RouteName.myUserNotes,
        done: [],
        argument: null,
      ),
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
    required String userID,
    required String title,
    required String body
  }){
    return NoteModel(
      title: title,
      body: body,
      id: 'x',
      parties: NoteParties(
        receiverID: userID,
        senderID: Standards.bldrsNotificationSenderID,
        senderImageURL: Standards.bldrsNotificationIconURL,
        senderType: PartyType.bldrs,
        receiverType: PartyType.user,
      ),
      sentTime: DateTime.now(),
      token: 'will be auto adjusted on NoteFireOps.create.adjustToken',
      topic: TopicModel.userGeneralNews,
      // sendNote: true,
      // sendFCM: true,
      navTo: const TriggerModel(
        name: RouteName.myUserNotes,
        done: [],
        argument: null,
      ),    );
  }
  // -----------------------------------------------------------------------------

  /// VALIDATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? receiverVsSenderValidator({
    required PartyType? senderType,
    required PartyType? receiverType,
  }){

    /// USER
    if (receiverType == PartyType.user){

      switch(senderType){
        case PartyType.user     : return null; /// user can receive from user
        case PartyType.bz       : return null; /// user can receive from bz
        case PartyType.bldrs    : return null; /// user can receive from bldrs
        case PartyType.country  : return null; /// user can receive from country
        default: return null;
      }

    }

    /// BZ
    else if (receiverType == PartyType.bz){

      switch(senderType){
        case PartyType.user     : return null; /// bz can receive from user
        case PartyType.bz       : return null; /// bz can receive from bz
        case PartyType.bldrs    : return null; /// bz can receive from bldrs
        case PartyType.country  : return null; /// bz can receive from country
        default: return null;
      }

    }

    /// OTHERWISE
    else {
      return 'receiver can only be a user or a bz';
    }

  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkNotesAreIdentical({
    required NoteModel? note1,
    required NoteModel? note2,
  }){
    bool _areIdentical = false;

    if (note1 == null && note2 == null){
      _areIdentical = true;
    }

    else if (note1 != null && note2 != null){

      if (
      note1.id == note2.id &&
          NoteParties.checkPartiesAreIdentical(parties1: note1.parties, parties2: note2.parties) == true &&
          note1.title == note2.title &&
          note1.body == note2.body &&
          Timers.checkTimesAreIdentical(accuracy: TimeAccuracy.microSecond, time1: note1.sentTime, time2: note2.sentTime) == true &&
          PosterModel.checkPostersAreIdentical(poster1: note1.poster, poster2: note2.poster) == true &&
          PollModel.checkPollsAreIdentical(poll1: note1.poll, poll2: note2.poll) == true &&
          note1.sendFCM == note2.sendFCM &&
          note1.sendNote == note2.sendNote &&
          note1.token == note2.token &&
          note1.topic == note2.topic &&
          TriggerModel.checkTriggersAreIdentical(note1.function, note2.function) == true &&
          TriggerModel.checkTriggersAreIdentical(note1.navTo, note2.navTo) == true &&
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
    required List<NoteModel>? notes1,
    required List<NoteModel>? notes2,
  }){
    bool _areIdentical = true;

    if (Mapper.checkCanLoopList(notes1) == true && Mapper.checkCanLoopList(notes2) == true){

      if (notes1!.length != notes2!.length){
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
      function.hashCode^
      navTo.hashCode^
      seen.hashCode^
      progress.hashCode^
      docSnapshot.hashCode;
  // -----------------------------------------------------------------------------
}
