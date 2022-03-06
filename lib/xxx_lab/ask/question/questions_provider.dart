import 'package:bldrs/xxx_lab/ask/question/question_model.dart';
import 'package:flutter/material.dart';

class QuestionsProvider with ChangeNotifier {
// ----------------------------------------------------------------------------

  /// HOT QUESTIONS

// -------------------------------------
  List<QuestionModel> _hotQuestions = <QuestionModel>[];
// -------------------------------------
  List<QuestionModel> get hotQuestions {
    return [..._hotQuestions];
  }
// -------------------------------------
  Future<void> getSetHotQuestions({
    @required BuildContext context,
    @required bool notify,
  }) async {

    final List<QuestionModel> _dummyQuestions = <QuestionModel>[
      QuestionModel.dummyQuestion(context: context, questionID: 'aaa'),
      QuestionModel.dummyQuestion(context: context, questionID: 'bbb'),
      QuestionModel.dummyQuestion(context: context, questionID: 'ccc'),
      QuestionModel.dummyQuestion(context: context, questionID: 'ddd'),
      QuestionModel.dummyQuestion(context: context, questionID: 'eee'),
      QuestionModel.dummyQuestion(context: context, questionID: 'fff'),
    ];

    _hotQuestions = _dummyQuestions;

    if (notify == true){
      notifyListeners();
    }

  }
// ----------------------------------------------------------------------------
}
