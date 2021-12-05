import 'package:bldrs/controllers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/controllers/localization/localizer.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/models/zone/flag_model.dart';
import 'package:bldrs/models/secondary_models/big_mac.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/layouts/dashboard_layout.dart';
import 'package:flutter/material.dart';

class PricingScreen extends StatelessWidget {

  const PricingScreen({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final List<BigMac> _macs = BigMac.bigMacs();

    _macs.sort(
            (BigMac macA, BigMac macB) =>
                BigMac.localPriceToDollar(localPrice: macB.localPrice, toDollarRate: macB.toDollarRate)
                    .compareTo(
                    BigMac.localPriceToDollar(localPrice: macA.localPrice, toDollarRate: macA.toDollarRate)
                )
    );

    // CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: false);

    return DashBoardLayout(
        pageTitle: 'Prices',
        listWidgets: <Widget>[

          ...List<Widget>.generate(
              _macs.length,
                  (int index){

                final BigMac _mac = _macs[index];
                final String _iso3 = _mac.countryID;
                final String _currency = _macs[index].currency;
                final double _toDollarRate = Numeric.roundFractions(_mac.toDollarRate, 2);
                final double _localPrice = Numeric.roundFractions(_mac.localPrice, 2);

                final String _flag = Flag.getFlagIconByCountryID(_iso3);
                final String _countryName = '${index + 1} - ${Localizer.translate(context, _iso3)}';
                final String _countryCurrency = '1 \$ = $_toDollarRate $_currency';
                final String _localBigMacPrice = 'BigMac = $_localPrice $_currency';
                final double _roundedMacPriceUSD = Numeric.roundFractions(BigMac.getBigMacDollarPriceByISO3(_iso3), 2);
                final String _localMacPriceInUSD = '= ${_roundedMacPriceUSD} \$ * ${Numeric.roundFractions(BigMac.bigMacsCountToBuyProAccount(), 2)} macs';

                final double _proAccountPriceInLocalCurrency = BigMac.proAccountPriceInLocalCurrencyByISO3(_iso3);
                final double _proPriceRounded = Numeric.roundFractions(_proAccountPriceInLocalCurrency, 2);
                final String _proPrice = '$_proPriceRounded $_currency';
                final double _proPriceDollar = BigMac.localPriceToDollar(localPrice: _proAccountPriceInLocalCurrency, toDollarRate: _toDollarRate);
                final double _proPriceDollarRounded = Numeric.roundFractions(_proPriceDollar, 2);
                final String _proPrice$ = '$_proPriceDollarRounded \$';

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
                          margins: const EdgeInsets.all(Ratioz.appBarPadding),
                          verse: _countryName,
                          verseScaleFactor: 0.5,
                          verseCentered: false,
                          secondLine: _countryCurrency,
                          secondLineScaleFactor: 0.8,

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
                          color: Colorz.black255,
                          margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
                          verse: _proPrice,
                          verseScaleFactor: 0.6,
                          secondLine: _proPrice$,
                          secondLineScaleFactor: 0.9,
                          secondLineColor: Colorz.yellow255,
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
