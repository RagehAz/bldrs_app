import 'dart:async';

import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/c_flyer_hero.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/f_saving_notice/a_saving_notice.dart';
import 'package:bldrs/b_views/z_components/questions/a_question_structure/f_question_box.dart';
import 'package:bldrs/b_views/z_components/questions/b_question_parts/a_header/a_question_header.dart';
import 'package:bldrs/b_views/z_components/questions/b_question_parts/b_footer/a_question_footer.dart';
import 'package:bldrs/b_views/z_components/questions/b_question_parts/c_question_body/a_question_body.dart';
import 'package:bldrs/c_controllers/i_flyer_controllers/header_controller.dart';
import 'package:bldrs/c_controllers/i_flyer_controllers/slides_controller.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart' as Sliders;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/xxx_dashboard/a_modules/a_test_labs/specialized_labs/ask/question/question_model.dart';
import 'package:flutter/material.dart';

class QuestionTree extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const QuestionTree({
    @required this.questionModel,
    @required this.userModel,
    @required this.flyerBoxWidth,
    @required this.flightDirection,
    this.onTap,
    this.loading = false,
    this.heroTag,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final QuestionModel questionModel;
  final UserModel userModel;
  final double flyerBoxWidth;
  final FlightDirection flightDirection;
  final Function onTap;
  final bool loading;
  final String heroTag;
  /// --------------------------------------------------------------------------
  // static const double flyerSmallWidth = 200;
  /// --------------------------------------------------------------------------
  @override
  State<QuestionTree> createState() => _QuestionTreeState();
}

class _QuestionTreeState extends State<QuestionTree> with TickerProviderStateMixin {
// -----------------------------------------------------------------------------
  /// FOR HEADER
  AnimationController _headerAnimationController;
  ScrollController _headerScrollController;
  /// FOR SLIDES
  PageController _horizontalSlidesController;
  /// FOR SAVING GRAPHIC
  AnimationController _animationController;
// ----------------------------------------------
  @override
  void initState() {
    super.initState();

    // ------------------------------------------
    /// FOR HEADER
    _headerScrollController = ScrollController();
    _headerAnimationController = initializeHeaderAnimationController(
      context: context,
      vsync: this,
    );
    // ------------------------------------------
    /// FOR SLIDES
    _horizontalSlidesController = PageController();
    // ------------------------------------------
    /// FOR SAVING GRAPHIC
    _animationController = AnimationController(
      vsync: this,
      duration: Ratioz.durationFading200,
      reverseDuration: Ratioz.durationFading200,
    );
    // ------------------------------------------

    // blog('FLYER IN FLIGHT : ${widget.flightDirection} : width : ${widget.flyerBoxWidth}');

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.flightDirection == FlightDirection.pop && _horizontalSlidesController.hasClients){

        unawaited(
            _horizontalSlidesController.animateToPage(0, duration: const Duration(milliseconds: 200), curve: Curves.easeOut)
        );
        // // blog('THE FUCKING INDEX WAS : ${widget.currentSlideIndex.value}');
        // widget.currentSlideIndex.value = 0;
        // // blog('THE FUCKING INDEX ISSS : ${widget.currentSlideIndex.value}');

      }
    });

  }
// -----------------------------------------------------------------------------
//   bool _isInit = true;
//   @override
//   void didChangeDependencies() {
//     if (_isInit) {
//     final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
//     _uiProvider.startController(
//             () async {
//
//               if (widget.currentSlideIndex.value == widget.flyerModel.slides.length && widget.inFlight == true){
//
//                 // await _slideToZeroIndex();
//                 blog('condition ahooooooooooooo is blah blah');
//
//               }
//
//
//         }
//     );
//     }
//     _isInit = false;
//     super.didChangeDependencies();
//   }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    super.dispose();
    _headerAnimationController.dispose();
    _headerScrollController.dispose();
    _animationController.dispose();
  }
// -----------------------------------------------------------------------------
  /// FOLLOW IS ON
  final ValueNotifier<bool> _followIsOn = ValueNotifier(false);
  void _setFollowIsOn(bool setTo) => _followIsOn.value = setTo;
// -----------------------------------------------------------------------------


  /// PROGRESS BAR OPACITY
  final ValueNotifier<double> _progressBarOpacity = ValueNotifier(1);
  /// HEADER IS EXPANDED
  final ValueNotifier<bool> _headerIsExpanded = ValueNotifier(false);
  /// HEADER PAGE OPACITY
  final ValueNotifier<double> _headerPageOpacity = ValueNotifier(0);
  /// SWIPE DIRECTION
  final ValueNotifier<Sliders.SwipeDirection> _swipeDirection = ValueNotifier(Sliders.SwipeDirection.next);
// -----------------------------------------------------------------------------
  Future<void> _onHeaderTap() async {

    // await Future.delayed(const Duration(milliseconds: 100),
    //         () async {

    await onTriggerHeader(
      context: context,
      headerAnimationController: _headerAnimationController,
      verticalController: _headerScrollController,
      headerIsExpanded: _headerIsExpanded,
      progressBarOpacity: _progressBarOpacity,
      headerPageOpacity: _headerPageOpacity,
    );

    // }
    // );

  }
// -----------------------------------------------------------------------------
  void _onSwipeSlide(int index){

    onHorizontalSlideSwipe(
      context: context,
      newIndex: index,
      currentSlideIndex: ValueNotifier<int>(0),
      swipeDirection: _swipeDirection,
    );

    // blog('index has become ${widget.currentSlideIndex.value}');

  }
// -----------------------------------------------------------------------------
  final ValueNotifier<bool> _flyerIsSaved = ValueNotifier(false);
  Future<void> _onSaveFlyer() async {

    // await Future.delayed(Ratioz.durationFading200, (){
    _flyerIsSaved.value = !_flyerIsSaved.value;
    await _triggerAnimation(_flyerIsSaved.value);
    // });

  }
// -----------------------------------------------------------------------------
  final ValueNotifier<bool> _graphicIsOn = ValueNotifier(false);
  final ValueNotifier<double> _graphicOpacity = ValueNotifier(1);
// -----------------------------------------------------------------------------
  Future<void> _triggerAnimation(bool isSaved) async {

    if (isSaved == true){

      /// 1 - GRAPHIC IS ALREADY OFF => SWITCH ON
      _graphicIsOn.value = true;
      _graphicOpacity.value = 1;

      // blog('-1 - _graphicIsOn => ${_graphicIsOn.value}');

      /// 2 - ANIMATE CONTROLLER
      await _animationController.forward(from: 0);
      // blog('-2 - _animatedController => $isSaved');

      /// 3 - START FADE OUT AND WAIT FOR IT
      _graphicOpacity.value = 0;
      // blog('-3 - _graphicOpacity => ${_graphicOpacity.value}');

      /// 4 - WAIT FOR FADE THEN SWITCH OFF GRAPHIC
      await Future.delayed(const Duration(milliseconds: 220), (){
        _graphicIsOn.value = false;
        // blog('-4 - _graphicIsOn => ${_graphicIsOn.value}');
      });

      /// 5 - READY THE FADE FOR THE NEXT ANIMATION
      await Future.delayed(const Duration(milliseconds: 200), (){
        _graphicOpacity.value = 1;
      });
      // blog('-5 - _canStartFadeOut => ${_graphicOpacity.value}');

    }

  }
// -----------------------------------------------------------------------------
//   Future<void> _slideToZeroIndex() async {
//     await Sliders.slideToBackFrom(_horizontalSlidesController, widget.currentSlideIndex.value);
//   }
// -----------------------------------------------------------------------------
  bool _inFlight(){

    if (widget.flightDirection == FlightDirection.non){
      return false;
    }
    else {
      return true;
    }

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // blog('${widget.flyerModel.slides[0].headline} : flight is : ${widget.inFlight}');

    final double _flyerBoxHeight = FlyerBox.height(context, widget.flyerBoxWidth);
    final bool _tinyMode = FlyerBox.isTinyMode(context, widget.flyerBoxWidth);

    return QuestionBox(
      key: const ValueKey<String>('QuestionTree_QuestionBox'),
      boxWidth: widget.flyerBoxWidth,
      boxColor: Colorz.blue80,
      stackWidgets: <Widget>[

        /// BODY
        QuestionBody(
          flyerBoxWidth: widget.flyerBoxWidth,
          flyerBoxHeight: _flyerBoxHeight,
          tinyMode: _tinyMode,
          questionModel: widget.questionModel,
        ),

        /// HEADER
        QuestionHeader(
          key: const ValueKey<String>('QuestionTree_QuestionHeader'),
          flyerBoxWidth: widget.flyerBoxWidth,
          onHeaderTap: _onHeaderTap,
          headerAnimationController: _headerAnimationController,
          headerScrollController: _headerScrollController,
          tinyMode: _tinyMode,
          headerIsExpanded: _headerIsExpanded,
          followIsOn: _followIsOn,
          headerPageOpacity: _headerPageOpacity,
          questionModel: widget.questionModel,
          userModel: widget.userModel,
        ),

        /// FOOTER
        QuestionFooter(
          key: const ValueKey<String>('QuestionTree_QuestionFooter'),
          flyerBoxWidth: widget.flyerBoxWidth,
          questionModel: widget.questionModel,
          tinyMode: _tinyMode,
          questionIsNice: _flyerIsSaved,
          onNiceQuestion: _onSaveFlyer,
          headerIsExpanded: _headerIsExpanded,
          inFlight: _inFlight(),
        ),

        /// NICE NOTICE
        if (_tinyMode != true && widget.flightDirection == FlightDirection.non)
          SavingNotice(
            isStarGraphic: true,
            key: const ValueKey<String>('NICE_NOTICE'),
            flyerBoxWidth: widget.flyerBoxWidth,
            flyerBoxHeight: _flyerBoxHeight,
            flyerIsSaved: _flyerIsSaved,
            animationController: _animationController,
            graphicIsOn: _graphicIsOn,
            graphicOpacity: _graphicOpacity,
          ),

      ],
    );

  }
}
