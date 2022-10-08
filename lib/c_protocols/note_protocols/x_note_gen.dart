import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/author_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_response_model.dart';
import 'package:bldrs/a_models/e_notes/aa_trigger_model.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/c_protocols/phrase_protocols/phrase_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:flutter/material.dart';

/// NOTE GENERATOR
class NoteGen {
  // -----------------------------------------------------------------------------

  const NoteGen();

  // -----------------------------------------------------------------------------

    /// AUTHORSHIP

  // --------------------
  ///
  static Future<NoteModel> authorshipInvitation({
    @required BuildContext context,
    @required BzModel bzModel,
    @required UserModel userModelToSendTo,
  }) async {

    final Phrase _title = await PhraseProtocols.fetchPhid(
      context: context,
      phid: 'phid_authorship_note_title',
      lang: userModelToSendTo.language ?? 'en',
    );

    final Phrase _body = await PhraseProtocols.fetchPhid(
      context: context,
      phid: 'phid_authorship_note_body',
      lang: userModelToSendTo.language ?? 'en',
    );

    return NoteModel(
      id: null, // will be defined in composeNoteProtocol
      senderID: bzModel.id, /// HAS TO BE BZ ID NOT AUTHOR ID
      senderImageURL: bzModel.logo,
      senderType: NoteSenderOrRecieverType.bz,
      receiverID: userModelToSendTo.id,
      receiverType: NoteSenderOrRecieverType.user,
      title: _title.value,
      body: _body.value,
      metaData: NoteModel.defaultMetaData,
      sentTime: DateTime.now(),
      poster: null,
      trigger: null,
      sendFCM: true,
      poll: const PollModel(
        buttons: PollModel.acceptDeclineButtons,
        reply: null,
        replyTime: null,
      ),
      token: userModelToSendTo?.fcmToken?.token,
      topic: null, // will be defined in composeNoteProtocol
      seen: false,
    );

  }
  // --------------------
  ///
  static Future<NoteModel> authorshipAcceptance({
    @required BuildContext context,
    @required UserModel senderModel,
    @required String bzID,
  }) async {

    final String _title = '##${senderModel.name} accepted The invitation request';

    final String _body = '##${senderModel.name} has become a part of the team now.';

    return NoteModel(
      id: null,
      senderID: senderModel.id,
      senderImageURL: senderModel.pic,
      senderType: NoteSenderOrRecieverType.user,
      receiverID: bzID,
      receiverType: NoteSenderOrRecieverType.bz,
      title: _title,
      body: _body,
      metaData: NoteModel.defaultMetaData,
      sentTime: DateTime.now(),
      poster: null,
      seen: false,
      sendFCM: true,
      poll: null,
      token: null,
      topic: NoteModel.generateTopic(
        topicType: TopicType.authorshipReply,
        id: bzID,
      ),
      trigger: TriggerModel.createAuthorshipAcceptanceTrigger(),
    );

  }
  // -----------------------------------------------------------------------------

  /// BZ TEAM

  // --------------------
  ///
  static Future<NoteModel> authorRoleChanged({
    @required BuildContext context,
    @required String bzID,
    @required AuthorModel author,
  }) async {

    final String _authorRoleString = AuthorModel.getAuthorRolePhid(
      context: context,
      role:  author.role,
    );

    return NoteModel(
      id: null,
      senderID: bzID,
      senderImageURL: author.pic,
      senderType: NoteSenderOrRecieverType.bz,
      receiverID: bzID,
      receiverType: NoteSenderOrRecieverType.bz,
      title: '##Team member Role changed',
      body: '##The team role of "${author.name}" has been set to "$_authorRoleString"',
      metaData: NoteModel.defaultMetaData,
      sentTime: DateTime.now(),
      poster: null,
      trigger: null,
      seen: false,
      sendFCM: true,
      poll: null,
      token: null,
      topic: NoteModel.generateTopic(
        topicType: TopicType.authorRoleChanged,
        id: bzID,
      ),
    );

  }
  // --------------------
  ///
  static Future<NoteModel> authorDeletedToBz({
    @required BuildContext context,
    @required BzModel bzModel,
    @required AuthorModel deletedAuthor,
  }) async {

    return NoteModel(
      id: null,
      senderID: deletedAuthor.userID,
      senderImageURL: deletedAuthor.pic,
      senderType: NoteSenderOrRecieverType.user,
      receiverID: bzModel.id,
      receiverType: NoteSenderOrRecieverType.bz,
      title: '##${deletedAuthor.name} has left the team',
      body: '##${deletedAuthor.name} is no longer part of ${bzModel.name} team',
      metaData: NoteModel.defaultMetaData,
      sentTime: DateTime.now(),
      poster: null,
      seen: false,
      sendFCM: true,
      poll: null,
      token: null,
      topic: NoteModel.generateTopic(
        topicType: TopicType.authorDeletion,
        id: bzModel.id,
      ),
      trigger: null,
    );

}
  // --------------------
  ///
  static Future<NoteModel> authorDeletedToUser({
    @required BuildContext context,
    @required BzModel bzModel,
    @required AuthorModel deletedAuthor,
  }) async {

    final UserModel _userModel = await UserProtocols.fetchUser(
      context: context,
      userID: deletedAuthor.userID,
    );

    return NoteModel(
      id: null,
      senderID: bzModel.id,
      senderImageURL: bzModel.logo,
      senderType: NoteSenderOrRecieverType.bz,
      receiverID: deletedAuthor.userID,
      receiverType: NoteSenderOrRecieverType.user,
      title: '##You have exited from ${bzModel.name} account',
      body: '##You are no longer part of ${bzModel.name} team',
      metaData: NoteModel.defaultMetaData,
      sentTime: DateTime.now(),
      poster: null,
      seen: false,
      sendFCM: true,
      poll: null,
      token: _userModel?.fcmToken?.token,
      topic: null,
      trigger: null,
    );

  }
  // --------------------
  ///
  static Future<NoteModel> bzDeletionToAuthor({
    @required BuildContext context,
    @required AuthorModel author,
    @required AuthorModel creator,
    @required BzModel bzModel,
  }) async {

    final UserModel _userModel = await UserProtocols.fetchUser(
      context: context,
      userID: author.userID,
    );

    return NoteModel(
      id: 'x',
      senderID: NoteModel.bldrsSenderID,
      senderImageURL: NoteModel.bldrsLogoStaticURL,
      senderType: NoteSenderOrRecieverType.bldrs,
      receiverID: author.userID,
      receiverType: NoteSenderOrRecieverType.user,
      title: '##${creator.name} has deleted "${bzModel.name}" business account',
      body: '##All related data to "${bzModel.name}" business account have been permanently deleted',
      metaData: NoteModel.defaultMetaData,
      sentTime: DateTime.now(),
      poster: null,
      seen: false,
      sendFCM: true,
      poll: null,
      token: _userModel?.fcmToken?.token,
      topic: null,
      trigger: TriggerModel.createBzDeletionTrigger(
        bzID: bzModel.id,
      ),
    );

  }
  // -----------------------------------------------------------------------------

  /// BZ FLYER

  // --------------------
  ///
  static Future<NoteModel> flyerUpdatedToBz({
    @required BuildContext context,
    @required BzModel bzModel,
    @required String flyerID,
  }) async {

    return NoteModel(
      id: null,
      senderID: bzModel.id,
      senderImageURL: bzModel.logo,
      senderType: NoteSenderOrRecieverType.bz,
      receiverID: bzModel.id,
      receiverType: NoteSenderOrRecieverType.bz,
      title: '##Flyer has been updated',
      body: '##This Flyer has been updated',
      metaData: NoteModel.defaultMetaData,
      sentTime: DateTime.now(),
      poster: null,
      seen: false,
      sendFCM: false,
      poll: null,
      token: null,
      topic: NoteModel.generateTopic(
        topicType: TopicType.flyerUpdate,
        id: bzModel.id,
      ),
      trigger: TriggerModel.createFlyerUpdateTrigger(
          flyerID: flyerID
      ),
    );

  }
  // --------------------
  ///
  static Future<NoteModel> flyerVerifiedToBz({
    @required BuildContext context,
    @required String flyerID,
    @required String bzID,
  }) async {

    return NoteModel(
      id: null,
      senderID: NoteModel.bldrsSenderID,
      senderImageURL: NoteModel.bldrsLogoStaticURL,
      senderType: NoteSenderOrRecieverType.bldrs,
      receiverID: bzID,
      receiverType: NoteSenderOrRecieverType.bz,
      title: 'Flyer has been verified',
      body: 'This Flyer is now public to be seen and searched by all users',
      metaData: NoteModel.defaultMetaData,
      sentTime: DateTime.now(),
      // poster: PosterModel(
      //   id: flyerID,
      //   type: PosterType.flyer,
      //   url: null,
      // ),
      poster: null,
      seen: false,
      sendFCM: true,
      poll: null,
      trigger: TriggerModel.createFlyerUpdateTrigger(
        flyerID: flyerID,
      ),
      token: null,
      topic: NoteModel.generateTopic(
        topicType: TopicType.flyerVerification,
        id: bzID,
      ),
    );

  }
  // -----------------------------------------------------------------------------

  /// BZ

  // --------------------
  static Future<NoteModel> bzContactNotAvailable({
    @required BuildContext context,
    @required BzModel bzModel,
    @required UserModel userModel,
  }) async {

    return NoteModel(
      id: 'x',
      senderID: userModel.id,
      senderImageURL: userModel.pic,
      senderType: NoteSenderOrRecieverType.user,
      receiverID: bzModel.id,
      receiverType: NoteSenderOrRecieverType.bz,
      title: '##${userModel.name} has tried to contact you',
      body: '##Please update your Business contacts info to allow customers to reach you',
      metaData: NoteModel.defaultMetaData,
      sentTime: DateTime.now(),
      poster: null,
      seen: false,
      sendFCM: true,
      poll: null,
      token: null,
      topic: NoteModel.generateTopic(
        topicType: TopicType.generalBzNotes,
        id: bzModel.id,
      ),
      trigger: null,
    );

  }
  // -----------------------------------------------------------------------------
}
