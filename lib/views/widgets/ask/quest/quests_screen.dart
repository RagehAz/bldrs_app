import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/ask/quest/quests_list.dart';
import 'package:bldrs/views/widgets/ask/question/questions_provider.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class QuesScreen extends StatelessWidget {
  const QuesScreen({Key key}) : super(key: key);

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

        layoutWidget: QuestList(questions: questionsProvider.getQuestionsList()),
      ),
    );
  }
}



