import 'package:bldrs/views/widgets/questions_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bldrs/providers/questions_provider.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final questionsProvider = Provider.of<QuestionsProvider>(context);
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text("Questions list")),
        body: QuestionsList(questions: questionsProvider.getQuestionsList()),
      ),
    );
  }
}
