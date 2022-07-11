import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/b_flyer_loading.dart';
import 'package:bldrs/b_views/z_components/questions/a_question_structure/c_question_full_screen.dart';
import 'package:bldrs/b_views/z_components/questions/a_question_structure/d_question_hero.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/ask/question/question_model.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuestionStarter extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const QuestionStarter({
    @required this.questionModel,
    @required this.minWidthFactor,
    this.heroTag,
    this.isFullScreen = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final QuestionModel questionModel;
  final double minWidthFactor;
  final bool isFullScreen;
  final String heroTag;
  /// --------------------------------------------------------------------------
  @override
  _QuestionStarterState createState() => _QuestionStarterState();
}

class _QuestionStarterState extends State<QuestionStarter> {
// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'xxxxx',);
    }
  }
// -----------------------------------------------------------------------------
  QuestionModel _questionModel;
  UserModel _userModel;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _questionModel = widget.questionModel;
    super.initState();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading(setTo: true).then((_) async {
// -----------------------------------------------------------------
        /// USER MODEL
        final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
        _userModel = await _usersProvider.fetchUserByID(
            context: context,
            userID: _questionModel.ownerID,
        );
// -----------------------------------------------------------------
        await _triggerLoading(setTo: false);

      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _loading.dispose();

    // if (_currentSlideIndex != null){
    //   _currentSlideIndex.dispose();
    // }

    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------
  Future<void> _openFullScreenFlyer() async {

    await context.pushTransparentRoute(
        QuestionFullScreen(
          key: const ValueKey<String>('Flyer_Full_Screen'),
          questionModel: _questionModel,
          userModel: _userModel,
          minWidthFactor: widget.minWidthFactor,
          heroTag: widget.heroTag,
        )
    );

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final double _flyerBoxWidth = FlyerBox.width(context, widget.minWidthFactor);

    return ValueListenableBuilder(
        key: ValueKey<String>('QuestionStarter_${widget.questionModel?.id}'),
        valueListenable: _loading,
        child: FlyerLoading(flyerBoxWidth: widget.minWidthFactor,),
        builder: (_, bool isLoading, Widget child){

          if (isLoading == true){
            return child;
          }

          else {

            return GestureDetector(
              onTap: _openFullScreenFlyer,
              child: QuestionHero(
                key: const ValueKey<String>('Question_hero'),
                questionModel: _questionModel,
                userModel: _userModel,
                minWidthFactor: widget.minWidthFactor,
                isFullScreen: widget.isFullScreen,
                heroTag: widget.heroTag,
              ),
            );

          }

        }
    );
  }
}
