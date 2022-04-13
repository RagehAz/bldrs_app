import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/c_flyer_hero.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/questions/a_question_structure/e_question_tree.dart';
import 'package:bldrs/c_controllers/i_flyer_controllers/flyer_controller.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/xxx_dashboard/a_modules/a_test_labs/specialized_labs/ask/question/question_model.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

Widget questionFlightShuttle({
  @required BuildContext flightContext,
  @required Animation<double> animation, // 0 to 1
  @required HeroFlightDirection flightDirection,
  @required BuildContext fromHeroContext,
  @required BuildContext toHeroContext,
  @required QuestionModel questionModel,
  @required UserModel userModel,
  @required double minWidthFactor,
}) {

  /// 'push' if expanding --- 'pop' if contracting
  final String _curveName = flightDirection.name;

  final Curve _curve = _curveName == 'push' ? Curves.fastOutSlowIn : Curves.fastOutSlowIn.flipped;

  final Tween<double> _tween = _curveName == 'push' ?
  Tween<double>(begin: 0, end: 1)
      :
  Tween<double>(begin: 1, end: 0);

  return TweenAnimationBuilder(
      key: const ValueKey<String>('FlyerHero_TweenAnimationBuilder'),
      tween: _tween,
      duration: Ratioz.duration150ms,
      curve: _curve,
      builder: (ctx, double value, Widget child){

        final double _flyerWidthFactor = flyerWidthSizeFactor(
          tween: value,
          minWidthFactor: minWidthFactor,
          // maxWidthFactor: 1, REDUNDANT
        );

        final double _flyerBoxWidth = FlyerBox.width(flightContext, _flyerWidthFactor);

        final FlightDirection _flightDirection = getFlightDirection(flightDirection.name);

        return Scaffold(
          backgroundColor: Colorz.nothing,
          body: QuestionTree(
            flyerBoxWidth: _flyerBoxWidth,
            questionModel: questionModel,
            userModel: userModel,
            loading: true,
            flightDirection: _flightDirection,
          ),
        );

      }
  );
}
// -----------------------------------------------------------------------------
