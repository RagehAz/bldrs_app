import 'dart:async';

import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/note_protocols/a_note_protocols.dart';
import 'package:bldrs/f_helpers/drafters/scrollers.dart';
import 'package:bldrs/x_dashboard/notes_creator/draft_note.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// SEND

// --------------------
///
Future<void> onSendNote({
  @required BuildContext context,
  @required DraftNote draftNote,
}) async {

  final bool _formIsValid = draftNote.formKey.currentState.validate();

  if (_formIsValid == true && draftNote.receiversModels.value.isNotEmpty){

    final bool _continue = await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: Verse.plain('Send ?'),
      bodyVerse: Verse.plain('Do you want to confirm sending this notification to '
          '${draftNote.receiversModels.value.length} ${NoteModel.getNoteCollName(draftNote.noteNotifier.value)} '),
      boolDialog: true,
    );

    if (_continue == true){

      unawaited(WaitDialog.showWaitDialog(context: context));

      /// IF ONE RECEIVER
      if (draftNote.receiversModels.value.length == 1){

        final List<String> _receiversIDs = NoteParties.getReceiversIDs(
          receiversModels: draftNote.receiversModels.value,
          partyType: draftNote.noteNotifier.value.parties.receiverType,
        );

        blog('878');

        await NoteProtocols.composeToOne(
          context: context,
          note: NoteProtocols.adjustReceiverID(
            receiverID: _receiversIDs.first,
            note: draftNote.noteNotifier.value,
          ),
          // uploadPoster: true,
        );

      }

      /// IF MANY RECEIVERS
      else {

        await NoteProtocols.composeToMultiple(
          context: context,
          note: draftNote.noteNotifier.value,
          receiversIDs: NoteParties.getReceiversIDs(
            receiversModels: draftNote.receiversModels.value,
            partyType: draftNote.noteNotifier.value.parties.receiverType,
          ),
        );

      }

      await WaitDialog.closeWaitDialog(context);

      await Scrollers.scrollToTop(
        controller: draftNote.scrollController,
      );

      unawaited(TopDialog.showTopDialog(
        context: context,
        firstVerse: Verse.plain('Note Sent'),
        secondVerse: Verse.plain('Alf Mabrouk ya5oya'),
        milliseconds: 200,
      ));

    }

  }

}
// -----------------------------------------------------------------------------
