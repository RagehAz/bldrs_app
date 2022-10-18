import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/z_note_events.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:flutter/material.dart';

class AuthorshipSendingProtocols {
  // -----------------------------------------------------------------------------

  const AuthorshipSendingProtocols();

  // -----------------------------------------------------------------------------

    /// SEND REQUEST

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> sendRequest({
    @required BuildContext context,
    @required BzModel bzModel,
    @required UserModel userModelToSendTo,
  }) async {

    await NoteEvent.sendAuthorshipInvitationNote(
      context: context,
      bzModel: bzModel,
      userModelToSendTo: userModelToSendTo,
    );

    final List<String> _pendingAuthors = Stringer.addStringToListIfDoesNotContainIt(
        strings: bzModel.pendingAuthors,
        stringToAdd: userModelToSendTo.id,
    );

    final BzModel _updatedBzModel = bzModel.copyWith(
      pendingAuthors: _pendingAuthors,
    );

    await BzProtocols.renovateBz(
        context: context,
        oldBzModel: bzModel,
        newBzModel: _updatedBzModel,
        showWaitDialog: false,
        navigateToBzInfoPageOnEnd: false,
    );

  }
  // -----------------------------------------------------------------------------

  /// CANCEL REQUEST

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> cancelRequest({
    @required BuildContext context,
    @required BzModel bzModel,
    @required String pendingUserID
  }) async {

    /// REMOVE USER FROM PENDING IDS
    final List<String> _updatedPendingUsers = Stringer.removeStringsFromStrings(
        removeFrom: bzModel.pendingAuthors,
        removeThis: <String>[pendingUserID],
    );

    final BzModel _updatedBzModel = bzModel.copyWith(
      pendingAuthors: _updatedPendingUsers,
    );

    final UserModel userModelToSendTo = await UserProtocols.fetchUser(
        context: context,
        userID: pendingUserID,
    );

    await Future.wait(<Future>[

      BzProtocols.renovateBz(
        context: context,
        newBzModel: _updatedBzModel,
        oldBzModel: bzModel,
        showWaitDialog: false,
        navigateToBzInfoPageOnEnd: false,
      ),

      NoteEvent.sendAuthorshipCancellationNote(
          context: context,
          bzModel: bzModel,
          userModelToSendTo: userModelToSendTo,
      ),

    ]);

  }
  // -----------------------------------------------------------------------------
}
