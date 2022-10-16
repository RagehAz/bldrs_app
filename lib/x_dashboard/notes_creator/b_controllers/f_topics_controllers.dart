import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/e_notes/aa_topic_model.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------

/// TOPIC

// --------------------
void onSelectTopic({
  @required TopicModel topic,
  @required PartyType partyType,
  @required ValueNotifier<NoteModel> noteNotifier,
}){

  final String _topicID = TopicModel.concludeTopicID(
    topicID: topic.id,
    partyType: partyType,
    bzID: null,
  );

  noteNotifier.value = noteNotifier.value.copyWith(
    topic: _topicID,
  );

}
// -----------------------------------------------------------------------------
