import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/xxx_lab/ask/quest/quests_list.dart';
import 'package:bldrs/xxx_lab/ask/question/questions_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuesScreen extends StatelessWidget {
  const QuesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final QuestionsProvider questionsProvider =
        Provider.of<QuestionsProvider>(context);

    return MainLayout(
      pyramids: Iconz.pyramidsGlass,
      appBarType: AppBarType.basic,
      appBarRowWidgets: const <Widget>[
        SuperVerse(
          verse: 'Questions list',
          labelColor: Colorz.white10,
          margin: 5,
          size: 4,
        ),
      ],
      layoutWidget: QuestList(questions: questionsProvider.getQuestionsList()),
    );
  }
}
