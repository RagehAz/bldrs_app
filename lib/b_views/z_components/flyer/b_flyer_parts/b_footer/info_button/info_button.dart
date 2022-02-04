import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/footer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/footer_button.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/discount_price_tag.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/info_graphic.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/installment_price_tag.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/normal_price_tag.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

enum InfoButtonType{
  info,
  price,
  discount,
  installments,
}

class InfoButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InfoButton({
    @required this.flyerBoxWidth,
    @required this.tinyMode,
    @required this.infoButtonExpanded,
    @required this.onInfoButtonTap,
    @required this.infoButtonType,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final bool tinyMode;
  final ValueNotifier<bool> infoButtonExpanded;
  final Function onInfoButtonTap;
  final InfoButtonType infoButtonType;
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

    final double _infoButtonCollapsedMargin = _collapsedMarginValue(
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
        _width = _expandedWidth(
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
        _height = _expandedHeight(
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
  @override
  Widget build(BuildContext context) {

    const InfoButtonType _priceTagType = InfoButtonType.info;

    return Align(
      key: const ValueKey<String>('info_button'),
      alignment: Aligners.superCenterAlignment(context),
      child: GestureDetector(
        onTap: onInfoButtonTap,
        child: ValueListenableBuilder(
          valueListenable: infoButtonExpanded,
          builder: (_, bool buttonExpanded, Widget child){

            final double _width = InfoButton.getWidth(
              context: context,
              flyerBoxWidth: flyerBoxWidth,
              tinyMode: tinyMode,
              isExpanded: buttonExpanded,
              infoButtonType: infoButtonType,
            );

            final double _height = InfoButton.getHeight(
              context: context,
              flyerBoxWidth: flyerBoxWidth,
              tinyMode: tinyMode,
              isExpanded: buttonExpanded,
            );

            final EdgeInsets _margins = InfoButton.getMargin(
              context: context,
              flyerBoxWidth: flyerBoxWidth,
              tinyMode: tinyMode,
              isExpanded: buttonExpanded,
            );

            final Color _color = InfoButton.getColor(
                flyerBoxWidth: flyerBoxWidth,
                tinyMode: tinyMode,
                isExpanded: buttonExpanded
            );

            final BorderRadius _borders = InfoButton.getBorders(
                context: context,
                flyerBoxWidth: flyerBoxWidth,
                tinyMode: tinyMode,
                isExpanded: buttonExpanded
            );

            return AnimatedContainer(
              width: _width,
              height: _height,
              duration: const Duration(milliseconds: 100),
              decoration: BoxDecoration(
                color: _color,
                borderRadius: _borders,
              ),
              margin: _margins,
              child: child,
            );

          },

          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero, /// ENTA EBN WES5A
            children: <Widget>[

              if (_priceTagType == InfoButtonType.info)
                InfoGraphic(
                  flyerBoxWidth: flyerBoxWidth,
                ),

              if (_priceTagType == InfoButtonType.price)
                NormalPriceTag(
                    flyerBoxWidth: flyerBoxWidth
                ),

              if (_priceTagType == InfoButtonType.discount)
                DiscountPriceTag(
                    flyerBoxWidth: flyerBoxWidth
                ),

              if (_priceTagType == InfoButtonType.installments)
                InstallmentsPriceTag(
                  flyerBoxWidth: flyerBoxWidth,
                ),

            ],

          ),
        ),
      ),
    );
  }
}
