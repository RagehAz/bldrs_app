import 'package:bldrs/b_views/widgets/general/buttons/main_button.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/xxx_lab/ask/new_questions_stuff/new_questions_screen.dart';
import 'package:bldrs/xxx_lab/ask/quest/quests_screen.dart';
import 'package:bldrs/xxx_lab/ask/question/ask_screen.dart';
import 'package:bldrs/xxx_lab/ask/question/question_screen.dart';
import 'package:flutter/material.dart';

class NewAsks extends StatelessWidget {

  const NewAsks({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pyramidsAreOn: true,
      zoneButtonIsOn: false,
      sectionButtonIsOn: false,
      historyButtonIsOn: false,
      appBarType: AppBarType.basic,
      pageTitle: 'Questions',
      layoutWidget: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: Ratioz.stratosphere),
        children: <Widget>[

          MainButton(
              buttonVerse: 'Go to old Questions screen',
              buttonIcon: Iconz.utPlanning,
              function: () async {
                await goToNewScreen(context, const QuestionScreen());
              }
          ),

          MainButton(
              buttonVerse: 'Go to old Ask screen',
              buttonIcon: Iconz.utPlanning,
              function: () async {
                await goToNewScreen(context, const OldAskScreen());
              }
          ),

          MainButton(
              buttonVerse: 'Go to old ques screen',
              buttonIcon: Iconz.utPlanning,
              function: () async {
                await goToNewScreen(context, const QuesScreen());
              }
          ),

          MainButton(
              buttonVerse: 'NEW QUESTIONS HOME',
              buttonIcon: Iconz.utPlanning,
              buttonColor: Colorz.red125,
              function: () async {
                await goToNewScreen(context, const NewQuestionsHome());
              }
          ),

        ],
      ),

    );

  }
}
