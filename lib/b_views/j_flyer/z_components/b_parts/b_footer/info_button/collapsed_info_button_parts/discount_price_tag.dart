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
import 'package:basics/helpers/classes/nums/numeric.dart';
import 'package:basics/helpers/classes/space/scale.dart';

class DiscountPriceTag extends StatelessWidget {
  // --------------------------------------------------------------------------
  const DiscountPriceTag({
    required this.flyerBoxWidth,
    required this.tinyMode,
    required this.width,
    required this.height,
    required this.paddingValue,
    required this.buttonIsExpanded,
    super.key
  });
  // --------------------
  final double flyerBoxWidth;
  final bool tinyMode;
  final double width;
  final double height;
  final double paddingValue;
  final ValueNotifier<bool?> buttonIsExpanded;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final CountryModel? _currentCountry = ZoneProvider.proGetCurrentZone(context: context, listen: true).countryModel;
    // --------------------
    const double _currentPrice = 14019.50;
    final String? _currencyID = Flag.getCountryCurrencyID(_currentCountry?.id);
    const double _oldPrice = 17800;
    final int? _discountPercentage = Numeric.calculateDiscountPercentage(
      oldPrice: _oldPrice,
      currentPrice: _currentPrice,
    );
    // --------------------
    final double _flyerSizeFactor = FlyerDim.flyerFactorByFlyerWidth(
      flyerBoxWidth: flyerBoxWidth,
      gridWidth: Scale.screenWidth(context),
    );
    final EdgeInsets _paddings = EdgeInsets.symmetric(horizontal: paddingValue);
    final Alignment _superCenterAlignment = BldrsAligners.superCenterAlignment(context);
    const double _separatorLineWidth = 1;
    final double _priceWidth = width - height - _separatorLineWidth - paddingValue;
    // --------------------
    return CollapsedInfoButtonBox(
      flyerBoxWidth: flyerBoxWidth,
      infoButtonType: InfoButtonType.discount,
      tinyMode: tinyMode,
      horizontalListViewChildren: <Widget>[

        /// DISCOUNT PERCENTAGE
        ValueListenableBuilder<bool?>(
            valueListenable: buttonIsExpanded,
            builder: (_, bool? _buttonExpanded, Widget? child){

              final double _percentagePosition =
              tinyMode ? height * 0.05
                  :
              Mapper.boolIsTrue(_buttonExpanded) ? height * 0.02
                  :
              height * 0.1;

              return SizedBox(
                width: tinyMode ? height * 1.2 : height,
                height: height,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[

                    /// PERCENTAGE
                    Positioned(
                      top: _percentagePosition,
                      child: Container(
                        width: height,
                        padding: EdgeInsets.symmetric(horizontal: height * 0.05),
                        child: BldrsText(
                          verse:  Verse(
                            id: '$_discountPercentage %',
                            translate: false,
                          ),
                          weight: VerseWeight.black,
                          color: Colorz.red255,
                        ),
                      ),
                    ),

                    /// OFF
                    Positioned(
                      bottom: _percentagePosition,
                      child: const BldrsText(
                        verse: Verse(
                          id: 'phid_off',
                          translate: true,
                          casing: Casing.upperCase,
                        ),
                        weight: VerseWeight.black,
                        scaleFactor: 0.8,
                        color: Colorz.red255,
                      ),
                    ),

                  ],
                ),
              );

            }
        ),



        /// SEPARATOR LINE
        Container(
          width: _separatorLineWidth,
          height: height,
          alignment: Alignment.center,
          child: Container(
            width: _separatorLineWidth,
            height: height * 0.6,
            color: Colorz.white125,
          ),
        ),

        /// PRICES
        ValueListenableBuilder(
            valueListenable: buttonIsExpanded,
            builder: (_, bool? _buttonExpanded, Widget? child){
              // -------------------------------------------
              final double _pricePosition =
              tinyMode ? height * 0.1
                  :
              Mapper.boolIsTrue(_buttonExpanded) ? height * 0.05
                  :
              height * 0.1;
              // -------------------------------------------
              final double _oldPriceSizeFactor =
              tinyMode ? _flyerSizeFactor * 0.7
                  :
              Mapper.boolIsTrue(_buttonExpanded) ? _flyerSizeFactor * 0.35
                  :
              _flyerSizeFactor * 0.35;
              // -------------------------------------------
              final double _currentPriceSizeFactor =
              tinyMode ? _flyerSizeFactor * 1.2
                  :
              Mapper.boolIsTrue(_buttonExpanded) ? _flyerSizeFactor * 0.6
                  :
              _flyerSizeFactor * 0.6;
              // -------------------------------------------
              return Container(
                width: _priceWidth,
                // padding: EdgeInsets.symmetric(horizontal: height * 0.1),
                alignment: _superCenterAlignment,
                child: Stack(
                  alignment: _superCenterAlignment,
                  children: <Widget>[

                    /// OLD PRICE
                    Positioned(
                      top: _pricePosition,
                      child: Container(
                        width: _priceWidth,
                        padding: _paddings,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[

                            /// OLD PRICE
                            BldrsText.versePrice(
                                context: context,
                                // currency: _currency,
                                price: _oldPrice,
                                scaleFactor: _oldPriceSizeFactor,
                                strikethrough: true,
                                color: Colorz.grey255,
                                isBold: false
                            ),

                            /// CURRENCY
                            Padding(
                              padding: _paddings,
                              child: BldrsText(
                                verse: Verse(
                                  id: _currencyID,
                                  translate: true,
                                  casing: Casing.upperCase,
                                ),
                                size: 6,
                                scaleFactor: _oldPriceSizeFactor,
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
                      bottom: _pricePosition,
                      child: Container(
                        width: _priceWidth,
                        height: height * 0.5,
                        alignment: _superCenterAlignment,
                        padding: _paddings,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: BldrsText.versePrice(
                            context: context,
                            // currency: _currency,
                            price: _currentPrice,
                            scaleFactor: _currentPriceSizeFactor,
                            color: Colorz.yellow255,
                          ),
                        ),
                      ),
                    )

                  ],
                ),
              );

            }
        ),

        /// FAKE END PADDING
        SizedBox(
          width: paddingValue,
          height: height,
        ),

      ],
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
