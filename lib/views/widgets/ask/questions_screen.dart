import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'questions_list.dart';
import 'questions_provider.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final questionsProvider = Provider.of<QuestionsProvider>(context);

    return Container(
      child: MainLayout(
        pyramids: Iconz.PyramidsGlass,
        appBarType: AppBarType.Basic,
        appBarRowWidgets: <Widget>[
          SuperVerse(
            verse: 'Questions list',
            labelColor: Colorz.White10,
            margin: 5,
            size: 4,
          ),

        ],

        layoutWidget: QuestionsList(questions: questionsProvider.getQuestionsList()),
      ),
    );
  }
}



