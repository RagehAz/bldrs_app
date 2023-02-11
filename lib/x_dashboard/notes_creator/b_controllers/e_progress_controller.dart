import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------

/// POSTER

// --------------------
/// TESTED : WORKS PERFECT
void onSwitchNoteProgress({
  @required bool value,
  @required ValueNotifier<NoteModel> noteNotifier,
  @required bool mounted,
}){

  blog('value : $value : ${noteNotifier.value.progress}');

  /// SWITCH ON
  if (value == true){

    setNotifier(
        notifier: noteNotifier,
        mounted: mounted,
        value: noteNotifier.value.copyWith(
          progress: 0,
        ),
    );

  }

  /// SWITCH OFF
  else {

    setNotifier(
      notifier: noteNotifier,
      mounted: mounted,
      value: noteNotifier.value.nullifyField(
        progress: true,
      ),
    );

  }

}
// --------------------
/// TESTED : WORKS PERFECT
void onTriggerNoteLoading({
  @required ValueNotifier<NoteModel> noteNotifier,
  @required bool mounted,
}){

  /// IF IS LOADING
  if (noteNotifier.value.progress == -1){

    setNotifier(
        notifier: noteNotifier,
        mounted: mounted,
        value: noteNotifier.value.copyWith(
          progress: 0,
        ),

    );

  }

  /// IF IS NOT LOADING
  else {

    setNotifier(
        notifier: noteNotifier,
        mounted: mounted,
        value: noteNotifier.value.copyWith(
            progress: -1
        ),
    );

  }

}
// --------------------
///
void onIncrementNoteProgress({
  @required ValueNotifier<NoteModel> noteNotifier,
  @required int amount,
  @required bool mounted,
}){

  if (noteNotifier.value.progress < 100){

    int _result = noteNotifier.value.progress + amount;
    if (_result > 100){
      _result = 100;
    }

    setNotifier(
        notifier: noteNotifier,
        mounted: mounted,
        value: noteNotifier.value.copyWith(
          progress: _result,
        ),
    );

  }

}
// --------------------
///
void onDecrementNoteProgress({
  @required ValueNotifier<NoteModel> noteNotifier,
  @required int amount,
  @required bool mounted,
}){
  if (noteNotifier.value.progress > -1){

    int _result = noteNotifier.value.progress - amount;
    if (_result < -1){
      _result = -1;
    }

    setNotifier(
        notifier: noteNotifier,
        mounted: mounted,
        value: noteNotifier.value.copyWith(
          progress: _result,
        ),
    );

  }

}
// -----------------------------------------------------------------------------
