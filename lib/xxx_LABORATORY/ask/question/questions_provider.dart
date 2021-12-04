import 'package:bldrs/xxx_LABORATORY/ask/quest/quest_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuestionsProvider with ChangeNotifier {
  List<Quest> _questions = <Quest>[];
// ----------------------------------------------------------------------------
  CollectionReference<Object> questionsFirebase =
      FirebaseFirestore.instance.collection('questions');
// ----------------------------------------------------------------------------
  QuestionsProvider() {
    fetchQuestions();
  }
// ----------------------------------------------------------------------------
  getQuestionsList() => _questions;
// ----------------------------------------------------------------------------
  fetchQuestions() async {
    _questions.clear();

    final QuerySnapshot<Object> _snapshot = await questionsFirebase.get();

    for (QueryDocumentSnapshot<Object> doc in _snapshot.docs){
      final Quest _newQ = Quest.fromMap(doc.data());
      _questions.add(_newQ);
    }

    notifyListeners();
  }
// ----------------------------------------------------------------------------
  add(String question) {
    questionsFirebase
        .add(<String, dynamic>{"body": question, "userID": 'xxxxxxxxxxxxxxxxx'})
        .then((DocumentReference<Object> value) => print("Question Added to Database."))
        .catchError(
            (Object error) => print("Failed to add Question to DataBase: $error"));
    fetchQuestions();
    notifyListeners();
  }
}
