import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/x_screens/g_bz/a_bz_profile/a_my_bz_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/user_profile/user_banner.dart';
import 'package:bldrs/c_protocols/author_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/fire_models/query_models/fire_finder.dart';
import 'package:bldrs/e_db/fire/fire_models/query_models/query_order_by.dart';
import 'package:bldrs/e_db/fire/fire_models/query_models/query_parameters.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/e_db/fire/ops/note_ops.dart' as NoteFireOps;
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// -----------------------------------------------------------------------------

/// BZ AUTHORSHIP NOTES STREAMING QUERY MODEL

// ------------------------------------------
/// TESTED : WORKS PERFECT
FireQueryModel bzSentPendingAuthorshipNotesStreamQueryModel({
  @required String bzID,
  @required ValueChanged<List<Map<String, dynamic>>> onDataChanged,
}){

  return FireQueryModel(
    collName: FireColl.notes,
    limit: 50,
    orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
    onDataChanged: onDataChanged,
    finders: <FireFinder>[

      FireFinder(
        field: 'senderID',
        comparison: FireComparison.equalTo,
        value: bzID,
      ),

      FireFinder(
        field: 'noteType',
        comparison: FireComparison.equalTo,
        value: NoteModel.cipherNoteType(NoteType.authorship),
      ),

      FireFinder(
        field: 'response',
        comparison: FireComparison.equalTo,
        value: NoteModel.cipherResponse(NoteResponse.pending),
      ),

    ],
  );

}
// ------------------------------------------
/// TESTED : NOT YET
FireQueryModel bzSentDeclinedAndCancelledNotesPaginatorQueryModel({
  @required String bzID,
  @required ValueChanged<List<Map<String, dynamic>>> onDataChanged,
}){

  return FireQueryModel(
    collName: FireColl.notes,
    limit: 10,
    orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
    onDataChanged: onDataChanged,
    finders: <FireFinder>[

      FireFinder(
        field: 'senderID',
        comparison: FireComparison.equalTo,
        value: bzID,
      ),

      FireFinder(
        field: 'noteType',
        comparison: FireComparison.equalTo,
        value: NoteModel.cipherNoteType(NoteType.authorship),
      ),

      FireFinder(
        field: 'response',
        comparison: FireComparison.equalTo,
        value: NoteModel.cipherResponse(NoteResponse.declined),
      ),

      /// TASK : ??? will this work ?
      FireFinder(
        field: 'response',
        comparison: FireComparison.equalTo,
        value: NoteModel.cipherResponse(NoteResponse.cancelled),
      ),

    ],
  );

}
// -----------------------------------------------------------------------------

/// SENDING AUTHORSHIP INVITATIONS

// -------------------------------
/// TESTED : SENDS GOOD : need translations
Future<void> onSendAuthorshipInvitation({
  @required BuildContext context,
  @required UserModel selectedUser,
  @required BzModel bzModel,
}) async {

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    title: 'Send Invitation ?',
    body: 'confirm sending invitation to ${selectedUser.name} to become an author of ${bzModel.name} account',
    boolDialog: true,
    height: 500,
    child: UserBanner(
      userModel: selectedUser,
    ),
  );

  if (_result == true){

    await NoteProtocols.sendAuthorshipInvitationNote(
      context: context,
      bzModel: bzModel,
      userModelToSendTo: selectedUser,
    );

    // final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
    // await _notesProvider.addNewPendingSentAuthorshipNote(
    //   context: context,
    //   note: _note,
    //   notify: true,
    // );

    unawaited(
        TopDialog.showTopDialog(
          context: context,
          firstLine: 'Invitation Sent',
          secondLine: 'Account authorship invitation has been sent to ${selectedUser.name} successfully',
          color: Colorz.green255,
          textColor: Colorz.white255,
        ));

  }

}
// -------------------------------
/// TESTED : WORKS PERFECT
Future<void> onCancelSentAuthorshipInvitation ({
  @required BuildContext context,
  @required NoteModel note,
}) async {

  if (note != null){

    final UserModel _receiverModel = await UsersProvider.proFetchUserModel(
        context: context,
        userID: note.receiverID
    );

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      title: 'Cancel Invitation ?',
      body: '${_receiverModel.name} will be notified with cancelling this invitation',
      boolDialog: true,
      confirmButtonText: 'Yes, Cancel Invitation',
    );

    if (_result == true){

      await NoteProtocols.cancelSentAuthorshipInvitation(
          context: context,
          note: note,
      );

      await TopDialog.showTopDialog(
        context: context,
        firstLine: 'Invitation request has been cancelled',
        color: Colorz.green255,
        textColor: Colorz.white255,
      );

    }

  }

}
// -----------------------------------------------------------------------------

/// AUTHORSHIP NOTE RESPONSES

// ------------------------------------------
/// TESTED : WORKS PERFECT
Future<void> respondToAuthorshipNote({
  @required BuildContext context,
  @required NoteResponse response,
  @required NoteModel noteModel,
  @required BzModel bzModel,
}) async {

  // NOTE : USER RESPONSE TO AUTHORSHIP INVITATION

  await NoteFireOps.markNoteAsSeen(
      context: context,
      noteModel: noteModel
  );

  /// ACCEPT AUTHORSHIP
  if (response == NoteResponse.accepted){
    await _acceptAuthorshipInvitation(
      context: context,
      noteModel: noteModel,
      bzModel: bzModel,
    );
  }

  /// DECLINE AUTHORSHIP
  else if (response == NoteResponse.declined){
    await _declineAuthorshipInvitation(
      context: context,
      noteModel: noteModel,
    );
  }

  else {
    blog('respondToAuthorshipNote : response : $response');
  }

}
// ------------------------------------------

/// ACCEPT AUTHORSHIP INVITATION

// -------------------
/// TESTED :
Future<void> _acceptAuthorshipInvitation({
  @required BuildContext context,
  @required NoteModel noteModel,
  @required BzModel bzModel,
}) async {

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    title: 'Accept invitation ?',
    body: 'This will add you as an Author for this business account',
    boolDialog: true,
  );

  if (_result == true){

    blog('_acceptAuthorshipInvitation : accepted ');

    unawaited(WaitDialog.showWaitDialog(
      context: context,
      loadingPhrase: "Adding you to '${bzModel.name}' business account",
    ));

    await AuthorProtocol.addMeAsNewAuthorToABzProtocol(
      context: context,
      oldBzModel: bzModel,
    );

    /// MODIFY NOTE RESPONSE
    await NoteProtocols.modifyNoteResponse(
      context: context,
      noteModel: noteModel,
      response: NoteResponse.accepted,
    );

    await NoteProtocols.sendAuthorshipAcceptanceNote(
      context: context,
      bzID: noteModel.senderID,
    );

    WaitDialog.closeWaitDialog(context);

    await CenterDialog.showCenterDialog(
      context: context,
      title: 'You have become an Author in ${bzModel.name}',
      body: 'You can control the business account, publish flyers, reply to costumers on behalf of the business and more.',
      confirmButtonText: 'Great',
    );

    await goToMyBzScreen(
      context: context,
      bzID: bzModel.id,
      replaceCurrentScreen: true,
    );

  }

}
// ------------------------------------------

/// DECLINE AUTHORSHIP INVITATION

// -------------------
/// TESTED :
Future<void> _declineAuthorshipInvitation({
  @required BuildContext context,
  @required NoteModel noteModel,
}) async {
  blog('_declineAuthorshipInvitation : decline ');

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    title: 'Decline invitation ?',
    body: 'This will reject the invitation and you will not be added as an author.',
    confirmButtonText: 'Decline Invitation',
    boolDialog: true,
  );

  if (_result == true){

    await NoteProtocols.modifyNoteResponse(
      context: context,
      noteModel: noteModel,
      response: NoteResponse.declined,
    );

  }

}
// -------------------
/*
/// TESTED : WORKS PERFECT
Future<void> _modifyNoteResponse({
  @required BuildContext context,
  @required NoteModel noteModel,
  @required NoteResponse response,
}) async {

  final NoteModel _newNoteModel = noteModel.copyWith(
    response: response,
    responseTime: DateTime.now(),
  );

  await NoteFireOps.updateNote(
    context: context,
    newNoteModel: _newNoteModel,
  );

}
 */
// ------------------------------------------

/// NAVIGATION

// -------------------
Future<void> goToMyBzScreen({
  @required BuildContext context,
  @required String bzID,
  @required bool replaceCurrentScreen,
}) async {

  final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);

  final BzModel _bzModel = await _bzzProvider.fetchBzByID(
    context: context,
    bzID: bzID,
  );

  _bzzProvider.setActiveBz(
    bzModel: _bzModel,
    notify: true,
  );

  if (replaceCurrentScreen == true){
    await Nav.replaceScreen(
        context: context,
        screen: const MyBzScreen()
    );
  }

  else {
    await Nav.goToNewScreen(
        context: context,
        screen: const MyBzScreen()
    );
  }


}
