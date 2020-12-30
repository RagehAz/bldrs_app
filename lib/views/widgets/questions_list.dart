import 'package:bldrs/models/question_model.dart';
import 'package:bldrs/providers/questions_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuestionsList extends StatelessWidget {
  const QuestionsList({Key key, this.questions}) : super(key: key);
  final List<Question> questions;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(questions[index].body));
        });
  }
}
