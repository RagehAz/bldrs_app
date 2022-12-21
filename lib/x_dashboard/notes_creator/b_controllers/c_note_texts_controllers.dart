import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------

/// BODY AND TITLE

// --------------------
/// TESTED : WORKS PERFECT
void onTitleChanged({
  @required String text,
  @required ValueNotifier<NoteModel> noteNotifier,
  @required bool mounted,
}){

  final NoteModel _updated = noteNotifier.value.copyWith(
    title: text,
  );

  setNotifier(
      notifier: noteNotifier,
      mounted: mounted,
      value: _updated
  );


}
// --------------------
/// TESTED : WORKS PERFECT
void onBodyChanged({
  @required String text,
  @required ValueNotifier<NoteModel> noteNotifier,
  @required bool mounted,
}){

  final NoteModel _updated = noteNotifier.value.copyWith(
    body: text,
  );

  setNotifier(
      notifier: noteNotifier,
      mounted: mounted,
      value: _updated,
  );

}
// -----------------------------------------------------------------------------

/// VALIDATORS

// --------------------
///
String noteTitleValidator(String text){
  if (text.length >= 30){
    return 'max length exceeded Bitch';
  }
  else if (text.isEmpty == true){
    return 'Atleast put 1 Character man';
  }
  else {
    return null;
  }
}
// --------------------
///
String noteBodyValidator(String text){
  {
    if (text.length >= 80){
      return 'max length exceeded Bitch';
    }
    else if (text.isEmpty){
      return 'Add more than 1 Character';
    }
    else {
      return null;
    }
  }
}
// -----------------------------------------------------------------------------
