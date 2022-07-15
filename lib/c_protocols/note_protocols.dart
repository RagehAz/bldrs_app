import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as AuthFireOps;
import 'package:bldrs/e_db/fire/ops/note_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:flutter/material.dart';

class NoteProtocols {

  NoteProtocols();

// -----------------------------------------------------------------------------

/// CREATE

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendAuthorshipInvitationNote({
    @required BuildContext context,
    @required BzModel bzModel,
    @required UserModel userModelToSendTo,
  }) async {

    final AuthorModel _myAuthorModel = AuthorModel.getAuthorFromBzByAuthorID(
      bz: bzModel,
      authorID: AuthFireOps.superUserID(),
    );

    /// TASK : SHOULD SEND NOTE WITH SELECTED USER'S LANG

    final NoteModel _note = NoteModel(
      id: null, // will be defined in note create fire ops
      senderID: bzModel.id, /// HAS TO BE BZ ID NOT AUTHOR ID
      senderImageURL: _myAuthorModel.pic,
      noteSenderType: NoteSenderType.bz,
      receiverID: userModelToSendTo.id,
      receiverType: NoteReceiverType.user,
      title: 'Business Account Invitation',
      body: "'${_myAuthorModel.name}' sent you an invitation to become an Author for '${bzModel.name}' business page",
      metaData: NoteModel.defaultMetaData,
      sentTime: DateTime.now(),
      attachment: bzModel.id,
      attachmentType: NoteAttachmentType.bzID,
      seen: false,
      seenTime: null,
      sendFCM: true,
      noteType: NoteType.authorship,
      response: NoteResponse.pending,
      responseTime: null,
      // senderImageURL:
      buttons: NoteModel.generateAcceptDeclineButtons(),
      token: userModelToSendTo?.fcmToken?.token,
    );

    await NoteFireOps.createNote(
      context: context,
      noteModel: _note,
    );

  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendAuthorshipAcceptanceNote({
    @required BuildContext context,
    @required String bzID,
  }) async {

    final UserModel _myUserModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    final NoteModel _noteModel = NoteModel(
      id: 'x',
      senderID: _myUserModel.id,
      senderImageURL: _myUserModel.pic,
      noteSenderType: NoteSenderType.user,
      receiverID: bzID,
      receiverType: NoteReceiverType.bz,
      title: '${_myUserModel.name} accepted The invitation request',
      body: '${_myUserModel.name} has become a part of the team now.',
      metaData: NoteModel.defaultMetaData,
      sentTime: DateTime.now(),
      attachment: null,
      attachmentType: NoteAttachmentType.non,
      seen: false,
      seenTime: null,
      sendFCM: true,
      noteType: NoteType.authorship,
      response: null,
      responseTime: null,
      buttons: null,
      token: null, // ????????????????????????????????????????????????????
    );

    await NoteFireOps.createNote(
        context: context,
        noteModel: _noteModel
    );

  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendAuthorRoleChangeNote({
    @required BuildContext context,
    @required String bzID,
    @required AuthorModel author,
  }) async {

    final String _authorRoleString = AuthorModel.translateRole(
      context: context,
      role:  author.role,
    );

    final NoteModel _noteModel = NoteModel(
      id: 'x',
      senderID: bzID,
      senderImageURL: author.pic,
      noteSenderType: NoteSenderType.bz,
      receiverID: bzID,
      receiverType: NoteReceiverType.bz,
      title: 'Team member Role changed',
      body: 'The team role of "${author.name}" has been set to "$_authorRoleString"',
      metaData: NoteModel.defaultMetaData,
      sentTime: DateTime.now(),
      attachment: null,
      attachmentType: null,
      seen: false,
      seenTime: null,
      sendFCM: true,
      noteType: NoteType.announcement,
      response: null,
      responseTime: null,
      buttons: null,
      token: null, // ????????????????????????????????????????????????????
    );

    await NoteFireOps.createNote(
      context: context,
      noteModel: _noteModel,
    );


  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendAuthorDeletionNotes({
    @required BuildContext context,
    @required BzModel bzModel,
    @required AuthorModel deletedAuthor,
  }) async {

    /// NOTE TO BZ
    final NoteModel _noteToBz = NoteModel(
      id: 'x',
      senderID: deletedAuthor.userID,
      senderImageURL: deletedAuthor.pic,
      noteSenderType: NoteSenderType.user,
      receiverID: bzModel.id,
      receiverType: NoteReceiverType.bz,
      title: '${deletedAuthor.name} has left the team',
      body: '${deletedAuthor.name} is no longer part of ${bzModel.name} team',
      metaData: NoteModel.defaultMetaData,
      sentTime: DateTime.now(),
      attachment: null,
      attachmentType: NoteAttachmentType.non,
      seen: false,
      seenTime: null,
      sendFCM: true,
      noteType: NoteType.announcement,
      response: null,
      responseTime: null,
      buttons: null,
      token: null, // ????????????????????????????????????????????????????????
    );

    await NoteFireOps.createNote(
      context: context,
      noteModel: _noteToBz,
    );

    final UserModel _userModel = await UsersProvider.proFetchUserModel(
        context: context,
        userID: deletedAuthor.userID,
    );

    /// NOTE TO DELETED AUTHOR
    final NoteModel _noteToUser = NoteModel(
      id: 'x',
      senderID: bzModel.id,
      senderImageURL: bzModel.logo,
      noteSenderType: NoteSenderType.bz,
      receiverID: deletedAuthor.userID,
      receiverType: NoteReceiverType.user,
      title: 'You have exited from ${bzModel.name} account',
      body: 'You are no longer part of ${bzModel.name} team',
      metaData: NoteModel.defaultMetaData,
      sentTime: DateTime.now(),
      attachment: null,
      attachmentType: NoteAttachmentType.non,
      seen: false,
      seenTime: null,
      sendFCM: true,
      noteType: NoteType.announcement,
      response: null,
      responseTime: null,
      buttons: null,
      token: _userModel?.fcmToken?.token,
    );

    await NoteFireOps.createNote(
      context: context,
      noteModel: _noteToUser,
    );

  }
// ----------------------------------
  static Future<void> sendBzDeletionNoteToAllAuthors({
    @required BuildContext context,
    @required BzModel bzModel,
  }) async {

    if (bzModel != null && Mapper.checkCanLoopList(bzModel.authors) == true){

      final AuthorModel _creator = AuthorModel.getCreatorAuthorFromBz(bzModel);

      for (final AuthorModel author in bzModel.authors){

        final UserModel _userModel = await UsersProvider.proFetchUserModel(
            context: context,
            userID: author.userID,
        );

        final NoteModel _note = NoteModel(
          id: 'x',
          senderID: NoteModel.bldrsSenderID,
          senderImageURL: NoteModel.bldrsLogoURL,
          noteSenderType: NoteSenderType.bldrs,
          receiverID: author.userID,
          receiverType: NoteReceiverType.user,
          title: '${_creator.name} has deleted "${bzModel.name}" business account',
          body: 'All related data to "${bzModel.name}" business account have been permanently deleted',
          metaData: NoteModel.defaultMetaData,
          sentTime: DateTime.now(),
          attachment: bzModel.id,
          attachmentType: NoteAttachmentType.bzID,
          seen: false,
          seenTime: null,
          sendFCM: true,
          noteType: NoteType.bzDeletion,
          response: null,
          responseTime: null,
          buttons: null,
          token: _userModel?.fcmToken?.token,
        );

        await NoteFireOps.createNote(
          context: context,
          noteModel: _note,
        );

      }

    }


  }
// -----------------------------------------------------------------------------

/// READ - STREAMING

// ----------------------------------
///
// -----------------------------------------------------------------------------

/// UPDATE

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> modifyNoteResponse({
    @required BuildContext context,
    @required NoteModel noteModel,
    @required NoteResponse response,
  }) async {

    final NoteModel _newNoteModel = noteModel.copyWith(
      response: response,
      responseTime: DateTime.now(),
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

  }
// -----------------------------------------------------------------------------

/// DELETE

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> cancelSentAuthorshipInvitation({
    @required BuildContext context,
    @required NoteModel note,
  }) async {

    final NoteModel _updated = note.copyWith(
      response: NoteResponse.cancelled,
      responseTime: DateTime.now(),
    );

    await NoteFireOps.updateNote(
      context: context,
      newNoteModel: _updated,
    );

  }
// ----------------------------------
  static Future<void> deleteNoteEverywhereProtocol({
    @required BuildContext context,
    @required NoteModel noteModel,
  }) async {

    /// FIRE DELETE
    await NoteFireOps.deleteNote(
        context: context,
        noteID: noteModel.id,
    );

    /// PRO DELETE
    NotesProvider.proDeleteNoteEverywhereIfExists(
      context: context,
      noteID: noteModel.id,
      notify: true,
    );

  }
// -----------------------------------------------------------------------------

/// SUPER DELETE ALL NOTES

// ----------------------------------
  /// VERY DANGEROUS : SHOULD BE BY A CLOUD FUNCTION
  static Future<void> deleteAllBzReceivedNotes({
    @required BuildContext context,
    @required String bzID,
  }) async {

    await NoteFireOps.deleteAllReceivedNotes(
        context: context,
        receiverID: bzID,
        receiverType: NoteReceiverType.bz,
    );

  }
// ----------------------------------
  /// VERY DANGEROUS : SHOULD BE BY A CLOUD FUNCTION
  static Future<void> deleteAllUserReceivedNotes({
    @required BuildContext context,
    @required String userID,
  }) async {

    blog('deleteAllUserReceivedNotes : start');

    await NoteFireOps.deleteAllReceivedNotes(
      context: context,
      receiverID: userID,
      receiverType: NoteReceiverType.user,
    );

    blog('deleteAllUserReceivedNotes : end');

  }
// ----------------------------------
}
