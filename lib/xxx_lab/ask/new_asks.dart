import 'package:bldrs/b_views/z_components/buttons/main_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/xxx_lab/ask/new_questions_stuff/new_questions_screen.dart';
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
              verse: 'Go to old Questions screen',
              icon: Iconz.utPlanning,
              onTap: () async {
                await goToNewScreen(context, const QuestionScreen());
              }
          ),

          MainButton(
              verse: 'Go to old Ask screen',
              icon: Iconz.utPlanning,
              onTap: () async {
                await goToNewScreen(context, const OldAskScreen());
              }
          ),

          MainButton(
              verse: 'NEW QUESTIONS HOME',
              icon: Iconz.utPlanning,
              buttonColor: Colorz.red125,
              onTap: () async {
                await goToNewScreen(context, const NewQuestionsHome());
              }
          ),

        ],
      ),

    );

  }
}
