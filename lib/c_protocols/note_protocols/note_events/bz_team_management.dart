import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/author_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_trigger_model.dart';
import 'package:bldrs/c_protocols/note_protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/auth_fire_ops.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/note_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class NoteEventsOfBzTeamManagement {
  // -----------------------------------------------------------------------------

  const NoteEventsOfBzTeamManagement();

  // -----------------------------------------------------------------------------

  /// SENDERS

  // --------------------
  ///
  static Future<void> sendAuthorRoleChangeNote({
    @required BuildContext context,
    @required String bzID,
    @required AuthorModel author,
  }) async {

    blog('NoteEventsOfBzTeamManagement.sendAuthorRoleChangeNote : START');

    final String _authorRoleString = AuthorModel.getAuthorRolePhid(
      context: context,
      role:  author.role,
    );

    final NoteModel _note = NoteModel(
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

    await NoteProtocols.compose(
      context: context,
      note: _note,
    );

    blog('NoteEventsOfBzTeamManagement.sendAuthorRoleChangeNote : END');

  }
  // --------------------
  ///
  static Future<void> sendAuthorDeletionNotes({
    @required BuildContext context,
    @required BzModel bzModel,
    @required AuthorModel deletedAuthor,
    @required bool sendToUserAuthorExitNote,
  }) async {
    blog('NoteEventsOfBzTeamManagement.sendAuthorDeletionNotes : START');

    /// NOTE TO BZ
    final NoteModel _noteToBz = NoteModel(
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

    await NoteProtocols.compose(
      context: context,
      note: _noteToBz,
    );

    /// NOTE TO DELETED AUTHOR
    if (sendToUserAuthorExitNote == true){

      final UserModel _userModel = await UserProtocols.fetchUser(
        context: context,
        userID: deletedAuthor.userID,
      );

       final NoteModel _noteToUser = NoteModel(
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

      await NoteProtocols.compose(
        context: context,
        note: _noteToUser,
      );

    }

    blog('NoteEventsOfBzTeamManagement.sendAuthorDeletionNotes : END');
  }
  // --------------------
  ///
  static Future<void> sendBzDeletionNoteToAllAuthors({
    @required BuildContext context,
    @required BzModel bzModel,
    @required bool includeMyself, // send bz deletion note to myself
  }) async {
    blog('NoteEventsOfBzTeamManagement.sendBzDeletionNoteToAllAuthors : START');

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

            await NoteProtocols.compose(
              context: context,
              note: _note,
            );

          }),

        ]);

      }

    }

    blog('NoteEventsOfBzTeamManagement.sendBzDeletionNoteToAllAuthors : END');
  }
  // --------------------
  ///
  static Future<void> sendNoBzContactAvailableNote({
    @required BuildContext context,
    @required BzModel bzModel,
  }) async {
    blog('NoteEventsOfBzTeamManagement.sendNoBzContactAvailableNote : START');

    final UserModel userModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    final NoteModel _note = NoteModel(
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

    await NoteFireOps.createNote(
        context: context,
        noteModel: _note
    );

    blog('NoteEventsOfBzTeamManagement.sendNoBzContactAvailableNote : END');
  }
  // -----------------------------------------------------------------------------
}
