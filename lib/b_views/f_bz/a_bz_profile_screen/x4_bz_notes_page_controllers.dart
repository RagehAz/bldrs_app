import 'dart:async';

import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/author_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poll_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/authorship_protocols/a_authorship_protocols.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/fire_finder.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/fire_query_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// BZ NOTE PAGINATION QUERY PARAMETERS

// --------------------
///
FireQueryModel bzReceivedNotesPaginationQueryParameters({
  @required String bzID,
  @required ValueChanged<List<Map<String, dynamic>>> onDataChanged,
}){

  return FireQueryModel(
    collRef: Fire.getSuperCollRef(
      aCollName: FireColl.bzz,
      bDocName: bzID,
      cSubCollName: FireSubColl.noteReceiver_receiver_notes,
    ),
    limit: 5,
    orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
    finders: <FireFinder>[

      FireFinder(
        field: 'receiverID',
        comparison: FireComparison.equalTo,
        value: bzID,
      ),

    ],
    onDataChanged: onDataChanged,
  );

}
// -----------------------------------------------------------------------------

/// MARKING NOTES AS SEEN

// --------------------
/// TESTED : WORKS PERFECT
/*
// void decrementBzObeliskUnseenNotesNumber({
//   @required NotesProvider notesProvider,
//   @required int markedNotesLength,
//   @required String bzID,
// }){
//
//   if (markedNotesLength > 0){
//
//     final int _mainNaValue = notesProvider.getObeliskNumber(
//       navModelID: NavModel.getMainNavIDString(navID: MainNavModel.bz, bzID: bzID),
//     );
//
//     final int _updatedMainValue = NavModel.updateObeliskNumber(
//       oldNumber: _mainNaValue,
//       change: markedNotesLength,
//       isIncrementing: false,
//     );
//
//     /// MARK ON PROVIDER
//     notesProvider.setObeliskNoteNumber(
//       caller: 'decrementBzObeliskUnseenNotesNumber',
//       value: _updatedMainValue,
//       navModelID: NavModel.getMainNavIDString(navID: MainNavModel.bz, bzID: bzID),
//       notify: false,
//     );
//
//     final int _bzNotesTabValue = notesProvider.getObeliskNumber(
//       navModelID: NavModel.getBzTabNavID(bzTab: BzTab.notes, bzID: bzID),
//     );
//
//     final int _updatedValue = NavModel.updateObeliskNumber(
//       oldNumber: _bzNotesTabValue,
//       change: markedNotesLength,
//       isIncrementing: false,
//     );
//
//     notesProvider.setObeliskNoteNumber(
//       caller: 'decrementBzObeliskUnseenNotesNumber',
//       value: _updatedValue,
//       navModelID: NavModel.getBzTabNavID(bzTab: BzTab.notes, bzID: bzID),
//       notify: false,
//     );
//
//   }
//
// }
 */
// -----------------------------------------------------------------------------

/// BZ AUTHORSHIP NOTES STREAMING QUERY MODEL

// --------------------
///
FireQueryModel bzSentPendingAuthorshipNotesStreamQueryModel({
  @required String bzID,
  @required ValueChanged<List<Map<String, dynamic>>> onDataChanged,
}){

  return FireQueryModel(
    collRef: Fire.getSuperCollRef(
      aCollName: FireColl.bzz,
      bDocName: bzID,
      cSubCollName: FireSubColl.noteReceiver_receiver_notes,
    ),
    limit: 50,
    orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
    onDataChanged: onDataChanged,
    finders: <FireFinder>[

      FireFinder(
        field: 'senderID',
        comparison: FireComparison.equalTo,
        value: bzID,
      ),

      // FireFinder(
      //   field: 'noteType',
      //   comparison: FireComparison.equalTo,
      //   value: NoteModel.cipherNoteType(NoteType.authorship),
      // ),

      const FireFinder(
        field: 'poll.reply',
        comparison: FireComparison.equalTo,
        value: PollModel.pending,
      ),

    ],
  );

}
// --------------------
///
FireQueryModel bzSentDeclinedAndCancelledNotesPaginatorQueryModel({
  @required String bzID,
  @required ValueChanged<List<Map<String, dynamic>>> onDataChanged,
}){

  return FireQueryModel(
    collRef: Fire.getSuperCollRef(aCollName: FireColl.notes),
    limit: 10,
    orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
    onDataChanged: onDataChanged,
    finders: <FireFinder>[

      FireFinder(
        field: 'senderID',
        comparison: FireComparison.equalTo,
        value: bzID,
      ),

      // FireFinder(
      //   field: 'noteType',
      //   comparison: FireComparison.equalTo,
      //   value: NoteModel.cipherNoteType(NoteType.authorship),
      // ),

      const FireFinder(
        field: 'poll.reply',
        comparison: FireComparison.equalTo,
        value: PollModel.decline,
      ),

      // /// TASK : ??? will this work ?
      // FireFinder(
      //   field: 'response',
      //   comparison: FireComparison.equalTo,
      //   value: NoteModel.cipherResponse(NoteResponse.cancelled),
      // ),

    ],
  );

}
// -----------------------------------------------------------------------------

/// SENDING AUTHORSHIP INVITATIONS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSendAuthorshipInvitation({
  @required BuildContext context,
  @required UserModel selectedUser,
  @required BzModel bzModel,
}) async {

  final bool _canInviteUser = BzModel.checkCanInviteUser(
    bzModel: bzModel,
    userID: selectedUser.id,
  );

  /// USER CAN BE INVITED
  if (_canInviteUser == true){

    final bool _result = await Dialogs.userDialog(
      context: context,
      titleVerse: const Verse(
        text: 'phid_send_invitation_?',
        translate: true,
      ),
      bodyVerse: Verse(
          text: '##confirm sending invitation to ${selectedUser.name} to become an author of ${bzModel.name} account',
          translate: true,
          variables: [selectedUser.name, bzModel.name]
      ),
      userModel: selectedUser,
    );

    if (_result == true){

      await AuthorshipProtocols.sendRequest(
        context: context,
        bzModel: bzModel,
        userModelToSendTo: selectedUser,
      );

      unawaited(TopDialog.showTopDialog(
        context: context,
        firstVerse: const Verse(
          text: 'phid_invitation_sent',
          translate: true,
        ),
        secondVerse: Verse(
          text: '##Account authorship invitation has been sent to ${selectedUser.name} successfully',
          translate: true,
          variables: selectedUser.name,
        ),
        color: Colorz.green255,
        textColor: Colorz.white255,
      ));

    }

  }

  /// USER IS ALREADY AN AUTHOR OR PENDING AUTHOR
  else {

    final bool _isAuthor = AuthorModel.checkAuthorsContainUserID(
        authors: bzModel.authors,
        userID: selectedUser.id,
    );

    final String _body = _isAuthor == true ? 'phid_user_is_author_already' : 'phid_user_is_pending_author';

    await Dialogs.userDialog(
      context: context,
      titleVerse: const Verse(
        text: 'phid_can_not_invite_user',
        translate: true,
      ),
      bodyVerse: Verse(
          text: _body,
          translate: true,
      ),
      userModel: selectedUser,
    );

  }


}
// --------------------
///
Future<void> onCancelSentAuthorshipInvitation ({
  @required BuildContext context,
  // @required NoteModel note,
}) async {

  blog('onCancelSentAuthorshipInvitation : old code need fixing');

  // if (note != null){
  //
  //   final UserModel _receiverModel = await UserProtocols.fetchUser(
  //       context: context,
  //       userID: note.parties.receiverID
  //   );
  //
  //   final bool _result = await CenterDialog.showCenterDialog(
  //     context: context,
  //     titleVerse: const Verse(
  //       text: 'phid_cancel_invitation_?',
  //       translate: true,
  //     ),
  //     bodyVerse: Verse(
  //       text: '##${_receiverModel.name} will be notified with cancelling this invitation',
  //       translate: true,
  //       variables: _receiverModel.name,
  //     ),
  //     boolDialog: true,
  //     confirmButtonVerse: const Verse(
  //       text: 'phid_yes_cancel_invitation',
  //       translate: true,
  //     ),
  //   );
  //
  //   if (_result == true){
  //
  //     await NoteEvent.cancelSentAuthorshipInvitation(
  //       context: context,
  //       note: note,
  //     );
  //
  //     await TopDialog.showTopDialog(
  //       context: context,
  //       firstVerse: const Verse(
  //         pseudo: 'Invitation request has been cancelled',
  //         text: 'phid_invitation_is_cancelled',
  //         translate: true,
  //       ),
  //       color: Colorz.green255,
  //       textColor: Colorz.white255,
  //     );
  //
  //   }
  //
  // }

}
// -----------------------------------------------------------------------------
