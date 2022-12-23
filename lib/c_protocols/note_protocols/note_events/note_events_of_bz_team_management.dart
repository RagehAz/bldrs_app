import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/e_notes/aa_topic_model.dart';
import 'package:bldrs/a_models/e_notes/aa_trigger_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/b_note_fun_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/c_protocols/note_protocols/fire/note_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/routing.dart';
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

    final String _authorRolePhid = AuthorModel.getAuthorRolePhid(
      context: context,
      role:  author.role,
    );

    final UserModel _userModel = await UserProtocols.fetch(
        context: context,
        userID: author.userID,
    );
    final String _langCode = _userModel?.language ?? 'en';

    /// TASK : ARABIC TRANSLATION IS MESSED UP IN ORDER
    final String _body =  '${author.name} '
                          '${await transPhid(context, 'phid_has_new_role', _langCode)} '
                          '${await transPhid(context, _authorRolePhid, _langCode)} ';

    final NoteModel _note = NoteModel(
      id: null,
      parties: NoteParties(
        senderID: bzID,
        senderImageURL: author.picPath,
        senderType: PartyType.bz,
        receiverID: bzID,
        receiverType: PartyType.bz,
      ),
      title: Verse.transBake(context, 'phid_member_role_changed'),
      body: _body,
      sentTime: DateTime.now(),
      topic: TopicModel.bakeTopicID(
        topicID: TopicModel.bzTeamRolesUpdates,
        bzID: bzID,
        receiverPartyType: PartyType.bz,
      ),
      navTo: TriggerModel(
        name: Routing.myBzTeamPage,
        argument: bzID,
        done: const [],
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

    // final String _title = '';

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
      navTo: TriggerModel(
        name: Routing.myBzTeamPage,
        argument: bzModel.id,
        done: const [],
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
         navTo: const TriggerModel(
           name: Routing.myUserNotesPage,
           argument: null,
           done: [],
         ),
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
              function: NoteFunProtocols.createDeleteBzLocallyTrigger(
                bzID: bzModel.id,
              ),
              topic: TopicModel.userAuthorshipsInvitations,
              navTo: const TriggerModel(
                name: Routing.myUserNotesPage,
                argument: null,
                done: [],
              ),
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
      title: '${userModel.name} ${Verse.transBake(context, 'has_tried_to_contact_you')}',
      body: Verse.transBake(context, 'phid_update_your_contacts'),
      sentTime: DateTime.now(),
      topic: TopicModel.bakeTopicID(
        topicID: TopicModel.bzGeneralNews,
        bzID: bzModel.id,
        receiverPartyType: PartyType.bz,
      ),
      navTo: TriggerModel(
        name: Routing.userPreview,
        argument: userModel.id,
        done: const [],
      ),
    );

    await NoteFireOps.createNote(
        noteModel: _note
    );

    blog('NoteEventsOfBzTeamManagement.sendNoBzContactAvailableNote : END');
  }
  // -----------------------------------------------------------------------------
}
