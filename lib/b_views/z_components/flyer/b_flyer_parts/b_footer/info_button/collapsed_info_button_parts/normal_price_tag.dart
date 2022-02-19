import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/collapsed_info_button_parts/collapsed_info_button_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/info_button_type.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NormalPriceTag extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NormalPriceTag({
    @required this.flyerBoxWidth,
    @required this.tinyMode,
    @required this.width,
    @required this.height,
    @required this.paddingValue,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final bool tinyMode;
  final double width;
  final double height;
  final double paddingValue;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// ------------------------------------------------------------------
    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: true);
    final CountryModel _currentCountry = _zoneProvider.currentCountry;
    const double _currentPrice = 10000000;
    final String _currency = _currentCountry?.currency;
// ------------------------------------------------------------------
    final EdgeInsets _paddings = EdgeInsets.symmetric(horizontal: paddingValue);
    final double _flyerSizeFactor = FlyerBox.sizeFactorByWidth(context, flyerBoxWidth);
// ------------------------------------------------------------------
    return CollapsedInfoButtonBox(
        flyerBoxWidth: flyerBoxWidth,
        infoButtonType: InfoButtonType.price,
        tinyMode: tinyMode,
        horizontalListViewChildren: <Widget>[

          Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            padding: _paddings,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: SuperVerse.priceVerse(
                context: context,
                currency: _currency,
                price: _currentPrice,
                scaleFactor: tinyMode ? _flyerSizeFactor * 1.3 : _flyerSizeFactor * 0.6,
                color: Colorz.yellow255,
                isCentered: true,
              ),
            ),
          ),

        ],
    );
  }
}