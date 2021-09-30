import 'package:bldrs/views/widgets/specific/ask/quest/quest_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuestionsProvider with ChangeNotifier {
  List<Quest> _questions = <Quest>[];
// ----------------------------------------------------------------------------
  CollectionReference questionsFirebase =
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
    questionsFirebase.get().then((QuerySnapshot querySnapshot) => {
          querySnapshot.docs.forEach((doc) {
            final Quest newQuestion = Quest.fromMap(doc.data());
            _questions.add(newQuestion);
          })
        });
    notifyListeners();
  }
// ----------------------------------------------------------------------------
  add(String question) {
    questionsFirebase
        .add({"body": question, "userID": 'kjhfkskfkfk'})
        .then((value) => print("Question Added to Database."))
        .catchError(
            (error) => print("Failed to add Question to DataBase: $error"));
    fetchQuestions();
    notifyListeners();
  }
}
