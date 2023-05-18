import 'package:mapper/mapper.dart';
import 'package:flutter/material.dart';

@immutable
class BigMac {
  /// --------------------------------------------------------------------------
  const BigMac({
    @required this.countryID,
    @required this.localPrice,
    @required this.currency,
    @required this.toDollarRate,
  });
  /// --------------------------------------------------------------------------
  final String countryID;
  final double localPrice;
  final String currency;
  final double toDollarRate;
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TASK : TEST ME
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'countryID': countryID,
      'localPrice': localPrice,
      'currency': currency,
      'toDollarRate': toDollarRate,
    };
  }
  // --------------------
  /// TASK : TEST ME
  static BigMac decipherBigMac(Map<String, dynamic> map) {
    BigMac _bigMac;

    if (map != null) {
      _bigMac = BigMac(
        countryID: map['countryID'],
        localPrice: map['localPrice'],
        currency: map['currency'],
        toDollarRate: map['toDollarRate'],
      );
    }

    return _bigMac;
  }
  // --------------------
  /// TASK : TEST ME
  static List<BigMac> decipherBigMacs(List<Map<String, dynamic>> maps) {
    /// after this should recieve one big map of maps

    final List<BigMac> _bigMacs = <BigMac>[];

    if (Mapper.checkCanLoopList(maps)) {
      for (final Map<String, dynamic> map in maps) {
        _bigMacs.add(decipherBigMac(map));
      }
    }

    return _bigMacs;
  }
  // --------------------
  /// TASK : TEST ME
  static Map<String, dynamic> cipherBigMacs(List<BigMac> bigMacs) {
    Map<String, dynamic> _bigMacsMap = <String, dynamic>{};

    if (Mapper.checkCanLoopList(bigMacs)) {
      for (final BigMac mac in bigMacs) {
        _bigMacsMap = Mapper.insertPairInMap(
          map: _bigMacsMap,
          key: mac.countryID,
          value: mac.toMap(),
          overrideExisting: true,
        );
      }
    }

    return _bigMacsMap;
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TASK : TEST ME
  static List<String> getCountriesIDsFromBigMacs(List<BigMac> bigMacs) {
    final List<String> _countriesIDs = <String>[];

    if (Mapper.checkCanLoopList(bigMacs)) {
      for (final BigMac bigMac in bigMacs) {
        _countriesIDs.add(bigMac.countryID);
      }
    }

    return _countriesIDs;
  }
  // --------------------
  /// TASK : TEST ME
  static double getBigMacDollarPriceByISO3(String iso3) {
    double _bigMacLocalPriceInUSD = 0;

    final BigMac _bigMac = getBigMacByISO3(iso3);

    if (_bigMac == null) {
      /// PLAN : hagilak
    }

    else {
      _bigMacLocalPriceInUSD = localPriceToDollar(
        localPrice: _bigMac.localPrice,
        toDollarRate: _bigMac.toDollarRate,
      );
    }

    return _bigMacLocalPriceInUSD;
  }
  // --------------------
  /// TASK : TEST ME
  static BigMac getBigMacByISO3(String iso3) {
    return bigMacs().singleWhere((BigMac bigMac) => bigMac.countryID == iso3,
        orElse: () => null);
  }
  // --------------------
  /// TASK : TEST ME
  static List<BigMac> getBigMacsOrdered() {
    final List<BigMac> _macs = <BigMac>[];

    // List<String> _orderedISO3s = [];

    // for (var mac in bigMacs()){
    //   _orderedISO3s.sort()
    // }

    bigMacs()
        .sort((BigMac a, BigMac b) => a.localPrice.compareTo(b.localPrice));

    return _macs;
  }
  // --------------------
  /// TASK : TEST ME
  static String getCurrencyByCountryIdFromBigMacs({
    @required String countryID,
    // List<BigMac> bigMacs,
  }) {

    final BigMac _bigMacOfThisCountry = bigMacs().singleWhere(
            (BigMac bigMac) => bigMac.countryID == countryID,
        orElse: () => null);

    final String _currency = _bigMacOfThisCountry?.currency;
    return _currency;
  }
  // -----------------------------------------------------------------------------

  /// OTHERS

  // --------------------
  static const double proAccountPriceEGY = 3000; // 5 peacocks
  // --------------------
  // --------------------
  /// TASK : TEST ME
  static double proAccountPriceInLocalCurrencyByISO3(String iso3) {
    final double _bigMacsCountToBuyProAccount = bigMacsCountToBuyProAccount();

    final BigMac _bigMac = getBigMacByISO3(iso3);

    final double _localBigMacPriceInLocalCurrency = _bigMac.localPrice;

    final double _proAccountPriceInLocalCurrency =
        _localBigMacPriceInLocalCurrency * _bigMacsCountToBuyProAccount;

    return _proAccountPriceInLocalCurrency;
  }
  // --------------------
  /// TASK : TEST ME
  static double bigMacsCountToBuyProAccount() {
    /// how many big macs can 5000 EGP buy
    const double _proAccountPriceEGY = proAccountPriceEGY;
    final double _bigMacPriceEGY = getBigMacByISO3('egy').localPrice;

    final double _count = _proAccountPriceEGY / _bigMacPriceEGY;
    return _count;
  }
  // --------------------
  /// TASK : TEST ME
  static double localPriceToDollar({
    double localPrice,
    double toDollarRate,
  }) {
    final double _priceInDollar = localPrice / toDollarRate;
    return _priceInDollar;
  }
  // --------------------
  /// TASK : TEST ME
  static List<BigMac> bigMacs() {
    final List<BigMac> _bigMacs = <BigMac>[
      const BigMac(
          countryID: 'arg',
          localPrice: 320,
          currency: 'ARS',
          toDollarRate: 85.3736),
      const BigMac(
          countryID: 'aus',
          localPrice: 6.48,
          currency: 'AUD',
          toDollarRate: 1.29996750081248),
      const BigMac(
          countryID: 'aze',
          localPrice: 3.95,
          currency: 'AZN',
          toDollarRate: 1.699),
      const BigMac(
          countryID: 'bhr',
          localPrice: 1.5,
          currency: 'BHD',
          toDollarRate: 0.377),
      const BigMac(
          countryID: 'bra',
          localPrice: 21.9,
          currency: 'BRL',
          toDollarRate: 5.5046),
      const BigMac(
          countryID: 'gbr',
          localPrice: 3.29,
          currency: 'GBP',
          toDollarRate: 0.741372280090447),
      const BigMac(
          countryID: 'can',
          localPrice: 6.77,
          currency: 'CAD',
          toDollarRate: 1.2803),
      const BigMac(
          countryID: 'chl',
          localPrice: 2940,
          currency: 'CLP',
          toDollarRate: 719.425),
      const BigMac(
          countryID: 'chn',
          localPrice: 22.4,
          currency: 'CNY',
          toDollarRate: 6.4751),
      const BigMac(
          countryID: 'col',
          localPrice: 12950,
          currency: 'COP',
          toDollarRate: 3460.5),
      const BigMac(
          countryID: 'cri',
          localPrice: 2350,
          currency: 'CRC',
          toDollarRate: 613.77),
      const BigMac(
          countryID: 'hrv',
          localPrice: 23,
          currency: 'HRK',
          toDollarRate: 6.23875),
      const BigMac(
          countryID: 'cze',
          localPrice: 89,
          currency: 'CZK',
          toDollarRate: 21.5909),
      const BigMac(
          countryID: 'dnk',
          localPrice: 30,
          currency: 'DKK',
          toDollarRate: 6.12065),
      const BigMac(
          countryID: 'egy',
          localPrice: 52.5,
          currency: 'EGP',
          toDollarRate: 22),
      const BigMac(
          countryID: 'euz',
          localPrice: 4.25,
          currency: 'EUR',
          toDollarRate: 0.823011398707872),
      const BigMac(
          countryID: 'gtm',
          localPrice: 25,
          currency: 'GTQ',
          toDollarRate: 7.8009),
      const BigMac(
          countryID: 'hnd',
          localPrice: 87,
          currency: 'HNL',
          toDollarRate: 24.103),
      const BigMac(
          countryID: 'hkg',
          localPrice: 20.5,
          currency: 'HKD',
          toDollarRate: 7.75535),
      const BigMac(
          countryID: 'hun',
          localPrice: 900,
          currency: 'HUF',
          toDollarRate: 297.42395),
      const BigMac(
          countryID: 'ind',
          localPrice: 190,
          currency: 'INR',
          toDollarRate: 73.39),
      const BigMac(
          countryID: 'idn',
          localPrice: 34000,
          currency: 'IDR',
          toDollarRate: 14125),
      const BigMac(
          countryID: 'isr',
          localPrice: 17,
          currency: 'ILS',
          toDollarRate: 3.179),
      const BigMac(
          countryID: 'jpn',
          localPrice: 390,
          currency: 'JPY',
          toDollarRate: 104.295),
      const BigMac(
          countryID: 'jor',
          localPrice: 2.3,
          currency: 'JOD',
          toDollarRate: 0.709),
      const BigMac(
          countryID: 'kwt',
          localPrice: 1.15,
          currency: 'KWD',
          toDollarRate: 0.3037),
      const BigMac(
          countryID: 'lbn',
          localPrice: 15500,
          currency: 'LBP',
          toDollarRate: 8750),
      const BigMac(
          countryID: 'mys',
          localPrice: 9.99,
          currency: 'MYR',
          toDollarRate: 4.052),
      const BigMac(
          countryID: 'mex',
          localPrice: 54,
          currency: 'MXN',
          toDollarRate: 20.11475),
      const BigMac(
          countryID: 'mda',
          localPrice: 50,
          currency: 'MDL',
          toDollarRate: 17.225),
      const BigMac(
          countryID: 'nzl',
          localPrice: 6.8,
          currency: 'NZD',
          toDollarRate: 1.39508928571429),
      const BigMac(
          countryID: 'nic',
          localPrice: 124,
          currency: 'NIO',
          toDollarRate: 34.8453),
      const BigMac(
          countryID: 'nor',
          localPrice: 52,
          currency: 'NOK',
          toDollarRate: 8.5439),
      const BigMac(
          countryID: 'omn',
          localPrice: 1.1,
          currency: 'OMR',
          toDollarRate: 0.385),
      const BigMac(
          countryID: 'pak',
          localPrice: 550,
          currency: 'PKR',
          toDollarRate: 160.35),
      const BigMac(
          countryID: 'per',
          localPrice: 11.9,
          currency: 'PEN',
          toDollarRate: 3.6207),
      const BigMac(
          countryID: 'phl',
          localPrice: 142,
          currency: 'PHP',
          toDollarRate: 48.0925),
      const BigMac(
          countryID: 'pol',
          localPrice: 13.08,
          currency: 'PLN',
          toDollarRate: 3.7226),
      const BigMac(
          countryID: 'qat',
          localPrice: 13,
          currency: 'QAR',
          toDollarRate: 3.641),
      const BigMac(
          countryID: 'rou',
          localPrice: 9.9,
          currency: 'RON',
          toDollarRate: 4.0089),
      const BigMac(
          countryID: 'rus',
          localPrice: 135,
          currency: 'RUB',
          toDollarRate: 74.63),
      const BigMac(
          countryID: 'sau',
          localPrice: 14,
          currency: 'SAR',
          toDollarRate: 3.7518),
      const BigMac(
          countryID: 'sgp',
          localPrice: 5.9,
          currency: 'SGD',
          toDollarRate: 1.3308),
      const BigMac(
          countryID: 'zaf',
          localPrice: 33.5,
          currency: 'ZAR',
          toDollarRate: 15.5225),
      const BigMac(
          countryID: 'kor',
          localPrice: 4500,
          currency: 'KRW',
          toDollarRate: 1097.35),
      const BigMac(
          countryID: 'lka',
          localPrice: 700,
          currency: 'LKR',
          toDollarRate: 189),
      const BigMac(
          countryID: 'swe',
          localPrice: 52.88,
          currency: 'SEK',
          toDollarRate: 8.29525),
      const BigMac(
          countryID: 'che',
          localPrice: 6.5,
          currency: 'CHF',
          toDollarRate: 0.89155),
      const BigMac(
          countryID: 'twn',
          localPrice: 72,
          currency: 'TWD',
          toDollarRate: 27.98),
      const BigMac(
          countryID: 'tha',
          localPrice: 128,
          currency: 'THB',
          toDollarRate: 30.13),
      const BigMac(
          countryID: 'tur',
          localPrice: 14.99,
          currency: 'TRY',
          toDollarRate: 7.4705),
      const BigMac(
          countryID: 'ukr',
          localPrice: 62,
          currency: 'UAH',
          toDollarRate: 28.14),
      const BigMac(
          countryID: 'are',
          localPrice: 14.75,
          currency: 'AED',
          toDollarRate: 3.67315),
      const BigMac(
          countryID: 'usa', localPrice: 5.66, currency: 'USD', toDollarRate: 1),
      const BigMac(
          countryID: 'ury',
          localPrice: 204,
          currency: 'UYU',
          toDollarRate: 42.495),
      const BigMac(
          countryID: 'vnm',
          localPrice: 66000,
          currency: 'VND',
          toDollarRate: 23064),
    ];

    return _bigMacs;
  }
  // --------------------
  /// TASK : TEST ME
  static List<String> euroCountries() {
    return <String>[
      'Germany',
      'Italy',
      'France',
      'Spain',
      'Portugal',
      'Greece',
      'Netherlands',
      'Belgium',
      'Austria',
      'Ireland',
      'Lithuania',
      'Finland',
      'Cyprus',
      'Slovenia',
      'Slovakia',
      'Latvia',
      'Estonia',
      'Malta',
      'Montenegro',
      'Kosovo',
      'Monaco',
      'Luxembourg',
      'Andorra',
      'San Marino',
      'Vatican City',
      'Martinique',

      /// FRENCH DEPT
      'Réunion',

      /// FRENCH DEPT
      'Guadeloupe',

      /// FRENCH DEPT
      'Mayotte',

      /// FRENCH DEPT
      'Saint Pierre and Miquelon',

      /// FRENCH DEPT
      'Saint Martin',

      /// FRENCH DEPT
      'Saint Barthélemy',
      'Åland Islands',
    ];
  }
  // -----------------------------------------------------------------------------
}
