import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/footer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/footer_button.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class InfoButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InfoButton({
    @required this.flyerBoxWidth,
    @required this.tinyMode,
    @required this.infoButtonExpanded,
    @required this.onInfoButtonTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final bool tinyMode;
  final ValueNotifier<bool> infoButtonExpanded;
  final Function onInfoButtonTap;
  /// --------------------------------------------------------------------------

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

    return Align(
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
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero, /// ENTA EBN WES5A
                children: <Widget>[

                  CollapsedPrice(
                      flyerBoxWidth: flyerBoxWidth
                  ),


                ],

              ),
            );

          },

        ),
      ),
    );
  }
}

class CollapsedPrice extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CollapsedPrice({
    @required this.flyerBoxWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _width = InfoButton.collapsedWidth(
        context: context,
        flyerBoxWidth: flyerBoxWidth
    );

    final double _height = InfoButton.collapsedHeight(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: true);
    final CountryModel _currentCountry = _zoneProvider.currentCountry;

    const double _currentPrice = 14019.50;
    final String _currency = _currentCountry?.currency;
    const double _oldPrice = 17800;
    final int _discountPercentage = Numeric.discountPercentage(
      oldPrice: _oldPrice,
      currentPrice: _currentPrice,
    );

    const double _tinyModePriceSizeMultiplier = 1.4;
    final double _flyerSizeFactor = FlyerBox.sizeFactorByWidth(context, flyerBoxWidth);

    const String _off = 'OFF';

    final double _paddingsValue = _height * 0.1;
    final EdgeInsets _paddings = EdgeInsets.symmetric(horizontal: _paddingsValue);
    final Alignment _superCenterAlignment = Aligners.superCenterAlignment(context);

    final double _priceWidth = _width - _height - 1 - _paddingsValue;

    return Container(
      width: _width,
      height: _height,
      alignment: Alignment.center,
      // child: SuperVerse.priceVerse(
      //   context: context,
      //   currency: _currency,
      //   price: _currentPrice,
      //   scaleFactor: _flyerSizeFactor * 0.5,
      // ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          /// DISCOUNT
          SizedBox(
            width: _height,
            height: _height,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[

                /// PERCENTAGE
                Positioned(
                  top: _height * 0.13,
                  child: Container(
                    width: _height,
                    padding: EdgeInsets.symmetric(horizontal: _height * 0.05),
                    child: SuperVerse(
                      verse: '${ _discountPercentage.toString()}%',
                      weight: VerseWeight.black,
                      color: Colorz.red255,
                    ),
                  ),
                ),

                /// OFF
                Positioned(
                  bottom: _height * 0.13,
                  child: const SuperVerse(
                    verse: _off,
                    weight: VerseWeight.black,
                    scaleFactor: 0.8,
                    color: Colorz.red255,
                  ),
                ),

              ],
            ),
          ),

          /// SEPARATOR LINE
          Container(
            width: 1,
            height: _height * 0.6,
            color: Colorz.white125,
          ),

          /// PRICES
          Container(
            width: _priceWidth,
            // padding: EdgeInsets.symmetric(horizontal: _height * 0.1),
            alignment: _superCenterAlignment,
            child: Stack(
              alignment: _superCenterAlignment,
              children: <Widget>[

                Positioned(
                  top: _height * 0.15,
                  child: Padding(
                    padding: _paddings,
                    child: Row(
                      children: <Widget>[

                        /// OLD PRICE
                        SuperVerse.priceVerse(
                            context: context,
                            // currency: _currency,
                            price: _oldPrice,
                            scaleFactor: _flyerSizeFactor * 0.35,
                            strikethrough: true,
                            color: Colorz.grey255,
                            isBold: false
                        ),

                        /// CURRENCY
                        Padding(
                          padding: _paddings,
                          child: SuperVerse(
                            verse: _currency,
                            size: 6,
                            scaleFactor: _flyerSizeFactor * 0.35,
                            weight: VerseWeight.thin,
                            italic: true,
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

                /// CURRENT PRICE
                Positioned(
                  bottom: _height * 0.1,
                  child: Container(
                    width: _priceWidth,
                    height: _height * 0.5,
                    alignment: _superCenterAlignment,
                    padding: _paddings,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: SuperVerse.priceVerse(
                        context: context,
                        // currency: _currency,
                        price: _currentPrice,
                        scaleFactor: _flyerSizeFactor * 0.6,
                        color: Colorz.yellow255,
                      ),
                    ),
                  ),
                )

              ],
            ),
          ),

          /// FAKE END PADDING
          SizedBox(
            width: _paddingsValue,
            height: _height,
          ),

        ],
      ),
    );
  }
}
