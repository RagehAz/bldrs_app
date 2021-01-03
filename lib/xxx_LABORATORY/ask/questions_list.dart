import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/views/widgets/space/stratosphere.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/xxx_LABORATORY/ask/question_model.dart';
import 'package:flutter/material.dart';

class QuestionsList extends StatelessWidget {
  const QuestionsList({Key key, this.questions}) : super(key: key);
  final List<Question> questions;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: Stratosphere.stratosphereSandwich,
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: SuperVerse(
              verse: '($index) :\n${questions[index].body}',
              maxLines: 100,
              labelColor: Colorz.WhiteAir,
              weight: VerseWeight.thin,
              size: 1,
              margin: 5,
              centered: false,
              color: Colorz.Yellow,

            ),
          );
        });
  }
}
