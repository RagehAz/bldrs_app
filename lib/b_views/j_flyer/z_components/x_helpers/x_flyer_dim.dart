import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/info_button_type.dart';
import 'package:bldrs/f_helpers/drafters/animators.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FlyerDim {
  /// --------------------------------------------------------------------------

  const FlyerDim();

  /// --------------------------------------------------------------------------
  // flyer ratios multiplied by flyerBoxWidth
  static const double _xFlyerBoxHeight = 1.74;

  static const double _xFlyerTopCorners = 0.05;
  static const double _xFlyerBottomCorners = 0.11;
  static const double _xFlyerHeaderMiniHeight = 0.27;
  static const double _xAuthorImageCorners = 0.029;
  static const double _xFollowCallSpacing = 0.005;
  /// HEADER WIDTH OF EACH COMPONENT IN RESPECT TO flyerBoxWidth
  static const double _xFlyerAuthorPicWidth = 0.15;
  static const double _xFlyerAuthorPicCorner = _xFlyerHeaderMiniHeight * 0.1083;
  static const double _xFlyerAuthorNameWidth = 0.47;
  static const double _xProgressBarHeightRatio = 0.0125;
  static const double _xFlyersGridSpacing = 0.02;

  static const double _xFlyerLogoWidth = 0.26;
  static const double _xFlyerFollowBtWidth = 0.11;

  /// Business logo corners Ratio in respect to Container Width or Height
  static const double rBzLogoCorner = 0.17152;

  /*
  static const double _xFlyerHeaderMainPadding = 0.006;
  static const double _xFlyerHeaderMaxHeight = 1.3;
  static const double _xFollowCallWidth = 0.113;
  static const double _xFollowBTHeight = 0.1;
  static const double _xCallBTHeight = 0.15;
  static const double _xFooterBTMargins = 0.026;
   */
  // -----------------------------------------------------------------------------

  /// --- FLYER BOX SIZES

  // --------------------
  /// TAMAM : WORKS PERFECT
  static double flyerWidthByFactor(BuildContext context, double flyerSizeFactor) {
    return Scale.superScreenWidth(context) * flyerSizeFactor;
  }
  // ---------
  /// TAMAM : WORKS PERFECT
  static double flyerWidthByFlyerHeight(double flyerBoxHeight){
    return flyerBoxHeight / _xFlyerBoxHeight;
  }
  // ---------
  /// TAMAM : WORKS PERFECT
  static double flyerHeightByFlyerWidth(BuildContext context, double flyerBoxWidth) {

    if (checkFlyerIsFullScreen(context, flyerBoxWidth) == true){
      return Scale.superScreenHeightWithoutSafeArea(context);
    }

    else {
      return flyerBoxWidth * _xFlyerBoxHeight;
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
    return flyerFactorByFlyerWidth(context, flyerWidthByFlyerHeight(flyerBoxHeight));
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
  static const double flyerAspectRatio = 1 / _xFlyerBoxHeight;
  // ---------

  /// FLYER CORNERS

  // ---------
  /// TAMAM : WORKS PERFECT
  static BorderRadius flyerCorners(BuildContext context, double flyerBoxWidth) {

    final double _flyerTopCorners = flyerTopCornerValue(flyerBoxWidth);
    final double _flyerBottomCorners = flyerBottomCornerValue(flyerBoxWidth);

    return Borderers.cornerOnly(
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
    return flyerBoxWidth * _xFlyerTopCorners;
  }
  // ---------
  /// TAMAM : WORKS PERFECT
  static double flyerBottomCornerValue(double flyerBoxWidth) {
    return flyerBoxWidth * _xFlyerBottomCorners;
  }
  // -----------------------------------------------------------------------------

  /// --- HEADER SIZES

  // --------------------
  /// TAMAM : WORKS PERFECT
  static double headerSlateHeight(double flyerBoxWidth) {
    return flyerBoxWidth * _xFlyerHeaderMiniHeight;
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
    return  headerSlateHeight(flyerBoxWidth)
            -
            headerSlatePaddingValue(flyerBoxWidth);
  }
  // ---------
  /// TAMAM : WORKS PERFECT
  static double headerSlateAndProgressHeights(BuildContext context, double flyerBoxWidth) {
    return headerSlateHeight(flyerBoxWidth)
            +
            (
                flyerHeightByFlyerWidth(context, flyerBoxWidth)
                *
                _xProgressBarHeightRatio
            );
  }
  // ---------
  static double headerSlatePaddingValue(double flyerBoxWidth){
    return (flyerBoxWidth * (_xFlyerHeaderMiniHeight - _xFlyerLogoWidth)) / 2;
  }
  // ---------
  static EdgeInsets headerSlatePaddings(double flyerBoxWidth){
    return EdgeInsets.all(headerSlatePaddingValue(flyerBoxWidth));
  }
  // ---------

  /// HEADER CORNERS

  // ---------
  /// TAMAM : WORKS PERFECT
  static BorderRadius headerSlateCorners({
    @required BuildContext context,
    @required double flyerBoxWidth
  }) {

    return Borderers.cornerAll(context, flyerBoxWidth * _xFlyerTopCorners);

  }
  // -----------------------------------------------------------------------------

  /// --- LOGO SIZE

  // --------------------
  /// TAMAM : WORKS PERFECT
  static double logoWidth(double flyerBoxWidth) {
    return flyerBoxWidth * _xFlyerLogoWidth;
  }
  // ---------

  /// LOGO CORNER

  // ---------
  /// TAMAM : WORKS PERFECT
  static BorderRadius logoCornersByFlyerBoxWidth({
    @required BuildContext context,
    @required double flyerBoxWidth,
    bool zeroCornerIsOn = false
  }) {

    final double _logoRoundCorners =  flyerTopCornerValue(flyerBoxWidth)
                                      -
                                      headerSlatePaddingValue(flyerBoxWidth);

    if (zeroCornerIsOn == true){
      return Borderers.cornerOnly(
          context: context,
          enTopLeft: _logoRoundCorners,
          enBottomLeft: _logoRoundCorners,
          enBottomRight: 0,
          enTopRight: _logoRoundCorners
      );
    }

    else {
      return Borderers.cornerAll(context, _logoRoundCorners);
    }

  }
  // ---------
  static double logoCornerValueByLogoWidth(double logoWidth) {
    return logoWidth * rBzLogoCorner;
  }
  // ---------
  static BorderRadius logoCornersByLogoWidth({
    @required BorderRadius cornersOverride,
    @required BuildContext context,
    @required double logoWidth,
    bool zeroCornerIsOn = false
}){

    final double _roundCornerValue = logoCornerValueByLogoWidth(logoWidth);
    final double _zeroCornerValue = zeroCornerIsOn == true ? 0 : _roundCornerValue;

    return cornersOverride ??
        Borderers.cornerOnly(
            context: context,
            enTopLeft: _roundCornerValue,
            enBottomLeft: _roundCornerValue,
            enBottomRight: _zeroCornerValue,
            enTopRight: _roundCornerValue
        );

  }
  // -----------------------------------------------------------------------------

  /// --- HEADER LABELS SIZES

  // --------------------
  static double headerLabelsWidth(double flyerBoxWidth) {

    final double _logoSize = logoWidth(flyerBoxWidth);
    final double _followAndCallWidth = followAndCallBoxWidth(flyerBoxWidth);
    final double _padding = headerSlatePaddingValue(flyerBoxWidth);

    return flyerBoxWidth - _logoSize - _followAndCallWidth - (_padding * 2);
  }
  // --------------------
  static double headerLabelsHeight(double flyerBoxWidth){
    return headerSlateHeight(flyerBoxWidth) - (2 * headerSlatePaddingValue(flyerBoxWidth));
  }
  // ---------

  /// BZ LABEL SIZES

  // ---------
  static double bzLabelHeight({
    @required double flyerBoxWidth,
    @required bool flyerShowsAuthor,
  }){

    if (flyerShowsAuthor == true){
      return  headerLabelsHeight(flyerBoxWidth)
              - authorLabelBoxHeight(flyerBoxWidth: flyerBoxWidth) //* 0.4;
              ;
    }

    else {
      return headerSlateHeight(flyerBoxWidth) * 0.7; //0.0475;
    }

  }
  // ---------
  static double bzLabelPaddingValue(double flyerBoxWidth){
    return flyerBoxWidth * 0.02;
  }
  // ---------
  static EdgeInsets bzLabelPaddings(double flyerBoxWidth){
    return EdgeInsets.symmetric(horizontal: bzLabelPaddingValue(flyerBoxWidth));
  }
  // ---------

  /// AUTHOR LABEL SIZES

  // ---------
  static double authorLabelBoxHeight({
    @required double flyerBoxWidth
  }){
    // flyerShowsAuthor == true ?
    return flyerBoxWidth * _xFlyerAuthorPicWidth;
    //     :
    // (flyerBoxWidth * ((Ratioz.xxflyerHeaderHeight* 0.3)-(2*Ratioz.xxflyerHeaderMainPadding)) )
  }
  // ---------
  static double authorLabelBoxWidth({
    @required double flyerBoxWidth,
    @required bool labelIsOn,
  }){
    final double _authorLabelBoxHeight = authorLabelBoxHeight(
      flyerBoxWidth: flyerBoxWidth,
    );

    final double _authorDataWidth = flyerBoxWidth * (_xFlyerAuthorPicWidth + _xFlyerAuthorNameWidth);

    return labelIsOn == true ? _authorDataWidth : _authorLabelBoxHeight;

  }
  // ---------

  /// AUTHOR PIC SIZES

  // ---------
  static double authorPicSizeBFlyerBoxWidth(double flyerBoxWidth){
    return flyerBoxWidth * _xFlyerAuthorPicWidth;
  }
  // ---------

  /// AUTHOR PIC CORNERS

  // ---------
  static double authorPicCornerValue({
    @required double flyerBoxWidth,
  }){
    return flyerBoxWidth * _xFlyerAuthorPicCorner;
  }
  // ---------
  static BorderRadius authorPicCornersByFlyerBoxWidth({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){

    final double _authorImageCorners = authorPicCornerValue(
      flyerBoxWidth: flyerBoxWidth,
    );

    return Borderers.cornerOnly(
        context: context,
        enTopLeft: _authorImageCorners,
        enBottomLeft: 0,
        enBottomRight: _authorImageCorners,
        enTopRight: _authorImageCorners
    );

  }
  // ---------
  static BorderRadius authorPicCornersByPicSize({
    @required BuildContext context,
    @required double picSize,
  }){

    return authorPicCornersByFlyerBoxWidth(
        context: context,
        flyerBoxWidth: picSize / _xFlyerAuthorPicWidth,
    );

  }
  // ---------

  /// AUTHOR LABEL VERSES

  // ---------
  static double authorLabelVersesWidth(double flyerBoxWidth){
    return flyerBoxWidth * _xFlyerAuthorNameWidth;
  }
  // ---------
  static EdgeInsets authorLabelVersesPadding(double flyerBoxWidth){
    final double _authorLabelVersesPaddingValue = flyerBoxWidth * _xFlyersGridSpacing;
    return EdgeInsets.symmetric(horizontal: _authorLabelVersesPaddingValue);
  }
  // -----------------------------------------------------------------------------

  /// --- FOLLOW AND CALL SIZES

  // --------------------
  static double followAndCallBoxWidth(double flyerBoxWidth) {
    return flyerBoxWidth * _xFlyerFollowBtWidth;
  }
  // ---------
  static double followAndCallBoxHeight(double flyerBoxWidth) {
    return logoWidth(flyerBoxWidth);
  }
  // ---------
  static double followButtonHeight(double flyerBoxWidth){
    return bzLabelHeight(
        flyerBoxWidth: flyerBoxWidth,
        flyerShowsAuthor: true,
    );
  }
  // ---------
  static double callButtonHeight(double flyerBoxWidth){
    final double _boxHeight = followAndCallBoxHeight(flyerBoxWidth);
    final double _followButtonHeight = followButtonHeight(flyerBoxWidth);
    final double _spacer = headerSlatePaddingValue(flyerBoxWidth);
    return _boxHeight - (_followButtonHeight + _spacer);
  }
  // ---------
  static BorderRadius superFollowOrCallCorners({
    @required BuildContext context,
    @required double flyerBoxWidth,
    @required bool gettingFollowCorner,
  }) {
    final double headerMainCorners = flyerBoxWidth * _xFlyerTopCorners;
    final double headerOffsetCorner = headerMainCorners - flyerBoxWidth * _xFollowCallSpacing;
    final double followBTCornerTL = flyerBoxWidth * _xAuthorImageCorners;
    final double followBTCornerTR = headerOffsetCorner;
    final double followBTCornerBL = flyerBoxWidth * _xAuthorImageCorners;
    final double followBTCornerBR = flyerBoxWidth * 0.021;

    final BorderRadius followCorners = Borderers.cornerOnly(
      context: context,
      enTopLeft: followBTCornerTL,
      enBottomLeft: followBTCornerBL,
      enBottomRight: followBTCornerBR,
      enTopRight: followBTCornerTR,
    );
    final BorderRadius callCorners = Borderers.cornerOnly(
      context: context,
      enTopLeft: followBTCornerBL,
      enBottomLeft: followBTCornerTL,
      enBottomRight: followBTCornerTR,
      enTopRight: followBTCornerBR,
    );

    return gettingFollowCorner == true ? followCorners : callCorners;
  }
  // -----------------------------------------------------------------------------

  /// --- BZ SLIDE

  // --------------------
  static double bzSlideHorizon(double flyerBoxWidth){
    return flyerBottomCornerValue(flyerBoxWidth) + Ratioz.appBarMargin;
  }

  static EdgeInsets bzSlideTileMargins(double flyerBoxWidth){
    return EdgeInsets.only(top: flyerBoxWidth * Ratioz.xxbzPageSpacing);
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
      return _footerBoxExpandedHeight(flyerBoxWidth);
    }

    else {
      return _footerBoxCollapsedHeight(
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

    final double _headerHeight = headerBoxHeight(flyerBoxWidth);
    final double _flyerBox = flyerHeightByFlyerWidth(context, flyerBoxWidth);

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

    return Borderers.cornerOnly(
      context: context,
      enBottomLeft: _bottomCorner,
      enBottomRight: _bottomCorner,
      enTopLeft: 0,
      enTopRight: 0,
    );

  }
  // ---------
  static double footerBoxBottomCornerValue(double flyerBoxWidth) {
    return flyerBottomCornerValue(flyerBoxWidth);
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
    final double _buttonSize = footerButtonSize(
        context: context,
        flyerBoxWidth: flyerBoxWidth
    );

    final double _spacing = footerButtonMarginValue(flyerBoxWidth);

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
    final _footerButtonWidth = footerButtonSize(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );

    final _footerSpacerWidth = footerButtonMarginValue(flyerBoxWidth);

    return flyerBoxWidth
        - (3 * _footerSpacerWidth)
        - _footerButtonWidth;
  }
  // ---------
  static double _infoButtonCollapsedWidth({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){

    final double _footerButtonSize = footerButtonSize(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );

    final double _footerButtonMargin = footerButtonMarginValue(flyerBoxWidth);

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
    return flyerBoxWidth - (2 * footerButtonMarginValue(flyerBoxWidth));
  }
  // ---------
  static double _infoButtonTinyHeight({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){
    return footerButtonSize(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );
  }
  // ---------
  static double _infoButtonCollapsedHeight({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){
    return 0.7 * footerButtonSize(
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

    return Borderers.cornerAll(context, _cornersValue);
  }
  // ---------
  static double _infoButtonTinyCornerValue({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){

    final double _footerBottomCorners = footerBoxBottomCornerValue(flyerBoxWidth);

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

    final double _footerBottomCorners = footerBoxBottomCornerValue(flyerBoxWidth);

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
    return footerButtonRadius(
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
    return footerButtonMarginValue(flyerBoxWidth);
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

    final double _footerMinHeight = footerBoxHeight(
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
    return footerButtonMarginValue(flyerBoxWidth);
  }
  // -----------------------------------------------------------------------------

  /// --- PROGRESS BAR SIZES

  // ---------
  static double progressBarBoxWidth(double flyerBoxWidth) {
    return flyerBoxWidth;
  }
  // ---------
  static double progressBarBoxHeight(double flyerBoxWidth) {
    return flyerBoxWidth * _xProgressBarHeightRatio;
  }
  // ---------

  /// BOX MARGINS

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

  ///  STRIPS SIZES

  // ---------
  static double progressStripsTotalLength(double flyerBoxWidth) {
    return flyerBoxWidth * 0.895;
  }
  // ---------

  ///  ONE STRIP SIZES

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
  // ---------
  static BorderRadius progressStripCorners({
    @required BuildContext context,
    @required double flyerBoxWidth
  }) {
    return Borderers.cornerAll(context, progressStripCornerValue(flyerBoxWidth));
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

  /// --- FLYER GRID SIZES

  // --------------------
  static double flyerGridWidth({
    @required BuildContext context,
    @required double givenGridWidth,
  }){
    return givenGridWidth ?? Scale.superScreenWidth(context);
  }
  // --------------------
  static double flyerGridHeight({
    @required BuildContext context,
    @required double givenGridHeight,
  }){
    return givenGridHeight ?? Scale.superScreenHeight(context);
  }
  // --------------------
  static const double _spacingRatio = 0.03;
  // --------------------
  static double flyerGridVerticalScrollFlyerBoxWidth({
    @required double gridZoneWidth,
    @required int numberOfColumns,
  }){
    final double _flyerBoxWidth =
        gridZoneWidth /
            (
                numberOfColumns
                    + (numberOfColumns * _spacingRatio)
                    + _spacingRatio
            );
    return _flyerBoxWidth;
  }
  // --------------------
  static double flyerGridHorizontalScrollFlyerBoxWidth({
    @required BuildContext context,
    @required double gridZoneHeight,
    @required int numberOfRows,
  }){

    final double _flyerBoxWidth =
        gridZoneHeight
        /
        (
            (numberOfRows * _xFlyerBoxHeight)
            +
            (numberOfRows * _spacingRatio) + _spacingRatio
        );

    /// REVERSE MATH TEST
    // final double _flyerBoxHeight = _flyerBoxWidth * Ratioz.xxflyerZoneHeight;
    // final double spacing = getGridSpacingValue(flyerBoxWidth: _flyerBoxWidth);
    // final double _result = (_flyerBoxHeight * numberOfRows) + (spacing * (numberOfRows + 1));
    // blog('result : $_result = ($_flyerBoxHeight * $numberOfRows) + ($spacing * ($numberOfRows + 1))');

    return _flyerBoxWidth;
  }
  // --------------------
  static double flyerGridGridSpacingValue(double flyerBoxWidth){
    return flyerBoxWidth * _spacingRatio;
  }
  // --------------------
  static EdgeInsets flyerGridPadding({
    @required BuildContext context,
    @required double gridSpacingValue,
    @required double topPaddingValue,
    @required bool isVertical,
  }){

    return Scale.superInsets(
      context: context,
      enLeft: gridSpacingValue,
      top: isVertical == true ? topPaddingValue : gridSpacingValue,
      enRight: isVertical == true ? gridSpacingValue : Ratioz.horizon,
      bottom: isVertical == true ? Ratioz.horizon : 0,
    );

  }
  // --------------------

  /// --- FLYER GRID SLOT SIZES

  // --------------------
  static double flyerGridSlotMinWidthFactor({
    @required double gridFlyerWidth,
    @required double gridZoneWidth,
  }){
    return gridFlyerWidth / gridZoneWidth;
  }
  // --------------------
  static double flyerGridSlotWidth({
    BuildContext context,
    int flyersLength
  }) {
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _gridWidth = _screenWidth - (2 * Ratioz.appBarMargin);
    final int _numberOfColumns = flyerGridColumnCount(flyersLength);
    return (_gridWidth - ((_numberOfColumns - 1) * Ratioz.appBarMargin)) / _numberOfColumns;
  }
  // --------------------
  static double flyerGridFlyerBoxWidth({
    @required BuildContext context,
    @required Axis scrollDirection,
    @required int numberOfColumnsOrRows,
    @required double gridWidth,
    @required double gridHeight,
  }){

    if (scrollDirection == Axis.vertical){

      final double _gridZoneWidth = flyerGridWidth(
        context: context,
        givenGridWidth: gridWidth,
      );

      return flyerGridVerticalScrollFlyerBoxWidth(
        numberOfColumns: numberOfColumnsOrRows,
        gridZoneWidth: _gridZoneWidth,
      );

    }

    else {

      final double _gridZoneHeight = flyerGridHeight(
        context: context,
        givenGridHeight: gridHeight,
      );

      return flyerGridHorizontalScrollFlyerBoxWidth(
        context: context,
        numberOfRows: numberOfColumnsOrRows,
        gridZoneHeight: _gridZoneHeight,
      );

    }

  }
  // --------------------
  static int flyerGridNumberOfSlots({
    @required int flyersCount,
    @required bool addFlyerButtonIsOn,
    @required bool isLoadingGrid,
    @required int numberOfColumnsOrRows,
  }){
    int _slotsCount = flyersCount;

    if (isLoadingGrid == true){
      _slotsCount = numberOfColumnsOrRows * numberOfColumnsOrRows;
      if (_slotsCount == 1){
        _slotsCount = 5;
      }
    }

    else if (addFlyerButtonIsOn == true){
      _slotsCount = _slotsCount + 1;
    }

    return _slotsCount;
  }
  // --------------------
  static int flyerGridColumnCount(int flyersLength) {

    if (flyersLength > 12){
      return 3;
    }
    else if (flyersLength > 6){
      return 2;
    }
    else {
      return 2;
    }

  }
  // --------------------
  static SliverGridDelegate flyerGridDelegate({
    @required Axis scrollDirection,
    @required double flyerBoxWidth,
    @required int numberOfColumnsOrRows,
  }){

    final double _gridSpacingValue = flyerGridGridSpacingValue(flyerBoxWidth);

    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisSpacing: scrollDirection == Axis.vertical ? _gridSpacingValue : 0,
      mainAxisSpacing: _gridSpacingValue,
      childAspectRatio: flyerAspectRatio,
      crossAxisCount: numberOfColumnsOrRows,
      mainAxisExtent: scrollDirection == Axis.vertical ? flyerBoxWidth * _xFlyerBoxHeight : flyerBoxWidth,
      // maxCrossAxisExtent: scrollDirection == Axis.vertical ? _flyerBoxWidth : Ratioz.xxflyerZoneHeight,
    );

  }
  // -----------------------------------------------------------------------------
}
