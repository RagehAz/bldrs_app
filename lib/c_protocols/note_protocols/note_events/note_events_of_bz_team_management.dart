import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/e_notes/aa_topic_model.dart';
import 'package:bldrs/a_models/e_notes/aa_trigger_model.dart';
import 'package:bldrs/c_protocols/note_protocols/fire/note_fire_ops.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/b_note_fun_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/router/a_route_name.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class NoteEventsOfBzTeamManagement {
  // -----------------------------------------------------------------------------

  const NoteEventsOfBzTeamManagement();

  // -----------------------------------------------------------------------------

  /// SENDERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendAuthorRoleChangeNote({
    required String? bzID,
    required AuthorModel? author,
  }) async {

    // blog('NoteEventsOfBzTeamManagement.sendAuthorRoleChangeNote : START');

    if (author != null){

      final String? _authorRolePhid = AuthorModel.getAuthorRolePhid(
        role:  author.role,
      );

      final UserModel? _userModel = await UserProtocols.fetch(
        userID: author.userID,
      );

      final Map<String, dynamic>? _map = await Localizer.getLangMap(
          langCode: _userModel?.language ?? 'en',
      );

      final String? _title = _map!['phid_member_role_changed'];
      /// TASK : ARABIC TRANSLATION IS MESSED UP IN ORDER
      final String? _hasNewRole = _map['phid_has_new_role'];
      final String? _role = _map[_authorRolePhid];

      final String _body =  '${author.name}\n$_hasNewRole $_role';

      final NoteModel _note = NoteModel(
        id: null,
        parties: NoteParties(
          senderID: bzID,
          senderImageURL: author.picPath,
          senderType: PartyType.bz,
          receiverID: bzID,
          receiverType: PartyType.bz,
        ),
        title: _title,
        body: _body,
        sentTime: DateTime.now(),
        topic: TopicModel.bakeTopicID(
          topicID: TopicModel.bzTeamRolesUpdates,
          bzID: bzID,
          receiverPartyType: PartyType.bz,
        ),
        navTo: TriggerModel(
          name: RouteName.myBzTeamPage,
          argument: bzID,
          done: const [],
        ),
      );

      await NoteProtocols.composeToOneReceiver(
      note: _note,
    );


    }

    // blog('NoteEventsOfBzTeamManagement.sendAuthorRoleChangeNote : END');

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendAuthorDeletionNotes({
    required BzModel? bzModel,
    required AuthorModel? deletedAuthor,
    required bool sendToUserAuthorExitNote,
  }) async {
    blog('NoteEventsOfBzTeamManagement.sendAuthorDeletionNotes : START');

    await _authorDeletionNoteToBz(
      bzModel: bzModel,
      deletedAuthor: deletedAuthor,
    );

    /// NOTE TO DELETED AUTHOR
    if (sendToUserAuthorExitNote == true){
      await _authorDeletionNoteToUser(
        bzModel: bzModel,
        deletedAuthor: deletedAuthor,
      );
    }

    blog('NoteEventsOfBzTeamManagement.sendAuthorDeletionNotes : END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _authorDeletionNoteToBz({
    required BzModel? bzModel,
    required AuthorModel? deletedAuthor,
  }) async {

    if (bzModel?.id != null && deletedAuthor != null) {

      final UserModel? _user = await UserProtocols.fetch(
        userID: deletedAuthor.userID,
      );

      final String? _title = await Localizer.translateByLangCode(
        phid: 'phid_a_member_exited_the_team',
        langCode: _user?.language,
      );

      /// NOTE TO BZ
      final NoteModel _noteToBz = NoteModel(
        id: null,
        parties: NoteParties(
          senderID: deletedAuthor.userID,
          senderImageURL: deletedAuthor.picPath,
          senderType: PartyType.user,
          receiverID: bzModel!.id!,
          receiverType: PartyType.bz,
        ),
        title: _title,
        body: deletedAuthor.name,
        sentTime: DateTime.now(),
        topic: TopicModel.bakeTopicID(
          topicID: TopicModel.bzTeamMembersExit,
          bzID: bzModel.id,
          receiverPartyType: PartyType.bz,
        ),
        navTo: TriggerModel(
          name: RouteName.myBzTeamPage,
          argument: bzModel.id,
          done: const [],
        ),
        function: NoteFunProtocols.createDeleteAllBzFlyersLocally(
          bzID: bzModel.id!,
        ),
      );

      await NoteProtocols.composeToOneReceiver(
        note: _noteToBz,
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _authorDeletionNoteToUser({
    required BzModel? bzModel,
    required AuthorModel? deletedAuthor,
  }) async {

    final UserModel? _userModel = await UserProtocols.fetch(
      userID: deletedAuthor?.userID,
    );

    if (bzModel != null && _userModel != null){

      final String? _title = await Localizer.translateByLangCode(
        phid: 'phid_you_have_exited_bz',
        langCode: _userModel.language,
      );

      final NoteModel _noteToUser = NoteModel(
        id: null,
        parties: NoteParties(
          senderID: bzModel.id,
          senderImageURL: bzModel.logoPath,
          senderType: PartyType.bz,
          receiverID: deletedAuthor?.userID,
          receiverType: PartyType.user,
        ),
        title: _title,
        body: bzModel.name,
        sentTime: DateTime.now(),
        token: _userModel.device?.token,
        topic: TopicModel.userAuthorshipsInvitations,
        navTo: const TriggerModel(
          name: RouteName.myUserNotes,
          argument: null,
          done: [],
        ),
      );

      await NoteProtocols.composeToOneReceiver(
      note: _noteToUser,
    );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendBzDeletionNoteToAllAuthors({
    required BzModel? bzModel,
    /// send bz deletion note to myself
    required bool includeMyself,
  }) async {
    blog('NoteEventsOfBzTeamManagement.sendBzDeletionNoteToAllAuthors : START');

    if (bzModel?.id != null && Mapper.checkCanLoopList(bzModel?.authors) == true){

      // final AuthorModel _creator = AuthorModel.getCreatorAuthorFromAuthors(bzModel.authors);

      /// ADJUST AUTHORS LIST IF DOES NOT INCLUDE MYSELF
      List<AuthorModel>? _authors = <AuthorModel>[...bzModel!.authors!];
      if (includeMyself == false){
        _authors = AuthorModel.removeAuthorFromAuthors(
          authors: _authors,
          authorIDToRemove: Authing.getUserID(),
        );
      }

      /// SEND NOTE TO AUTHORS
      if (Mapper.checkCanLoopList(_authors) == true){

        await Future.wait(<Future>[

          ...List.generate(_authors!.length, (index) async {

            final AuthorModel author = _authors![index];

            final UserModel? _userModel = await UserProtocols.fetch(
              userID: author.userID,
            );

            final String? _title = await Localizer.translateByLangCode(
              phid: 'phid_bz_has_been_deleted',
              langCode: _userModel?.language,
            );

            final NoteModel _note = NoteModel(
              id: 'x',
              parties: NoteParties(
                senderID: Standards.bldrsNotificationSenderID,
                senderImageURL: Standards.bldrsNotificationIconURL,
                senderType: PartyType.bldrs,
                receiverID: author.userID,
                receiverType: PartyType.user,
              ),
              title: _title,
              body: bzModel.name,
              sentTime: DateTime.now(),
              token: _userModel?.device?.token,
              function: NoteFunProtocols.createDeleteBzLocallyTrigger(
                bzID: bzModel.id!,
              ),
              topic: TopicModel.userAuthorshipsInvitations,
              navTo: const TriggerModel(
                name: RouteName.myUserNotes,
                argument: null,
                done: [],
              ),
            );

            await NoteProtocols.composeToOneReceiver(
              note: _note,
            );

          }),

        ]);

      }

    }

    blog('NoteEventsOfBzTeamManagement.sendBzDeletionNoteToAllAuthors : END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendNoBzContactAvailableNote({
    required BuildContext context,
    required BzModel? bzModel,
  }) async {
    blog('NoteEventsOfBzTeamManagement.sendNoBzContactAvailableNote : START');

    final UserModel? userModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    if (bzModel != null && userModel != null){

          final String? _title = await Localizer.translateByLangCode(
      phid: 'has_tried_to_contact_you',
      langCode: userModel.language,
    );

    final String? _hasTriedToContactYou = await Localizer.translateByLangCode(
        phid: 'has_tried_to_contact_you',
        langCode: userModel.language,
    );

    final String _body = '${userModel.name}\n'
                          '$_hasTriedToContactYou';

    final NoteModel _note = NoteModel(
      id: 'x',
      parties: NoteParties(
        senderID: userModel.id,
        senderImageURL: userModel.picPath,
        senderType: PartyType.user,
        receiverID: bzModel.id,
        receiverType: PartyType.bz,
      ),
      title: _title,
      body: _body,
      sentTime: DateTime.now(),
      topic: TopicModel.bakeTopicID(
        topicID: TopicModel.bzGeneralNews,
        bzID: bzModel.id,
        receiverPartyType: PartyType.bz,
      ),
      navTo: TriggerModel(
        name: RouteName.userPreview,
        argument: userModel.id,
        done: const [],
      ),
    );

    await NoteFireOps.createNote(
        noteModel: _note
    );

    }

    blog('NoteEventsOfBzTeamManagement.sendNoBzContactAvailableNote : END');
  }
  // -----------------------------------------------------------------------------
}
