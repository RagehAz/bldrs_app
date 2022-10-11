import 'dart:async';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/x_utilities/error_helpers.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/fire_finder.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/fire_query_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/firestore.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/storage.dart';
import 'package:bldrs/e_back_end/f_cloud/cloud_functions.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/user_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// ------------------------------------------------o
typedef NotiModelsWidgetsBuilder = Widget Function(
    BuildContext context,
    List<NoteModel> notiModels,
    );
/// ------------------------------------------------o
class NoteFireOps {
  // -----------------------------------------------------------------------------

  const NoteFireOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  ///
  static Future<NoteModel> createNote({
    @required BuildContext context,
    @required NoteModel noteModel,
    ValueChanged<NoteModel> onFinished,
  }) async {
    NoteModel _output;

    if (noteModel != null){

      NoteModel _note = await _adjustNoteToken(
          context: context,
          noteModel: noteModel
      );

      _note = await _adjustBldrsLogoURL(
        context: context,
        noteModel: _note,
      );

      Mapper.blogMap( _note.toMap(toJSON: true), invoker: 'fuck the fucking map');

      await Fire.createDoc(
        context: context,
        collName: FireColl.notes,
        input: _note.toMap(toJSON: false),
        onFinish: (DocumentReference ref){
          _output = _note.copyWith(id: ref.id,);
        },
      );

      blog('createNote : _note.sendFCM : ${_output.sendFCM} : _note.token : ${_output.token}');

      /// returns true on success and false of failure
      if (_output.sendFCM == true && _output.token != null) {
        await CloudFunction.call(
            context: context,
            functionName: CloudFunction.callSendFCMToDevice,
            mapToPass: _output.toMap(toJSON: true),
            onFinish: (dynamic result){
              blog('NoteFireOps.createNote : FCM SENT : $result');
            }
        );
      }

    if (onFinished != null){
        onFinished(_output);
      }

    }

    return _output;
  }
  // --------------------
  ///
  static Future<List<NoteModel>> createNotes({
    @required BuildContext context,
    @required NoteModel noteModel,
    @required List<String> receiversIDs,
  }) async {

    final List<NoteModel> _output = <NoteModel>[];
    bool _success = false;

    if (noteModel != null && Mapper.checkCanLoopList(receiversIDs) == true){

      await Future.wait(<Future>[

        ...List.generate(receiversIDs.length, (index){

          final NoteModel _note = noteModel.copyWith(
            parties: noteModel.parties.copyWith(
              receiverID: receiversIDs[index],
            ),
          );

          return createNote(
            context: context,
            noteModel: _note,
            onFinished: (NoteModel uploaded){
              _output.add(uploaded);
            }
          );

        }),

      ]);

      _success = true;
    }

    return _success == true ? _output : null;
  }
  // --------------------
  ///
  static Future<NoteModel> _adjustNoteToken({
    @required BuildContext context,
    @required NoteModel noteModel,
  }) async {
    NoteModel _note = noteModel;

    if (noteModel != null){

      if (noteModel.parties.receiverType == NotePartyType.user){

        final UserModel _user = await UserFireOps.readUser(
            context: context,
            userID: noteModel.parties.receiverID,
        );

        blog('_adjustNoteToken : userToken is : ${_user?.fcmToken?.token}');

        if (TextCheck.isEmpty(_user?.fcmToken?.token) == true){
          _note = _note.nullifyField(
            token: true,
          );
        }
        else {
          _note = _note.copyWith(
            token: _user?.fcmToken?.token,
          );
        }


      }

    }

    return _note;
  }
  // --------------------
  ///
  static Future<NoteModel> _adjustBldrsLogoURL({
    @required BuildContext context,
    @required NoteModel noteModel,
  }) async {
    NoteModel _note;

    blog('_adjustBldrsLogoURL : noteModel.token : ${noteModel.token}');

    if (noteModel != null){

      /// ADJUST IMAGE IF SENDER IS BLDRS
      if (noteModel.parties.senderID == NoteParties.bldrsSenderID){

        final String _bldrsNotificationIconURL = await Storage.getImageURLByPath(
            context: context,
            storageDocName: 'admin',
            fileName: NoteParties.bldrsFCMIconFireStorageFileName,
        );

        _note = noteModel.copyWith(
          parties: noteModel.parties.copyWith(
            senderImageURL: _bldrsNotificationIconURL ?? NoteParties.bldrsLogoStaticURL,
          ),
        );

      }

      /// KEEP IT AS IS
      else {
        _note = noteModel.copyWith();
      }

    }

    return _note;
  }
  // -----------------------------------------------------------------------------

  /// ALL NOTES PAGINATION

  // --------------------
  ///
  static Future<List<NoteModel>> readReceivedNotes({
    @required BuildContext context,
    @required String recieverID,
    @required NotePartyType receiverType,
    int limit = 10,
    QueryDocumentSnapshot<Object> startAfter,
    QueryOrderBy orderBy,
  }) async {

    final List<Map<String, dynamic>> _maps = await Fire.readCollectionDocs(
      context: context,
      collName: FireColl.notes,
      limit: limit,
      addDocsIDs: true,
      orderBy: orderBy,
      startAfter: startAfter,
      addDocSnapshotToEachMap: true,
      finders: <FireFinder>[

        FireFinder(
          field: 'receiverID',
          comparison: FireComparison.equalTo,
          value: recieverID,
        ),

        FireFinder(
          field: 'receiverType',
          comparison: FireComparison.equalTo,
          value: NoteParties.cipherNoteSenderOrRecieverType(receiverType),
        ),

      ],
    );

    final List<NoteModel> _notes = NoteModel.decipherNotes(
      maps: _maps,
      fromJSON: false,
    );

    return _notes;
  }
  // --------------------
  ///
  static Future<List<NoteModel>> paginateAllSentNotes({
    @required BuildContext context,
    @required String senderID,
    @required int limit,
    @required QueryDocumentSnapshot<Object> startAfter,
  }) async {

    List<NoteModel> _notes = <NoteModel>[];

    if (senderID != null){

      final List<Map<String, dynamic>> _maps = await Fire.readCollectionDocs(
        context: context,
        collName: FireColl.notes,
        // startAfter: startAfter,
        // orderBy: 'sentTime',
        addDocsIDs: true,
        addDocSnapshotToEachMap: true,
        // limit: limit,
        finders: <FireFinder>[
          FireFinder(
            field: 'senderID',
            comparison: FireComparison.equalTo,
            value: senderID,
          ),
        ],
      );

      Mapper.blogMaps(_maps, methodName: 'paginateAllSentNotes');

      if (Mapper.checkCanLoopList(_maps) == true){

        _notes = NoteModel.decipherNotes(
          maps: _maps,
          fromJSON: false,
        );

      }

    }

    return _notes;
  }
  // --------------------
  ///
  static Future<List<NoteModel>> paginateAllReceivedNotes({
    @required BuildContext context,
    @required String recieverID,
    @required int limit,
    @required QueryDocumentSnapshot<Object> startAfter,
  }) async {

    List<NoteModel> _notes = <NoteModel>[];

    if (recieverID != null){

      final List<Map<String, dynamic>> _maps = await Fire.readCollectionDocs(
        context: context,
        collName: FireColl.notes,
        startAfter: startAfter,
        orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
        addDocsIDs: true,
        addDocSnapshotToEachMap: true,
        limit: limit,
        finders: <FireFinder>[
          FireFinder(
            field: 'recieverID',
            comparison: FireComparison.equalTo,
            value: recieverID,
          ),
        ],
      );

      if (Mapper.checkCanLoopList(_maps) == true){

        _notes = NoteModel.decipherNotes(
          maps: _maps,
          fromJSON: false,
        );

      }

    }

    return _notes;
  }
  // -----------------------------------------------------------------------------

  /// STREAMING

  // --------------------
  ///
  static Stream<List<NoteModel>> getNoteModelsStream({
    @required BuildContext context,
    QueryDocumentSnapshot<Object> startAfter,
    int limit,
    QueryOrderBy orderBy,
    List<FireFinder> finders,
  }) {

    Stream<List<NoteModel>> _notiModelsStream;

    tryAndCatch(
        context: context,
        methodName: 'getNoteModelsStream',
        functions: () {

          final Stream<QuerySnapshot<Object>> _querySnapshots = Fire.streamCollection(
            queryModel: FireQueryModel(
                collRef: Fire.createSuperCollRef(aCollName: FireColl.notes),
                startAfter: startAfter,
                limit: limit,
                orderBy: orderBy,
                finders: finders,
                onDataChanged: (List<Map<String, dynamic>> maps){
                  blog('getNoteModelsStream : onDataChanged : ${maps.length} maps');
                }
            ),
          );

          blog('x getNotiModelsStream : _querySnapshots : $_querySnapshots : id : ${_querySnapshots.first}');

          _notiModelsStream = _querySnapshots.map((QuerySnapshot<Object> querySnapshot){

            final List<Map<String, dynamic>> _maps = Mapper.getMapsFromQueryDocumentSnapshotsList(
              queryDocumentSnapshots: querySnapshot.docs,
              addDocsIDs: true,
              addDocSnapshotToEachMap: true,
            );

            final List<NoteModel> _notes = NoteModel.decipherNotes(
                maps: _maps,
                fromJSON: false
            );

            return _notes;
          });

          blog('getNotiModelsStream : _notiModelsStream : $_notiModelsStream');
        });

    return _notiModelsStream;
  }
  // --------------------

  /// UPDATE

  // --------------------
  ///
  static Future<void> updateNote({
    @required BuildContext context,
    @required NoteModel newNoteModel,
  }) async {

    if (newNoteModel != null){
      await Fire.updateDoc(
        context: context,
        collName: FireColl.notes,
        docName: newNoteModel.id,
        input: newNoteModel.toMap(toJSON: false),
      );
    }

  }
  // --------------------
  ///
  static Future<void> markNoteAsSeen({
    @required BuildContext context,
    @required NoteModel noteModel,
  }) async {

    if (noteModel.seen != true){

      final NoteModel _updatedNote = noteModel.copyWith(
        seen: true,
        // seenTime: DateTime.now(),
      );

      await updateNote(
        context: context,
        newNoteModel: _updatedNote,
      );

    }


  }
  // --------------------
  ///
  static Future<void> markNotesAsSeen({
    @required BuildContext context,
    @required List<NoteModel> notes,
  }) async {

    if (Mapper.checkCanLoopList(notes) == true){

      /// MARK ON FIREBASE
      for (final NoteModel note in notes){
        unawaited(markNoteAsSeen(
          context: context,
          noteModel: note,
        ));
      }


    }

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  ///
  static Future<void> deleteNote({
    @required BuildContext context,
    @required String noteID,
  }) async {

    if (noteID != null){

      await Fire.deleteDoc(
        context: context,
        collName: FireColl.notes,
        docName: noteID,
      );

    }

  }
  // --------------------
  ///
  static Future<void> deleteNotes({
    @required BuildContext context,
    @required List<NoteModel> notes,
  }) async {

    if (Mapper.checkCanLoopList(notes) == true){

      for (final NoteModel note in notes){

        await deleteNote(
          context: context,
          noteID: note.id,
        );

      }

    }

  }
  // --------------------
  ///
  static Future<void> deleteAllReceivedNotes({
    @required BuildContext context,
    @required String receiverID,
    @required NotePartyType receiverType,
  }) async {

    /// TASK : VERY DANGEROUS : SHOULD BE BY A CLOUD FUNCTION

    final List<NoteModel> _notesToDelete = <NoteModel>[];

    /// READ ALL NOTES
    for (int i = 0; i <= 500; i++){
      final List<NoteModel> _notes = await readReceivedNotes(
        context: context,
        // limit: 10,
        receiverType: receiverType,
        recieverID: receiverID,
        startAfter: _notesToDelete.isNotEmpty == true ? _notesToDelete?.last?.docSnapshot : null,
      );

      if (Mapper.checkCanLoopList(_notes) == true){
        _notesToDelete.addAll(_notes);
      }

      else {
        break;
      }

    }

    /// DELETE ALL NOTES
    if (Mapper.checkCanLoopList(_notesToDelete) == true){

      await deleteNotes(
        context: context,
        notes: _notesToDelete,
      );

    }

  }
  // --------------------
}
/// ------------------------------------------------o
