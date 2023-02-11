import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poll_model.dart';
import 'package:stringer/stringer.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------

/// BUTTONS

// --------------------
/// TESTED : WORKS PERFECT
void onAddNoteButton({
  @required ValueNotifier<NoteModel> noteNotifier,
  @required String button,
  @required bool mounted,
}){

  /// POLL IS EMPTY
  if (noteNotifier.value.poll == null){

    setNotifier(
        notifier: noteNotifier,
        mounted: mounted,
        value: noteNotifier.value.copyWith(
          poll: PollModel(
            buttons: [button],
            reply: null,
            replyTime: null,
          ),
        ),
    );

  }

  /// POLL HAS STUFF
  else {

    final List<String> _updatedButtons = Stringer.addOrRemoveStringToStrings(
      strings: noteNotifier.value?.poll?.buttons,
      string: button,
    );

    if (_updatedButtons.isEmpty == true){

      setNotifier(
          notifier: noteNotifier,
          mounted: mounted,
          value: noteNotifier.value.nullifyField(
            poll: true,
          ),
      );

    }

    else {

      setNotifier(
          notifier: noteNotifier,
          mounted: mounted,
          value: noteNotifier.value.copyWith(
            poll: noteNotifier.value.poll.copyWith(
              buttons: _updatedButtons,
            ),
          ),
      );

    }

  }

}
// -----------------------------------------------------------------------------

/// VALIDATOR

// --------------------
String noteButtonsValidator(NoteModel note){
  String _message;

  // if (note?.type == NoteType.authorship){
  //   if (note?.buttons?.length != 2){
  //     return 'Authorship Note should include yes & no buttons';
  //   }
  // }

  return _message;
}
// -----------------------------------------------------------------------------
