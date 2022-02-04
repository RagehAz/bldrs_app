import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/info_button.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiscountPriceTag extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DiscountPriceTag({
    @required this.flyerBoxWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// ------------------------------------------------------------------
    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: true);
    final CountryModel _currentCountry = _zoneProvider.currentCountry;
// ------------------------------------------------------------------
    const double _currentPrice = 14019.50;
    final String _currency = _currentCountry?.currency;
    const double _oldPrice = 17800;
    final int _discountPercentage = Numeric.discountPercentage(
      oldPrice: _oldPrice,
      currentPrice: _currentPrice,
    );
    const String _off = 'OFF';
// ------------------------------------------------------------------
    final double _width = InfoButton.collapsedWidth(
        context: context,
        flyerBoxWidth: flyerBoxWidth
    );
    final double _height = InfoButton.collapsedHeight(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );
// ------------------------------------------------------------------
    final double _flyerSizeFactor = FlyerBox.sizeFactorByWidth(context, flyerBoxWidth);
    final double _paddingsValue = _height * 0.1;
    final EdgeInsets _paddings = EdgeInsets.symmetric(horizontal: _paddingsValue);
    final Alignment _superCenterAlignment = Aligners.superCenterAlignment(context);
    final double _priceWidth = _width - _height - 1 - _paddingsValue;
// ------------------------------------------------------------------
    return Container(
      key: const ValueKey<String>('discount_price_tag'),
      width: _width,
      height: _height,
      alignment: Alignment.center,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[

          /// DISCOUNT PERCENTAGE
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
            height: _height,
            alignment: Alignment.center,
            child: Container(
              width: 1,
              height: _height * 0.6,
              color: Colorz.white125,
            ),
          ),

          /// PRICES
          Container(
            width: _priceWidth,
            // padding: EdgeInsets.symmetric(horizontal: _height * 0.1),
            alignment: _superCenterAlignment,
            child: Stack(
              alignment: _superCenterAlignment,
              children: <Widget>[

                /// OLD PRICE
                Positioned(
                  top: _height * 0.15,
                  child: Container(
                    width: _priceWidth,
                    padding: _paddings,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
