import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/j_poster/poster_model.dart';
import 'package:bldrs/a_models/e_notes/aa_topic_model.dart';
import 'package:bldrs/c_protocols/note_protocols/fire/note_fire_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:fire/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
import 'package:bldrs/e_back_end/f_cloud/cloud_functions.dart';
import 'package:mapper/mapper.dart';
import 'package:numeric/numeric.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class NoteProtocols {
  // -----------------------------------------------------------------------------

  const NoteProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  ///
  static Future<void> composeToMultipleShallDoThisLaterWhenTheTimeIsRightButNowIHaveMouthsToFeed({
    @required BuildContext context,
    @required NoteModel note,
    @required List<String> receiversIDs,
  }) async {

    blog('should compose note to multiple receivers');

    // if (Mapper.checkCanLoopList(receiversIDs) == true && note != null){
    //
    //   NoteModel _note = await _uploadNotePoster(
    //     context: context,
    //     note: note,
    //     isPublic: true,
    //   );
    //
    //   await Future.wait(<Future>[
    //
    //     ...List.generate(receiversIDs.length, (index){
    //
    //       _note = adjustReceiverID(
    //         note: _note,
    //         receiverID: receiversIDs[index],
    //       );
    //
    //       return NoteProtocols.composeToOneUser(
    //         context: context,
    //         note: _note,
    //         uploadPoster: false,
    //       );
    //
    //     }),
    //
    //   ]);
    //
    // }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<NoteModel> composeToOneReceiver({
    @required BuildContext context,
    @required NoteModel note,
    bool uploadPoster = true,
  }) async {

    NoteModel _output;

    assert(note.parties.receiverID.length > 5, 'Something is wrong with receiverID');
    assert(note.parties.receiverID != 'xxx', 'receiverID is xxx');
    assert(note.parties.receiverID != null, 'noteModel.parties.receiverID == null');
    assert(note.parties.receiverType != null, 'noteModel.parties.receiverType == null');
    assert(note.parties.senderID != null, 'noteModel.parties.senderID == null');
    assert(note.parties.senderType != null, 'noteModel.parties.senderType == null');
    assert(note.parties.senderImageURL != null, 'noteModel.parties.senderImageURL == null');
    assert(note.title != null, 'noteModel.title == null');
    assert(note.body != null, 'noteModel.body == null');
    assert(note.topic != null, 'noteModel.topic == null');
    assert(note.sendNote == true || note.sendFCM == true, 'noteModel.sendNote == true || noteModel.sendFCM == true');

    final bool _canSendNote = NoteModel.checkNoteIsSendable(note);

    if (_canSendNote == true){

      NoteModel _note = note;

      /// UPLOAD POSTER
      if (uploadPoster == true){
        _note = await _uploadNotePoster(
          context: context,
          note: _note,
          isPublic: false,
        );
      }

      /// MAKE SURE TOPIC IS ADJUSTED
      _note = _rebakeTopic(_note);

      /// UPDATE SENT TIME
      _note = _note.copyWith(
        sentTime: DateTime.now(),
      );

      /// CREATE NOTE FIRE OPS
      _note = await NoteFireOps.createNote(
        noteModel: _note,
      );


      /// SEND FCM
      await _sendFCMToOneReceiver(
        context: context,
        noteModel: _note,
      );

      _output = _note;
    }

    else {
      blog('composeToOne : Can not send the note');
    }

    return _output;
  }
  // --------------------
  /// DEPRECATED
  /*
  /// TESTED : WORKS PERFECT
  static Future<void> composeToOneBz({
    @required BuildContext context,
    @required NoteModel note,
    bool uploadPoster = true,
  }) async {

    // final bool _canSendNote = NoteModel.checkNoteIsSendable(note);
    //
    // if (_canSendNote == true){

      // NoteModel _note = note;

      // /// UPLOAD POSTER
      // if (uploadPoster == true){
      //   _note = await _uploadNotePoster(
      //     context: context,
      //     note: _note,
      //     isPublic: false,
      //   );
      // }

      // /// MAKE SURE TOPIC IS ADJUSTED
      // _note = _rebakeTopic(_note);

      // /// UPDATE SENT TIME
      // _note = _note.copyWith(
      //   sentTime: DateTime.now(),
      // );

      // /// CREATE NOTE FIRE OPS
      // _note = await NoteFireOps.createNote(
      //   noteModel: _note,
      // );

      // /// SEND FCM
      // await _sendFCMToOneReceiver(
      //   context: context,
      //   noteModel: _note,
      // );

    // }
    //
    // else {
    //   blog('composeToOne : Can not send the note');
    // }

  }

   */
  // --------------------
  /// TASK : FIX ME
  static Future<NoteModel> _uploadNotePoster({
    @required BuildContext context,
    @required NoteModel note,
    @required bool isPublic,
  }) async {

    // NoteModel _output = note;
    //
    // if (note != null && note.poster != null){
    //
    //   if (note.poster.type != PosterType.url){
    //
    //     /// URL IS NOT DEFINED
    //     if (note.poster.url == null){
    //
    //       if (note.poster.file != null){
    //
    //         List<String> _ownersIDs = <String>['public'];
    //         if (isPublic == false){
    //
    //           /// RECEIVER IS BZ
    //           if (note.parties.receiverType == PartyType.bz){
    //
    //             final String _bzID = note.parties.senderID;
    //             final BzModel _bzModel = await BzProtocols.fetch(context: context, bzID: _bzID);
    //             final AuthorModel _creator = AuthorModel.getCreatorAuthorFromAuthors(_bzModel.authors);
    //             _ownersIDs = [_creator.userID];
    //
    //           }
    //
    //           /// RECEIVER IS USER
    //           else {
    //             _ownersIDs = <String>[note.parties.receiverID];
    //           }
    //
    //         }
    //
    //
    //         final String _posterURL = await Storage.createStoragePicAndGetURL(
    //           inputFile: note.poster.file,
    //           collName: StorageColl.posters,
    //           docName: Numeric.createUniqueID(maxDigitsCount: 12).toString(),
    //           ownersIDs: _ownersIDs,
    //         );
    //
    //         _output = note.copyWith(
    //           poster: note.poster.copyWith(
    //             url: _posterURL,
    //           ),
    //         );
    //
    //       }
    //
    //     }
    //
    //     /// URL IS DEFINED
    //     else {
    //       // DO NOTHING - keep as is
    //     }
    //
    //   }
    //
    // }
    //
    // _output.blogNoteModel(invoker: '_uploadNotePoster..END');
    //
    return note;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static NoteModel adjustReceiverID({
    @required String receiverID,
    @required NoteModel note,
  }){

    return note.copyWith(
      parties: note.parties.copyWith(
        receiverID: receiverID,
      ),
    );


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _sendFCMToOneReceiver({
    @required BuildContext context,
    @required NoteModel noteModel,
  }) async {

    if (noteModel != null && noteModel.sendFCM == true){

      NoteModel _note = noteModel;
      if (noteModel.sendNote == false){
        _note = noteModel.copyWith(
          id: Numeric.createUniqueID().toString(),
        );
      }

      final bool _receiverCanReceive = await _checkReceiverCanReceiveFCM(
        context: context,
        noteModel: _note,
      );

      if (_receiverCanReceive == true){

        final NoteModel _note = await _adjustNoteToken(
            context: context,
            noteModel: noteModel
        );

        /// USER RECEIVER : SEND TO DEVICE
        if (noteModel.parties.receiverType == PartyType.user){

          if (_note.token != null) {

            blog('should send TO DEVICE aho note to ${_note.parties.receiverID}');

            await CloudFunction.call(
                context: context,
                functionName: CloudFunction.callSendFCMToDevice,
                mapToPass: _note.toMap(toJSON: true),
                onFinish: (dynamic result){
                  blog('NoteFireOps.createNote : FCM SENT : $result');
                }
            );

          }

        }

        /// BZ RECEIVER : SEND TO TOPIC
        if (noteModel.parties.receiverType == PartyType.bz){

          blog('should send TO DEVICE aho note to ${_note.parties.receiverID}');

          await CloudFunction.call(
              context: context,
              functionName: CloudFunction.callSendFCMToTopic,
              mapToPass: _note.toMap(toJSON: true),
              onFinish: (dynamic result){
                blog('NoteFireOps.createNote : FCM SENT : $result');
              }
          );


        }


      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> _checkReceiverCanReceiveFCM({
    @required BuildContext context,
    @required NoteModel noteModel,
  }) async {
    bool _canReceive = false;

    if (noteModel != null && noteModel.sendFCM == true){

      /// RECEIVER IS USER
      if (noteModel.parties.receiverType == PartyType.user){

        final UserModel _userModel = await UserProtocols.refetch(
          context: context,
          userID: noteModel.parties.receiverID,
        );

        _canReceive = TopicModel.checkUserIsSubscribedToThisTopic(
          context: context,
          topicID: noteModel.topic,
          partyType: PartyType.user,
          bzID: null,
          userModel: _userModel,
        );
      }

      /// RECEIVER IS BZ
      else if (noteModel.parties.receiverType == PartyType.bz){

        /// BZ AUTHORS SHOULD BE SUBSCRIBED OR NOT TO THE TOPIC
        /// AND BZ RECEIVES THIS NOTE
        _canReceive = true;
      }

    }

    return _canReceive;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<NoteModel> _adjustNoteToken({
    @required BuildContext context,
    @required NoteModel noteModel,
  }) async {
    NoteModel _note = noteModel;

    if (noteModel != null){

      /// USER RECEIVER : INJECT USER TOKEN IN NOTE
      if (noteModel.parties.receiverType == PartyType.user){

        final UserModel _user = await UserProtocols.fetch(
          context: context,
          userID: noteModel.parties.receiverID,
        );

        blog('_adjustNoteToken : userToken is : ${_user?.device?.token}');

        if (TextCheck.isEmpty(_user?.device?.token) == true){
          _note = noteModel.nullifyField(
            token: true,
          );
        }
        else {
          _note = noteModel.copyWith(
            token: _user?.device?.token,
          );
        }


      }

      /// BZ RECEIVED : WILL SEND TO TOPIC NOT TO DEVICE
      if (noteModel.parties.receiverType == PartyType.bz){

        _note = noteModel.nullifyField(
          token: true,
        );

      }

    }

    return _note;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static NoteModel _rebakeTopic(NoteModel note){

    if (note.parties.receiverType == PartyType.user){
      return note;
    }

    else {

      final bool _isBakedAlready = TextCheck.stringContainsSubString(
          string: note.topic,
          subString: '_') == true;

      if (_isBakedAlready == true){
        return note;
      }

      else {

        final String _bakedTopicID = TopicModel.bakeTopicID(
          topicID: note.topic,
          bzID: note.parties.receiverID,
          receiverPartyType: PartyType.bz,
        );

        return note.copyWith(
          topic: _bakedTopicID,
        );
      }


    }

  }
  // -----------------------------------------------------------------------------

  /// READ ( no fetching for now ,, maybe later in life when things get happier)

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<NoteModel> readNote({
    @required String noteID,
    @required String userID,
  }) async {

    final NoteModel _note = await NoteFireOps.readNote(
      noteID: noteID,
      userID: userID,
    );

    return _note;
  }
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> renovate({
    @required BuildContext context,
    @required NoteModel newNote,
    @required NoteModel oldNote
  }) async {

    if (newNote != null && oldNote != null){

      final bool _postersAreIdentical = PosterModel.checkPostersAreIdentical(
        poster1: newNote.poster,
        poster2: oldNote.poster,
      );
      assert(_postersAreIdentical == true, 'NoteProtocol.renovate : can not renovate with a new poster');

      await NoteFireOps.updateNote(
        note: newNote,
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------
  ///
  static Future<void> wipeNote({
    @required NoteModel note,
  }) async {

    blog('NoteProtocol.wipeNote : noteID : ${note.id}: START');

    /// DELETE POSTER IF EXISTED
    await _wipePoster(
      note: note,
    );


    /// FIRE DELETE
    await NoteFireOps.deleteNote(
      note: note,
    );

    /// DEPRECATED
    // /// PRO DELETE
    // NotesProvider.proDeleteNoteEverywhereIfExists(
    //   context: context,
    //   noteID: note.id,
    //   notify: true,
    // );

    blog('NoteProtocol.wipeNote : END');
  }
  // --------------------
  /// TASK : DO THIS POSTER THING
  static Future<void> _wipePoster({
    @required NoteModel note,
  }) async {

    // if (note != null && note.poster != null){
    //
    //   if (
    //       note.poster.type == PosterType.cameraImage
    //       ||
    //       note.poster.type == PosterType.galleryImage
    //   ){
    //
    //     if (note.poster.url != null){
    //
    //       final String _picName = await Storage.getImageNameByURL(
    //         url: note.poster.url,
    //       );
    //
    //       if (_picName != null){
    //         await Storage.deleteStoragePic(
    //           collName: StorageColl.posters,
    //           docName: _picName,
    //         );
    //       }
    //
    //     }
    //
    //   }
    //
    // }

  }
  // --------------------
  /// VERY VERY EXPENSIVE : TASK : OPTIMIZE THIS IN FUTURE : DEVICE WILL EXPLODE HERE
  static Future<void> wipeAllNotes({
    @required PartyType partyType,
    @required String id,
  }) async {

    /// TASK : DELETE ALL NOTES PROTO FUCKING COLE
    blog('should wipe all notes in this shit');

    if (id != null){

      final List<NoteModel> _notesToDelete = <NoteModel>[];

      /// READ ALL NOTES
      for (int i = 0; i <= 1000; i++){
        final List<Map<String, dynamic>> _maps = await Fire.readSubCollectionDocs(
          limit: 10,
          collName: FireColl.getPartyCollName(partyType),
          docName: id,
          subCollName: FireSubColl.noteReceiver_receiver_notes,
          addDocsIDs: true,
          addDocSnapshotToEachMap: true,
          startAfter: _notesToDelete.isEmpty == true ? null : _notesToDelete?.last?.docSnapshot,
        );

        if (Mapper.checkCanLoopList(_maps) == true){

          final List<NoteModel> _notes = NoteModel.decipherNotes(
            maps: _maps,
            fromJSON: false,
          );

          _notesToDelete.addAll(_notes);

        }

        else {
          break;
        }

      }

      /// DELETE ALL NOTES
      if (Mapper.checkCanLoopList(_notesToDelete) == true){

        await Future.wait(<Future>[

          ...List.generate(_notesToDelete.length, (index){

            return wipeNote(
                note: _notesToDelete[index],
            );

        }),

        ]);


      }

    }


  }
  // -----------------------------------------------------------------------------

  /// TOPIC SUBSCRIPTION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> subscribeToAllBzTopics({
    @required BuildContext context,
    @required String bzID,
    @required bool renovateUser,
  }) async {

    if (bzID != null){

      final List<String> bzTopics = TopicModel.getAllPossibleBzTopicsIDs(
        bzID: bzID,
      );

      await Future.wait(<Future>[

        /// RENOVATE USER MODEL FCM TOPICS FIELD
        if (renovateUser == true)
          _addAllBzTopicsToMyTopicsAndRenovate(
            context: context,
            bzID: bzID,
          ),

        /// SUBSCRIBE TO FCM TOPICS
        ...List.generate(bzTopics.length, (index){

          return FCM.subscribeToTopic(
            topicID: bzTopics[index],
          );

      }),



      ]);

    }


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _addAllBzTopicsToMyTopicsAndRenovate({
    @required BuildContext context,
    @required String bzID,
  }) async {

    final UserModel _oldUser = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    if (_oldUser != null){

      final UserModel _newUser = UserModel.addAllBzTopicsToMyTopics(
          oldUser: _oldUser,
          bzID: bzID
      );

      await UserProtocols.renovate(
        context: context,
        newPic: null,
        newUser: _newUser,
        oldUser: _oldUser,
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> unsubscribeFromAllBzTopics({
    @required BuildContext context,
    @required String bzID,
    @required bool renovateUser,
  }) async {

    if (bzID != null){

      final List<String> bzTopics = TopicModel.getAllPossibleBzTopicsIDs(
        bzID: bzID,
      );

      await Future.wait(<Future>[

        /// RENOVATE USER MODEL
        if (renovateUser == true)
          _removeAllBzTopicsFromMyTopicsAndRenovate(
            context: context,
            bzID: bzID,
          ),

        /// FCM : UNSUBSCRIBE TO TOPICS
        ...List.generate(bzTopics.length, (index){
          return FCM.unsubscribeFromTopic(
            topicID: bzTopics[index],
          );
        }),

      ]);

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _removeAllBzTopicsFromMyTopicsAndRenovate({
    @required BuildContext context,
    @required String bzID,
  }) async {

    final UserModel _oldUser = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    if (_oldUser != null) {

      final UserModel _newUser = UserModel.removeAllBzTopicsFromMyTopics(
          oldUser: _oldUser,
          bzID: bzID
      );

      await UserProtocols.renovate(
        context: context,
        newPic: null,
        newUser: _newUser,
        oldUser: _oldUser,
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> unsubscribeFromAllBzzTopics({
    @required BuildContext context,
    @required List<String> bzzIDs,
    @required bool renovateUser,
  }) async {

    if (Mapper.checkCanLoopList(bzzIDs) == true){

      await Future.wait(<Future>[

        ...List.generate(bzzIDs.length, (index) {

          return unsubscribeFromAllBzTopics(
            context: context,
            bzID: bzzIDs[index],
            renovateUser: renovateUser,
          );

        }),

      ]);

    }

  }
  // -----------------------------------------------------------------------------
}
