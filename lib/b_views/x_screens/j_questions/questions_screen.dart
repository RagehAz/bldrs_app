import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/y_views/j_questions/questions_screen_view.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/ask/question/questions_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const QScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  State<QScreen> createState() => _QScreenState();
/// --------------------------------------------------------------------------
}

class _QScreenState extends State<QScreen> {
// -----------------------------------------------------------------------------
  ScrollController _questionsGridScrollController;
  ScrollController _sliverNestedScrollController;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _questionsGridScrollController = ScrollController();
    _sliverNestedScrollController = ScrollController();
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void didChangeDependencies() {

    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
    _uiProvider.startController((){

      final QuestionsProvider _questionsProvider = Provider.of<QuestionsProvider>(context, listen: false);

      _questionsProvider.getSetHotQuestions(context: context, notify: true);

    });

    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  final ValueNotifier<BzType> _currentQuestionsBzType = ValueNotifier(BzType.developer);
  void onChangeCurrentFlyerType(BzType bzType){
    _currentQuestionsBzType.value = bzType;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pageTitle: 'Questions',
      appBarType: AppBarType.basic,
      historyButtonIsOn: false,
      sectionButtonIsOn: false,
      // zoneButtonIsOn: true,
      // pyramidsAreOn: false,
      pyramidsAreOn: true,
      skyType: SkyType.black,
      layoutWidget: QuestionsScreenView(
        onChangeCurrentFlyerType: onChangeCurrentFlyerType,
        currentQuestionsBzType: _currentQuestionsBzType,
        questionsGridScrollController: _questionsGridScrollController,
        sliverNestedScrollController: _sliverNestedScrollController,
      ),

    );

  }
}
