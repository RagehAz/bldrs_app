import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/footer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/footer_button.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PriceTag extends StatefulWidget {

  const PriceTag({
    @required this.flyerBoxWidth,
    @required this.flyerBoxHeight,
    @required this.tinyMode,
    @required this.flyerModel,
    @required this.priceTagePageController,
    Key key
  }) : super(key: key);

  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final bool tinyMode;
  final FlyerModel flyerModel;
  final PageController priceTagePageController;

  @override
  State<PriceTag> createState() => _PriceTagState();
// -----------------------------------------------------------------------------
  static double _priceTagMinWidthBigMode({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){

    return (flyerBoxWidth * 0.5)
        +
        (
            FooterButton.buttonSize(
                context: context,
                flyerBoxWidth: flyerBoxWidth,
                tinyMode: false,
            ) * 0.5
        );

  }
// -----------------------------------------------------------------------------
  static double _priceTagMaxWidthBigMode({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){

    final double _width =
        (flyerBoxWidth * 0.5)
            +
            (FooterButton.buttonSize(
              context: context,
              flyerBoxWidth: flyerBoxWidth,
              tinyMode: false,
            ) * 0.5)
            +
            FooterButton.buttonMargin(
                context: context,
                flyerBoxWidth: flyerBoxWidth,
                tinyMode: false
            )
            +
            FooterButton.buttonSize(
              context: context,
              flyerBoxWidth: flyerBoxWidth,
              tinyMode: false,
            );

    return _width;
  }
// -----------------------------------------------------------------------------
  static double _priceTagMinHeightBigMode({
    @required BuildContext context,
    @required double flyerBoxWidth,
}){
    return flyerBoxWidth * 0.2;
  }
// -----------------------------------------------------------------------------
  static double _priceTagMaxHeightBigMode({
    @required double flyerBoxWidth,
  }){
    return flyerBoxWidth * 0.8;
  }
// -----------------------------------------------------------------------------
  static double getPriceTagWidth({
    @required BuildContext context,
    @required bool tinyMode,
    @required bool isExpanded,
    @required double flyerBoxWidth,
}){

    double _width;

    if (tinyMode == true){
      _width = flyerBoxWidth * 0.7;
    }

    else {

      if (isExpanded == true){
        _width = _priceTagMaxWidthBigMode(
            context: context,
            flyerBoxWidth: flyerBoxWidth
        );
      }

      else {
        _width = _priceTagMinWidthBigMode(
            context: context,
            flyerBoxWidth: flyerBoxWidth
        );
      }

    }

    return _width;
  }
// -----------------------------------------------------------------------------
  static double getPriceTagHeight({
    @required BuildContext context,
    @required bool tinyMode,
    @required bool isExpanded,
    @required double flyerBoxWidth,
}){
    double _height;

    if (tinyMode == true){
      _height = flyerBoxWidth * 0.2;
    }

    else {

      if (isExpanded == true){
        _height = _priceTagMaxHeightBigMode(
            flyerBoxWidth: flyerBoxWidth
        );
      }

      else {
        _height = _priceTagMinHeightBigMode(
            context: context,
            flyerBoxWidth: flyerBoxWidth
        );
      }

    }

    return _height;

  }
// -----------------------------------------------------------------------------
}

class _PriceTagState extends State<PriceTag> {


// -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isExpanded = ValueNotifier(false);
// ---------------------------------------------
  void _triggerPriceTag(){

    blog('taaaaaapping on price tag');

    _isExpanded.value = !_isExpanded.value;
  }
// -----------------------------------------------------------------------------
  String _getCurrentCurrency(BuildContext context){
    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: true);
    return _zoneProvider.currentCountry.currency;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _footerHeight = FooterBox.collapsedHeight(
        context: context,
        flyerBoxWidth: widget.flyerBoxWidth
    );

    const double _currentPrice = 14999.99;
    final String _currency = _getCurrentCurrency(context);
    const double _oldPrice = 17800;
    final int _discountPercentage = Numeric.discountPercentage(
      oldPrice: _oldPrice,
      currentPrice: _currentPrice,
    );

    // final double _flyerSizeFactor = FlyerBox.sizeFactorByWidth(context, widget.flyerBoxWidth);
    // final double _tinyModePriceSizeMultiplier = widget.tinyMode == true ? 1.4 : 1;
    // final double _priceTagMinWidthBigMode = PriceTag._priceTagMinWidthBigMode(context: context, flyerBoxWidth: widget.flyerBoxWidth);
    // final double _width = widget.tinyMode == true ? _priceTagMinWidthBigMode  : widget.flyerBoxWidth * 0.55;
    // final double _height = widget.tinyMode == true ? widget.flyerBoxWidth * 0.3 : widget.flyerBoxWidth * 0.2;

    return Align(
      alignment: Aligners.superBottomAlignment(context),
      child: ValueListenableBuilder(
          valueListenable: _isExpanded,
          builder: (_, bool isExpanded, Widget child){

            final double _width = PriceTag.getPriceTagWidth(
              context: context,
              flyerBoxWidth: widget.flyerBoxWidth,
              tinyMode: widget.tinyMode,
              isExpanded: isExpanded,
            );

            final double _height = PriceTag.getPriceTagHeight(
              context: context,
              flyerBoxWidth: widget.flyerBoxWidth,
              tinyMode: widget.tinyMode,
              isExpanded: isExpanded,
            );

            return AnimatedContainer(
              width: widget.flyerBoxWidth,
              height: _height,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 100),
              alignment: Aligners.superCenterAlignment(context),
              child: PageView(
                children: <Widget>[

                  GestureDetector(
                    onTap: _triggerPriceTag,
                    child: AnimatedContainer(
                      width: _width,
                      height: _height,
                      // margin: EdgeInsets.only(bottom: _footerHeight),
                      curve: Curves.easeOut,
                      duration: const Duration(milliseconds: 100),
                      decoration: BoxDecoration(
                        color: Colorz.bloodTest,
                        borderRadius: Borderers.superPriceTagCorners(context, widget.flyerBoxWidth),
                        // boxShadow: Shadowz.appBarShadow,
                      ),
                    ),
                  ),

                  Container(
                    width: widget.flyerBoxWidth,
                    height: 20,
                    color: Colorz.yellow125,
                  ),

                ],
              ),
            );

          }
      ),
    );

    // return Container(
    //   width: widget.flyerBoxWidth,
    //   height: FlyerBox.height(context, widget.flyerBoxWidth),
    //   alignment: Aligners.superBottomAlignment(context),
    //   child: Container(
    //     width: _width,
    //     height: _height,
    //     padding: const EdgeInsets.all(5),
    //     margin: EdgeInsets.only(bottom: _footerHeight),
    //     decoration: BoxDecoration(
    //       color: Colorz.white125,
    //       borderRadius: Borderers.superPriceTagCorners(context, widget.flyerBoxWidth),
    //       boxShadow: Shadowz.appBarShadow,
    //     ),
    //     child: FittedBox(
    //       fit: BoxFit.scaleDown,
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: <Widget>[
    //           Container(
    //             alignment: Aligners.superCenterAlignment(context),
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: <Widget>[
    //
    //                 /// CURRENT PRICING
    //                 SuperVerse.priceVerse(
    //                     context: context,
    //                     price: _currentPrice,
    //                     currency: _currency,
    //                     scaleFactor:
    //                     _flyerSizeFactor * _tinyModePriceSizeMultiplier,
    //                     color: Colorz.black255),
    //
    //                 /// OLD PRICING
    //                 if (widget.tinyMode == false)
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: <Widget>[
    //                       SuperVerse.priceVerse(
    //                         context: context,
    //                         price: _oldPrice,
    //                         currency: _currency,
    //                         scaleFactor: _flyerSizeFactor * 0.4,
    //                         strikethrough: true,
    //                         color: Colorz.black125,
    //                       ),
    //                       SizedBox(
    //                         width: _flyerSizeFactor * 10,
    //                       ),
    //                       SuperVerse(
    //                         verse: '$_discountPercentage% OFF',
    //                         color: Colorz.green255,
    //                         weight: VerseWeight.black,
    //                         italic: true,
    //                         scaleFactor: _flyerSizeFactor,
    //                       ),
    //                     ],
    //                   ),
    //
    //               ],
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
