import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/e_notes/aa_topic_model.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------

/// TOPIC

// --------------------
/// TESTED : WORKS PERFECT
void onSelectTopic({
  @required TopicModel topic,
  @required PartyType partyType,
  @required ValueNotifier<NoteModel> noteNotifier,
  @required bool mounted,
}){

  /// WHILE CREATING NOTE : TOPIC ID WILL BE RAW WITHOUT ADDING A BZ ID TO IT
  /// SO NO NEED TO CONCLUDE THE COMPOUND TOPIC ID
  // final String _topicID = TopicModel.concludeTopicID(
  //   topicID: topic.id,
  //   partyType: partyType,
  //   bzID: null,
  // );

  setNotifier(
      notifier: noteNotifier,
      mounted: mounted,
      value: noteNotifier.value.copyWith(
        topic: topic.id,
      ),
  );


}
// -----------------------------------------------------------------------------
