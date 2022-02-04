import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/info_button.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InstallmentsPriceTag extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InstallmentsPriceTag({
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
    const double _currentPrice = 100000000;
    final String _currency = _currentCountry?.currency;
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
    final double _paddingsValue = _height * 0.25;
    final EdgeInsets _paddings = EdgeInsets.symmetric(horizontal: _paddingsValue);
// ------------------------------------------------------------------
    return Container(
      key: const ValueKey<String>('normal_price_tag'),
      width: _width,
      height: _height,
      alignment: Alignment.center,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[

          Container(
            width: _width,
            height: _height,
            alignment: Alignment.center,
            // padding: _paddings,
            child: Stack(
              children: <Widget>[

                Positioned(
                  top: _height * 0.1,
                  child: Container(
                    width:  _width,
                    height: _height * 0.5,
                    alignment: superCenterAlignment(context),
                    padding: _paddings,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: SuperVerse.priceVerse(
                        context: context,
                        currency: _currency,
                        price: _currentPrice,
                        scaleFactor: _flyerSizeFactor * 0.6,
                        color: Colorz.yellow255,
                        isCentered: true,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  bottom: _height * 0.1,
                  child: Container(
                    width:  _width,
                    height: _height * 0.5,
                    alignment: superCenterAlignment(context),
                    padding: _paddings,
                    child: SuperVerse(
                      verse: '/ 40 Months',
                      size: 6,
                      scaleFactor: _flyerSizeFactor * 0.4,
                    ),
                  ),
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}
