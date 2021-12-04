import 'package:bldrs/controllers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/numeric.dart';
import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/providers/zone_provider.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/pages_parts/slides_page_parts/footer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PriceTag extends StatelessWidget {
  final double flyerBoxWidth;
  final SuperFlyer superFlyer;

  const PriceTag({
    @required this.flyerBoxWidth,
    @required this.superFlyer,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final double _footerHeight = FlyerFooter.boxHeight(context: context, flyerBoxWidth: flyerBoxWidth);

    final ZoneProvider _zoneProvider =  Provider.of<ZoneProvider>(context, listen: true);
    final CountryModel _currentCountry = _zoneProvider.currentCountry;

    const double _currentPrice = 14999.99;
    final String _currency = _currentCountry.currency;
    const double _oldPrice = 17800;
    final int _discountPercentage = Numeric.discountPercentage(
      oldPrice: _oldPrice,
      currentPrice: _currentPrice,
    );

    final double _flyerSizeFactor = FlyerBox.sizeFactorByWidth(context, flyerBoxWidth);
    final bool _tinyMode = FlyerBox.isTinyMode(context, flyerBoxWidth);

    final double _tinyModePriceSizeMultiplier = _tinyMode == true ? 1.4 : 1;

    final double _priceTagWidth = _tinyMode == true ? flyerBoxWidth * 0.7 : flyerBoxWidth * 0.55;
    final double _priceTagHeight = _tinyMode == true ? flyerBoxWidth * 0.3 : flyerBoxWidth * 0.2;

    return Container(
      width: flyerBoxWidth,
      height: FlyerBox.height(context, flyerBoxWidth),
      alignment: Aligners.superBottomAlignment(context),
      child: Container(
        width: _priceTagWidth,
        height: _priceTagHeight,
        padding: const EdgeInsets.all(5),
        margin: EdgeInsets.only(bottom: _footerHeight),
        decoration: BoxDecoration(
          color: Colorz.white125,
          borderRadius: Borderers.superPriceTagCorners(context, flyerBoxWidth),
          boxShadow: Shadowz.appBarShadow,
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[

              Container(
                alignment: Aligners.superCenterAlignment(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[

                    /// CURRENT PRICING
                    SuperVerse.priceVerse(
                      context: context,
                      price: _currentPrice,
                      currency: _currency,
                      scaleFactor: _flyerSizeFactor * _tinyModePriceSizeMultiplier,
                      color: Colorz.black255
                    ),

                    /// OLD PRICING
                    if(_tinyMode == false)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[

                        SuperVerse.priceVerse(
                          context: context,
                          price: _oldPrice,
                          currency: _currency,
                          scaleFactor: _flyerSizeFactor * 0.4,
                          strikethrough: true,
                          color: Colorz.black125,
                        ),

                        SizedBox(
                          width: _flyerSizeFactor * 10,
                        ),


                        SuperVerse(
                          verse: '$_discountPercentage% OFF',
                          color: Colorz.green255,
                          weight: VerseWeight.black,
                          italic: true,
                          size: 2,
                          scaleFactor: _flyerSizeFactor,
                        ),


                      ],
                    ),


                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

}
