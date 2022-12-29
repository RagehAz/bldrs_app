import 'package:bldrs/a_models/d_zone/x_money/currency_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/buttons/flagbox_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/page_bubble/page_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/i_chains/z_components/specs/data_creators/xx_currency_button.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';

import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/currency_manager/x_currency_manager_controllers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrencyManagerScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CurrencyManagerScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context) - 10;
    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    final List<CurrencyModel> _currencies = _zoneProvider.allCurrencies;

    final double _clearWidth = PageBubble.clearWidth(context);
    const double _numberZoneWidth = 50;
    final double _currencyButtonWidth = _clearWidth - _numberZoneWidth;

    return MainLayout(
      title: Verse.plain('Currencies'),
      pyramidsAreOn: true,
      skyType: SkyType.black,
      appBarType: AppBarType.basic,
      appBarRowWidgets: <Widget>[

        const Expander(),

        AppBarButton(
          verse: Verse.plain('Backup'),
          onTap: () => onBackupCurrencies(context),
        ),

      ],
      child: PageBubble(
        screenHeightWithoutSafeArea: _screenHeight,
        appBarType: AppBarType.basic,
        color: Colorz.white20,
        child: Scroller(
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _currencies.length,
              padding: const EdgeInsets.only(
                top: Ratioz.appBarMargin,
                bottom: Ratioz.horizon,
              ),
              itemBuilder: (_, index){

                final CurrencyModel _currency = _currencies[index];
                final String _number = Numeric.formatNumberWithinDigits(num: index + 1, digits: 3);

                return Center(
                  child: Container(
                    width: _clearWidth,
                    decoration: BoxDecoration(
                      borderRadius: DreamBox.boxCorners,
                      color: Colorz.white10,
                    ),
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        /// NUMBER
                        SizedBox(
                          width: _numberZoneWidth,
                          child: SuperVerse(
                            verse: Verse.plain(_number),
                            labelColor: Colorz.black125,
                            margin: 5,
                            size: 1,
                          ),
                        ),

                        /// CURRENCY
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            CurrencyButton(
                              width: _currencyButtonWidth,
                              height: 50,
                              countryID: _currency.countriesIDs.last,
                              currency: _currency,
                              onTap: (CurrencyModel currency){
                                currency.blogCurrency();
                              },
                            ),

                            if (_currency.countriesIDs.length > 1)
                              SizedBox(
                                width: _currencyButtonWidth,
                                height: 60,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: _currency.countriesIDs.length,
                                    padding: Scale.constantMarginsAll10,
                                    itemBuilder: (_, index){

                                      final String _countryID = _currency.countriesIDs[index];

                                      return FlagBox(
                                        countryID: _countryID,
                                      );

                                    }
                                ),
                              ),

                          ],

                        ),

                      ],
                    ),
                  ),
                );

              }
          ),
        ),
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
