import 'package:flutter/material.dart';

class BigMac{
  final String iso3;
  final double localPrice;
  final String currency;
  final double toDollarRate;

  const BigMac({
    @required this.iso3,
    @required this.localPrice,
    @required this.currency,
    @required this.toDollarRate,
});
// -----------------------------------------------------------------------------
  static const double proAccountPriceEGY = 3000.00; // 5 peacocks
// -----------------------------------------------------------------------------
  static double proAccountPriceInLocalCurrencyByISO3(String iso3){
    final double _bigMacsCountToBuyProAccount = bigMacsCountToBuyProAccount();

    final BigMac _bigMac = getBigMacByISO3(iso3);

    final double _localBigMacPriceInLocalCurrency = _bigMac.localPrice;

    final double _proAccountPriceInLocalCurrency = _localBigMacPriceInLocalCurrency * _bigMacsCountToBuyProAccount;

    return _proAccountPriceInLocalCurrency;
  }
// -----------------------------------------------------------------------------
  /// how many big macs can 5000 EGP buy
  static double bigMacsCountToBuyProAccount(){
    final double _proAccountPriceEGY = proAccountPriceEGY;
    final double _bigMacPriceEGY = getBigMacByISO3('egy').localPrice;

    final double _count = _proAccountPriceEGY / _bigMacPriceEGY;
    return _count;
  }
// -----------------------------------------------------------------------------
  static double getBigMacDollarPriceByISO3(String iso3){
    double _bigMacLocalPriceInUSD = 0;

    final BigMac _bigMac = getBigMacByISO3(iso3);

    if (_bigMac == null){
      /// TASK : hagilak
    }

    else {

      _bigMacLocalPriceInUSD = localPriceToDollar(
        localPrice: _bigMac.localPrice,
        toDollarRate: _bigMac.toDollarRate,
      );

    }

    return _bigMacLocalPriceInUSD;
  }
// -----------------------------------------------------------------------------
  static double localPriceToDollar({double localPrice, double toDollarRate}){
    final double _priceInDollar = localPrice / toDollarRate;
    return _priceInDollar;
  }
// -----------------------------------------------------------------------------
  static BigMac getBigMacByISO3(String iso3){
    return bigMacs().singleWhere((bigMac) => bigMac.iso3 == iso3, orElse: ()=> null);
  }
// -----------------------------------------------------------------------------
  static List<BigMac> getBigMacsOrdered(){
    List<BigMac> _macs = <BigMac>[];

    // List<String> _orderedISO3s = [];

    // for (var mac in bigMacs()){
    //   _orderedISO3s.sort()
    // }

    bigMacs().sort((a,b) => a.localPrice.compareTo(b.localPrice));

    return _macs;
  }
// -----------------------------------------------------------------------------
  static List<BigMac> bigMacs(){
    List<BigMac> _bigMacs = <BigMac>[
      const BigMac(iso3: 'arg', localPrice: 320, currency: 'ARS', toDollarRate: 85.3736),
      const BigMac(iso3: 'aus', localPrice: 6.48, currency: 'AUD', toDollarRate: 1.29996750081248),
      const BigMac(iso3: 'aze', localPrice: 3.95, currency: 'AZN', toDollarRate: 1.699),
      const BigMac(iso3: 'bhr', localPrice: 1.5, currency: 'BHD', toDollarRate: 0.377),
      const BigMac(iso3: 'bra', localPrice: 21.9, currency: 'BRL', toDollarRate: 5.5046),
      const BigMac(iso3: 'gbr', localPrice: 3.29, currency: 'GBP', toDollarRate: 0.741372280090447),
      const BigMac(iso3: 'can', localPrice: 6.77, currency: 'CAD', toDollarRate: 1.2803),
      const BigMac(iso3: 'chl', localPrice: 2940, currency: 'CLP', toDollarRate: 719.425),
      const BigMac(iso3: 'chn', localPrice: 22.4, currency: 'CNY', toDollarRate: 6.4751),
      const BigMac(iso3: 'col', localPrice: 12950, currency: 'COP', toDollarRate: 3460.5),
      const BigMac(iso3: 'cri', localPrice: 2350, currency: 'CRC', toDollarRate: 613.77),
      const BigMac(iso3: 'hrv', localPrice: 23, currency: 'HRK', toDollarRate: 6.23875),
      const BigMac(iso3: 'cze', localPrice: 89, currency: 'CZK', toDollarRate: 21.5909),
      const BigMac(iso3: 'dnk', localPrice: 30, currency: 'DKK', toDollarRate: 6.12065),
      const BigMac(iso3: 'egy', localPrice: 42.5, currency: 'EGP', toDollarRate: 15.64),
      const BigMac(iso3: 'euz', localPrice: 4.25, currency: 'EUR', toDollarRate: 0.823011398707872),
      const BigMac(iso3: 'gtm', localPrice: 25, currency: 'GTQ', toDollarRate: 7.8009),
      const BigMac(iso3: 'hnd', localPrice: 87, currency: 'HNL', toDollarRate: 24.103),
      const BigMac(iso3: 'hkg', localPrice: 20.5, currency: 'HKD', toDollarRate: 7.75535),
      const BigMac(iso3: 'hun', localPrice: 900, currency: 'HUF', toDollarRate: 297.42395),
      const BigMac(iso3: 'ind', localPrice: 190, currency: 'INR', toDollarRate: 73.39),
      const BigMac(iso3: 'idn', localPrice: 34000, currency: 'IDR', toDollarRate: 14125),
      const BigMac(iso3: 'isr', localPrice: 17, currency: 'ILS', toDollarRate: 3.179),
      const BigMac(iso3: 'jpn', localPrice: 390, currency: 'JPY', toDollarRate: 104.295),
      const BigMac(iso3: 'jor', localPrice: 2.3, currency: 'JOD', toDollarRate: 0.709),
      const BigMac(iso3: 'kwt', localPrice: 1.15, currency: 'KWD', toDollarRate: 0.3037),
      const BigMac(iso3: 'lbn', localPrice: 15500, currency: 'LBP', toDollarRate: 8750),
      const BigMac(iso3: 'mys', localPrice: 9.99, currency: 'MYR', toDollarRate: 4.052),
      const BigMac(iso3: 'mex', localPrice: 54, currency: 'MXN', toDollarRate: 20.11475),
      const BigMac(iso3: 'mda', localPrice: 50, currency: 'MDL', toDollarRate: 17.225),
      const BigMac(iso3: 'nzl', localPrice: 6.8, currency: 'NZD', toDollarRate: 1.39508928571429),
      const BigMac(iso3: 'nic', localPrice: 124, currency: 'NIO', toDollarRate: 34.8453),
      const BigMac(iso3: 'nor', localPrice: 52, currency: 'NOK', toDollarRate: 8.5439),
      const BigMac(iso3: 'omn', localPrice: 1.1, currency: 'OMR', toDollarRate: 0.385),
      const BigMac(iso3: 'pak', localPrice: 550, currency: 'PKR', toDollarRate: 160.35),
      const BigMac(iso3: 'per', localPrice: 11.9, currency: 'PEN', toDollarRate: 3.6207),
      const BigMac(iso3: 'phl', localPrice: 142, currency: 'PHP', toDollarRate: 48.0925),
      const BigMac(iso3: 'pol', localPrice: 13.08, currency: 'PLN', toDollarRate: 3.7226),
      const BigMac(iso3: 'qat', localPrice: 13, currency: 'QAR', toDollarRate: 3.641),
      const BigMac(iso3: 'rou', localPrice: 9.9, currency: 'RON', toDollarRate: 4.0089),
      const BigMac(iso3: 'rus', localPrice: 135, currency: 'RUB', toDollarRate: 74.63),
      const BigMac(iso3: 'sau', localPrice: 14, currency: 'SAR', toDollarRate: 3.7518),
      const BigMac(iso3: 'sgp', localPrice: 5.9, currency: 'SGD', toDollarRate: 1.3308),
      const BigMac(iso3: 'zaf', localPrice: 33.5, currency: 'ZAR', toDollarRate: 15.5225),
      const BigMac(iso3: 'kor', localPrice: 4500, currency: 'KRW', toDollarRate: 1097.35),
      const BigMac(iso3: 'lka', localPrice: 700, currency: 'LKR', toDollarRate: 189),
      const BigMac(iso3: 'swe', localPrice: 52.88, currency: 'SEK', toDollarRate: 8.29525),
      const BigMac(iso3: 'che', localPrice: 6.5, currency: 'CHF', toDollarRate: 0.89155),
      const BigMac(iso3: 'twn', localPrice: 72, currency: 'TWD', toDollarRate: 27.98),
      const BigMac(iso3: 'tha', localPrice: 128, currency: 'THB', toDollarRate: 30.13),
      const BigMac(iso3: 'tur', localPrice: 14.99, currency: 'TRY', toDollarRate: 7.4705),
      const BigMac(iso3: 'ukr', localPrice: 62, currency: 'UAH', toDollarRate: 28.14),
      const BigMac(iso3: 'are', localPrice: 14.75, currency: 'AED', toDollarRate: 3.67315),
      const BigMac(iso3: 'usa', localPrice: 5.66, currency: 'USD', toDollarRate: 1),
      const BigMac(iso3: 'ury', localPrice: 204, currency: 'UYU', toDollarRate: 42.495),
      const BigMac(iso3: 'vnm', localPrice: 66000, currency: 'VND', toDollarRate: 23064),
    ];

    return _bigMacs;
  }
// -----------------------------------------------------------------------------
  static String getCurrencyByIso3(String iso3){
    final BigMac _bigMacOfThisCountry = bigMacs().singleWhere((bigMac) => bigMac.iso3 == iso3, orElse: ()=> null);
    final String _currency = _bigMacOfThisCountry?.currency;
    return _currency;
  }
// -----------------------------------------------------------------------------
}