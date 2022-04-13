import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/questions/a_question_structure/d_question_hero.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/ask/question/question_model.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';

class QuestionFullScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const QuestionFullScreen({
    @required this.minWidthFactor,
    @required this.questionModel,
    @required this.userModel,
    @required this.heroTag,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double minWidthFactor;
  final QuestionModel questionModel;
  final UserModel userModel;
  final String heroTag;
  /// --------------------------------------------------------------------------
  Future<void> _onDismiss(BuildContext context) async {
    Nav.goBack(context);
    // currentSlideIndex.value = 0;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DismissiblePage(
      key: const ValueKey<String>('QuestionFullScreen_DismissiblePage'),
      onDismiss: () => _onDismiss(context),
      isFullScreen: false,
      dragSensitivity: .4,
      maxTransformValue: 4,
      // direction: DismissDirection.horizontal,
      reverseDuration: Ratioz.duration150ms,

      child: Material(
        color: Colors.transparent,
        type: MaterialType.transparency,

        child: QuestionHero(
          questionModel: questionModel,
          userModel: userModel,
          isFullScreen: true,
          minWidthFactor: minWidthFactor,
          heroTag: heroTag,
        ),

      ),
    );
  }
}
