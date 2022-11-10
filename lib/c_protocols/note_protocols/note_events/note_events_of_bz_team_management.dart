import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/e_notes/aa_topic_model.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/b_trigger_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/c_protocols/note_protocols/fire/note_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class NoteEventsOfBzTeamManagement {
  // -----------------------------------------------------------------------------

  const NoteEventsOfBzTeamManagement();

  // -----------------------------------------------------------------------------

  /// SENDERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendAuthorRoleChangeNote({
    @required BuildContext context,
    @required String bzID,
    @required AuthorModel author,
  }) async {

    // blog('NoteEventsOfBzTeamManagement.sendAuthorRoleChangeNote : START');

    final String _authorRoleString = AuthorModel.getAuthorRolePhid(
      context: context,
      role:  author.role,
    );

    final NoteModel _note = NoteModel(
      id: null,
      parties: NoteParties(
        senderID: bzID,
        senderImageURL: author.picPath,
        senderType: PartyType.bz,
        receiverID: bzID,
        receiverType: PartyType.bz,
      ),
      title: '##Team member Role changed',
      body: '##The team role of "${author.name}" has been set to "$_authorRoleString"',
      sentTime: DateTime.now(),
      topic: TopicModel.bakeTopicID(
        topicID: TopicModel.bzTeamRolesUpdates,
        bzID: bzID,
        receiverPartyType: PartyType.bz,
      ),
    );

    await NoteProtocols.composeToOneReceiver(
      context: context,
      note: _note,
    );

    // blog('NoteEventsOfBzTeamManagement.sendAuthorRoleChangeNote : END');

  }
  // --------------------
  /// TASK : TEST ME
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
      parties: NoteParties(
        senderID: deletedAuthor.userID,
        senderImageURL: deletedAuthor.picPath,
        senderType: PartyType.user,
        receiverID: bzModel.id,
        receiverType: PartyType.bz,
      ),
      title: '##${deletedAuthor.name} has left the team',
      body: '##${deletedAuthor.name} is no longer part of ${bzModel.name} team',
      sentTime: DateTime.now(),
      topic: TopicModel.bakeTopicID(
        topicID: TopicModel.bzTeamMembersExit,
        bzID: bzModel.id,
        receiverPartyType: PartyType.bz,
      ),
    );

    await NoteProtocols.composeToOneReceiver(
      context: context,
      note: _noteToBz,
    );

    /// NOTE TO DELETED AUTHOR
    if (sendToUserAuthorExitNote == true){

      final UserModel _userModel = await UserProtocols.fetch(
        context: context,
        userID: deletedAuthor.userID,
      );

       final NoteModel _noteToUser = NoteModel(
         id: null,
         parties: NoteParties(
           senderID: bzModel.id,
           senderImageURL: bzModel.logoPath,
           senderType: PartyType.bz,
           receiverID: deletedAuthor.userID,
           receiverType: PartyType.user,
         ),
         title: '##You have exited from ${bzModel.name} account',
         body: '##You are no longer part of ${bzModel.name} team',
         sentTime: DateTime.now(),
         token: _userModel?.device?.token,
         topic: TopicModel.userAuthorshipsInvitations,
       );

      await NoteProtocols.composeToOneReceiver(
        context: context,
        note: _noteToUser,
      );

    }

    blog('NoteEventsOfBzTeamManagement.sendAuthorDeletionNotes : END');
  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> sendBzDeletionNoteToAllAuthors({
    @required BuildContext context,
    @required BzModel bzModel,
    /// send bz deletion note to myself
    @required bool includeMyself,
  }) async {
    blog('NoteEventsOfBzTeamManagement.sendBzDeletionNoteToAllAuthors : START');

    if (bzModel != null && Mapper.checkCanLoopList(bzModel.authors) == true){

      final AuthorModel _creator = AuthorModel.getCreatorAuthorFromAuthors(bzModel.authors);

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

            final UserModel _userModel = await UserProtocols.refetch(
              context: context,
              userID: author.userID,
            );

            final NoteModel _note = NoteModel(
              id: 'x',
              parties: NoteParties(
                senderID: NoteParties.bldrsSenderID,
                senderImageURL: NoteParties.bldrsLogoStaticURL,
                senderType: PartyType.bldrs,
                receiverID: author.userID,
                receiverType: PartyType.user,
              ),
              title: '##${_creator.name} has deleted "${bzModel.name}" business account',
              body: '##All related data to "${bzModel.name}" business account have been permanently deleted',
              sentTime: DateTime.now(),
              token: _userModel?.device?.token,
              trigger: TriggerProtocols.createDeleteBzLocallyTrigger(
                bzID: bzModel.id,
              ),
              topic: TopicModel.userAuthorshipsInvitations,
            );

            await NoteProtocols.composeToOneReceiver(
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
  /// TASK : TEST ME
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
      parties: NoteParties(
        senderID: userModel.id,
        senderImageURL: userModel.picPath,
        senderType: PartyType.user,
        receiverID: bzModel.id,
        receiverType: PartyType.bz,
      ),
      title: '##${userModel.name} has tried to contact you',
      body: '##Please update your Business contacts info to allow customers to reach you',
      sentTime: DateTime.now(),
      topic: TopicModel.bakeTopicID(
        topicID: TopicModel.bzGeneralNews,
        bzID: bzModel.id,
        receiverPartyType: PartyType.bz,
      ),
    );

    await NoteFireOps.createNote(
        noteModel: _note
    );

    blog('NoteEventsOfBzTeamManagement.sendNoBzContactAvailableNote : END');
  }
  // -----------------------------------------------------------------------------
}
