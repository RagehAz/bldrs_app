import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/b_footer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/e_footer_button.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/a_info_button_structure/b_info_page_tree.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/info_button_type.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class InfoButtonStarter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InfoButtonStarter({
    @required this.flyerBoxWidth,
    @required this.flyerModel,
    @required this.flyerZone,
    @required this.tinyMode,
    @required this.infoButtonExpanded,
    @required this.onInfoButtonTap,
    @required this.infoButtonType,
    @required this.infoPageVerticalController,
    @required this.inFlight,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final FlyerModel flyerModel;
  final ZoneModel flyerZone;
  final bool tinyMode;
  final ValueNotifier<bool> infoButtonExpanded;
  final Function onInfoButtonTap;
  final InfoButtonType infoButtonType;
  final ScrollController infoPageVerticalController;
  final bool inFlight;
  // --------------------------------------------------------------------------

  /// WIDTH

// --------------------------------
  static double _tinyWidth({
    @required double flyerBoxWidth,
  }){
    final double _width = flyerBoxWidth * 0.45;

    return _width;
  }
// --------------------------------
  static double collapsedWidth({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){

    final double _footerButtonSize = FooterButton.buttonSize(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
        tinyMode: false
    );

    final double _footerButtonMargin = FooterButton.buttonMargin(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
        tinyMode: false
    );

    final double _infoButtonCollapsedMargin = collapsedMarginValue(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );

    final double _collapsedWidth = flyerBoxWidth
        -
        (4 * _footerButtonMargin)
        -
        (3 * _footerButtonSize)
        -
        (1 * _infoButtonCollapsedMargin);

    return _collapsedWidth;
  }
// --------------------------------
  static double expandedWidth({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){

    final double _footerButtonMargin = FooterButton.buttonMargin(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
        tinyMode: false
    );

    final _expandedWidth = flyerBoxWidth - (2 * _footerButtonMargin);

    return _expandedWidth;
  }
// -----------------------------------------------------------------------------

  /// HEIGHT

// --------------------------------
  static double _tinyHeight(){
    const double _height = 20;

    return _height;
  }
// --------------------------------
  static double collapsedHeight({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){

    final double _footerButtonSize = FooterButton.buttonSize(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
        tinyMode: false
    );

    final _collapsedHeight =  _footerButtonSize * 0.7;

    return _collapsedHeight;
  }
// --------------------------------
  static double expandedHeight({
    @required double flyerBoxWidth,
  }){

    return flyerBoxWidth;
  }
// -----------------------------------------------------------------------------

  /// MARGIN

// --------------------------------
  static double _tinyMarginValue(){
    const double _margin = 10;

    return _margin;
  }
// --------------------------------
  static double collapsedMarginValue({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){

    final double _buttonMinHeight = collapsedHeight(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );

    final double _footerMinHeight = FooterBox.collapsedHeight(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
      tinyMode: false,
    );

    final double _collapsedMargin = (_footerMinHeight - _buttonMinHeight) / 2;

    return _collapsedMargin;
  }
// --------------------------------
  static double expandedMarginValue({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){

    final double _expandedMargin = FooterButton.buttonMargin(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
        tinyMode: false
    );

    return _expandedMargin;
  }
// -----------------------------------------------------------------------------

  /// COLOR

// --------------------------------
  static Color _tinyColor(){
    const Color _color = Colorz.bloodTest;

    return _color;
  }
// --------------------------------
  static Color _collapsedColor(){
    const Color _color = Colorz.black230;

    return _color;
  }
// --------------------------------
  static Color _expandedColor(){
    const Color _color = Colorz.black255;

    return _color;
  }
// ----------------------------------------------------------------------------

  /// CORNERS

// --------------------------------
  static double _tinyCornerValue(){
    const double _corner = 5;

    return _corner;
  }
// --------------------------------
  static double _collapsedCornerValue({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){

    final double _footerBottomCorners = FooterBox.boxCornersValue(flyerBoxWidth);

    final double _infoButtonMargin = collapsedMarginValue(
        context: context,
        flyerBoxWidth: flyerBoxWidth
    );

    final double _collapsedCornerValue = _footerBottomCorners - _infoButtonMargin;

    return _collapsedCornerValue;
  }
// --------------------------------
  static double expandedCornerValue({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){

    final double _expandedCornerValue = FooterButton.buttonRadius(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
      tinyMode: false,
    );

    return _expandedCornerValue;
  }
// -----------------------------------------------------------------------------

  /// GETTERS

// --------------------------------
  static double getWidth({
    @required BuildContext context,
    @required double flyerBoxWidth,
    @required bool tinyMode,
    @required bool isExpanded,
    @required InfoButtonType infoButtonType,
  }){
    double _width;

    /// TINY MODE
    if (tinyMode == true){
      _width = _tinyWidth(
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

        /// ONLY INFO
        if (infoButtonType == InfoButtonType.info){
          _width = collapsedHeight(
              context: context,
              flyerBoxWidth: flyerBoxWidth
          );
        }

        /// PRICE TAG
        else {
          _width = collapsedWidth(
            context: context,
            flyerBoxWidth: flyerBoxWidth,
          );
        }

      }

    }

    return _width;
  }
// --------------------------------
  static double getHeight({
    @required BuildContext context,
    @required double flyerBoxWidth,
    @required bool tinyMode,
    @required bool isExpanded,
  }){
    double _height;

    if (tinyMode == true){
      _height = _tinyHeight();
    }

    else {

      if (isExpanded == true){
        _height = expandedHeight(
          flyerBoxWidth: flyerBoxWidth,
        );
      }

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
    @required double flyerBoxWidth,
    @required bool tinyMode,
    @required bool isExpanded,
  }){

    double _cornersValue;

    if (tinyMode == true){
      _cornersValue = _tinyCornerValue();
    }

    else {

      if (isExpanded == true){
        _cornersValue = expandedCornerValue(
          context: context,
          flyerBoxWidth: flyerBoxWidth,
        );
      }

      else {
        _cornersValue = _collapsedCornerValue(
          context: context,
          flyerBoxWidth: flyerBoxWidth,
        );
      }

    }

    final BorderRadius _borders = Borderers.superBorderAll(context, _cornersValue);

    return _borders;
  }
// --------------------------------
  static Color getColor({
    @required double flyerBoxWidth,
    @required bool tinyMode,
    @required bool isExpanded,
  }){

    Color _color;

    if (tinyMode == true){
      _color = _tinyColor();
    }

    else {

      if (isExpanded == true){
        _color = _expandedColor();
      }

      else {
        _color = _collapsedColor();
      }

    }

    return _color;
  }
// --------------------------------
  static EdgeInsets getMargin({
    @required BuildContext context,
    @required double flyerBoxWidth,
    @required bool tinyMode,
    @required bool isExpanded,
  }){
    double _marginValue;

    if (tinyMode == true){
      _marginValue = _tinyMarginValue();
    }

    else {

      if (isExpanded == true){
        _marginValue = expandedMarginValue(
          context: context,
          flyerBoxWidth: flyerBoxWidth,
        );
      }
      else {
        _marginValue = collapsedMarginValue(
          context: context,
          flyerBoxWidth: flyerBoxWidth,
        );
      }
    }

    final EdgeInsets _margins = EdgeInsets.all(_marginValue);

    return _margins;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Align(
      key: const ValueKey<String>('InfoButtonStarter'),
      alignment: Aligners.superBottomAlignment(context),
      child: GestureDetector(
        onTap: onInfoButtonTap,
        child: ValueListenableBuilder(
          valueListenable: infoButtonExpanded,
          builder: (_, bool buttonExpanded, Widget infoPageTree){

            final double _width = InfoButtonStarter.getWidth(
              context: context,
              flyerBoxWidth: flyerBoxWidth,
              tinyMode: tinyMode,
              isExpanded: buttonExpanded,
              infoButtonType: infoButtonType,
            );

            final double _height = InfoButtonStarter.getHeight(
              context: context,
              flyerBoxWidth: flyerBoxWidth,
              tinyMode: tinyMode,
              isExpanded: buttonExpanded,
            );

            final EdgeInsets _margins = InfoButtonStarter.getMargin(
              context: context,
              flyerBoxWidth: flyerBoxWidth,
              tinyMode: tinyMode,
              isExpanded: buttonExpanded,
            );

            final Color _color = InfoButtonStarter.getColor(
                flyerBoxWidth: flyerBoxWidth,
                tinyMode: tinyMode,
                isExpanded: buttonExpanded
            );

            final BorderRadius _borders = InfoButtonStarter.getBorders(
                context: context,
                flyerBoxWidth: flyerBoxWidth,
                tinyMode: tinyMode,
                isExpanded: buttonExpanded
            );

            return AnimatedContainer(
              key: const ValueKey<String>('InfoButtonStarter_animated_container'),
              width: _width,
              height: _height,
              duration: const Duration(milliseconds: 100),
              decoration: BoxDecoration(
                color: _color,
                borderRadius: _borders,
              ),
              margin: _margins,
              child: infoPageTree,
            );

            },

          child: InfoPageTree(
            key: const ValueKey<String>('InfoButtonStarter_InfoPageTree'),
            flyerModel: flyerModel,
            flyerZone: flyerZone,
            flyerBoxWidth: flyerBoxWidth,
            infoButtonType: infoButtonType,
            buttonIsExpanded: infoButtonExpanded,
            tinyMode: tinyMode,
            infoPageVerticalController: infoPageVerticalController,
            inFlight: inFlight,
          ),

        ),
      ),
    );
  }
}
