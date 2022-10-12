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
import 'package:bldrs/f_helpers/drafters/stringers.dart';
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

      final NoteModel _noteWithUpdatedPoster = await _uploadNotePoster(
        context: context,
        note: note,
      );

      await Future.wait(<Future>[

        ...List.generate(receiversIDs.length, (index){

          final String _receiverID = receiversIDs[index];

          final NoteModel _note = _noteWithUpdatedPoster.copyWith(
            parties: note.parties.copyWith(
              receiverID: _receiverID,
            ),
          );

          return NoteProtocols.composeToOne(
            context: context,
            note: _note,
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
  }) async {

    assert(note.parties.receiverID.length > 5, 'Something is wrong with receiverID');

    final bool _canSendNote = NoteModel.checkCanSendNote(note);

    if (_canSendNote == true){

      /// UPLOAD POSTER
      NoteModel _note = await _uploadNotePoster(
        context: context,
        note: note,
      );

      _note = await _adjustBldrsLogoURL(
        context: context,
        noteModel: _note,
      );

      _note = note.copyWith(
        sentTime: DateTime.now(),
      );

      _note = await NoteFireOps.createNote(
        context: context,
        noteModel: _note,
      );

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

  static Future<NoteModel> _uploadNotePoster({
    @required BuildContext context,
    @required NoteModel note,
  }) async {

    NoteModel _output = note;

    if (note != null && note.poster != null){

      if (note.poster.type != PosterType.url){

        /// URL IS NOT DEFINED
        if (note.poster.url == null){

          if (note.poster.file != null){

            List<String> _ownersIDs = <String>[];

            /// ADD BZ CREATOR ID TO NOTE
            if (note.parties.senderType == NotePartyType.bz){
              final String _bzID = note.parties.senderID;
              final BzModel _bzModel = await BzProtocols.fetchBz(context: context, bzID: _bzID);
              final AuthorModel _creator = AuthorModel.getCreatorAuthorFromBz(_bzModel);
              _ownersIDs = Stringer.addStringToListIfDoesNotContainIt(
                strings: _ownersIDs,
                stringToAdd: _creator.userID,
              );
            }

            else {
              _ownersIDs = <String>[note.parties.senderID];
            }

            final String _posterURL = await Storage.createStoragePicAndGetURL(
              context: context,
              inputFile: note.poster.file,
              docName: StorageDoc.posters,
              fileName: Numeric.createUniqueID(maxDigitsCount: 12).toString(),
              ownersIDs: _ownersIDs,
            );

            _output = _output.copyWith(
              poster: _output.poster.copyWith(
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

    return _output;
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

        if (_note.token != null) {
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
      context: context,
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

    // /// DELETE ATTACHMENT IF IMAGE
    // if (noteModel.posterType == NoteAttachmentType.image){
    //
    //   final String _picName = await Storage.getImageNameByURL(
    //     context: context,
    //     url: noteModel.model,
    //   );
    //
    //   await Storage.deleteStoragePic(
    //     context: context,
    //     storageDocName: StorageDoc.notesBanners,
    //     fileName: _picName,
    //   );
    //
    // }

    /// FIRE DELETE
    await NoteFireOps.deleteNote(
      context: context,
      noteID: note.id,
    );

    /// PRO DELETE
    NotesProvider.proDeleteNoteEverywhereIfExists(
      context: context,
      noteID: note.id,
      notify: true,
    );

    blog('NoteProtocol.deleteNoteEverywhereProtocol : END');
  }
  // -----------------------------------------------------------------------------
}
