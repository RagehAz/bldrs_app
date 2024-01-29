import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/models/flag_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/b_footer/info_button/collapsed_info_button_parts/collapsed_info_button_box.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/b_footer/info_button/info_button_type.dart';
import 'package:bldrs/g_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/space/scale.dart';

class NormalPriceTag extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NormalPriceTag({
    required this.flyerBoxWidth,
    required this.tinyMode,
    required this.width,
    required this.height,
    required this.paddingValue,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final bool tinyMode;
  final double width;
  final double height;
  final double paddingValue;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final ZoneModel? _currentZone = ZoneProvider.proGetCurrentZone(context: context, listen: true);
    final CountryModel? _currentCountry = _currentZone?.countryModel;
    const double _currentPrice = 10000000;
    final String? _currencyID = Flag.getCountryCurrencyID(_currentCountry?.id);
    // --------------------
    final EdgeInsets _paddings = EdgeInsets.symmetric(horizontal: paddingValue);
    final double _flyerSizeFactor = FlyerDim.flyerFactorByFlyerWidth(
      flyerBoxWidth: flyerBoxWidth,
      gridWidth: Scale.screenWidth(context),
    );
    // --------------------
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
              child: BldrsText.versePrice(
                context: context,
                currency: _currencyID,
                price: _currentPrice,
                scaleFactor: tinyMode ? _flyerSizeFactor * 1.3 : _flyerSizeFactor * 0.6,
                color: Colorz.yellow255,
                isCentered: true,
              ),
            ),
          ),

        ],
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
