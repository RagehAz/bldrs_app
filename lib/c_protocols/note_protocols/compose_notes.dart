import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/auth_fire_ops.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/note_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class ComposeNoteProtocols {
  // -----------------------------------------------------------------------------

  const ComposeNoteProtocols();

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendAuthorshipInvitationNote({
    @required BuildContext context,
    @required BzModel bzModel,
    @required UserModel userModelToSendTo,
  }) async {

    blog('ComposeNoteProtocols.sendAuthorshipInvitationNote : START');

    final AuthorModel _myAuthorModel = AuthorModel.getAuthorFromBzByAuthorID(
      bz: bzModel,
      authorID: AuthFireOps.superUserID(),
    );

    /// TASK : SHOULD SEND NOTE WITH SELECTED USER'S LANG

    final NoteModel _note = NoteModel(
      id: null, // will be defined in note create fire ops
      senderID: bzModel.id, /// HAS TO BE BZ ID NOT AUTHOR ID
      senderImageURL: _myAuthorModel.pic,
      senderType: NoteSenderOrRecieverType.bz,
      receiverID: userModelToSendTo.id,
      receiverType: NoteSenderOrRecieverType.user,
      title: '##Business Account Invitation',
      body: "##'${_myAuthorModel.name}' sent you an invitation to become an Author for '${bzModel.name}' business page",
      metaData: NoteModel.defaultMetaData,
      sentTime: DateTime.now(),
      attachment: bzModel.id,
      attachmentType: NoteAttachmentType.bzID,
      seen: false,
      seenTime: null,
      sendFCM: true,
      type: NoteType.authorship,
      response: NoteResponse.pending,
      responseTime: null,
      // senderImageURL:
      buttons: NoteModel.generateAcceptDeclineButtons(),
      token: userModelToSendTo?.fcmToken?.token,
      topic: null,
    );

    await NoteFireOps.createNote(
      context: context,
      noteModel: _note,
    );

    blog('ComposeNoteProtocols.sendAuthorshipInvitationNote : END');

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendAuthorshipAcceptanceNote({
    @required BuildContext context,
    @required String bzID,
  }) async {

    blog('ComposeNoteProtocols.sendAuthorshipAcceptanceNote : START');

    final UserModel _myUserModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    final NoteModel _noteModel = NoteModel(
      id: 'x',
      senderID: _myUserModel.id,
      senderImageURL: _myUserModel.pic,
      senderType: NoteSenderOrRecieverType.user,
      receiverID: bzID,
      receiverType: NoteSenderOrRecieverType.bz,
      title: '##${_myUserModel.name} accepted The invitation request',
      body: '##${_myUserModel.name} has become a part of the team now.',
      metaData: NoteModel.defaultMetaData,
      sentTime: DateTime.now(),
      attachment: null,
      attachmentType: NoteAttachmentType.non,
      seen: false,
      seenTime: null,
      sendFCM: true,
      type: NoteType.authorship,
      response: null,
      responseTime: null,
      buttons: null,
      token: null, // ????????????????????????????????????????????????????
      topic: NoteModel.generateTopic(
          topicType: TopicType.authorshipAcceptance,
          id: bzID,
      ),
    );

    await NoteFireOps.createNote(
        context: context,
        noteModel: _noteModel
    );

    blog('ComposeNoteProtocols.sendAuthorshipAcceptanceNote : END');

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendAuthorRoleChangeNote({
    @required BuildContext context,
    @required String bzID,
    @required AuthorModel author,
  }) async {

    blog('ComposeNoteProtocols.sendAuthorRoleChangeNote : START');

    final String _authorRoleString = AuthorModel.getAuthorRolePhid(
      context: context,
      role:  author.role,
    );

    final NoteModel _noteModel = NoteModel(
      id: 'x',
      senderID: bzID,
      senderImageURL: author.pic,
      senderType: NoteSenderOrRecieverType.bz,
      receiverID: bzID,
      receiverType: NoteSenderOrRecieverType.bz,
      title: '##Team member Role changed',
      body: '##The team role of "${author.name}" has been set to "$_authorRoleString"',
      metaData: NoteModel.defaultMetaData,
      sentTime: DateTime.now(),
      attachment: null,
      attachmentType: null,
      seen: false,
      seenTime: null,
      sendFCM: true,
      type: NoteType.notice,
      response: null,
      responseTime: null,
      buttons: null,
      token: null, // ????????????????????????????????????????????????????
      topic: NoteModel.generateTopic(
        topicType: TopicType.authorRoleChanged,
        id: bzID,
      ),
    );

    await NoteFireOps.createNote(
      context: context,
      noteModel: _noteModel,
    );

    blog('ComposeNoteProtocols.sendAuthorRoleChangeNote : END');

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendAuthorDeletionNotes({
    @required BuildContext context,
    @required BzModel bzModel,
    @required AuthorModel deletedAuthor,
    @required bool sendToUserAuthorExitNote,
  }) async {
    blog('ComposeNoteProtocols.sendAuthorDeletionNotes : START');

    /// NOTE TO BZ
    final NoteModel _noteToBz = NoteModel(
      id: 'x',
      senderID: deletedAuthor.userID,
      senderImageURL: deletedAuthor.pic,
      senderType: NoteSenderOrRecieverType.user,
      receiverID: bzModel.id,
      receiverType: NoteSenderOrRecieverType.bz,
      title: '##${deletedAuthor.name} has left the team',
      body: '##${deletedAuthor.name} is no longer part of ${bzModel.name} team',
      metaData: NoteModel.defaultMetaData,
      sentTime: DateTime.now(),
      attachment: null,
      attachmentType: NoteAttachmentType.non,
      seen: false,
      seenTime: null,
      sendFCM: true,
      type: NoteType.notice,
      response: null,
      responseTime: null,
      buttons: null,
      token: null, // ????????????????????????????????????????????????????????
      topic: NoteModel.generateTopic(
        topicType: TopicType.authorDeletion,
        id: bzModel.id,
      ),
    );

    await NoteFireOps.createNote(
      context: context,
      noteModel: _noteToBz,
    );

    /// NOTE TO DELETED AUTHOR
    if (sendToUserAuthorExitNote == true){

      final UserModel _userModel = await UserProtocols.fetchUser(
        context: context,
        userID: deletedAuthor.userID,
      );

      final NoteModel _noteToUser = NoteModel(
        id: 'x',
        senderID: bzModel.id,
        senderImageURL: bzModel.logo,
        senderType: NoteSenderOrRecieverType.bz,
        receiverID: deletedAuthor.userID,
        receiverType: NoteSenderOrRecieverType.user,
        title: '##You have exited from ${bzModel.name} account',
        body: '##You are no longer part of ${bzModel.name} team',
        metaData: NoteModel.defaultMetaData,
        sentTime: DateTime.now(),
        attachment: null,
        attachmentType: NoteAttachmentType.non,
        seen: false,
        seenTime: null,
        sendFCM: true,
        type: NoteType.notice,
        response: null,
        responseTime: null,
        buttons: null,
        token: _userModel?.fcmToken?.token,
        topic: null,
      );

      await NoteFireOps.createNote(
        context: context,
        noteModel: _noteToUser,
      );

    }

    blog('ComposeNoteProtocols.sendAuthorDeletionNotes : END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendBzDeletionNoteToAllAuthors({
    @required BuildContext context,
    @required BzModel bzModel,
    @required bool includeMyself, // send bz deletion note to myself
  }) async {
    blog('ComposeNoteProtocols.sendBzDeletionNoteToAllAuthors : START');

    if (bzModel != null && Mapper.checkCanLoopList(bzModel.authors) == true){

      final AuthorModel _creator = AuthorModel.getCreatorAuthorFromBz(bzModel);

      /// ADJUST AUTHORS LIST IF DOES NOT INCLUDE MYSELF
      List<AuthorModel> _authors = <AuthorModel>[...bzModel.authors];
      if (includeMyself == false){
        _authors = AuthorModel.removeAuthorFromAuthors(
          authors: _authors,
          authorIDToRemove: AuthFireOps.superUserID(),
        );
      }

      /// SEND NOTE TO AUTHORS
      if (Mapper.checkCanLoopList(_authors) == true){

        await Future.wait(<Future>[

          ...List.generate(_authors.length, (index) async {

            final AuthorModel author = _authors[index];

            final UserModel _userModel = await UserProtocols.fetchUser(
              context: context,
              userID: author.userID,
            );

            final NoteModel _note = NoteModel(
              id: 'x',
              senderID: NoteModel.bldrsSenderID,
              senderImageURL: NoteModel.bldrsLogoStaticURL,
              senderType: NoteSenderOrRecieverType.bldrs,
              receiverID: author.userID,
              receiverType: NoteSenderOrRecieverType.user,
              title: '##${_creator.name} has deleted "${bzModel.name}" business account',
              body: '##All related data to "${bzModel.name}" business account have been permanently deleted',
              metaData: NoteModel.defaultMetaData,
              sentTime: DateTime.now(),
              attachment: bzModel.id,
              attachmentType: NoteAttachmentType.bzID,
              seen: false,
              seenTime: null,
              sendFCM: true,
              type: NoteType.bzDeletion,
              response: null,
              responseTime: null,
              buttons: null,
              token: _userModel?.fcmToken?.token,
              topic: null,
            );

            await NoteFireOps.createNote(
              context: context,
              noteModel: _note,
            );


          }),

        ]);

      }

    }

    blog('ComposeNoteProtocols.sendBzDeletionNoteToAllAuthors : END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendFlyerUpdateNoteToItsBz({
    @required BuildContext context,
    @required BzModel bzModel,
    @required String flyerID,
  }) async {

    blog('ComposeNoteProtocols.sendFlyerUpdateNoteToItsBz : START');

    final NoteModel _note = NoteModel(
      id: 'x',
      senderID: bzModel.id,
      senderImageURL: bzModel.logo,
      senderType: NoteSenderOrRecieverType.bz,
      receiverID: bzModel.id,
      receiverType: NoteSenderOrRecieverType.bz,
      title: '##Flyer has been updated',
      body: '##This Flyer has been updated',
      metaData: NoteModel.defaultMetaData,
      sentTime: DateTime.now(),
      attachment: <String>[flyerID],
      attachmentType: NoteAttachmentType.flyersIDs,
      seen: false,
      seenTime: null,
      sendFCM: false,
      type: NoteType.flyerUpdate,
      response: null,
      responseTime: null,
      buttons: null,
      token: null,
      topic: NoteModel.generateTopic(
          topicType: TopicType.flyerUpdate,
          id: bzModel.id,
      ),
    );

    await NoteFireOps.createNote(
        context: context,
        noteModel: _note
    );

    blog('ComposeNoteProtocols.sendFlyerUpdateNoteToItsBz : END');

  }
  // --------------------
  /// TESTED : ...
  static Future<void> sendNoBzContactAvailableNote({
    @required BuildContext context,
    @required BzModel bzModel,
  }) async {
    blog('ComposeNoteProtocols.sendNoBzContactAvailableNote : START');

    final UserModel _userModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    final NoteModel _note = NoteModel(
      id: 'x',
      senderID: _userModel.id,
      senderImageURL: _userModel.pic,
      senderType: NoteSenderOrRecieverType.user,
      receiverID: bzModel.id,
      receiverType: NoteSenderOrRecieverType.bz,
      title: '##${_userModel.name} has tried to contact you',
      body: '##Please update your Business contacts info to allow customers to reach you',
      metaData: NoteModel.defaultMetaData,
      sentTime: DateTime.now(),
      attachment: null,
      attachmentType: NoteAttachmentType.non,
      seen: false,
      seenTime: null,
      sendFCM: true,
      type: NoteType.notice,
      response: null,
      responseTime: null,
      buttons: null,
      token: null,
      topic: NoteModel.generateTopic(
          topicType: TopicType.generalBzNotes,
          id: bzModel.id,
      ),
    );

    await NoteFireOps.createNote(
        context: context,
        noteModel: _note
    );

    blog('ComposeNoteProtocols.sendNoBzContactAvailableNote : END');
  }
  // -----------------------------------------------------------------------------
}
