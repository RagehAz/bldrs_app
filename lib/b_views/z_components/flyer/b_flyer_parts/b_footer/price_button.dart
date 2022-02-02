import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/footer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/footer_button.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class InfoButton extends StatefulWidget {

  const InfoButton({
    @required this.flyerBoxWidth,
    @required this.tinyMode,
    Key key
  }) : super(key: key);

 final double flyerBoxWidth;
 final bool tinyMode;

  @override
  _InfoButtonState createState() => _InfoButtonState();
// -----------------------------------------------------------------------------

  /// WIDTH

// --------------------------------
  static double _tinyWidth({
  @required double flyerBoxWidth,
}){
    final double _width = flyerBoxWidth * 0.45;

    return _width;
  }
// --------------------------------
  static double _collapsedWidth({
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

    final double _infoButtonCollapsedMargin = _collapsedMarginValue(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );

    final double _collapsedWidth = flyerBoxWidth
        -
        (3 * _footerButtonMargin)
        -
        (3 * _footerButtonSize)
        -
        (2 * _infoButtonCollapsedMargin);

    return _collapsedWidth;
  }
// --------------------------------
  static double _expandedWidth({
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
    double _height = 20;

    return _height;
  }
// --------------------------------
  static double _collapsedHeight({
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
  static double _expandedHeight({
  @required double flyerBoxWidth,
  }){

    return flyerBoxWidth;
  }
// -----------------------------------------------------------------------------

  /// MARGIN

// --------------------------------
  static double _tinyMarginValue(){
    double _margin = 10;

    return _margin;
  }
// --------------------------------
  static double _collapsedMarginValue({
    @required BuildContext context,
    @required double flyerBoxWidth,
}){

    final double _buttonMinHeight = _collapsedHeight(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
    );

    final double _footerMinHeight = FooterBox.boxHeight(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
      tinyMode: false,
    );

    final double _collapsedMargin = (_footerMinHeight - _buttonMinHeight) / 2;

    return _collapsedMargin;
  }
// --------------------------------
  static double _expandedMarginValue({
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
    Color _color = Colorz.bloodTest;

    return _color;
  }
// --------------------------------
  static Color _collapsedColor(){
    const Color _color = Colorz.blue80;

    return _color;
  }
// --------------------------------
  static Color _expandedColor(){
    const Color _color = Colorz.white200;

    return _color;
  }
// ----------------------------------------------------------------------------

  /// CORNERS

// --------------------------------
  static double _tinyCornerValue(){
    double _corner = 5;

    return _corner;
  }
// --------------------------------
  static double _collapsedCornerValue({
    @required BuildContext context,
    @required double flyerBoxWidth,
}){

    final double _footerBottomCorners = FooterBox.boxCornersValue(flyerBoxWidth);

    final double _infoButtonMargin = _collapsedMarginValue(
        context: context,
        flyerBoxWidth: flyerBoxWidth
    );

    final double _collapsedCornerValue = _footerBottomCorners - _infoButtonMargin;

    return _collapsedCornerValue;
  }
// --------------------------------
  static double _expandedCornerValue({
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
}){

    double _width;

    if (tinyMode == true){
      _width = _tinyWidth(
        flyerBoxWidth: flyerBoxWidth,
      );
    }

    else {

      if (isExpanded == true){
        _width = _expandedWidth(
          context: context,
          flyerBoxWidth: flyerBoxWidth,
        );
      }

      else {
        _width = _collapsedWidth(
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
        _height = _expandedHeight(
          flyerBoxWidth: flyerBoxWidth,
        );
      }

      else {
        _height = _collapsedHeight(
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
        _cornersValue = _expandedCornerValue(
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
        _marginValue = _expandedMarginValue(
          context: context,
          flyerBoxWidth: flyerBoxWidth,
        );
      }
      else {
        _marginValue = _collapsedMarginValue(
          context: context,
          flyerBoxWidth: flyerBoxWidth,
        );
      }
    }

    final EdgeInsets _margins = EdgeInsets.all(_marginValue);

    return _margins;
  }
// -----------------------------------------------------------------------------
}

class _InfoButtonState extends State<InfoButton> {
// -----------------------------------------------------------------------------
  ValueNotifier<bool> infoButtonExpanded = ValueNotifier(false);
// ----------------------------------------
  void onPriceButtonTap(){
    infoButtonExpanded.value = ! infoButtonExpanded.value;
  }
// -----------------------------------------------------------------------------
  double _calculateWidth(bool buttonIsExpanded){

    double _width;

    if (buttonIsExpanded == true){
      _width = widget.flyerBoxWidth;
    }

    else {

      final double _footerButtonSize = FooterButton.buttonSize(
          context: context,
          flyerBoxWidth: widget.flyerBoxWidth,
          tinyMode: false
      );

      final double _footerButtonMargin = FooterButton.buttonMargin(
          context: context,
          flyerBoxWidth: widget.flyerBoxWidth,
          tinyMode: false
      );

      final double _infoButtonMargin = _infoButtonMinMargin();

      _width = widget.flyerBoxWidth
          -
          (3 * _footerButtonMargin)
          -
          (3 * _footerButtonSize)
          -
          (2 * _infoButtonMargin);

    }

    return _width;
  }
// -----------------------------------------------------------------------------
//   double _calculateHeight(bool buttonIsExpanded){
//     double _height;
//
//
//     if (buttonIsExpanded == true){
//       _height = 50;
//     }
//
//     else {
//
//       final double _buttonMinMargin = _infoButtonMinMargin();
//       final double _footerMinHeight = FooterBox.boxHeight(
//         context: context,
//         flyerBoxWidth: widget.flyerBoxWidth,
//         tinyMode: false,
//       );
//
//       _height = _footerMinHeight - (_buttonMinMargin * 2);
//     }
//
//     return _height * 1.2;
//   }
// -----------------------------------------------------------------------------
  double _infoButtonMinHeight(){

    final double _footerButtonSize = FooterButton.buttonSize(
        context: context,
        flyerBoxWidth: widget.flyerBoxWidth,
        tinyMode: false
    );

    return _footerButtonSize * 0.7;
  }
// -----------------------------------------------------------------------------
  double _infoButtonMinMargin(){

    final double _buttonMinHeight = _infoButtonMinHeight();
    final double _footerMinHeight = FooterBox.boxHeight(
      context: context,
      flyerBoxWidth: widget.flyerBoxWidth,
      tinyMode: false,
    );

    final double _minMargin = (_footerMinHeight - _buttonMinHeight) / 2;

    return _minMargin;
  }
// -----------------------------------------------------------------------------
  BorderRadius _calculateBorders(){
    final double _footerBottomCorners = FooterBox.boxCornersValue(widget.flyerBoxWidth);

    final double _infoButtonMargin = _infoButtonMinMargin();

    final double _buttonCorners = _footerBottomCorners - _infoButtonMargin;

    final BorderRadius _intoButtonBorder = Borderers.superBorderAll(context, _buttonCorners);
    return _intoButtonBorder;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: superCenterAlignment(context),
      child: GestureDetector(
        onTap: onPriceButtonTap,
        child: ValueListenableBuilder(
          valueListenable: infoButtonExpanded,
          builder: (_, bool buttonExpanded, Widget child){

            final double _width = _calculateWidth(buttonExpanded);
            final double _height = _infoButtonMinHeight();

            final double _marginValue = _infoButtonMinMargin();
            final EdgeInsets _margins = EdgeInsets.all(_marginValue);

            blog('a77aaaaaaaaaaa');

            return AnimatedContainer(
              width: _width,
              height: _height,
              duration: const Duration(milliseconds: 100),
              decoration: BoxDecoration(
                color: Colorz.bloodTest,
                borderRadius: _calculateBorders(),
              ),
              margin: _margins,
            );

          },


        ),
      ),
    );
  }
}
