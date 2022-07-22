import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/e_db/fire/ops/note_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';

class NoteProtocol {

  NoteProtocol();

// -----------------------------------------------------------------------------

/// CREATE

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendAuthorshipInvitationNote({
    @required BuildContext context,
    @required BzModel bzModel,
    @required UserModel userModelToSendTo,
  }) async {

    blog('NoteProtocol.sendAuthorshipInvitationNote : START');

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

    blog('NoteProtocol.sendAuthorshipInvitationNote : END');

  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendAuthorshipAcceptanceNote({
    @required BuildContext context,
    @required String bzID,
  }) async {

    blog('NoteProtocol.sendAuthorshipAcceptanceNote : START');

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

    blog('NoteProtocol.sendAuthorshipAcceptanceNote : END');

  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendAuthorRoleChangeNote({
    @required BuildContext context,
    @required String bzID,
    @required AuthorModel author,
  }) async {

    blog('NoteProtocol.sendAuthorRoleChangeNote : START');

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

    blog('NoteProtocol.sendAuthorRoleChangeNote : END');

  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendAuthorDeletionNotes({
    @required BuildContext context,
    @required BzModel bzModel,
    @required AuthorModel deletedAuthor,
  }) async {

    blog('NoteProtocol.sendAuthorDeletionNotes : START');

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

    blog('NoteProtocol.sendAuthorDeletionNotes : END');

  }
// ----------------------------------
  /// TESTED : ...
  static Future<void> sendBzDeletionNoteToAllAuthors({
    @required BuildContext context,
    @required BzModel bzModel,
  }) async {

    blog('NoteProtocol.sendBzDeletionNoteToAllAuthors : START');

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

    blog('NoteProtocol.sendBzDeletionNoteToAllAuthors : END');

  }
// ----------------------------------
  /// TESTED : ...
  static Future<void> sendFlyerUpdateNoteToItsBz({
    @required BuildContext context,
    @required BzModel bzModel,
    @required String flyerID,
  }) async {

    blog('NoteProtocol.sendFlyerUpdateNoteToItsBz : START');

    final NoteModel _note = NoteModel(
      id: 'x',
      senderID: bzModel.id,
      senderImageURL: bzModel.logo,
      noteSenderType: NoteSenderType.bz,
      receiverID: bzModel.id,
      receiverType: NoteReceiverType.bz,
      title: 'Flyer has been updated',
      body: 'This Flyer has been updated',
      metaData: NoteModel.defaultMetaData,
      sentTime: DateTime.now(),
      attachment: <String>[flyerID],
      attachmentType: NoteAttachmentType.flyersIDs,
      seen: false,
      seenTime: null,
      sendFCM: false,
      noteType: NoteType.flyerUpdate,
      response: null,
      responseTime: null,
      buttons: null,
      token: null,
    );

    await NoteFireOps.createNote(
        context: context,
        noteModel: _note
    );

    blog('NoteProtocol.sendFlyerUpdateNoteToItsBz : END');

  }
// ----------------------------------
  /// TESTED : ...
  static Future<void> sendNoBzContactAvailableNote({
    @required BuildContext context,
    @required BzModel bzModel,
}) async {
    blog('NoteProtocol.sendNoBzContactAvailableNote : START');

    final UserModel _userModel = UsersProvider.proGetMyUserModel(
        context: context,
        listen: false,
    );

    final NoteModel _note = NoteModel(
      id: 'x',
      senderID: _userModel.id,
      senderImageURL: _userModel.pic,
      noteSenderType: NoteSenderType.user,
      receiverID: bzModel.id,
      receiverType: NoteReceiverType.bz,
      title: '${_userModel.name} has tried to contact you',
      body: 'Please update your Business contacts info to allow customers to reach you',
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
      token: null,
    );

    await NoteFireOps.createNote(
        context: context,
        noteModel: _note
    );

    blog('NoteProtocol.sendNoBzContactAvailableNote : END');
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

    blog('NoteProtocol.modifyNoteResponse : START');

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

    blog('NoteProtocol.modifyNoteResponse : END');

  }
// -----------------------------------------------------------------------------

/// DELETE

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> cancelSentAuthorshipInvitation({
    @required BuildContext context,
    @required NoteModel note,
  }) async {

    blog('NoteProtocol.cancelSentAuthorshipInvitation : START');

    final NoteModel _updated = note.copyWith(
      response: NoteResponse.cancelled,
      responseTime: DateTime.now(),
    );

    await NoteFireOps.updateNote(
      context: context,
      newNoteModel: _updated,
    );

    blog('NoteProtocol.cancelSentAuthorshipInvitation : END');

  }
// ----------------------------------
  static Future<void> deleteNoteEverywhereProtocol({
    @required BuildContext context,
    @required NoteModel noteModel,
  }) async {

    blog('NoteProtocol.deleteNoteEverywhereProtocol : START');

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

    blog('NoteProtocol.deleteNoteEverywhereProtocol : END');
  }
// -----------------------------------------------------------------------------

/// SUPER DELETE ALL NOTES

// ----------------------------------
  /// VERY DANGEROUS : SHOULD BE BY A CLOUD FUNCTION
  static Future<void> deleteAllBzReceivedNotes({
    @required BuildContext context,
    @required String bzID,
  }) async {

    blog('NoteProtocol.deleteAllBzReceivedNotes : START');

    await NoteFireOps.deleteAllReceivedNotes(
        context: context,
        receiverID: bzID,
        receiverType: NoteReceiverType.bz,
    );

    blog('NoteProtocol.deleteAllBzReceivedNotes : END');

  }
// ----------------------------------
  /// VERY DANGEROUS : SHOULD BE BY A CLOUD FUNCTION
  static Future<void> deleteAllUserReceivedNotes({
    @required BuildContext context,
    @required String userID,
  }) async {

    blog('NoteProtocol.deleteAllUserReceivedNotes : START');

    await NoteFireOps.deleteAllReceivedNotes(
      context: context,
      receiverID: userID,
      receiverType: NoteReceiverType.user,
    );

    blog('NoteProtocol.deleteAllUserReceivedNotes : END');

  }
// ----------------------------------
}
