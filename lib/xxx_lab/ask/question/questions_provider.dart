import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/xxx_lab/ask/quest/quest_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuestionsProvider with ChangeNotifier {
  /// --------------------------------------------------------------------------
  QuestionsProvider() {
    fetchQuestions();
  }

  /// --------------------------------------------------------------------------
  final List<Quest> _questions = <Quest>[];
// ----------------------------------------------------------------------------
  CollectionReference<Object> questionsFirebase =
      FirebaseFirestore.instance.collection('questions');
// ----------------------------------------------------------------------------
  List<Quest> getQuestionsList() => _questions;
// ----------------------------------------------------------------------------
  Future<void> fetchQuestions() async {
    _questions.clear();

    final QuerySnapshot<Object> _snapshot = await questionsFirebase.get();

    for (final QueryDocumentSnapshot<Object> doc in _snapshot.docs) {
      final Quest _newQ = Quest.fromMap(doc.data());
      _questions.add(_newQ);
    }

    notifyListeners();
  }

// ----------------------------------------------------------------------------
  void add(String question) {
    questionsFirebase
        .add(<String, dynamic>{'body': question, 'userID': 'xxxxxxxxxxxxxxxxx'})
        .then((DocumentReference<Object> value) =>
            blog('Question Added to Database.'))
        .catchError((Object error) =>
            blog('Failed to add Question to DataBase: $error'));
    fetchQuestions();
    notifyListeners();
  }
// ----------------------------------------------------------------------------
}
