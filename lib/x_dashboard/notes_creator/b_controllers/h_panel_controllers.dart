import 'dart:async';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scrollers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/x_dashboard/notes_creator/x_lab_screens/x_import_template_screen/a_import_template_note_screen.dart';
import 'package:bldrs/x_dashboard/notes_creator/draft_note.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

// -----------------------------------------------------------------------------

/// NOTE OPTIONS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onNoteCreatorCardOptionsTap({
  @required BuildContext context,
  @required DraftNote draftNote,
}) async {

  // await BottomDialog.showButtonsBottomDialog(
  //     context: context,
  //     draggable: true,
  //     numberOfWidgets: 2,
  //     titleVerse: const Verse(
  //       text: 'phid_options',
  //       translate: true,
  //     ),
  //     buttonHeight: 50,
  //     builder: (_){
  //
  //       return <Widget>[
  //
  //
  //
  //       ];
  //
  //     }
  // );

}
// -----------------------------------------------------------------------------

/// TEST

// --------------------
Future<void> onTestNote({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> noteNotifier,
}) async {

  /// NOTE : THIS SEND GLOBAL AWESOME NOTIFICATION "NOOT"

}
// -----------------------------------------------------------------------------

/// BLOG

// --------------------
Future<void> onBlogNote({
  @required ValueNotifier<NoteModel> noteNotifier,
}) async {
  noteNotifier.value.blogNoteModel();
}
// -----------------------------------------------------------------------------

/// CLEAR

// --------------------
/// TESTED : WORKS PERFECT
void clearNote({
  @required DraftNote draftNote,
}){
  draftNote.noteNotifier.value = NoteModel.initialNoteForCreation;
  draftNote.titleController.clear();
  draftNote.bodyController.clear();
  draftNote.receiversModels.value = [];
}
// -----------------------------------------------------------------------------

/// IMPORTING

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onGoToNoteTemplatesScreen({
  @required BuildContext context,
  @required DraftNote draftNote,
}) async {

  final NoteModel _templateNote = await Nav.goToNewScreen(
    context: context,
    screen: const ImportTemplateNoteScreen(),
    transitionType: PageTransitionType.rightToLeft,
  );

  if (_templateNote != null){

    draftNote.receiversModels.value = await _getReceiversModelsByReceiversIDs(
      context: context,
      receiversIDs: <String>[_templateNote.parties.receiverID],
      partyType: _templateNote.parties.receiverType,
    );

    draftNote.noteNotifier.value = _templateNote;
    draftNote.titleController.text = _templateNote.title;
    draftNote.bodyController.text = _templateNote.body;

    await Scrollers.scrollToTop(
      controller: draftNote.scrollController,
    );

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<List<dynamic>> _getReceiversModelsByReceiversIDs({
  @required BuildContext context,
  @required List<String> receiversIDs,
  @required PartyType partyType,
}) async {

  List<dynamic> _output = <dynamic>[];

  if (Mapper.checkCanLoopList(receiversIDs) == true){

    if (partyType == PartyType.user){
      _output = await UserProtocols.fetchUsers(
        context: context,
        usersIDs: receiversIDs,
      );
    }

    if (partyType == PartyType.bz){
      _output = await BzProtocols.fetchBzz(
          context: context,
          bzzIDs: receiversIDs
      );
    }

  }

  return _output;
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSelectNoteTemplateTap({
  @required BuildContext context,
  @required NoteModel noteModel,
}) async {

  await Nav.goBack(
    context: context,
    invoker: 'onSelectNoteTemplateTap',
    passedData: noteModel,
  );

}
// -----------------------------------------------------------------------------
