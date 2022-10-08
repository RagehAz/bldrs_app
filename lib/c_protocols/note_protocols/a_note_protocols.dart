import 'package:bldrs/a_models/b_bz/author_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/e_notes/aa_response_model.dart';
import 'package:bldrs/c_protocols/note_protocols/compose_notes.dart';
import 'package:bldrs/c_protocols/note_protocols/renovate_notes.dart';
import 'package:bldrs/c_protocols/note_protocols/wipe_notes.dart';
import 'package:flutter/material.dart';

class NoteProtocols {
  // -----------------------------------------------------------------------------

  const NoteProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  static Future<void> compose({
    @required BuildContext context,
    @required NoteModel note,
  }) async {

    // final NoteModel _finalNoteModel = note.value.copyWith(
    //   sentTime: DateTime.now(),
    // );
    //
    // final List<NoteModel> _uploadedNotes = await NoteFireOps.createNotes(
    //   context: context,
    //   noteModel: _finalNoteModel,
    //   receiversIDs: receiversIDs.value,
    // );
    //
    // /// TASK : SHOULD VISIT THIS onSendNoteOps thing
    // /// MAYBE SAVE A REFERENCE OF THIS NOTE ID SOMEWHERE ON SUB DOC OF BZ
    // /// TO BE EASY TO TRACE AND DELETE WHILE IN DELETE BZ OPS
    //
    // await NoteLDBOps.insertNotes(_uploadedNotes);

    /// REFERENCE
    // await NoteFireOps.createNote(
    //     context: context,
    //     noteModel: _noteModel
    // );


  }
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  static Future<void> renovate({
    @required BuildContext context,
    @required NoteModel note,
  }) async {

  }
  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------
  static Future<void> wipe({
    @required BuildContext context,
    @required NoteModel note,
  }) async {

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
    //
    // /// DELETE ON FIRESTORE
    // await NoteFireOps.deleteNote(
    //   context: context,
    //   noteID: noteModel.id,
    // );
    //
    // /// DELETE LOCALLY
    // // final List<NoteModel> _newList = NoteModel.removeNoteFromNotes(
    // //   notes: notes.value,
    // //   noteModel: noteModel,
    // // );
    // // notes.value = _newList;


  }
  // -----------------------------------------------------------------------------

  /// CUSTOM

  // --------------------




  /// TESTED : WORKS PERFECT
  static Future<void> sendAuthorshipInvitationNote({
    @required BuildContext context,
    @required BzModel bzModel,
    @required UserModel userModelToSendTo,
  }) => ComposeNoteProtocols.sendAuthorshipInvitationNote(
    context: context,
    bzModel: bzModel,
    userModelToSendTo: userModelToSendTo,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendAuthorshipAcceptanceNote({
    @required BuildContext context,
    @required String bzID,
  }) => ComposeNoteProtocols.sendAuthorshipAcceptanceNote(
    context: context,
    bzID: bzID,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendAuthorRoleChangeNote({
    @required BuildContext context,
    @required String bzID,
    @required AuthorModel author,
  }) => ComposeNoteProtocols.sendAuthorRoleChangeNote(
    context: context,
    bzID: bzID,
    author: author,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendAuthorDeletionNotes({
    @required BuildContext context,
    @required BzModel bzModel,
    @required AuthorModel deletedAuthor,
    @required bool sendToUserAuthorExitNote,
  }) => ComposeNoteProtocols.sendAuthorDeletionNotes(
    context: context,
    bzModel: bzModel,
    deletedAuthor: deletedAuthor,
    sendToUserAuthorExitNote: sendToUserAuthorExitNote,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendBzDeletionNoteToAllAuthors({
    @required BuildContext context,
    @required BzModel bzModel,
    @required bool includeMyself,
  }) => ComposeNoteProtocols.sendBzDeletionNoteToAllAuthors(
    context: context,
    bzModel: bzModel,
    includeMyself: includeMyself,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendFlyerUpdateNoteToItsBz({
    @required BuildContext context,
    @required BzModel bzModel,
    @required String flyerID,
  }) => ComposeNoteProtocols.sendFlyerUpdateNoteToItsBz(
    context: context,
    bzModel: bzModel,
    flyerID: flyerID,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendNoBzContactAvailableNote({
    @required BuildContext context,
    @required BzModel bzModel,
  }) => ComposeNoteProtocols.sendNoBzContactAvailableNote(
    context: context,
    bzModel: bzModel,
  );
  // -----------------------------------------------------------------------------

  /// FETCH

  // --------------------
  ///
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> modifyNoteResponse({
    @required BuildContext context,
    @required NoteModel noteModel,
    @required PollModel pollModel,
  }) => RenovateNoteProtocols.modifyNoteResponse(
    context: context,
    noteModel: noteModel,
    pollModel: pollModel,
  );
  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> cancelSentAuthorshipInvitation({
    @required BuildContext context,
    @required NoteModel note,
  }) => WipeNoteProtocols.cancelSentAuthorshipInvitation(
      context: context,
      note: note
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeNote({
    @required BuildContext context,
    @required NoteModel noteModel,
  }) => WipeNoteProtocols.wipeNote(
      context: context,
      noteModel: noteModel
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeBzReceivedNotes({
    @required BuildContext context,
    @required String bzID,
  }) => WipeNoteProtocols.deleteAllBzReceivedNotes(
    context: context,
    bzID: bzID,
  );
  // --------------------
  ///
  static Future<void> wipeBzSentAuthorshipNotes({
    @required BuildContext context,
    @required String bzID,
  }) => WipeNoteProtocols.wipeBzSentAuthorshipNotes(
      context: context,
      bzID: bzID
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeUserReceivedNotes({
    @required BuildContext context,
    @required String userID,
  }) => WipeNoteProtocols.wipeUserReceivedNotes(
      context: context,
      userID: userID
  );
  // --------------------
}
