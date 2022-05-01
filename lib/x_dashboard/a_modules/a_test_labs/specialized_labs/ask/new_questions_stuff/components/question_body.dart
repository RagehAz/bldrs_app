import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/ask/question/question_model.dart';
import 'package:flutter/material.dart';

class QuestionBody extends StatelessWidget {

  const QuestionBody({
    @required this.questionModel,
    Key key
  }) : super(key: key);

  final QuestionModel questionModel;

  @override
  Widget build(BuildContext context) {

    final double _bubbleClearWidth = Bubble.clearWidth(context);

    return SizedBox(
      key: const ValueKey<String>('question_body'),
      width: _bubbleClearWidth,
      child: Column(
        children: <Widget>[

          SuperVerse(
            verse: questionModel.headline,
            size: 4,
            margin: 5,
            maxLines: 3,
          ),

          SuperVerse(
            verse: questionModel.body,
            weight: VerseWeight.thin,
            size: 3,
            maxLines: 1000,
          ),

        ],
      ),
    );
  }
}
