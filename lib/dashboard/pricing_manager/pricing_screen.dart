import 'package:bldrs/controllers/drafters/numberers.dart';
import 'package:bldrs/controllers/localization/localizer.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/flagz.dart';
import 'package:bldrs/controllers/theme/pricing.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/layouts/dashboard_layout.dart';
import 'package:flutter/material.dart';

class PricingScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    List<BigMac> _macs = BigMac.bigMacs();

    _macs.sort(
            (macA,macB) =>
                BigMac.localPriceToDollar(localPrice: macB.localPrice, toDollarRate: macB.toDollarRate)
                    .compareTo(
                    BigMac.localPriceToDollar(localPrice: macA.localPrice, toDollarRate: macA.toDollarRate)
                )
    );

    // CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: false);

    return DashBoardLayout(
        loading: false,
        pageTitle: 'Prices',
        listWidgets: <Widget>[

          ...List.generate(
              _macs.length,
                  (index){

                BigMac _mac = _macs[index];
                String _iso3 = _mac.iso3;
                String _currency = _macs[index].currency;
                double _toDollarRate = Numberers.roundFractions(_mac.toDollarRate, 2);
                double _localPrice = Numberers.roundFractions(_mac.localPrice, 2);

                String _flag = Flagz.getFlagByIso3(_iso3);
                String _countryName = '${index + 1} - ${Localizer.translate(context, _iso3)}';
                String _countryCurrency = '1 \$ = $_toDollarRate $_currency';
                String _localBigMacPrice = 'BigMac = $_localPrice $_currency';
                double _roundedMacPriceUSD = Numberers.roundFractions(BigMac.getBigMacDollarPriceByISO3(_iso3), 2);
                String _localMacPriceInUSD = '= ${_roundedMacPriceUSD} \$ * ${Numberers.roundFractions(BigMac.bigMacsCountToBuyProAccount(), 2)} macs';

                double _proAccountPriceInLocalCurrency = BigMac.proAccountPriceInLocalCurrencyByISO3(_iso3);
                double _proPriceRounded = Numberers.roundFractions(_proAccountPriceInLocalCurrency, 2);
                String _proPrice = '$_proPriceRounded $_currency';
                double _proPriceDollar = BigMac.localPriceToDollar(localPrice: _proAccountPriceInLocalCurrency, toDollarRate: _toDollarRate);
                double _proPriceDollarRounded = Numberers.roundFractions(_proPriceDollar, 2);
                String _proPrice$ = '$_proPriceDollarRounded \$';

                return
                  Container(
                    width: 100,
                    height: 50,
                    child: Row(
                      children: <Widget>[

                        /// COUNTRY
                        DreamBox(
                          height: 40,
                          width: 140,
                          icon: _flag,
                          margins: EdgeInsets.all(Ratioz.appBarPadding),
                          verse: _countryName,
                          verseScaleFactor: 0.5,
                          verseCentered: false,
                          secondLine: _countryCurrency,
                          secondLineScaleFactor: 0.8,
                          verseMaxLines: 1,

                        ),

                        /// BIG MAC
                        DreamBox(
                          height: 40,
                          width: 150,
                          verse: _localBigMacPrice,
                          verseScaleFactor: 0.5,
                          verseCentered: false,
                          secondLine: _localMacPriceInUSD,
                          secondLineScaleFactor: 0.9,
                        ),

                        DreamBox(
                          height: 40,
                          width: 100,
                          color: Colorz.Black255,
                          margins: EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
                          verse: _proPrice,
                          verseScaleFactor: 0.6,
                          secondLine: _proPrice$,
                          secondLineScaleFactor: 0.9,
                          secondLineColor: Colorz.Yellow255,
                        ),

                      ],
                    ),
                  );

                  }
          ),

        ],
    );
  }
}
