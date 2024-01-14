import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/models/flag_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/collapsed_info_button_parts/collapsed_info_button_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/info_button_type.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/space/scale.dart';

class InstallmentsPriceTag extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InstallmentsPriceTag({
    required this.flyerBoxWidth,
    required this.tinyMode,
    required this.width,
    required this.height,
    required this.paddingValue,
    required this.buttonIsExpanded,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final bool tinyMode;
  final double width;
  final double height;
  final double paddingValue;
  final ValueNotifier<bool?> buttonIsExpanded;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final ZoneModel? _currentZone = ZoneProvider.proGetCurrentZone(context: context, listen: true);
    final CountryModel? _currentCountry = _currentZone?.countryModel;
    const double _currentPrice = 100000000;
    final String? _currencyID = Flag.getCountryCurrencyID(_currentCountry?.id);
    // --------------------
    final double _flyerSizeFactor = FlyerDim.flyerFactorByFlyerWidth(
      flyerBoxWidth: flyerBoxWidth,
      gridWidth: Scale.screenWidth(context),
    );
    // --------------------
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
              builder: (_, bool? _buttonIsExpanded, Widget? child){

                final bool _expanded = Mapper.boolIsTrue(_buttonIsExpanded);
                // ---------------------------------------------------
                final double _position =
                tinyMode ? height * 0.1
                    :
                 _expanded ? 0.1
                    :
                height * 0.1;
                // ---------------------------------------------------
                final double _priceScaleFactor =
                tinyMode ? _flyerSizeFactor * 1.1
                    :
                _expanded ? _flyerSizeFactor * 0.6
                    :
                _flyerSizeFactor * 0.6;
                // ---------------------------------------------------
                final double _installmentScaleFactor =
                tinyMode ? _flyerSizeFactor * 0.8
                    :
                _expanded ? _flyerSizeFactor * 0.4
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
                        alignment: BldrsAligners.superCenterAlignment(context),
                        padding: _paddings,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: BldrsText.versePrice(
                            context: context,
                            currency: _currencyID,
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
                        alignment: BldrsAligners.superCenterAlignment(context),
                        padding: _paddings,
                        child: BldrsText(
                          verse: const Verse(
                            id: '##/ 400 Months',
                            translate: false,
                          ),
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
    // --------------------
  }
/// --------------------------------------------------------------------------
}
