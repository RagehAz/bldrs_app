import 'dart:async';

import 'package:bldrs/a_models/flyer/records/review_model.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/b_footer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/c_footer_shadow.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/info_button_type.dart';
import 'package:bldrs/b_views/z_components/questions/b_question_parts/b_footer/b_question_footer_buttons.dart';
import 'package:bldrs/b_views/z_components/questions/b_question_parts/b_footer/review_button/a_review_button_structure/a_convertible_review_page_pre_starter.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/animators.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/xxx_dashboard/a_modules/a_test_labs/specialized_labs/ask/question/question_model.dart';
import 'package:flutter/material.dart';

class QuestionFooter extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const QuestionFooter({
    @required this.flyerBoxWidth,
    @required this.questionModel,
    @required this.tinyMode,
    @required this.onNiceQuestion,
    @required this.questionIsNice,
    @required this.headerIsExpanded,
    @required this.inFlight,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final QuestionModel questionModel;
  final bool tinyMode;
  final Function onNiceQuestion;
  final ValueNotifier<bool> questionIsNice;
  final ValueNotifier<bool> headerIsExpanded;
  final bool inFlight;

  @override
  State<QuestionFooter> createState() => _QuestionFooterState();
}

class _QuestionFooterState extends State<QuestionFooter> {

  ScrollController _infoPageVerticalController;
  ScrollController _reviewPageVerticalController;
  TextEditingController _reviewTextController;

  @override
  void initState() {
    _infoPageVerticalController = ScrollController();
    _reviewPageVerticalController = ScrollController();
    _reviewTextController = TextEditingController();
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    disposeScrollControllerIfPossible(_infoPageVerticalController);
    disposeScrollControllerIfPossible(_reviewPageVerticalController);
    disposeControllerIfPossible(_reviewTextController);
    super.dispose();
  }
// -----------------------------------------------------------------------------
  void _onShareQuestion(){
    blog('SHARE QUESTION NOW');
  }
// -----------------------------------------------------------------------------
  final ValueNotifier<bool> _infoButtonExpanded = ValueNotifier(false);
// ----------------------------------------
  Future<void> onInfoButtonTap() async {
    _infoButtonExpanded.value = !_infoButtonExpanded.value;

    if(_infoButtonExpanded.value == false){
      unawaited(
          _infoPageVerticalController.animateTo(0,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeOut,
          )
      );

      await Future.delayed(const Duration(milliseconds: 200), (){
        _canShowConvertibleReviewButton.value = true;
      });
    }

    if (_infoButtonExpanded.value == true){
      _reviewButtonExpanded.value = false;
      _canShowConvertibleReviewButton.value = false;
    }

  }
// -----------------------------------------------------------------------------
  final ValueNotifier<bool> _reviewButtonExpanded = ValueNotifier(false);
  final ValueNotifier<bool> _canShowConvertibleReviewButton = ValueNotifier(true);
// ----------------------------------------
  void onReviewButtonTap(){
    _reviewButtonExpanded.value = !_reviewButtonExpanded.value;
  }
// -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isEditingReview = ValueNotifier(false);
  void _onEditReview(){
    blog('onEditReview');
    _isEditingReview.value = !_isEditingReview.value;
  }
// -----------------------------------------------------------------------------
  void _onSubmitReview(){
    blog('_onSubmitReview : ${_reviewTextController.text}');
  }
// -----------------------------------------------------------------------------
  void _onShowReviewOptions(ReviewModel reviewModel){
    blog('_onShowReviewOptions : $reviewModel');
  }
// -----------------------------------------------------------------------------
  bool _canShowInfoButtonChecker({
    @required InfoButtonType infoButtonType,
  }){
    bool _canShow = true;

    if (widget.tinyMode == true || widget.inFlight == true){
      if (infoButtonType == InfoButtonType.info){
        _canShow = false;
      }
    }

    return _canShow;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Positioned(
      bottom: 0,
      child: ValueListenableBuilder(
        valueListenable: widget.headerIsExpanded,
        builder: (_, bool _headerIsExpanded, Widget child){

          return AnimatedOpacity(
            opacity: _headerIsExpanded ? 0 : 1,
            duration: Ratioz.duration150ms,
            child: child,
          );

        },
        child: SizedBox(
          key: const ValueKey<String>('question_footer_box'),
          width: widget.flyerBoxWidth,
          height: FooterBox.collapsedHeight(context: context, flyerBoxWidth: widget.flyerBoxWidth, tinyMode: widget.tinyMode),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[

              /// BOTTOM SHADOW
              FooterShadow(
                key: const ValueKey<String>('FooterShadow'),
                flyerBoxWidth: widget.flyerBoxWidth,
                tinyMode: widget.tinyMode,
              ),

              /// FOOTER BUTTONS
              QuestionFooterButtons(
                key: const ValueKey<String>('FooterButtons'),
                flyerBoxWidth: widget.flyerBoxWidth,
                tinyMode: widget.tinyMode,
                onSaveFlyer: widget.onNiceQuestion,
                onReviewFlyer: onReviewButtonTap,
                onShareFlyer: _onShareQuestion,
                flyerIsSaved: widget.questionIsNice,
                inFlight: widget.inFlight,
              ),

              // /// INFO BUTTON
              // if (_canShowInfoButton == true)
              //   InfoButtonStarter(
              //     flyerBoxWidth: widget.flyerBoxWidth,
              //     flyerModel: widget.questionModel,
              //     flyerZone: widget.flyerZone,
              //     tinyMode: widget.tinyMode,
              //     infoButtonExpanded: _infoButtonExpanded,
              //     onInfoButtonTap: onInfoButtonTap,
              //     infoButtonType: _infoButtonType,
              //     infoPageVerticalController: _infoPageVerticalController,
              //     inFlight: widget.inFlight,
              //   ),

              /// CONVERTIBLE REVIEW BUTTON
              if (widget.tinyMode == false && widget.inFlight == false)
                QuestionConvertibleReviewPagePreStarter(
                  infoButtonExpanded: _infoButtonExpanded,
                  canShowConvertibleReviewButton: _canShowConvertibleReviewButton,
                  flyerBoxWidth: widget.flyerBoxWidth,
                  tinyMode: widget.tinyMode,
                  onReviewButtonTap: onReviewButtonTap,
                  reviewButtonExpanded: _reviewButtonExpanded,
                  reviewPageVerticalController: _reviewPageVerticalController,
                  inFlight: widget.inFlight,
                  onEditReview: _onEditReview,
                  isEditingReview: _isEditingReview,
                  onSubmitReview: _onSubmitReview,
                  reviewTextController: _reviewTextController,
                  onShowReviewOptions: _onShowReviewOptions,
                  centeredInFooter: true,
                ),

            ],
          ),
        ),
      ),
    );

  }
}
