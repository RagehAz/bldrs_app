import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/ask/new_questions_stuff/components/asker_label.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/ask/new_questions_stuff/components/private_replies_counter.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/ask/new_questions_stuff/components/question_body.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/ask/new_questions_stuff/components/question_pictures_builder.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/ask/new_questions_stuff/components/question_reply_buttons.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/ask/new_questions_stuff/components/question_separator_line.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/ask/question/question_model.dart';
import 'package:flutter/material.dart';

class AskedQuestion extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AskedQuestion({
    @required this.askerUserModel,
    @required this.questionModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final UserModel askerUserModel;
  final QuestionModel questionModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Bubble(
      centered: true,
      bubbleColor: Colorz.white10,
      columnChildren: <Widget>[

        /// ASKER LABEL
        AskerLabel(
          userModel: askerUserModel,
          questionModel: questionModel,
        ),

        /// QUESTION SEPARATOR LINE
        const QuestionSeparatorLine(),

        /// QUESTION BODY
        QuestionBody(
          questionModel: questionModel,
        ),

        /// QUESTION SEPARATOR LINE
        const QuestionSeparatorLine(lineIsON: false,),

        /// QUESTION PICTURES
        if (canLoopList(questionModel?.pics))
        QuestionPicturesBuilder(
          questionModel: questionModel,
          height: 200,
        ),

        /// QUESTION SEPARATOR LINE
        const QuestionSeparatorLine(),

        PrivateRepliesCounter(
          questionModel: questionModel,
        ),

        /// QUESTION SEPARATOR LINE
        const QuestionSeparatorLine(),

        QuestionReplyButtons(
          questionModel: questionModel,
          askerUserModel: askerUserModel,
        ),

      ],
    );

  }
}
