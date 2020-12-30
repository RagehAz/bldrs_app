import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/xxx_LABORATORY/ask/questions_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            labelColor: Colorz.WhiteAir,
            margin: 5,
            size: 4,
          ),

        ],

        layoutWidget: QuestionsList(questions: questionsProvider.getQuestionsList()),
      ),
    );
  }
}



