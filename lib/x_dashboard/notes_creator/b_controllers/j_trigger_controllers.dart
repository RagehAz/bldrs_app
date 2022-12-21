import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_trigger_model.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
/// TESTED : WORKS PERFECT
void onAddTrigger({
  @required ValueNotifier<NoteModel> noteNotifier,
  @required TriggerModel trigger,
  @required bool mounted,
}){

  setNotifier(
      notifier: noteNotifier,
      mounted: mounted,
      value: noteNotifier.value.copyWith(function: trigger),
  );

}
// --------------------
/// TESTED : WORKS PERFECT
void removeTrigger({
  @required ValueNotifier<NoteModel> noteNotifier,
  @required bool mounted,
}){

  setNotifier(
      notifier: noteNotifier,
      mounted: mounted,
      value: noteNotifier.value.nullifyField(
        function: true,
      ),
  );

}
// -----------------------------------------------------------------------------
