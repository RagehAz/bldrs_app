import 'package:bldrs/a_models/flyer/sub/review_model.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/e_footer_button.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/a_info_button_structure/a_info_button_starter.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/review_button/a_review_button_structure/c_review_page_tree.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class QuestionReviewPageStarter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const QuestionReviewPageStarter({
    @required this.flyerBoxWidth,
    @required this.tinyMode,
    @required this.onReviewButtonTap,
    @required this.reviewButtonExpanded,
    @required this.reviewPageVerticalController,
    @required this.inFlight,
    @required this.onEditReview,
    @required this.isEditingReview,
    @required this.onSubmitReview,
    @required this.reviewTextController,
    @required this.onShowReviewOptions,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final bool tinyMode;
  final Function onReviewButtonTap;
  final ValueNotifier<bool> reviewButtonExpanded;
  final ScrollController reviewPageVerticalController;
  final bool inFlight;
  final Function onEditReview;
  final ValueNotifier<bool> isEditingReview;
  final Function onSubmitReview;
  final TextEditingController reviewTextController;
  final ValueChanged<ReviewModel> onShowReviewOptions;
// -----------------------------------------------------------------------------

  /// WIDTH

// --------------------------------
  static double _tinyWidth({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){
    final double _tinyWidth = FooterButton.buttonSize(context: context, flyerBoxWidth: flyerBoxWidth, tinyMode: true);
    return _tinyWidth;
  }
// --------------------------------
  static double collapsedWidth({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){
    final double _width = FooterButton.buttonSize(context: context, flyerBoxWidth: flyerBoxWidth, tinyMode: false);
    return _width;
  }
// --------------------------------
  static double expandedWidth({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){
    final double _expandedHeight = InfoButtonStarter.expandedWidth(context: context, flyerBoxWidth: flyerBoxWidth);
    return _expandedHeight;
  }
// -----------------------------------------------------------------------------

  /// HEIGHT

// --------------------------------
  static double _tinyHeight({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){
    return _tinyWidth(context: context, flyerBoxWidth: flyerBoxWidth);
  }
// --------------------------------
  static double collapsedHeight({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){

    final double _collapsedHeight = FooterButton.buttonSize(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
      tinyMode: false,
    );

    return _collapsedHeight;
  }
// --------------------------------
  static double expandedHeight({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){

    final double _headerHeight = FlyerBox.headerBoxHeight(flyerBoxWidth: flyerBoxWidth);
    final double _footerExpandedMargin = InfoButtonStarter.expandedMarginValue(context: context, flyerBoxWidth: flyerBoxWidth);
    final double _flyerHeight = FlyerBox.height(context, flyerBoxWidth);

    final _expandedReviewPageHeight = _flyerHeight - _headerHeight - (_footerExpandedMargin * 2);

    return _expandedReviewPageHeight;
  }
// -----------------------------------------------------------------------------

  /// MARGIN

// --------------------------------
//   static double _tinyMarginValue({
//     @required BuildContext context,
//     @required double flyerBoxWidth,
// }){
//     final double _margin = FooterButton.buttonMargin(context: context, flyerBoxWidth: flyerBoxWidth, tinyMode: true);
//     return _margin;
//   }
// --------------------------------
  /*
  static double _collapsedRightEnMargin({
    @required BuildContext context,
    @required double flyerBoxWidth,
    @required bool tinyMode,
  }){

    final double _buttonCollapsedSize = FooterButton.buttonSize(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
      tinyMode: tinyMode,
    );
    final double _footerButtonMargin = FooterButton.buttonMargin(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
      tinyMode: tinyMode,
    );

    final double _rightEnMargin = _buttonCollapsedSize + (_footerButtonMargin * 2);

    return _rightEnMargin * 0;
  }
   */
// --------------------------------
  /*
  static double _expandedRightEnMargin({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){
    final double _expandedRightMargin = FooterButton.buttonMargin(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
      tinyMode: false,
    );

    return _expandedRightMargin;
  }
   */
// --------------------------------
  static double _leftEnMargin({
    @required BuildContext context,
    @required double flyerBoxWidth,
    @required bool tinyMode,
  }){

    final double _footerButtonMargin = FooterButton.buttonMargin(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
      tinyMode: tinyMode,
    );

    return _footerButtonMargin;
  }
// -----------------------------------------------------------------------------

  /// COLOR

// --------------------------------
//   static Color _tinyColor(){
//     return Colorz.green125;
//   }
// --------------------------------
  static Color _collapsedColor(){
    return Colorz.black255;
  }
// --------------------------------
  static Color _expandedColor(){
    return Colorz.black255;
  }
// -----------------------------------------------------------------------------

  /// CORNERS

// --------------------------------
  static double _tinyCornerValue({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){
    final double _cornerValue = FooterButton.buttonRadius(context: context, flyerBoxWidth: flyerBoxWidth, tinyMode: true);
    return _cornerValue;
  }
// --------------------------------
  static double _collapsedCornerValue({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){
    final double _cornerValue = FooterButton.buttonRadius(context: context, flyerBoxWidth: flyerBoxWidth, tinyMode: false);
    return _cornerValue;
  }
// --------------------------------
  static double expandedCornerValue({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){
    final double _cornerValue = InfoButtonStarter.expandedCornerValue(context: context, flyerBoxWidth: flyerBoxWidth);
    return _cornerValue;
  }
// -----------------------------------------------------------------------------

  /// GETTERS

// --------------------------------
  static double getWidth({
    @required BuildContext context,
    @required bool tinyMode,
    @required double flyerBoxWidth,
    @required bool isExpanded,
  }){
    double _width;

    /// TINY MODE
    if (tinyMode == true){
      _width = _tinyWidth(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
      );
    }

    /// FULL SCREEN MODE
    else {

      /// EXPANDED
      if (isExpanded == true){
        _width = expandedWidth(
          context: context,
          flyerBoxWidth: flyerBoxWidth,
        );
      }

      /// COLLAPSED
      else {
        _width = collapsedWidth(
          context: context,
          flyerBoxWidth: flyerBoxWidth,
        );
      }

    }

    return _width;
  }
// --------------------------------
  static double getHeight({
    @required BuildContext context,
    @required bool tinyMode,
    @required double flyerBoxWidth,
    @required bool isExpanded,
  }){
    double _height;

    /// TINY MODE
    if (tinyMode == true){
      _height = _tinyHeight(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
      );
    }

    /// FULL SCREEN MODE
    else {

      /// EXPANDED
      if (isExpanded == true){
        _height = expandedHeight(
          context: context,
          flyerBoxWidth: flyerBoxWidth,
        );
      }

      /// COLLAPSED
      else {

        _height = collapsedHeight(
          context: context,
          flyerBoxWidth: flyerBoxWidth,
        );

      }

    }

    return _height;

  }
// --------------------------------
  static BorderRadius getBorders({
    @required BuildContext context,
    @required bool tinyMode,
    @required double flyerBoxWidth,
    @required bool isExpanded,
  }){
    double _cornerValue;

    /// TINY MODE
    if (tinyMode == true){
      _cornerValue = _tinyCornerValue(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
      );
    }

    /// FULL SCREEN MODE
    else {

      /// EXPANDED
      if (isExpanded == true){
        _cornerValue = expandedCornerValue(
          context: context,
          flyerBoxWidth: flyerBoxWidth,
        );
      }

      /// COLLAPSED
      else {

        _cornerValue = _collapsedCornerValue(
          context: context,
          flyerBoxWidth: flyerBoxWidth,
        );

      }

    }

    final BorderRadius _borderRadius = Borderers.superBorderAll(context, _cornerValue);


    return _borderRadius;

  }
// --------------------------------
  static Color getColor({
    @required bool tinyMode,
    @required bool isExpanded,
  }){
    Color _color;

    // if (tinyMode == true){
    //   _color = _tinyColor();
    // }

    // else {

    if (isExpanded == true){
      _color = _expandedColor();
    }

    else {
      _color = _collapsedColor();
    }

    // }

    return _color;
  }
// --------------------------------
  static EdgeInsets getMargin({
    @required BuildContext context,
    @required bool tinyMode,
    @required double flyerBoxWidth,
    @required bool isExpanded,
  }){

    final double _leftMargin = _leftEnMargin(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
      tinyMode: tinyMode,
    );

    // final double _collapsedRightMargin = _collapsedRightEnMargin(
    //   context: context,
    //   flyerBoxWidth: flyerBoxWidth,
    //   tinyMode: tinyMode,
    // );

    // final double _expandedRightMargin = _expandedRightEnMargin(
    //     context: context,
    //     flyerBoxWidth: flyerBoxWidth
    // );

    final EdgeInsets _margins = Scale.superInsets(
      context: context,
      bottom: _leftMargin,
      // enTop: 0,
      // enRight: 0,
      // enLeft: 0,
    );

    return _margins;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      key: const ValueKey<String>('QuestionReviewPageStarter'),
      onTap: onReviewButtonTap,
      child: ValueListenableBuilder<bool>(
        valueListenable: reviewButtonExpanded,
        builder: (_, bool reviewButtonIsExpanded, Widget reviewPageTree){

          final double _width = getWidth(
            context: context,
            tinyMode: tinyMode,
            flyerBoxWidth: flyerBoxWidth,
            isExpanded: reviewButtonIsExpanded,
          );

          final double _height = getHeight(
            context: context,
            tinyMode: tinyMode,
            flyerBoxWidth: flyerBoxWidth,
            isExpanded: reviewButtonIsExpanded,
          );

          final EdgeInsets _margins = getMargin(
            context: context,
            tinyMode: tinyMode,
            flyerBoxWidth: flyerBoxWidth,
            isExpanded: reviewButtonIsExpanded,
          );

          final Color _color = getColor(
            tinyMode: tinyMode,
            isExpanded: reviewButtonIsExpanded,
          );

          final BorderRadius _borders = getBorders(
            context: context,
            tinyMode: tinyMode,
            flyerBoxWidth: flyerBoxWidth,
            isExpanded: reviewButtonIsExpanded,
          );

          return AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            width: _width ,
            height: _height,
            decoration: BoxDecoration(
              borderRadius: _borders,
              color: _color,
            ),
            margin: _margins,
            alignment: Alignment.center,
            child: reviewPageTree,
          );

        },

        child: ReviewPageTree(
          flyerBoxWidth: flyerBoxWidth,
          onReviewButtonTap: onReviewButtonTap,
          reviewButtonExpanded: reviewButtonExpanded,
          reviewPageVerticalController: reviewPageVerticalController,
          inFlight: inFlight,
          tinyMode: tinyMode,
          onEditReview: onEditReview,
          isEditingReview: isEditingReview,
          onSubmitReview: onSubmitReview,
          reviewTextController: reviewTextController,
          onShowReviewOptions: onShowReviewOptions,
          flyerID: 'x',
        ),

      ),
    );

  }
}
