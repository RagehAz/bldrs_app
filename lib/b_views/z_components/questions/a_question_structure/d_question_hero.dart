import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/c_flyer_hero.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/questions/a_question_structure/e_question_tree.dart';
import 'package:bldrs/c_controllers/i_flyer_controllers/flyer_controller.dart';
import 'package:bldrs/c_controllers/j_question_controller/j_question_controllers.dart';
import 'package:bldrs/xxx_dashboard/a_modules/a_test_labs/specialized_labs/ask/question/question_model.dart';
import 'package:flutter/material.dart';

class QuestionHero extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const QuestionHero({
    @required this.questionModel,
    @required this.userModel,
    @required this.isFullScreen,
    @required this.minWidthFactor,
    @required this.heroTag,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final QuestionModel questionModel;
  final UserModel userModel;
  final bool isFullScreen;
  final double minWidthFactor;
  final String heroTag;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final String _heroTag = createHeroTag(
      heroTag: heroTag,
      flyerID: questionModel.id,
    );
    final double _factor = isFullScreen ?  1 : minWidthFactor;
    final double _flyerBoxWidth = FlyerBox.width(context, _factor);

    // blog('THE FUCKING BITCH ASS FLYER : ${flyerModel.id} SHOULD START AT : ${currentSlideIndex.value}');

    return Hero(
      key: ValueKey<String>(_heroTag),
      tag: _heroTag,
      flightShuttleBuilder: (
          BuildContext flightContext,
          Animation<double> animation,
          HeroFlightDirection flightDirection,
          BuildContext fromHeroContext,
          BuildContext toHeroContext,
          ){

        return questionFlightShuttle(
          questionModel: questionModel,
          userModel: userModel,
          minWidthFactor: minWidthFactor,
          animation: animation,
          flightContext: flightContext,
          flightDirection: flightDirection,
          fromHeroContext: fromHeroContext,
          toHeroContext: toHeroContext,
        );

      },

      child: QuestionTree(
        flyerBoxWidth: _flyerBoxWidth,
        questionModel: questionModel,
        heroTag: _heroTag,
        flightDirection: FlightDirection.non,
        userModel: userModel,
      ),

    );
  }
}
