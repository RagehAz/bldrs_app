import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/info_button_type.dart';
import 'package:bldrs/f_helpers/drafters/animators.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:flutter/material.dart';

class FlyerDim {
  /// --------------------------------------------------------------------------

  const FlyerDim();

  /// --------------------------------------------------------------------------
  // flyer ratios multiplied by flyerBoxWidth
  static const double xFlyerBoxHeight = 1.74;

  static const double xFlyerTopCorners = 0.05;
  static const double xFlyerBottomCorners = 0.11;

  static const double xFlyerHeaderMiniHeight = 0.27;
  static const double xFlyerHeaderMaxHeight = 1.3;

  static const double xAuthorImageCorners = 0.029;
  static const double xFollowCallWidth = 0.113;
  static const double xFollowCallSpacing = 0.005;
  static const double xFollowBTHeight = 0.1;
  static const double xCallBTHeight = 0.15;
  static const double xFooterBTMargins = 0.026;

  /// HEADER WIDTH OF EACH COMPONENT IN RESPECT TO flyerBoxWidth
  static const double xFlyerHeaderMainPadding = 0.006;
  static const double xFlyerLogoWidth = 0.26;
  static const double xFlyerAuthorPicWidth = 0.15;
  static const double xFlyerAuthorPicCorner = FlyerDim.xFlyerHeaderMiniHeight * 0.1083;
  static const double xFlyerAuthorNameWidth = 0.47;
  static const double xFlyerFollowBtWidth = 0.11;
  static const double xProgressBarHeightRatio = 0.0125;
  static const double xFlyersGridSpacing = 0.02;

  /// Business logo corners Ratio in respect to Container Width or Height
  static const double rBzLogoCorner = 0.17152;
  // -----------------------------------------------------------------------------

  /// --- FLYER BOX SIZES

  // --------------------
  /// TAMAM : WORKS PERFECT
  static double flyerWidthByFactor(BuildContext context, double flyerSizeFactor) {
    return Scale.superScreenWidth(context) * flyerSizeFactor;
  }
  // ---------
  /// TAMAM : WORKS PERFECT
  static double flyerWidthByFlyerHeight(BuildContext context, double flyerBoxHeight){
    return flyerWidthByFactor(context, flyerFactorByFlyerHeight(context, flyerBoxHeight));
  }
  // ---------
  /// TAMAM : WORKS PERFECT
  static double flyerHeightByFlyerWidth(BuildContext context, double flyerBoxWidth) {

    if (checkFlyerIsFullScreen(context, flyerBoxWidth) == true){
      return Scale.superScreenHeightWithoutSafeArea(context);
    }

    else {
      return flyerBoxWidth * xFlyerBoxHeight;
    }

  }
  // ---------
  /// TAMAM : WORKS PERFECT
  static double flyerFactorByFlyerWidth(BuildContext context, double flyerBoxWidth) {
    return flyerBoxWidth / Scale.superScreenWidth(context);
  }
  // ---------
  /// TAMAM : WORKS PERFECT
  static double flyerFactorByFlyerHeight(BuildContext context, double flyerBoxHeight) {
    return flyerFactorByFlyerWidth(context, flyerWidthByFlyerHeight(context, flyerBoxHeight));
  }
  // ---------
  /// TAMAM : WORKS PERFECT
  static double heightBySizeFactor({
    @required BuildContext context,
    @required double flyerSizeFactor,
  }) {
    return flyerHeightByFlyerWidth(context, flyerWidthByFactor(context, flyerSizeFactor));
  }
  // ---------

  static double flyerPaddingValue(double flyerBoxWidth){
    return (flyerBoxWidth * (xFlyerHeaderMiniHeight - xFlyerLogoWidth)) / 2;
  }
  // ---------

  /// FLYER CORNERS

  // ---------
  /// TAMAM : WORKS PERFECT
  static BorderRadius flyerCorners(BuildContext context, double flyerBoxWidth) {

    final double _flyerTopCorners = flyerTopCornerValue(flyerBoxWidth);
    final double _flyerBottomCorners = flyerBottomCornerValue(flyerBoxWidth);

    return Borderers.superBorderOnly(
      context: context,
      enTopLeft: _flyerTopCorners,
      enBottomLeft: _flyerBottomCorners,
      enBottomRight: _flyerBottomCorners,
      enTopRight: _flyerTopCorners,
    );

  }
  // ---------
  /// TAMAM : WORKS PERFECT
  static double flyerTopCornerValue(double flyerBoxWidth) {
    return flyerBoxWidth * FlyerDim.xFlyerTopCorners;
  }
  // ---------
  /// TAMAM : WORKS PERFECT
  static double flyerBottomCornerValue(double flyerBoxWidth) {
    return flyerBoxWidth * FlyerDim.xFlyerBottomCorners;
  }
  // -----------------------------------------------------------------------------

  /// --- HEADER SIZES

  // --------------------
  /// TAMAM : WORKS PERFECT
  static double headerBoxHeight(double flyerBoxWidth) {
    return flyerBoxWidth * FlyerDim.xFlyerHeaderMiniHeight;
  }
  // ---------
  /*
  static double headerMaxStripHeight(double flyerBoxWidth){
    return flyerBoxWidth;
  }
   */
  // ---------
  /// TAMAM : WORKS PERFECT
  static double headerOffsetHeight(double flyerBoxWidth) {
    return (flyerBoxWidth * FlyerDim.xFlyerHeaderMiniHeight)
            -
            (2 * flyerBoxWidth * FlyerDim.xFollowCallSpacing);
  }
  // ---------
  /// TAMAM : WORKS PERFECT
  static double headerAndProgressHeights(BuildContext context, double flyerBoxWidth) {
    return headerBoxHeight(flyerBoxWidth)
            +
            (
                flyerHeightByFlyerWidth(context, flyerBoxWidth)
                *
                xProgressBarHeightRatio
            );
  }
  // ---------

  /// HEADER CORNERS

  // ---------
  /// TAMAM : WORKS PERFECT
  static BorderRadius headerBoxCorners({
    @required BuildContext context,
    @required double flyerBoxWidth
  }) {

    return Borderers.superBorderAll(context, flyerBoxWidth * FlyerDim.xFlyerTopCorners);

  }
  // -----------------------------------------------------------------------------

  /// --- LOGO SIZE

  // --------------------
  /// TAMAM : WORKS PERFECT
  static double logoWidth(double flyerBoxWidth) {
    return flyerBoxWidth * FlyerDim.xFlyerLogoWidth;
  }
  // ---------

  /// LOGO CORNER

  // ---------
  /// TAMAM : WORKS PERFECT
  static BorderRadius logoCorners({
    @required BuildContext context,
    @required double flyerBoxWidth,
    bool zeroCornerIsOn = false
  }) {

    final double _logoRoundCorners =
            /// HEADER MAIN CORNERS
            (flyerBoxWidth * FlyerDim.xFlyerTopCorners)
            -
            /// HEADER MAIN PADDING
            (flyerBoxWidth * FlyerDim.xFlyerHeaderMainPadding);

    if (zeroCornerIsOn == true){
      return Borderers.superBorderOnly(
          context: context,
          enTopLeft: _logoRoundCorners,
          enBottomLeft: _logoRoundCorners,
          enBottomRight: 0,
          enTopRight: _logoRoundCorners
      );
    }

    else {
      return Borderers.superBorderAll(context, _logoRoundCorners);
    }

  }
  // ---------
  static double logoCornerValue(double logoWidth) {
    return logoWidth * rBzLogoCorner;
  }
  // -----------------------------------------------------------------------------

  /// --- HEADER LABELS SIZES

  // --------------------
  static double headerLabelsWidth(double flyerBoxWidth) {

    final double _logoSize = logoWidth(flyerBoxWidth);
    final double _followAndCallWidth = followAndCallBoxWidth(flyerBoxWidth);
    final double _padding = flyerPaddingValue(flyerBoxWidth);

    return flyerBoxWidth - _logoSize - _followAndCallWidth - (_padding * 2);

    // return flyerBoxWidth * (FlyerDim.xFlyerAuthorPicWidth + FlyerDim.xFlyerAuthorNameWidth);
  }
  // --------------------
  static double headerLabelsHeight(double flyerBoxWidth){
    return flyerBoxWidth * (FlyerDim.xFlyerHeaderMiniHeight - (2 * FlyerDim.xFlyerHeaderMainPadding));
  }
  // -----------------------------------------------------------------------------

  /// --- FOLLOW AND CALL SIZES

  // --------------------
  static double followAndCallBoxWidth(double flyerBoxWidth) {
    return (flyerBoxWidth * FlyerDim.xFlyerFollowBtWidth) - 1;
  }
  // ---------
  static double followAndCallBoxHeight({
    @required double flyerBoxWidth,
    @required bool headerIsExpanded,
  }) {
    final double _headerMainHeight = FlyerDim.headerBoxHeight(flyerBoxWidth);
    final double _headerMainPadding = flyerBoxWidth * FlyerDim.xFlyerHeaderMainPadding;
    return _headerMainHeight - (2 * _headerMainPadding);
  }
  // ---------
  static double followAndCallPaddingValue(double flyerBoxWidth) {
    return flyerBoxWidth * FlyerDim.xFlyerHeaderMainPadding;
  }
  // -----------------------------------------------------------------------------

  /// --- FOOTER SIZES

  // --------------------
  static double footerBoxHeight({
    @required BuildContext context,
    @required double flyerBoxWidth,
    @required bool infoButtonExpanded,
  }){

    if (infoButtonExpanded == true){
      return FlyerDim._footerBoxExpandedHeight(flyerBoxWidth);
    }

    else {
      return FlyerDim._footerBoxCollapsedHeight(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
      );
    }

  }
  // ---------
  static double _footerBoxCollapsedHeight({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }) {

    final double _footerBTMargins = footerButtonMarginValue(flyerBoxWidth,);

    final double _footerBTRadius = footerButtonRadius(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );

    return (2 * _footerBTMargins) + (2 * _footerBTRadius);
  }
  // ---------
  static double _footerBoxExpandedHeight(double flyerBoxWidth){
    return flyerBoxWidth;
  }
  // ---------
  /*
  static double footerBoxExpandedReviewHeight({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){

    final double _headerHeight = FlyerDim.headerBoxHeight(flyerBoxWidth);
    final double _flyerBox = FlyerDim.flyerHeightByFlyerWidth(context, flyerBoxWidth);

    final double _expandedReviewHeight = _flyerBox - _headerHeight;

    return _expandedReviewHeight;
  }
   */
  // ---------

  /// FOOTER CORNERS

  // ---------
  static BorderRadius footerBoxCorners({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){

    final double _bottomCorner = footerBoxBottomCornerValue(flyerBoxWidth);

    return Borderers.superBorderOnly(
      context: context,
      enBottomLeft: _bottomCorner,
      enBottomRight: _bottomCorner,
      enTopLeft: 0,
      enTopRight: 0,
    );

  }
  // ---------
  static double footerBoxBottomCornerValue(double flyerBoxWidth) {
    return flyerBoxWidth * FlyerDim.xFlyerBottomCorners;
  }
  // -----------------------------------------------------------------------------

  /// --- FOOTER BUTTONS SIZES

  // --------------------
  static double footerButtonSize({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }) {
    return 2 * footerButtonRadius(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );
  }
  // ---------

  /// FOOTER BUTTONS MARGINS

  // ---------
  static EdgeInsets footerButtonEnRightMargin({
    @required double flyerBoxWidth,
    @required BuildContext context,
    @required int buttonNumber,
    @required double flightTweenValue,
  }){
    final double _buttonSize = FlyerDim.footerButtonSize(
        context: context,
        flyerBoxWidth: flyerBoxWidth
    );

    final double _spacing = FlyerDim.footerButtonMarginValue(flyerBoxWidth);

    final double _rightEnMarginValue =  ((_buttonSize + _spacing) * (buttonNumber - 1)) + _spacing;

    return Scale.superInsets(
      context: context,
      top: _spacing,
      bottom: _spacing,
      enLeft: _spacing,
      enRight: Animators.limitTweenImpact(
        minDouble: _spacing,
        maxDouble: _rightEnMarginValue,
        tweenValue: flightTweenValue,
      ),
    );

  }
  // ---------
  static double footerButtonMarginValue(double flyerBoxWidth) {
    return flyerBoxWidth * 0.01;
  }
  // ---------

  /// FOOTER BUTTONS CORNERS

  // ---------
  static double footerButtonRadius({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }) {
    final double _flyerBottomCorners = footerBoxBottomCornerValue(flyerBoxWidth);
    final double _footerBTMargins = footerButtonMarginValue(flyerBoxWidth);
    return _flyerBottomCorners - _footerBTMargins;
  }
  // -----------------------------------------------------------------------------

  /// --- INFO BUTTON SIZES

  // --------------------
  static double infoButtonWidth({
    @required BuildContext context,
    @required double flyerBoxWidth,
    @required bool tinyMode,
    @required bool isExpanded,
    @required InfoButtonType infoButtonType,
  }){

    /// TINY MODE
    if (tinyMode == true){
      return _infoButtonTinyWidth(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
      );
    }

    /// FULL SCREEN MODE
    else {

      /// EXPANDED
      if (isExpanded == true){
        return _infoButtonExpandedWidth(
          context: context,
          flyerBoxWidth: flyerBoxWidth,
        );
      }

      /// COLLAPSED
      else {

        /// ONLY INFO
        if (infoButtonType == InfoButtonType.info){
          return _infoButtonCollapsedHeight(
              context: context,
              flyerBoxWidth: flyerBoxWidth
          );
        }

        /// PRICE TAG
        else {
          return _infoButtonCollapsedWidth(
            context: context,
            flyerBoxWidth: flyerBoxWidth,
          );
        }

      }

    }

  }
  // ---------
  static double infoButtonHeight({
    @required BuildContext context,
    @required double flyerBoxWidth,
    @required bool tinyMode,
    @required bool isExpanded,
  }){

    if (tinyMode == true){
      return _infoButtonTinyHeight(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
      );
    }

    else {

      if (isExpanded == true){
        return _infoButtonExpandedHeight(
          flyerBoxWidth: flyerBoxWidth,
        );
      }

      else {
        return _infoButtonCollapsedHeight(
          context: context,
          flyerBoxWidth: flyerBoxWidth,
        );
      }

    }

  }
  // ---------
  static double _infoButtonTinyWidth({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){
    final _footerButtonWidth = FlyerDim.footerButtonSize(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );

    final _footerSpacerWidth = FlyerDim.footerButtonMarginValue(flyerBoxWidth);

    return flyerBoxWidth
        - (3 * _footerSpacerWidth)
        - _footerButtonWidth;
  }
  // ---------
  static double _infoButtonCollapsedWidth({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){

    final double _footerButtonSize = FlyerDim.footerButtonSize(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );

    final double _footerButtonMargin = FlyerDim.footerButtonMarginValue(flyerBoxWidth);

    final double _infoButtonCollapsedMargin = infoButtonCollapsedMarginValue(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );

    return flyerBoxWidth
        -
        (4 * _footerButtonMargin)
        -
        (3 * _footerButtonSize)
        -
        (1 * _infoButtonCollapsedMargin);

  }
  // ---------
  static double _infoButtonExpandedWidth({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){
    return flyerBoxWidth - (2 * FlyerDim.footerButtonMarginValue(flyerBoxWidth));
  }
  // ---------
  static double _infoButtonTinyHeight({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){
    return FlyerDim.footerButtonSize(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );
  }
  // ---------
  static double _infoButtonCollapsedHeight({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){
    return 0.7 * FlyerDim.footerButtonSize(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );
  }
  // ---------
  static double _infoButtonExpandedHeight({
    @required double flyerBoxWidth,
  }){
    return flyerBoxWidth;
  }
  // ---------

  /// INFO BUTTON CORNERS

  // ---------
  static BorderRadius infoButtonCorners({
    @required BuildContext context,
    @required double flyerBoxWidth,
    @required bool tinyMode,
    @required bool isExpanded,
  }){

    double _cornersValue = 0;

    if (tinyMode == true){
      _cornersValue = _infoButtonTinyCornerValue(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
      );
    }

    else {

      if (isExpanded == true){
        _cornersValue = _infoButtonExpandedCornerValue(
          context: context,
          flyerBoxWidth: flyerBoxWidth,
        );
      }

      else {
        _cornersValue = _infoButtonCollapsedCornerValue(
          context: context,
          flyerBoxWidth: flyerBoxWidth,
        );
      }

    }

    return Borderers.superBorderAll(context, _cornersValue);
  }
  // ---------
  static double _infoButtonTinyCornerValue({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){

    final double _footerBottomCorners = FlyerDim.footerBoxBottomCornerValue(flyerBoxWidth);

    final double _tinyMargin = _infoButtonTinyMarginValue(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );

    return _footerBottomCorners - _tinyMargin;
  }
  // ---------
  static double _infoButtonCollapsedCornerValue({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){

    final double _footerBottomCorners = FlyerDim.footerBoxBottomCornerValue(flyerBoxWidth);

    final double _infoButtonMargin = infoButtonCollapsedMarginValue(
        context: context,
        flyerBoxWidth: flyerBoxWidth
    );

    return _footerBottomCorners - _infoButtonMargin;
  }
  // ---------
  static double _infoButtonExpandedCornerValue({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){
    return FlyerDim.footerButtonRadius(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );
  }
  // ---------

  /// INFO BUTTON MARGIN

  // ---------
  static EdgeInsets infoButtonMargins({
    @required BuildContext context,
    @required double flyerBoxWidth,
    @required bool tinyMode,
    @required bool isExpanded,
  }){
    double _marginValue = 0;

    if (tinyMode == true){
      _marginValue = _infoButtonTinyMarginValue(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
      );
    }

    else {

      if (isExpanded == true){
        _marginValue = _infoButtonExpandedMarginValue(
          context: context,
          flyerBoxWidth: flyerBoxWidth,
        );
      }

      else {
        _marginValue = infoButtonCollapsedMarginValue(
          context: context,
          flyerBoxWidth: flyerBoxWidth,
        );
      }

    }

    return EdgeInsets.all(_marginValue);
  }
  // ---------
  static double _infoButtonTinyMarginValue({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){
    return FlyerDim.footerButtonMarginValue(flyerBoxWidth);
  }
  // ---------
  static double infoButtonCollapsedMarginValue({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){

    final double _buttonMinHeight = _infoButtonCollapsedHeight(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );

    final double _footerMinHeight = FlyerDim.footerBoxHeight(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
      infoButtonExpanded: false,
    );

    return (_footerMinHeight - _buttonMinHeight) / 2;

  }
  // ---------
  static double _infoButtonExpandedMarginValue({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){
    return FlyerDim.footerButtonMarginValue(flyerBoxWidth);
  }
  // -----------------------------------------------------------------------------

  /// --- PROGRESS BAR SIZES

  // ---------
  static double progressBarBoxWidth(double flyerBoxWidth) {
    return flyerBoxWidth;
  }
  // ---------
  static double progressBarBoxHeight(double flyerBoxWidth) {
    return flyerBoxWidth * FlyerDim.xProgressBarHeightRatio;
  }
  // ---------

  /// PROGRESS BAR MARGINS

  // ---------
  static EdgeInsets progressBarBoxMargins({
    @required double flyerBoxWidth,
    EdgeInsets margins,
  }) {
    return margins ?? EdgeInsets.only(top: flyerBoxWidth * 0.27);
  }
  // ---------
  static double progressBarPaddingValue(double flyerBoxWidth) {
    final double _stripsTotalLength = progressStripsTotalLength(flyerBoxWidth);
    return (flyerBoxWidth - _stripsTotalLength) / 2;
  }
  // ---------

  /// PROGRESS BAR STRIPS SIZES

  // ---------
  static double progressStripsTotalLength(double flyerBoxWidth) {
    return flyerBoxWidth * 0.895;
  }
  // ---------
  static double progressStripLength({
    @required double flyerBoxWidth,
    @required int numberOfStrips,
  }) {
    return progressStripsTotalLength(flyerBoxWidth) / (numberOfStrips ?? 1);
  }
  // ---------
  static double progressStripThickness(double flyerBoxWidth) {
    return flyerBoxWidth * 0.007;
  }
  // ---------

  /// PROGRESS BAR STRIP CORNERS

  // ---------
  static double progressStripCornerValue(double flyerBoxWidth) {
    return progressStripThickness(flyerBoxWidth) * 0.5;
  }
  // --------------------
  static BorderRadius progressStripCorners({
    @required BuildContext context,
    @required double flyerBoxWidth
  }) {
    return Borderers.superBorderAll(context, progressStripCornerValue(flyerBoxWidth));
  }
  // -----------------------------------------------------------------------------

  /// --- CHECKERS

  // --------------------
  /// TAMAM : WORKS PERFECT
  static bool checkFlyerIsFullScreen(BuildContext context, double flyerBoxWidth){
    return flyerBoxWidth >= Scale.superScreenWidth(context);
  }
  // ---------
  /// TAMAM : WORKS PERFECT
  static bool isTinyMode(BuildContext context, double flyerBoxWidth) {
    bool _tinyMode = false; // 0.4 needs calibration

    if (flyerBoxWidth < (Scale.superScreenWidth(context) * 0.58)) {
      _tinyMode = true;
    }

    return _tinyMode;
  }
  // -----------------------------------------------------------------------------
}
