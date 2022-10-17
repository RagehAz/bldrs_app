import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/author_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poster_model.dart';
import 'package:bldrs/a_models/e_notes/aa_topic_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/storage.dart';
import 'package:bldrs/e_back_end/f_cloud/cloud_functions.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/note_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
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
  static Future<void> composeToMultiple({
    @required BuildContext context,
    @required NoteModel note,
    @required List<String> receiversIDs,
  }) async {

    if (Mapper.checkCanLoopList(receiversIDs) == true && note != null){

      NoteModel _note = await _uploadNotePoster(
        context: context,
        note: note,
        isPublic: true,
      );

      await Future.wait(<Future>[

        ...List.generate(receiversIDs.length, (index){

          _note = adjustReceiverID(
            note: _note,
            receiverID: receiversIDs[index],
          );

          return NoteProtocols.composeToOneUser(
            context: context,
            note: _note,
            uploadPoster: false,
          );

        }),

      ]);

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> composeToOneUser({
    @required BuildContext context,
    @required NoteModel note,
    bool uploadPoster = true,
  }) async {

    assert(note.parties.receiverID.length > 5, 'Something is wrong with receiverID');
    assert(note.parties.receiverID != 'xxx', 'receiverID is xxx');

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

    }

    else {
      blog('composeToOne : Can not send the note');
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> composeToOneBz({
    @required BuildContext context,
    @required NoteModel note,
    bool uploadPoster = true,
  }) async {

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

    }

    else {
      blog('composeToOne : Can not send the note');
    }


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<NoteModel> _uploadNotePoster({
    @required BuildContext context,
    @required NoteModel note,
    @required bool isPublic,
  }) async {

    NoteModel _output = note;

    if (note != null && note.poster != null){

      if (note.poster.type != PosterType.url){

        /// URL IS NOT DEFINED
        if (note.poster.url == null){

          if (note.poster.file != null){

            List<String> _ownersIDs = <String>['public'];
            if (isPublic == false){

              /// RECEIVER IS BZ
              if (note.parties.receiverType == PartyType.bz){

                final String _bzID = note.parties.senderID;
                final BzModel _bzModel = await BzProtocols.fetchBz(context: context, bzID: _bzID);
                final AuthorModel _creator = AuthorModel.getCreatorAuthorFromBz(_bzModel);
                _ownersIDs = [_creator.userID];

              }

              /// RECEIVER IS USER
              else {
                _ownersIDs = <String>[note.parties.receiverID];
              }


            }


            final String _posterURL = await Storage.createStoragePicAndGetURL(
              inputFile: note.poster.file,
              docName: StorageDoc.posters,
              fileName: Numeric.createUniqueID(maxDigitsCount: 12).toString(),
              ownersIDs: _ownersIDs,
            );

            _output = note.copyWith(
              poster: note.poster.copyWith(
                url: _posterURL,
              ),
            );

          }

        }

        /// URL IS DEFINED
        else {
          // DO NOTHING - keep as is
        }

      }

    }

    _output.blogNoteModel(invoker: '_uploadNotePoster..END');

    return _output;
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

        final UserModel _userModel = await UserProtocols.refetchUser(
          context: context,
          userID: noteModel.parties.receiverID,
        );

        _canReceive = TopicModel.checkUserIsSubscribedToAnyTopic(
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

        final UserModel _user = await UserProtocols.fetchUser(
          context: context,
          userID: noteModel.parties.receiverID,
        );

        blog('_adjustNoteToken : userToken is : ${_user?.fcmToken?.token}');

        if (TextCheck.isEmpty(_user?.fcmToken?.token) == true){
          _note = noteModel.nullifyField(
            token: true,
          );
        }
        else {
          _note = noteModel.copyWith(
            token: _user?.fcmToken?.token,
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
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------

  static Future<void> renovate({
    @required BuildContext context,
    @required NoteModel newNote,
    @required NoteModel oldNote
  }) async {

    final bool _postersAreIdentical = PosterModel.checkPostersAreIdentical(
        poster1: newNote.poster,
        poster2: oldNote.poster,
    );
    assert(_postersAreIdentical == true, 'NoteProtocol.renovate : can not renovate with a new poster');

    NotesProvider.proUpdateNoteEverywhereIfExists(
      context: context,
      noteModel: newNote,
      notify: true,
    );

    await NoteFireOps.updateNote(
      note: newNote,
    );

  }
  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------
  ///
  static Future<void> wipeNote({
    @required BuildContext context,
    @required NoteModel note,
  }) async {

    blog('NoteProtocol.deleteNoteEverywhereProtocol : START');

    /// DELETE POSTER IF EXISTED
    await _wipePoster(
      context: context,
      note: note,
    );


    /// FIRE DELETE
    await NoteFireOps.deleteNote(
      note: note,
    );

    /// PRO DELETE
    NotesProvider.proDeleteNoteEverywhereIfExists(
      context: context,
      noteID: note.id,
      notify: true,
    );

    blog('NoteProtocol.deleteNoteEverywhereProtocol : END');
  }
  // --------------------
  ///
  static Future<void> _wipePoster({
    @required BuildContext context,
    @required NoteModel note,
  }) async {

    if (note != null && note.poster != null){

      if (
          note.poster.type == PosterType.cameraImage
          ||
          note.poster.type == PosterType.galleryImage
      ){

        if (note.poster.url != null){

          final String _picName = await Storage.getImageNameByURL(
            context: context,
            url: note.poster.url,
          );

          if (_picName != null){
            await Storage.deleteStoragePic(
              storageDocName: StorageDoc.posters,
              fileName: _picName,
            );
          }

        }

      }

    }

  }
  // -----------------------------------------------------------------------------
}
