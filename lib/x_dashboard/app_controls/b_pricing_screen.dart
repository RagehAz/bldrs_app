import 'package:bldrs/a_models/d_zone/b_country/flag.dart';
import 'package:bldrs/a_models/d_zone/x_money/big_mac.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';

import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/zz_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class PricingScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PricingScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final List<BigMac> _macs = BigMac.bigMacs();
    _macs.sort((BigMac macA, BigMac macB) => BigMac.localPriceToDollar(
        localPrice: macB.localPrice, toDollarRate: macB.toDollarRate)
        .compareTo(BigMac.localPriceToDollar(
        localPrice: macA.localPrice, toDollarRate: macA.toDollarRate)));

    // CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: false);

    return DashBoardLayout(
      pageTitle: 'Prices',
      listWidgets: <Widget>[
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _macs.length,
            shrinkWrap: true,
            // padding: EdgeInsets.zero, /// AGAIN => ENTA EBN WES5A
            itemBuilder: (_, index) {
              final BigMac _mac = _macs[index];
              final String _iso3 = _mac.countryID;
              final String _currency = _macs[index].currency;
              final double _toDollarRate = Numeric.roundFractions(_mac.toDollarRate, 2);
              final double _localPrice = Numeric.roundFractions(_mac.localPrice, 2);

              final String _flag = Flag.getCountryIcon(_iso3);
              final String _countryName = '${index + 1} - ${Localizer.translate(context, _iso3)}';
              final String _countryCurrency = '1 \$ = $_toDollarRate $_currency';
              final String _localBigMacPrice = 'BigMac = $_localPrice $_currency';
              final double _roundedMacPriceUSD = Numeric.roundFractions(BigMac.getBigMacDollarPriceByISO3(_iso3), 2);
              final String _localMacPriceInUSD = '= $_roundedMacPriceUSD \$ * ${Numeric.roundFractions(BigMac.bigMacsCountToBuyProAccount(), 2)} macs';

              final double _proAccountPriceInLocalCurrency = BigMac.proAccountPriceInLocalCurrencyByISO3(_iso3);
              final double _proPriceRounded = Numeric.roundFractions(_proAccountPriceInLocalCurrency, 2);
              final String _proPrice = '$_proPriceRounded $_currency';
              final double _proPriceDollar = BigMac.localPriceToDollar(
                localPrice: _proAccountPriceInLocalCurrency,
                toDollarRate: _toDollarRate,
              );

              final double _proPriceDollarRounded = Numeric.roundFractions(_proPriceDollar, 2);
              final String _proPrice$ = '$_proPriceDollarRounded \$';

              return SizedBox(
                width: 100,
                height: 50,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    /// COUNTRY
                    DreamBox(
                      height: 40,
                      width: 140,
                      icon: _flag,
                      margins: const EdgeInsets.all(Ratioz.appBarPadding),
                      verse: Verse.plain(_countryName),
                      verseScaleFactor: 0.5,
                      verseCentered: false,
                      secondLine: Verse.plain(_countryCurrency),
                      secondLineScaleFactor: 0.8,
                    ),

                    /// BIG MAC
                    DreamBox(
                      height: 40,
                      width: 150,
                      verse: Verse.plain(_localBigMacPrice),
                      verseScaleFactor: 0.5,
                      verseCentered: false,
                      secondLine: Verse.plain(_localMacPriceInUSD),
                      secondLineScaleFactor: 0.9,
                    ),

                    DreamBox(
                      height: 40,
                      width: 100,
                      color: Colorz.black255,
                      margins: const EdgeInsets.symmetric(
                          horizontal: Ratioz.appBarPadding),
                      verse: Verse.plain(_proPrice),
                      verseScaleFactor: 0.6,
                      secondLine: Verse.plain(_proPrice$),
                      secondLineScaleFactor: 0.9,
                      secondLineColor: Colorz.yellow255,
                    ),
                  ],
                ),
              );
            }),

        // ...List<Widget>.generate(
        //     _macs.length,
        //         (int index){
        //
        //       final BigMac _mac = _macs[index];
        //       final String _iso3 = _mac.countryID;
        //       final String _currency = _macs[index].currency;
        //       final double _toDollarRate = Numeric.roundFractions(_mac.toDollarRate, 2);
        //       final double _localPrice = Numeric.roundFractions(_mac.localPrice, 2);
        //
        //       final String _flag = Flag.getFlagIconByCountryID(_iso3);
        //       final String _countryName = '${index + 1} - ${Localizer.translate(context, _iso3)}';
        //       final String _countryCurrency = '1 \$ = $_toDollarRate $_currency';
        //       final String _localBigMacPrice = 'BigMac = $_localPrice $_currency';
        //       final double _roundedMacPriceUSD = Numeric.roundFractions(BigMac.getBigMacDollarPriceByISO3(_iso3), 2);
        //       final String _localMacPriceInUSD = '= $_roundedMacPriceUSD \$ * ${Numeric.roundFractions(BigMac.bigMacsCountToBuyProAccount(), 2)} macs';
        //
        //       final double _proAccountPriceInLocalCurrency = BigMac.proAccountPriceInLocalCurrencyByISO3(_iso3);
        //       final double _proPriceRounded = Numeric.roundFractions(_proAccountPriceInLocalCurrency, 2);
        //       final String _proPrice = '$_proPriceRounded $_currency';
        //       final double _proPriceDollar = BigMac.localPriceToDollar(localPrice: _proAccountPriceInLocalCurrency, toDollarRate: _toDollarRate);
        //       final double _proPriceDollarRounded = Numeric.roundFractions(_proPriceDollar, 2);
        //       final String _proPrice$ = '$_proPriceDollarRounded \$';
        //
        //       return
        //         SizedBox(
        //           width: 100,
        //           height: 50,
        //           child: Row(
        //             children: <Widget>[
        //
        //               /// COUNTRY
        //               DreamBox(
        //                 height: 40,
        //                 width: 140,
        //                 icon: _flag,
        //                 margins: const EdgeInsets.all(Ratioz.appBarPadding),
        //                 verse: _countryName,
        //                 verseScaleFactor: 0.5,
        //                 verseCentered: false,
        //                 secondLine: _countryCurrency,
        //                 secondLineScaleFactor: 0.8,
        //
        //               ),
        //
        //               /// BIG MAC
        //               DreamBox(
        //                 height: 40,
        //                 width: 150,
        //                 verse: _localBigMacPrice,
        //                 verseScaleFactor: 0.5,
        //                 verseCentered: false,
        //                 secondLine: _localMacPriceInUSD,
        //                 secondLineScaleFactor: 0.9,
        //               ),
        //
        //               DreamBox(
        //                 height: 40,
        //                 width: 100,
        //                 color: Colorz.black255,
        //                 margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
        //                 verse: _proPrice,
        //                 verseScaleFactor: 0.6,
        //                 secondLine: _proPrice$,
        //                 secondLineScaleFactor: 0.9,
        //                 secondLineColor: Colorz.yellow255,
        //               ),
        //
        //             ],
        //           ),
        //         );
        //
        //         }
        // ),
      ],
    );

  }
  /// --------------------------------------------------------------------------
}
