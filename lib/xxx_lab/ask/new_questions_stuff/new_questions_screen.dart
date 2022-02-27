import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/xxx_lab/ask/new_questions_stuff/components/asked_question.dart';
import 'package:bldrs/xxx_lab/ask/question/question_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewQuestionsHome extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NewQuestionsHome({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final UserModel _currentUserModel = _usersProvider.myUserModel;
    final QuestionModel _questionModel = QuestionModel.dummyQuestion(context);

    return MainLayout(
      pyramidsAreOn: true,
      zoneButtonIsOn: false,
      sectionButtonIsOn: false,
      historyButtonIsOn: false,
      appBarType: AppBarType.basic,
      pageTitle: 'Questions',
      layoutWidget: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: Ratioz.stratosphere),
        itemCount: 10,
        itemBuilder: (_, index){

          return AskedQuestion(
            askerUserModel: _currentUserModel,
            questionModel: _questionModel,
          );

        },
      ),

    );

  }
}
