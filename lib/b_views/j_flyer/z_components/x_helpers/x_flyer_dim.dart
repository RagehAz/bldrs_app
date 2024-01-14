import 'package:basics/helpers/animators/animators.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/space/borderers.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/info_button_type.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:basics/z_grid/z_grid.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/space/scale.dart';
/// => TAMAM
class FlyerDim {
  /// --------------------------------------------------------------------------

  const FlyerDim();

  /// --------------------------------------------------------------------------
  // flyer ratios multiplied by flyerBoxWidth
  // static const double xFlyerBoxHeightRatioToWidth = 1.74; // is dynamic now according to screen

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
  /// TESTED : WORKS PERFECT
  static double flyerWidthByFactor({
    required double flyerSizeFactor,
    required double gridWidth,
  }) {
    return gridWidth * flyerSizeFactor;
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static double flyerWidthByFlyerHeight({
    required double flyerBoxHeight,
  }){
    return flyerBoxHeight / flyerHeightRatioToWidth;
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static const double flyerHeightRatioToWidth = 1.74;
  // ---------
  /// TESTED : WORKS PERFECT
  static double flyerHeightByFlyerWidth({
    required double flyerBoxWidth,
  }) {
    return flyerBoxWidth * flyerHeightRatioToWidth;
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static double flyerFactorByFlyerWidth({
    required double gridWidth,
    required double flyerBoxWidth,
  }) {
    return flyerBoxWidth / gridWidth;
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static double flyerFactorByFlyerHeight({
    required double gridWidth,
    required double flyerBoxHeight,
  }) {
    return flyerFactorByFlyerWidth(
      gridWidth: gridWidth,
      flyerBoxWidth: flyerWidthByFlyerHeight(
          flyerBoxHeight: flyerBoxHeight,
        ),
    );
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static double heightBySizeFactor({
    required double flyerSizeFactor,
    required double gridWidth,
  }) {
    return flyerHeightByFlyerWidth(
      flyerBoxWidth: flyerWidthByFactor(
        flyerSizeFactor: flyerSizeFactor,
        gridWidth: gridWidth,
      ),
    );
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static double flyerAspectRatio(){
    return 1 / flyerHeightRatioToWidth;
  }
  // ---------

  /// FLYER CORNERS

  // ---------
  /// TESTED : WORKS PERFECT
  static BorderRadius flyerCorners(double flyerBoxWidth) {

    final double _flyerTopCorners = flyerTopCornerValue(flyerBoxWidth);
    final double _flyerBottomCorners = flyerBottomCornerValue(flyerBoxWidth);

    return Borderers.cornerOnly(
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      enTopLeft: _flyerTopCorners,
      enBottomLeft: _flyerBottomCorners,
      enBottomRight: _flyerBottomCorners,
      enTopRight: _flyerTopCorners,
    );

  }
  // ---------
  /// TESTED : WORKS PERFECT
  static double flyerTopCornerValue(double flyerBoxWidth) {
    return flyerBoxWidth * _xFlyerTopCorners;
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static double flyerBottomCornerValue(double flyerBoxWidth) {
    return flyerBoxWidth * _xFlyerBottomCorners;
  }
  // -----------------------------------------------------------------------------

  /// --- HEADER SIZES

  // --------------------
  /// TESTED : WORKS PERFECT
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
  /// TESTED : WORKS PERFECT
  static double headerOffsetHeight(double flyerBoxWidth) {
    return  headerSlateHeight(flyerBoxWidth)
            -
            headerSlatePaddingValue(flyerBoxWidth);
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static double headerSlateAndProgressHeights({
    required double flyerBoxWidth,
  }) {

    final double _flyerHeight = flyerHeightByFlyerWidth(
      flyerBoxWidth: flyerBoxWidth,
    );

    return  headerSlateHeight(flyerBoxWidth)
            +
            (_flyerHeight * _xProgressBarHeightRatio);
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static double headerSlatePaddingValue(double flyerBoxWidth){
    return (flyerBoxWidth * (_xFlyerHeaderMiniHeight - _xFlyerLogoWidth)) / 2;
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static EdgeInsets headerSlatePaddings(double flyerBoxWidth){
    return EdgeInsets.all(headerSlatePaddingValue(flyerBoxWidth));
  }
  // ---------

  /// HEADER CORNERS

  // ---------
  /// TESTED : WORKS PERFECT
  static BorderRadius headerSlateCorners({
    required double flyerBoxWidth
  }) {

    return Borderers.cornerAll(flyerBoxWidth * _xFlyerTopCorners);

  }
  // -----------------------------------------------------------------------------

  /// --- LOGO SIZE

  // --------------------
  /// TESTED : WORKS PERFECT
  static double logoWidth(double flyerBoxWidth) {
    return flyerBoxWidth * _xFlyerLogoWidth;
  }
  // ---------

  /// LOGO CORNER

  // ---------
  /// TESTED : WORKS PERFECT
  static BorderRadius logoCornersByFlyerBoxWidth({
    required BuildContext context,
    required double flyerBoxWidth,
    bool zeroCornerIsOn = false
  }) {

    final double _logoRoundCorners =  flyerTopCornerValue(flyerBoxWidth)
                                      -
                                      headerSlatePaddingValue(flyerBoxWidth);

    if (zeroCornerIsOn == true){
      return Borderers.cornerOnly(
          appIsLTR: UiProvider.checkAppIsLeftToRight(),
          enTopLeft: _logoRoundCorners,
          enBottomLeft: _logoRoundCorners,
          enBottomRight: 0,
          enTopRight: _logoRoundCorners
      );
    }

    else {
      return Borderers.cornerAll(_logoRoundCorners);
    }

  }
  // ---------
  /// TESTED : WORKS PERFECT
  static double logoCornerValueByLogoWidth(double? logoWidth) {
    if (logoWidth == null){
      return 0;
    }
    else {
      return logoWidth * rBzLogoCorner;
    }
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static BorderRadius logoCornersByLogoWidth({
    required BorderRadius? cornersOverride,
    required BuildContext context,
    required double logoWidth,
    bool? zeroCornerIsOn = false
  }) {
    final double _roundCornerValue = logoCornerValueByLogoWidth(logoWidth);
    final double _zeroCornerValue = Mapper.boolIsTrue(zeroCornerIsOn) == true ? 0 : _roundCornerValue;

    return cornersOverride ?? Borderers.cornerOnly(
        appIsLTR: UiProvider.checkAppIsLeftToRight(),
        enTopLeft: _roundCornerValue,
        enBottomLeft: _roundCornerValue,
        enBottomRight: _zeroCornerValue,
        enTopRight: _roundCornerValue);
  }
  // -----------------------------------------------------------------------------

  /// --- HEADER LABELS SIZES

  // --------------------
  /// TESTED : WORKS PERFECT
  static double headerLabelsWidth(double flyerBoxWidth) {

    final double _logoSize = logoWidth(flyerBoxWidth);
    final double _followAndCallWidth = followAndCallBoxWidth(flyerBoxWidth);
    final double _padding = headerSlatePaddingValue(flyerBoxWidth);

    return flyerBoxWidth - _logoSize - _followAndCallWidth - (_padding * 2);
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static double headerLabelsHeight(double flyerBoxWidth){
    return headerSlateHeight(flyerBoxWidth) - (2 * headerSlatePaddingValue(flyerBoxWidth));
  }
  // ---------

  /// BZ LABEL SIZES

  // ---------
  /// TESTED : WORKS PERFECT
  static double bzLabelHeight({
    required double flyerBoxWidth,
    required bool flyerShowsAuthor,
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
  /// TESTED : WORKS PERFECT
  static double bzLabelPaddingValue(double flyerBoxWidth){
    return flyerBoxWidth * 0.02;
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static EdgeInsets bzLabelPaddings(double flyerBoxWidth){
    return EdgeInsets.symmetric(horizontal: bzLabelPaddingValue(flyerBoxWidth));
  }
  // ---------

  /// AUTHOR LABEL SIZES

  // ---------
  /// TESTED : WORKS PERFECT
  static double authorLabelBoxHeight({
    required double flyerBoxWidth
  }){
    // flyerShowsAuthor == true ?
    return flyerBoxWidth * _xFlyerAuthorPicWidth;
    //     :
    // (flyerBoxWidth * ((Ratioz.xxflyerHeaderHeight* 0.3)-(2*Ratioz.xxflyerHeaderMainPadding)) )
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static double authorLabelBoxWidth({
    required double flyerBoxWidth,
    required bool onlyShowAuthorImage,
  }){
    final double _authorLabelBoxHeight = authorLabelBoxHeight(
      flyerBoxWidth: flyerBoxWidth,
    );

    final double _authorDataWidth = flyerBoxWidth * (_xFlyerAuthorPicWidth + _xFlyerAuthorNameWidth);

    return onlyShowAuthorImage == true ? _authorLabelBoxHeight : _authorDataWidth;

  }
  // ---------

  /// AUTHOR PIC SIZES

  // ---------
  /// TESTED : WORKS PERFECT
  static double authorPicSizeBFlyerBoxWidth(double flyerBoxWidth){
    return flyerBoxWidth * _xFlyerAuthorPicWidth;
  }
  // ---------

  /// AUTHOR PIC CORNERS

  // ---------
  /// TESTED : WORKS PERFECT
  static double authorPicCornerValue({
    required double flyerBoxWidth,
  }){
    return flyerBoxWidth * _xFlyerAuthorPicCorner;
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static BorderRadius authorPicCornersByFlyerBoxWidth({
    required BuildContext context,
    required double flyerBoxWidth,
  }){

    final double _authorImageCorners = authorPicCornerValue(
      flyerBoxWidth: flyerBoxWidth,
    );

    return Borderers.cornerOnly(
        appIsLTR: UiProvider.checkAppIsLeftToRight(),
        enTopLeft: _authorImageCorners,
        enBottomLeft: 0,
        enBottomRight: _authorImageCorners,
        enTopRight: _authorImageCorners
    );

  }
  // ---------
  /// TESTED : WORKS PERFECT
  static BorderRadius authorPicCornersByPicSize({
    required BuildContext context,
    required double picSize,
  }){

    return authorPicCornersByFlyerBoxWidth(
        context: context,
        flyerBoxWidth: picSize / _xFlyerAuthorPicWidth,
    );

  }
  // ---------

  /// AUTHOR LABEL VERSES

  // ---------
  /// TESTED : WORKS PERFECT
  static double authorLabelVersesWidth(double flyerBoxWidth){
    return flyerBoxWidth * _xFlyerAuthorNameWidth;
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static EdgeInsets authorLabelVersesPadding(double flyerBoxWidth){
    final double _authorLabelVersesPaddingValue = flyerBoxWidth * _xFlyersGridSpacing;
    return EdgeInsets.symmetric(horizontal: _authorLabelVersesPaddingValue);
  }
  // -----------------------------------------------------------------------------

  /// --- FOLLOW AND CALL SIZES

  // --------------------
  /// TESTED : WORKS PERFECT
  static double followAndCallBoxWidth(double flyerBoxWidth) {
    return flyerBoxWidth * _xFlyerFollowBtWidth;
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static double followAndCallBoxHeight(double flyerBoxWidth) {
    return logoWidth(flyerBoxWidth);
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static double followButtonHeight(double flyerBoxWidth){
    return bzLabelHeight(
        flyerBoxWidth: flyerBoxWidth,
        flyerShowsAuthor: true,
    );
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static double callButtonHeight(double flyerBoxWidth){
    final double _boxHeight = followAndCallBoxHeight(flyerBoxWidth);
    final double _followButtonHeight = followButtonHeight(flyerBoxWidth);
    final double _spacer = headerSlatePaddingValue(flyerBoxWidth);
    return _boxHeight - (_followButtonHeight + _spacer);
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static BorderRadius superFollowOrCallCorners({
    required BuildContext context,
    required double flyerBoxWidth,
    required bool gettingFollowCorner,
  }) {
    final double headerMainCorners = flyerBoxWidth * _xFlyerTopCorners;
    final double headerOffsetCorner = headerMainCorners - flyerBoxWidth * _xFollowCallSpacing;
    final double followBTCornerTL = flyerBoxWidth * _xAuthorImageCorners;
    final double followBTCornerTR = headerOffsetCorner;
    final double followBTCornerBL = flyerBoxWidth * _xAuthorImageCorners;
    final double followBTCornerBR = flyerBoxWidth * 0.021;

    final BorderRadius followCorners = Borderers.cornerOnly(
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      enTopLeft: followBTCornerTL,
      enBottomLeft: followBTCornerBL,
      enBottomRight: followBTCornerBR,
      enTopRight: followBTCornerTR,
    );
    final BorderRadius callCorners = Borderers.cornerOnly(
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
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
  /// TESTED : WORKS PERFECT
  static double bzSlideHorizon(double flyerBoxWidth){
    return flyerBottomCornerValue(flyerBoxWidth) + Ratioz.appBarMargin;
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static EdgeInsets bzSlideTileMargins(double flyerBoxWidth){
    return EdgeInsets.only(top: flyerBoxWidth * Ratioz.xxbzPageSpacing);
  }
  // -----------------------------------------------------------------------------

  /// --- FOOTER SIZES

  // --------------------
  /// TESTED : WORKS PERFECT
  static double footerBoxHeight({
    required double flyerBoxWidth,
    required bool infoButtonExpanded,
    required bool showTopButton,
  }){

    if (infoButtonExpanded == true){
      return _footerBoxExpandedHeight(flyerBoxWidth);
    }

    else {
      return _footerBoxCollapsedHeight(
        flyerBoxWidth: flyerBoxWidth,
        hasLink: showTopButton,
      );
    }

  }
  // ---------
  /// TESTED : WORKS PERFECT
  static double _footerBoxCollapsedHeight({
    required double flyerBoxWidth,
    required bool hasLink,
  }) {

    final double _footerBTMargins = footerButtonMarginValue(flyerBoxWidth,);

    final double _footerBTRadius = footerButtonRadius(
      flyerBoxWidth: flyerBoxWidth,
    );

    final double _linkHeight = hasLink == true ? (2 * _footerBTRadius) + (2 * _footerBTMargins) : 0;

    return (2 * _footerBTMargins) + (2 * _footerBTRadius) + _linkHeight;
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static double _footerBoxExpandedHeight(double flyerBoxWidth){
    return flyerBoxWidth;
  }
  // ---------
  /*
  static double footerBoxExpandedReviewHeight({
    required BuildContext context,
    required double flyerBoxWidth,
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
  /// TESTED : WORKS PERFECT
  static BorderRadius footerBoxCorners({
    required BuildContext context,
    required double flyerBoxWidth,
  }){

    final double _bottomCorner = footerBoxBottomCornerValue(flyerBoxWidth);

    return Borderers.cornerOnly(
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      enBottomLeft: _bottomCorner,
      enBottomRight: _bottomCorner,
      enTopLeft: 0,
      enTopRight: 0,
    );

  }
  // ---------
  /// TESTED : WORKS PERFECT
  static double footerBoxBottomCornerValue(double flyerBoxWidth) {
    return flyerBottomCornerValue(flyerBoxWidth);
  }
  // -----------------------------------------------------------------------------

  /// --- FOOTER BUTTONS SIZES

  // --------------------
  static double footerButtonSize({
    required double flyerBoxWidth,
  }) {
    return 2 * footerButtonRadius(
      flyerBoxWidth: flyerBoxWidth,
    );
  }
  // ---------

  /// FOOTER BUTTONS MARGINS

  // ---------
  /// TESTED : WORKS PERFECT
  static EdgeInsets footerButtonEnRightMargin({
    required double flyerBoxWidth,
    required int buttonNumber,
    required double flightTweenValue,
  }){
    final double _buttonSize = footerButtonSize(
        flyerBoxWidth: flyerBoxWidth
    );

    final double _spacing = footerButtonMarginValue(flyerBoxWidth);

    final double _rightEnMarginValue =  ((_buttonSize + _spacing) * (buttonNumber - 1)) + _spacing;

    return Scale.superInsets(
      context: getMainContext(),
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
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
  /// TESTED : WORKS PERFECT
  static double footerButtonMarginValue(double flyerBoxWidth) {
    return flyerBoxWidth * 0.01;
  }
  // ---------

  /// FOOTER BUTTONS CORNERS

  // ---------
  /// TESTED : WORKS PERFECT
  static double footerButtonRadius({
    required double flyerBoxWidth,
  }) {
    final double _flyerBottomCorners = footerBoxBottomCornerValue(flyerBoxWidth);
    final double _footerBTMargins = footerButtonMarginValue(flyerBoxWidth);
    return _flyerBottomCorners - _footerBTMargins;
  }
  // -----------------------------------------------------------------------------

  /// --- INFO BUTTON SIZES

  // --------------------
  static double infoButtonWidth({
    required double flyerBoxWidth,
    required bool tinyMode,
    required bool? isExpanded,
    required InfoButtonType? infoButtonType,
  }){

    /// TINY MODE
    if (tinyMode == true){
      return _infoButtonTinyWidth(
        flyerBoxWidth: flyerBoxWidth,
      );
    }

    /// FULL SCREEN MODE
    else {

      /// EXPANDED
      if (Mapper.boolIsTrue(isExpanded) == true){
        return _infoButtonExpandedWidth(
          flyerBoxWidth: flyerBoxWidth,
        );
      }

      /// COLLAPSED
      else {

        /// ONLY INFO
        if (infoButtonType == InfoButtonType.info){
          return _infoButtonCollapsedHeight(
              flyerBoxWidth: flyerBoxWidth
          );
        }

        /// PRICE TAG
        else {
          return _infoButtonCollapsedWidth(
            flyerBoxWidth: flyerBoxWidth,
          );
        }

      }

    }

  }
  // ---------
  /// TESTED : WORKS PERFECT
  static double infoButtonHeight({
    required double flyerBoxWidth,
    required bool tinyMode,
    required bool? isExpanded,
  }){

    if (tinyMode == true){
      return _infoButtonTinyHeight(
        flyerBoxWidth: flyerBoxWidth,
      );
    }

    else {

      if (Mapper.boolIsTrue(isExpanded) == true){
        return _infoButtonExpandedHeight(
          flyerBoxWidth: flyerBoxWidth,
        );
      }

      else {
        return _infoButtonCollapsedHeight(
          flyerBoxWidth: flyerBoxWidth,
        );
      }

    }

  }
  // ---------
  /// TESTED : WORKS PERFECT
  static double _infoButtonTinyWidth({
    required double flyerBoxWidth,
  }){
    final _footerButtonWidth = footerButtonSize(
      flyerBoxWidth: flyerBoxWidth,
    );

    final _footerSpacerWidth = footerButtonMarginValue(flyerBoxWidth);

    return flyerBoxWidth
        - (3 * _footerSpacerWidth)
        - _footerButtonWidth;
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static double _infoButtonCollapsedWidth({
    required double flyerBoxWidth,
  }){

    final double _footerButtonSize = footerButtonSize(
      flyerBoxWidth: flyerBoxWidth,
    );

    final double _footerButtonMargin = footerButtonMarginValue(flyerBoxWidth);

    final double _infoButtonCollapsedMargin = infoButtonCollapsedMarginValue(
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
  /// TESTED : WORKS PERFECT
  static double _infoButtonExpandedWidth({
    required double flyerBoxWidth,
  }){
    return flyerBoxWidth - (2 * footerButtonMarginValue(flyerBoxWidth));
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static double _infoButtonTinyHeight({
    required double flyerBoxWidth,
  }){
    return footerButtonSize(
      flyerBoxWidth: flyerBoxWidth,
    );
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static double _infoButtonCollapsedHeight({
    required double flyerBoxWidth,
  }){
    return 0.7 * footerButtonSize(
      flyerBoxWidth: flyerBoxWidth,
    );
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static double _infoButtonExpandedHeight({
    required double flyerBoxWidth,
  }){
    return flyerBoxWidth;
  }
  // ---------

  /// INFO BUTTON CORNERS

  // ---------
  /// TESTED : WORKS PERFECT
  static BorderRadius infoButtonCorners({
    required double flyerBoxWidth,
    required bool tinyMode,
    required bool? isExpanded,
  }){

    double _cornersValue = 0;

    if (tinyMode == true){
      _cornersValue = _infoButtonTinyCornerValue(
        flyerBoxWidth: flyerBoxWidth,
      );
    }

    else {

      if (Mapper.boolIsTrue(isExpanded) == true){
        _cornersValue = _infoButtonExpandedCornerValue(
          flyerBoxWidth: flyerBoxWidth,
        );
      }

      else {
        _cornersValue = _infoButtonCollapsedCornerValue(
          flyerBoxWidth: flyerBoxWidth,
        );
      }

    }

    return Borderers.cornerAll(_cornersValue);
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static double _infoButtonTinyCornerValue({
    required double flyerBoxWidth,
  }){

    final double _footerBottomCorners = footerBoxBottomCornerValue(flyerBoxWidth);

    final double _tinyMargin = _infoButtonTinyMarginValue(
      flyerBoxWidth: flyerBoxWidth,
    );

    return _footerBottomCorners - _tinyMargin;
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static double _infoButtonCollapsedCornerValue({
    required double flyerBoxWidth,
  }){

    final double _footerBottomCorners = footerBoxBottomCornerValue(flyerBoxWidth);

    final double _infoButtonMargin = infoButtonCollapsedMarginValue(
        flyerBoxWidth: flyerBoxWidth
    );

    return _footerBottomCorners - _infoButtonMargin;
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static double _infoButtonExpandedCornerValue({
    required double flyerBoxWidth,
  }){
    return footerButtonRadius(
      flyerBoxWidth: flyerBoxWidth,
    );
  }
  // ---------

  /// INFO BUTTON MARGIN

  // ---------
  /// TESTED : WORKS PERFECT
  static EdgeInsets infoButtonMargins({
    required double flyerBoxWidth,
    required bool tinyMode,
    required bool? isExpanded,
  }){
    double _marginValue = 0;

    if (tinyMode == true){
      _marginValue = _infoButtonTinyMarginValue(
        flyerBoxWidth: flyerBoxWidth,
      );
    }

    else {

      if (Mapper.boolIsTrue(isExpanded) == true){
        _marginValue = _infoButtonExpandedMarginValue(
          flyerBoxWidth: flyerBoxWidth,
        );
      }

      else {
        _marginValue = infoButtonCollapsedMarginValue(
          flyerBoxWidth: flyerBoxWidth,
        );
      }

    }

    return EdgeInsets.all(_marginValue);
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static double _infoButtonTinyMarginValue({
    required double flyerBoxWidth,
  }){
    return footerButtonMarginValue(flyerBoxWidth);
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static double infoButtonCollapsedMarginValue({
    required double flyerBoxWidth,
  }){

    final double _buttonMinHeight = _infoButtonCollapsedHeight(
      flyerBoxWidth: flyerBoxWidth,
    );

    final double _footerMinHeight = footerBoxHeight(
      flyerBoxWidth: flyerBoxWidth,
      infoButtonExpanded: false,
      showTopButton: false,
    );

    return (_footerMinHeight - _buttonMinHeight) / 2;

  }
  // ---------
  /// TESTED : WORKS PERFECT
  static double _infoButtonExpandedMarginValue({
    required double flyerBoxWidth,
  }){
    return footerButtonMarginValue(flyerBoxWidth);
  }
  // -----------------------------------------------------------------------------

  /// --- PROGRESS BAR SIZES

  // ---------
  /// TESTED : WORKS PERFECT
  static double progressBarBoxWidth(double flyerBoxWidth) {
    return flyerBoxWidth;
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static double progressBarBoxHeight(double flyerBoxWidth) {
    return flyerBoxWidth * _xProgressBarHeightRatio;
  }
  // ---------

  /// BOX MARGINS

  // ---------
  /// TESTED : WORKS PERFECT
  static EdgeInsets progressBarBoxMargins({
    required double flyerBoxWidth,
    EdgeInsets? margins,
  }) {
    return margins ?? EdgeInsets.only(top: flyerBoxWidth * 0.27);
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static double progressBarPaddingValue(double flyerBoxWidth) {
    final double _stripsTotalLength = progressStripsTotalLength(flyerBoxWidth);
    return (flyerBoxWidth - _stripsTotalLength) / 2;
  }
  // ---------

  ///  STRIPS SIZES

  // ---------
  /// TESTED : WORKS PERFECT
  static double progressStripsTotalLength(double flyerBoxWidth) {
    return flyerBoxWidth * 0.895;
  }
  // ---------

  ///  ONE STRIP SIZES

  // ---------
  /// TESTED : WORKS PERFECT
  static double progressStripLength({
    required double flyerBoxWidth,
    required int? numberOfStrips,
  }) {
    return progressStripsTotalLength(flyerBoxWidth) / (numberOfStrips ?? 1);
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static double progressStripThickness(double flyerBoxWidth) {
    return flyerBoxWidth * 0.007;
  }
  // ---------

  /// PROGRESS BAR STRIP CORNERS

  // ---------
  /// TESTED : WORKS PERFECT
  static double progressStripCornerValue(double flyerBoxWidth) {
    return progressStripThickness(flyerBoxWidth) * 0.5;
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static BorderRadius progressStripCorners({
    required double flyerBoxWidth
  }) {
    return Borderers.cornerAll(progressStripCornerValue(flyerBoxWidth));
  }
  // -----------------------------------------------------------------------------

  /// --- CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkFlyerIsFullScreen({
    required double gridWidth,
    required double gridHeight,
    required double flyerBoxWidth,
  }){

    final double _bigFlyerWidth = ZGridScale.getBigItemWidth(
      context: getMainContext(),
      gridWidth: gridWidth,
      gridHeight: gridHeight,
      itemAspectRatio: flyerAspectRatio(),
    );

    return flyerBoxWidth == _bigFlyerWidth;
  }
  // ---------
  /// TESTED : WORKS PERFECT
  static bool isTinyMode({
    required double gridWidth,
    required double gridHeight,
    required double flyerBoxWidth,
  }) {

    final bool _isFullScreen = checkFlyerIsFullScreen(
        gridWidth: gridWidth,
        gridHeight: gridHeight,
      flyerBoxWidth: flyerBoxWidth,
    );

    return !_isFullScreen;

    // bool _tinyMode = false; // 0.4 needs calibration
    //
    // if (flyerBoxWidth < (Scale.screenWidth(context) * 0.58)) {
    //   _tinyMode = true;
    // }
    //
    // return _tinyMode;
  }
  // -----------------------------------------------------------------------------

  /// --- FLYER GRID SIZES

  // --------------------
  /// TESTED : WORKS PERFECT
  static double flyerGridWidth({
    required BuildContext context,
    required double? givenGridWidth,
  }){
    return givenGridWidth ?? Scale.screenWidth(context);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double flyerGridHeight({
    required BuildContext context,
    required double? givenGridHeight,
  }){
    return givenGridHeight ?? Scale.screenHeight(context);
  }
  // --------------------
  static const double _spacingRatio = 0.03;
  // --------------------
  /// TESTED : WORKS PERFECT
  static double flyerGridVerticalScrollFlyerBoxWidth({
    required double gridZoneWidth,
    required int numberOfColumns,
    double? spacingRatio,
  }){

    final double _ratio = spacingRatio ?? _spacingRatio;

    final double _flyerBoxWidth =
        gridZoneWidth /
            (
                numberOfColumns
                    + (numberOfColumns * _ratio)
                    + _ratio // in ZGrid.getSmallItemWidth it is a (-) not (+)
            );
    return _flyerBoxWidth;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double flyerGridHorizontalScrollFlyerBoxWidth({
    required double gridZoneHeight,
    required int numberOfRows,
    double? spacingRatio,
  }){

    final double _ratio = spacingRatio ?? _spacingRatio;

    blog('numberOfRows : $numberOfRows');
    blog('gridZoneHeight : $gridZoneHeight : spacingRatio : $_ratio');
    assert(numberOfRows > 0, 'numberOfRows must be greater than 0');
    assert(gridZoneHeight > 0, 'gridZoneHeight must be greater than 0');

    final double _flyerBoxWidth =
        gridZoneHeight
        /
        (
            (numberOfRows * flyerHeightRatioToWidth)
            +
            (numberOfRows * _ratio) + _ratio
        );

    /// REVERSE MATH TEST
    // final double _flyerBoxHeight = _flyerBoxWidth * Ratioz.xxflyerZoneHeight;
    // final double spacing = getGridSpacingValue(flyerBoxWidth: _flyerBoxWidth);
    // final double _result = (_flyerBoxHeight * numberOfRows) + (spacing * (numberOfRows + 1));
    // blog('result : $_result = ($_flyerBoxHeight * $numberOfRows) + ($spacing * ($numberOfRows + 1))');

    return _flyerBoxWidth;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double flyerGridGridSpacingValue(double? flyerBoxWidth){
    return (flyerBoxWidth ?? 0) * _spacingRatio;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static EdgeInsets flyerGridPadding({
    required BuildContext context,
    required double gridWidth,
    required double gridHeight,
    required double gridSpacingValue,
    required double topPaddingValue, /// when is vertical scrolling
    required bool isVertical,
    required bool hasResponsiveSideMargin,
    double? endPadding,
  }){

    if (isVertical == true){
      return _verticalGridPaddings(
        gridHeight: gridHeight,
        gridWidth: gridWidth,
        bottomPadding: endPadding,
        topPaddingValue: topPaddingValue,
        hasResponsiveSideMargin: hasResponsiveSideMargin,
      );
    }

    else {
      return _horizontalGridPaddings(
        endPadding: endPadding,
        gridSpacingValue: gridSpacingValue,
      );
    }


  }
  // --------------------
  static EdgeInsets _verticalGridPaddings({
    required double gridWidth,
    required double gridHeight,
    required double? bottomPadding,
    required double topPaddingValue,
    required bool hasResponsiveSideMargin,
  }){

    final double gridSideMargin = ZGridScale.getGridSideMargin(
      context: getMainContext(),
      gridWidth: gridWidth,
      gridHeight: gridHeight,
      itemAspectRatio: flyerAspectRatio(),
      hasResponsiveSideMargin: hasResponsiveSideMargin,
    );

    final double? _bottomPaddingOnZoomedOut = ZGridScale.getBottomPaddingOnZoomedOut(
      bottomPaddingOnZoomedOut: bottomPadding,
    );

    return Scale.superInsets(
      context: getMainContext(),
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      enLeft: gridSideMargin,
      top: topPaddingValue,
      enRight: gridSideMargin,
      bottom: _bottomPaddingOnZoomedOut ?? Ratioz.horizon,
    );

  }
  // --------------------
  static EdgeInsets _horizontalGridPaddings({
    required double gridSpacingValue,
    required double? endPadding,
  }){

    return Scale.superInsets(
      context: getMainContext(),
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      enLeft: gridSpacingValue,
      top: gridSpacingValue,
      enRight: endPadding ?? gridSpacingValue,
      bottom: gridSpacingValue,
    );

  }
  // --------------------

  /// --- FLYER GRID SLOT SIZES

  // --------------------
  /// TESTED : WORKS PERFECT
  static double flyerGridSlotMinWidthFactor({
    required double gridFlyerWidth,
    required double gridZoneWidth,
  }){
    return gridFlyerWidth / gridZoneWidth;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double flyerGridSlotWidth({
    required BuildContext context,
    required double gridWidth,
    required int flyersLength,
  }) {
    final double _gridWidth = gridWidth - (2 * Ratioz.appBarMargin);
    final int _numberOfColumns = flyerGridColumnCount(flyersLength);
    return (_gridWidth - ((_numberOfColumns - 1) * Ratioz.appBarMargin)) / _numberOfColumns;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double flyerGridFlyerBoxWidth({
    required BuildContext context,
    required Axis scrollDirection,
    required int numberOfColumnsOrRows,
    required double gridWidth,
    required double? gridHeight,
    required bool hasResponsiveSideMargin,
    double? spacingRatio,
  }){

    if (scrollDirection == Axis.vertical){

      return ZGridScale.getSmallItemWidth(
        context: getMainContext(),
        gridWidth: gridWidth,
        gridHeight: gridHeight,
        columnCount: numberOfColumnsOrRows,
        itemAspectRatio: flyerAspectRatio(),
        hasResponsiveSideMargin: hasResponsiveSideMargin,
      );

    }

    else {

      final double _gridZoneHeight = flyerGridHeight(
        context: context,
        givenGridHeight: gridHeight,
      );

      return flyerGridHorizontalScrollFlyerBoxWidth(
        numberOfRows: numberOfColumnsOrRows,
        gridZoneHeight: _gridZoneHeight,
        spacingRatio: spacingRatio,
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int flyerGridNumberOfSlots({
    required int flyersCount,
    required bool addFlyerButtonIsOn,
    required bool isLoadingGrid,
    required int numberOfColumnsOrRows,
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
  /// TESTED : WORKS PERFECT
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
  /// TESTED : WORKS PERFECT
  static SliverGridDelegate flyerGridDelegate({
    required BuildContext context,
    required Axis scrollDirection,
    required double flyerBoxWidth,
    required int numberOfColumnsOrRows,
  }){

    final double _gridSpacingValue = flyerGridGridSpacingValue(flyerBoxWidth);

    if (scrollDirection == Axis.vertical){

      // return SliverGridDelegateWithMaxCrossAxisExtent(
      //   maxCrossAxisExtent: flyerBoxWidth,
      //   childAspectRatio:  flyerAspectRatio(),
      //   crossAxisSpacing: _gridSpacingValue,
      //   mainAxisSpacing: _gridSpacingValue,
      //   mainAxisExtent: flyerHeightByFlyerWidth(flyerBoxWidth: flyerBoxWidth),
      // );

      return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisSpacing: _gridSpacingValue,
      mainAxisSpacing: _gridSpacingValue,
      childAspectRatio: flyerAspectRatio(),
      crossAxisCount: numberOfColumnsOrRows,
      mainAxisExtent: flyerHeightByFlyerWidth(flyerBoxWidth: flyerBoxWidth),
    );
    }

    else {
      return SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: _gridSpacingValue,
        mainAxisSpacing: _gridSpacingValue,
        childAspectRatio: flyerAspectRatio(),
        crossAxisCount: numberOfColumnsOrRows,
        mainAxisExtent: flyerBoxWidth,
      );
    }

  }
  // -----------------------------------------------------------------------------

  /// GTA BUTTON

  // --------------------
  /// TESTED : WORKS PERFECT
  static double gtaButtonWidth({
    required double flyerBoxWidth,
  }){

    final double _footerButtonSpacing = footerButtonMarginValue(flyerBoxWidth);
    final double _footerButtonSize = footerButtonSize(
        flyerBoxWidth: flyerBoxWidth
    );

    return flyerBoxWidth
        - (_footerButtonSpacing * 2)
        - _footerButtonSize
        - (_footerButtonSize * 0.5);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static EdgeInsets gtaButtonMargins({
    required double flyerBoxWidth,
  }) {
    return EdgeInsets.symmetric(
      horizontal: FlyerDim.infoButtonMargins(
        flyerBoxWidth: flyerBoxWidth,
        isExpanded: false,
        tinyMode: false,
      )
          .bottom,
    );
  }
  // -----------------------------------------------------------------------------
}
