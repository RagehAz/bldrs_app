import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------

/// SEND NOTE

// --------------------
/// TESTED : WORKS PERFECT
void onSwitchSendNote({
  @required ValueNotifier<NoteModel> noteNotifier,
  @required bool value,
  @required bool mounted,
}){

  setNotifier(
      notifier: noteNotifier,
      mounted: mounted,
      value: noteNotifier.value.copyWith(
        sendNote: value,
      )
  );

}
// -----------------------------------------------------------------------------

/// SEND FCM

// --------------------
/// TESTED : WORKS PERFECT
void onSwitchSendFCM({
  @required ValueNotifier<NoteModel> noteNotifier,
  @required bool value,
  @required bool mounted,
}){

  setNotifier(
      notifier: noteNotifier,
      mounted: mounted,
      value: noteNotifier.value.copyWith(
        sendFCM: value,
      ),
  );

}
// -----------------------------------------------------------------------------

/// IS DISMISSIBLE

// --------------------
void onSwitchIsDismissible({
  @required ValueNotifier<NoteModel> noteNotifier,
  @required bool value,
  @required bool mounted,
}){

  blog('dismissible was : ${noteNotifier.value.dismissible} : ${noteNotifier.value.dismissible} : and should be $value');

  setNotifier(
      notifier: noteNotifier,
      mounted: mounted,
      value: noteNotifier.value.copyWith(
        dismissible: value,
      ),
  );


}
// -----------------------------------------------------------------------------
