import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/b_views/z_components/app_bar/bldrs_sliver_app_bar_small.dart';
import 'package:bldrs/b_views/z_components/buttons/flyer_type_button.dart';
import 'package:bldrs/b_views/z_components/questions/questions_grid.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/xxx_lab/ask/question/question_model.dart';
import 'package:bldrs/xxx_lab/ask/question/questions_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuestionsScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const QuestionsScreenView({
    @required this.currentQuestionsBzType,
    @required this.onChangeCurrentFlyerType,
    @required this.questionsGridScrollController,
    @required this.sliverNestedScrollController,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<BzType> currentQuestionsBzType;
  final ValueChanged<BzType> onChangeCurrentFlyerType;
  final ScrollController questionsGridScrollController;
  final ScrollController sliverNestedScrollController;
  /// --------------------------------------------------------------------------
  bool _isSelected({
    @required BzType questionType,
    @required BzType currentQuestionType,
  }){

    bool _isSelected = false;

    if (currentQuestionType == questionType){
      _isSelected = true;
    }

    return _isSelected;
  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    return NestedScrollView(
      key: const ValueKey<String>('QuestionsScreenView'),
      // controller: sliverNestedScrollController,
      physics: const BouncingScrollPhysics(),
      floatHeaderSlivers: true,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){

        return <Widget>[

          /// QUESTIONS SCREEN SLIVER TABS
          ValueListenableBuilder(
            valueListenable: currentQuestionsBzType,
            builder: (_, BzType _currentBzType, Widget childB){

              return BldrsSliverAppBarSmall(
                content: ListView.builder(
                  controller: ScrollController(),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: sectionsList.length,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemBuilder: (_, index){

                    final BzType _bzType = BzModel.bzTypesList[index];
                    final String _flyerTypeString = BzModel.translateBzType(
                      context: context,
                      bzType: _bzType,
                    );

                    final bool _typeIsSelected = _isSelected(
                      questionType: _bzType,
                      currentQuestionType: _currentBzType,
                    );

                    return
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.5),
                        child: FlyerTypeButton(
                          key: ValueKey<String>('questions_bzType_tab_button_$_flyerTypeString'),
                          verse: BzModel.translateBzType(
                              context: context,
                              bzType: _bzType
                          ),
                          icon: Iconizer.bzTypeIconOff(_bzType),
                          isSelected: _typeIsSelected,
                          onTap: () => onChangeCurrentFlyerType(_bzType),
                        ),
                      );

                  },
                ),
              );

            },
          ),

        ];

      },

      /// QUESTIONS GRIDS PAGES
      body: Consumer<QuestionsProvider>(
        builder: (_, QuestionsProvider questionsProvider, Widget child){

          final List<QuestionModel> _questions = questionsProvider.hotQuestions;

          return

            ValueListenableBuilder(
                valueListenable: currentQuestionsBzType,
                builder: (_, BzType _currentBzType, Widget childB){

                  final List<QuestionModel> _questionsOfThisType = QuestionModel.filterQuestionsByBzType(
                    questions: _questions,
                    bzType: _currentBzType,
                  );

                  return

                    QuestionsGrid(
                      key: ValueKey<String>('QuestionsGrid_$_currentBzType'),
                      questionsGridScrollController: questionsGridScrollController,
                      questions: _questionsOfThisType,
                    );

                }
            );

        },
      ),

    );

  }
}
