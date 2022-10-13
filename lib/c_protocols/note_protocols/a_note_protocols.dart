import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/author_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poll_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poster_model.dart';
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

          return NoteProtocols.composeToOne(
            context: context,
            note: _note,
            uploadPoster: false,
          );

        }),

      ]);

    }

  }
  // --------------------
  ///
  static Future<void> composeToOne({
    @required BuildContext context,
    @required NoteModel note,
    bool uploadPoster = true,
  }) async {

    assert(note.parties.receiverID.length > 5, 'Something is wrong with receiverID');
    assert(note.parties.receiverID != 'xxx', 'receiverID is xxx');

    final bool _canSendNote = NoteModel.checkCanSendNote(note);

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
      await _sendNoteFCM(
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
              if (note.parties.receiverType == NotePartyType.bz){

                final String _bzID = note.parties.senderID;
                final BzModel _bzModel = await BzProtocols.fetchBz(context: context, bzID: _bzID);
                final AuthorModel _creator = AuthorModel.getCreatorAuthorFromBz(_bzModel);
                _ownersIDs = [_bzID, _creator.userID];

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
  /// TESTED :
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
  ///
  static Future<void> _sendNoteFCM({
    @required BuildContext context,
    @required NoteModel noteModel,
  }) async {

    if (noteModel != null){

      final bool _canSendFCM = await _checkReceiverCanReceiveFCM(
        context: context,
        noteModel: noteModel,
      );

      if (_canSendFCM == true){

        final NoteModel _note = await _adjustNoteToken(
            context: context,
            noteModel: noteModel
        );

        _note.blogNoteModel(invoker: '_sendNoteFCM.afterTokenAdjustment');

        if (_note.token != null) {

          blog('should send aho note to ${_note.parties.receiverID}');

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



    }

  }
  // --------------------
  ///
  static Future<bool> _checkReceiverCanReceiveFCM({
    @required BuildContext context,
    @required NoteModel noteModel,
  }) async {
    bool _canReceive = false;

    if (noteModel != null){

      if (noteModel.sendFCM == false){
        _canReceive = false;
      }
      else {

        // if (noteModel.parties.receiverType == NotePartyType.user){
          // final UserModel _userModel = await UserProtocols.fetchUser(
          //   context: context,
          //   userID: noteModel.parties.receiverID,
          // );
        // }
        // else if (noteModel.parties.receiverType == NotePartyType.bz){
          // final BzModel _bzModel = await BzProtocols.fetchBz(
          //   context: context,
          //   bzID: noteModel.parties.receiverID,
          // );
        // }

        /// TASK : NEED TO MAKE A SETTINGS PREFERENCE MAP TO KNOW IF PROFILE
        /// HAD OPTED TO RECEIVING THIS TYPE OF FCM OR NOT
        _canReceive = true;

      }

    }

    return _canReceive;
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

        final UserModel _user = await UserProtocols.refetchUser(
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

      _note.blogNoteModel(invoker: '_adjustNoteToken.in');

    }


    return _note;
  }
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------

  static Future<void> renovate({
    @required BuildContext context,
    @required NoteModel note,
  }) async {

  }
  // --------------------
  ///
  static Future<void> modifyNoteResponse({
    @required BuildContext context,
    @required NoteModel note,
    @required PollModel pollModel,
  }) async {
    blog('RenovateNoteProtocols.modifyNoteResponse : START');

    final NoteModel _newNoteModel = note.copyWith(
      poll: pollModel,
      // responseTime: DateTime.now(),
    );

    NotesProvider.proUpdateNoteEverywhereIfExists(
      context: context,
      noteModel: _newNoteModel,
      notify: true,
    );

    await NoteFireOps.updateNote(
      newNoteModel: _newNoteModel,
    );

    blog('RenovateNoteProtocols.modifyNoteResponse : END');
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
