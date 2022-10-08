import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/author_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/c_protocols/note_protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/x_note_gen.dart';
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
  ///
  static Future<void> sendAuthorshipInvitationNote({
    @required BuildContext context,
    @required BzModel bzModel,
    @required UserModel userModelToSendTo,
  }) async {

    blog('ComposeNoteProtocols.sendAuthorshipInvitationNote : START');

    final NoteModel _note = await NoteGen.authorshipInvitation(
      context: context,
      bzModel: bzModel,
      userModelToSendTo: userModelToSendTo,
    );

    await NoteProtocols.compose(
      context: context,
      note: _note,
    );

    blog('ComposeNoteProtocols.sendAuthorshipInvitationNote : END');

  }
  // --------------------
  ///
  static Future<void> sendAuthorshipAcceptanceNote({
    @required BuildContext context,
    @required String bzID,
  }) async {

    blog('ComposeNoteProtocols.sendAuthorshipAcceptanceNote : START');

    final UserModel _myUserModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    final NoteModel _note = await NoteGen.authorshipAcceptance(
      context: context,
      bzID: bzID,
      senderModel: _myUserModel,
    );

    await NoteProtocols.compose(
      context: context,
      note: _note,
    );

    blog('ComposeNoteProtocols.sendAuthorshipAcceptanceNote : END');

  }
  // --------------------
  ///
  static Future<void> sendAuthorRoleChangeNote({
    @required BuildContext context,
    @required String bzID,
    @required AuthorModel author,
  }) async {

    blog('ComposeNoteProtocols.sendAuthorRoleChangeNote : START');

    final NoteModel _note = await NoteGen.authorRoleChanged(
      context: context,
      author: author,
      bzID: bzID,
    );

    await NoteProtocols.compose(
      context: context,
      note: _note,
    );

    blog('ComposeNoteProtocols.sendAuthorRoleChangeNote : END');

  }
  // --------------------
  ///
  static Future<void> sendAuthorDeletionNotes({
    @required BuildContext context,
    @required BzModel bzModel,
    @required AuthorModel deletedAuthor,
    @required bool sendToUserAuthorExitNote,
  }) async {
    blog('ComposeNoteProtocols.sendAuthorDeletionNotes : START');

    /// NOTE TO BZ
    final NoteModel _noteToBz = await NoteGen.authorDeletedToBz(
      context: context,
      deletedAuthor: deletedAuthor,
      bzModel: bzModel,
    );

    await NoteProtocols.compose(
      context: context,
      note: _noteToBz,
    );

    /// NOTE TO DELETED AUTHOR
    if (sendToUserAuthorExitNote == true){

      final NoteModel _noteToUser = await NoteGen.authorDeletedToUser(
        context: context,
        bzModel: bzModel,
        deletedAuthor: deletedAuthor,
      );

      await NoteProtocols.compose(
        context: context,
        note: _noteToUser,
      );

    }

    blog('ComposeNoteProtocols.sendAuthorDeletionNotes : END');
  }
  // --------------------
  ///
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

            final NoteModel _note = await NoteGen.bzDeletionToAuthor(
                context: context,
                author: author,
                creator: _creator,
                bzModel: bzModel,
            );

            await NoteProtocols.compose(
              context: context,
              note: _note,
            );

          }),

        ]);

      }

    }

    blog('ComposeNoteProtocols.sendBzDeletionNoteToAllAuthors : END');
  }
  // --------------------
  ///
  static Future<void> sendFlyerUpdateNoteToItsBz({
    @required BuildContext context,
    @required BzModel bzModel,
    @required String flyerID,
  }) async {

    blog('ComposeNoteProtocols.sendFlyerUpdateNoteToItsBz : START');

    final NoteModel _note = await NoteGen.flyerUpdatedToBz(
      context: context,
      bzModel: bzModel,
      flyerID: flyerID,
    );

    await NoteProtocols.compose(
      context: context,
      note: _note,
    );

    blog('ComposeNoteProtocols.sendFlyerUpdateNoteToItsBz : END');

  }
  // --------------------
  ///
  static Future<void> sendNoBzContactAvailableNote({
    @required BuildContext context,
    @required BzModel bzModel,
  }) async {
    blog('ComposeNoteProtocols.sendNoBzContactAvailableNote : START');

    final UserModel _userModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    final NoteModel _note = await NoteGen.bzContactNotAvailable(
      context: context,
      bzModel: bzModel,
      userModel: _userModel,
    );

    await NoteFireOps.createNote(
        context: context,
        noteModel: _note
    );

    blog('ComposeNoteProtocols.sendNoBzContactAvailableNote : END');
  }
  // -----------------------------------------------------------------------------
}
