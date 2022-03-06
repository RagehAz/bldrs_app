import 'package:bldrs/b_views/z_components/flyer/c_flyer_groups/flyers_grid.dart';
import 'package:bldrs/b_views/z_components/questions/a_question_structure/a_question_starter.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/xxx_lab/ask/question/question_model.dart';
import 'package:flutter/material.dart';

class QuestionsGrid extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const QuestionsGrid({
    @required this.questions,
    @required this.questionsGridScrollController,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<QuestionModel> questions;
  final ScrollController questionsGridScrollController;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final int _numberOfColumns = FlyersGrid.gridColumnCount(questions.length);
    const double _spacing = Ratioz.appBarMargin;
    final double _flyerBoxWidth = FlyersGrid.calculateFlyerBoxWidth(
      flyersLength: questions.length,
      context: context,
    );

    return
      questions.isEmpty ?
      const SizedBox()
          :
      GridView.builder(
        key: const ValueKey<String>('QuestionsGrid'),
        itemCount: questions.length,
        // controller: flyersGridScrollController,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(right: _spacing, left: _spacing, top: _spacing, bottom: Ratioz.horizon),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _numberOfColumns,
          mainAxisSpacing: _spacing,
          crossAxisSpacing: _spacing,
          childAspectRatio: 1 / Ratioz.xxflyerZoneHeight,
        ),
        itemBuilder: (BuildContext ctx, int index) {

          /// NORMAL QUESTION
          return QuestionStarter(
            questionModel: questions[index],
            minWidthFactor: FlyersGrid.getFlyerMinWidthFactor(
                gridFlyerWidth: _flyerBoxWidth,
                gridZoneWidth: superScreenWidth(context)
            ),
          );

        },
      );
  }
}
