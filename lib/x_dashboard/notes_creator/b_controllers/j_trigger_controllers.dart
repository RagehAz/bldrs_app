import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_trigger_model.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
/// TESTED : WORKS PERFECT
void onAddTrigger({
  @required ValueNotifier<NoteModel> noteNotifier,
  @required TriggerModel trigger,
}){

  noteNotifier.value = noteNotifier.value.copyWith(
    trigger: trigger,
  );

}
// --------------------
/// TESTED : WORKS PERFECT
void removeTrigger({
  @required ValueNotifier<NoteModel> noteNotifier,
}){

  noteNotifier.value = noteNotifier.value.nullifyField(
    trigger: true,
  );

}
// -----------------------------------------------------------------------------
