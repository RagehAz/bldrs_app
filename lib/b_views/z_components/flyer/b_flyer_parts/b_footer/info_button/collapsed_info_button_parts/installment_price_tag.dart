import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/collapsed_info_button_parts/collapsed_info_button_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/info_button_type.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InstallmentsPriceTag extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InstallmentsPriceTag({
    @required this.flyerBoxWidth,
    @required this.tinyMode,
    @required this.width,
    @required this.height,
    @required this.paddingValue,
    @required this.buttonIsExpanded,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final bool tinyMode;
  final double width;
  final double height;
  final double paddingValue;
  final ValueNotifier<bool> buttonIsExpanded; /// p
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// ------------------------------------------------------------------
    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: true);
    final CountryModel _currentCountry = _zoneProvider.currentCountry;
    const double _currentPrice = 100000000;
    final String _currency = _currentCountry?.currency;
// ------------------------------------------------------------------
    final double _flyerSizeFactor = FlyerBox.sizeFactorByWidth(context, flyerBoxWidth);
// ------------------------------------------------------------------
    return CollapsedInfoButtonBox(
      flyerBoxWidth: flyerBoxWidth,
      infoButtonType: InfoButtonType.installments,
      tinyMode: tinyMode,
      horizontalListViewChildren: <Widget>[

          Container(
            width:width,
            height: height,
            alignment: Alignment.center,
            // padding: _paddings,
            child: ValueListenableBuilder(
              valueListenable: buttonIsExpanded,
              builder: (_, bool _buttonIsExpanded, Widget child){
                // ---------------------------------------------------
                final double _position =
                tinyMode ? height * 0.1
                    :
                _buttonIsExpanded ? 0.1
                    :
                height * 0.1;
                // ---------------------------------------------------
                final double _priceScaleFactor =
                tinyMode ? _flyerSizeFactor * 1.1
                    :
                _buttonIsExpanded ? _flyerSizeFactor * 0.6
                    :
                _flyerSizeFactor * 0.6;
                // ---------------------------------------------------
                final double _installmentScaleFactor =
                tinyMode ? _flyerSizeFactor * 0.8
                    :
                _buttonIsExpanded ? _flyerSizeFactor * 0.4
                    :
                _flyerSizeFactor * 0.4;
                // ---------------------------------------------------

                final EdgeInsets _paddings = EdgeInsets.symmetric(
                    horizontal: tinyMode ? paddingValue * 2 : paddingValue
                );

                return Stack(
                  children: <Widget>[

                    Positioned(
                      top: _position,
                      child: Container(
                        width: width,
                        height: height * 0.5,
                        alignment: Aligners.superCenterAlignment(context),
                        padding: _paddings,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: SuperVerse.priceVerse(
                            context: context,
                            currency: _currency,
                            price: _currentPrice,
                            scaleFactor: _priceScaleFactor,
                            color: Colorz.yellow255,
                            isCentered: true,
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: _position,
                      child: Container(
                        width: width,
                        height: height * 0.5,
                        alignment: Aligners.superCenterAlignment(context),
                        padding: _paddings,
                        child: SuperVerse(
                          verse: '/ 40 Months',
                          size: 6,
                          scaleFactor: _installmentScaleFactor,
                        ),
                      ),
                    ),

                  ],
                );

              },
            ),
          ),

        ],
    );
  }
}
