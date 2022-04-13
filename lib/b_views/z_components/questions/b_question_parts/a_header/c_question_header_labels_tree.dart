import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/questions/b_question_parts/a_header/d_question_header_labels.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/ask/question/question_model.dart';
import 'package:flutter/material.dart';

class QuestionHeaderLabelsTree extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const QuestionHeaderLabelsTree({
    @required this.headerLabelsWidthTween,
    @required this.logoMinWidth,
    @required this.logoSizeRatioTween,
    @required this.flyerBoxWidth,
    @required this.questionModel,
    @required this.userModel,
    @required this.tinyMode,
    @required this.headerIsExpanded,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Animation<double> headerLabelsWidthTween;
  final double logoMinWidth;
  final Animation<double> logoSizeRatioTween;
  final double flyerBoxWidth;
  final QuestionModel questionModel;
  final UserModel userModel;
  final bool tinyMode;
  final ValueNotifier<bool> headerIsExpanded;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder<bool>(
      valueListenable: headerIsExpanded,
      child: Center(
        child: SizedBox(
          width: headerLabelsWidthTween.value,
          height: logoMinWidth * logoSizeRatioTween.value,
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: <Widget>[

              // if (tinyMode == false)
                QuestionHeaderLabels(
                  flyerBoxWidth: flyerBoxWidth  * logoSizeRatioTween.value,
                  userModel: userModel,
                  headerIsExpanded: false,
                ),

            ],
          ),
        ),
      ),
      builder: (_, bool headerIsExpanded, Widget child){

        final double _opacity =
        headerIsExpanded == true ? 0
        //     :
        // tinyMode == true ? 0
            :
        1;

        return AnimatedOpacity(
          key: const ValueKey<String>('Header_labels_Animated_opacity'),
          opacity: _opacity,
          duration: Ratioz.durationFading200,
          child: child,
        );

      },
    );

  }
}
