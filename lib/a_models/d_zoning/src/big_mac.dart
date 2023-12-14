part of world_zoning;

@immutable
class BigMac {
  /// --------------------------------------------------------------------------
  const BigMac({
    required this.countryID,
    required this.localPrice,
    required this.currencyID,
    required this.toDollarRate,
  });
  /// --------------------------------------------------------------------------
  final String? countryID;
  final double? localPrice;
  final String? currencyID;
  final double? toDollarRate;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  BigMac copyWith({
    String? countryID,
    double? localPrice,
    String? currencyID,
    double? toDollarRate,
  }){
    return BigMac(
      countryID: countryID ?? this.countryID,
      localPrice: localPrice ?? this.localPrice,
      currencyID: currencyID ?? this.currencyID,
      toDollarRate: toDollarRate ?? this.toDollarRate,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TASK : TEST ME
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'countryID': countryID,
      'localPrice': localPrice,
      'currencyID': currencyID,
      'toDollarRate': toDollarRate,
    };
  }
  // --------------------
  /// TASK : TEST ME
  static BigMac? decipherBigMac(Map<String, dynamic>? map) {
    BigMac? _bigMac;

    if (map != null) {
      _bigMac = BigMac(
        countryID: map['countryID'],
        localPrice: map['localPrice'],
        currencyID: map['currencyID'],
        toDollarRate: map['toDollarRate'],
      );
    }

    return _bigMac;
  }
  // --------------------
  /// TASK : TEST ME
  static List<BigMac> decipherBigMacs(List<Map<String, dynamic>>? maps) {
    /// after this should receive one big map of maps

    final List<BigMac> _bigMacs = <BigMac>[];

    if (Lister.checkCanLoop(maps) == true) {
      for (final Map<String, dynamic> map in maps!) {

        final BigMac? _mac = decipherBigMac(map);

        if (_mac != null){
          _bigMacs.add(_mac);
        }

      }
    }

    return _bigMacs;
  }
  // --------------------
  /// TASK : TEST ME
  static Map<String, dynamic> cipherBigMacs(List<BigMac>? bigMacs) {
    Map<String, dynamic> _bigMacsMap = <String, dynamic>{};

    if (Lister.checkCanLoop(bigMacs) == true) {
      for (final BigMac mac in bigMacs!) {
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
  // --------------------
  /// TASK : TEST ME
  static List<BigMac> updateBigMacsExchangeRates({
    required Map<String, dynamic>? rates,
    required List<BigMac>? bigMacs,
  }){
    List<BigMac> _output = [];

    if (rates == null || Lister.checkCanLoop(bigMacs) == false){
      _output = getBigMacs();
    }
    else {

      /// looks like this
      /// {
      /// 'AED': 3.6725,
      /// ...
      /// }

      for (final BigMac mac in bigMacs!){

        final double? _toDollarRate = rates[mac.currencyID?.toUpperCase()]?.toDouble();

        if (_toDollarRate != null){

          final BigMac _bigMac = mac.copyWith(
            toDollarRate: _toDollarRate,
          );

          _output.add(_bigMac);

        }

      }

    }

    return _output;
  }

  // -----------------------------------------------------------------------------

  /// COUNTRIES IDS GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getCountriesIDsFromBigMacs(List<BigMac>? bigMacs) {
    final List<String> _countriesIDs = <String>[];

    if (Lister.checkCanLoop(bigMacs) == true) {
      for (final BigMac bigMac in bigMacs!) {

        if (bigMac.countryID != null){
          _countriesIDs.add(bigMac.countryID!);
        }

      }
    }

    return _countriesIDs;
  }
  // -----------------------------------------------------------------------------

  /// TO DOLLAR RATE GETTERS

  // --------------------
  /// TASK : TEST ME
  static double getBigMacDollarPriceByISO3({
    required String? iso3,
    required List<BigMac>? bigMacs,
}) {
    double _bigMacLocalPriceInUSD = 0;

    final BigMac? _bigMac = getBigMacByISO3(
      iso3: iso3,
      bigMacs: bigMacs,
    );

    if (_bigMac == null) {
      /// PLAN : will come to you
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

  /// BIG MAC GETTERS

  // --------------------
  /// TASK : TEST ME
  static BigMac? getBigMacByISO3({
    required String? iso3,
    required List<BigMac>? bigMacs,
  }) {

    if (Lister.checkCanLoop(bigMacs) == false || iso3 == null){
      return null;
    }

    else {
    return bigMacs?.firstWhereOrNull((BigMac bigMac) => bigMac.countryID == iso3);
    }

  }
  // --------------------
  /// TASK : TEST ME
  static List<BigMac> getBigMacsByCountriesIDs({
    required List<String>? countriesIDs,
    required List<BigMac>? bigMacs,
  }){
    final List<BigMac> _output = [];

    if (
        Lister.checkCanLoop(countriesIDs) == true
        &&
        Lister.checkCanLoop(bigMacs) == true
    ){

      for (final String countryID in countriesIDs!){

        final BigMac? _mac = getBigMacByISO3(
          iso3: countryID,
          bigMacs: bigMacs,
        );

        if (_mac != null){
          _output.add(_mac);
        }

      }

    }


    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static BigMac? getBigMacByCurrencyID({
    required String? currencyID,
    required List<BigMac>? bigMacs,
  }){
    BigMac? _output;

    if (currencyID != null && Lister.checkCanLoop(bigMacs) == true){

      _output = bigMacs!.singleWhereOrNull(
          (BigMac bigMac) => bigMac.currencyID?.toLowerCase() == currencyID.toLowerCase());
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CURRENCY GETTERS

  // --------------------
  /// TASK : TEST ME
  static String? getCurrencyByCountryIDFromBigMacs({
    required String? countryID,
    required List<BigMac>? bigMacs,
  }) {

    if (Lister.checkCanLoop(bigMacs) == false || countryID == null){
      return null;
    }

    else {
      final BigMac? _bigMacOfThisCountry = bigMacs!.singleWhereOrNull(
              (BigMac bigMac) => bigMac.countryID == countryID
      );

      final String? _currency = _bigMacOfThisCountry?.currencyID;
      return _currency;
    }

  }
  // -----------------------------------------------------------------------------

  /// SORTING

  // --------------------
  /// TASK : TEST ME
  static List<BigMac> sortBigMacsByLocalPrice({
    required List<BigMac> bigMacs,
}) {
    final List<BigMac> _macs = <BigMac>[];

    if (Lister.checkCanLoop(bigMacs) == false){
      bigMacs.sort((BigMac a, BigMac b) => a.localPrice?.compareTo(b.localPrice as num) ?? 0);
      _macs.addAll(bigMacs);
    }


    return _macs;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<BigMac> sortBigMacsByCountryName({
    required List<BigMac>? toSort,
    required List<BigMac>? allMacs,
    required String langCode,
  }){

    if (Lister.checkCanLoop(toSort) == true ) {

      final List<String> _bigMacsCountriesIDs = getCountriesIDsFromBigMacs(toSort);

      final List<String> _countriesIDsSorted = CountryModel.sortCountriesNamesAlphabetically(
        countriesIDs: _bigMacsCountriesIDs,
        langCode: langCode,
      );

      return getBigMacsByCountriesIDs(
        countriesIDs: _countriesIDsSorted,
        bigMacs: allMacs,
      );
    }

    else {
      return [];
    }

  }
  // --------------------
  /// TASK : FIX INDEX BUG
  static List<BigMac> sortByAccountDollarPrice({
    required List<BigMac>? bigMacs,
    required List<BigMac>? allMacs,
    required double accountPrice,
  }){
    final List<BigMac> _output = [];

    if (
    Lister.checkCanLoop(bigMacs) == true
    &&
    Lister.checkCanLoop(allMacs) == true
    ){

      blog('bigMacs length : ${bigMacs?.length} : ${allMacs?.length}');

      bigMacs?.sort((a, b){

        final double? _priceA = convertBigMacPriceToDollar(
          value: accountPrice,
          bigMac: a,
          bigMacs: allMacs,
        );

        final double? _priceB = convertBigMacPriceToDollar(
          value: accountPrice,
          bigMac: b,
          bigMacs: allMacs,
        );

        if (_priceA == null || _priceB == null){
          return 0;
        }

        else {
          return _priceA.compareTo(_priceB);
        }

      });

      _output.addAll(bigMacs ?? []);
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CONVERTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static double? convertBigMacPriceToDollar({
    required BigMac? bigMac,
    required double? value,
    required List<BigMac>? bigMacs,
  }){
    double? _output;

    if (bigMac != null && value != null){

      final double? _toDollarRate = Numeric.roundFractions(bigMac.toDollarRate, 2);

      /// ACCOUNT PRICE LOCAL
      final double _accPriceLocal = BigMac.accountPriceInLocalCurrencyByCountryID(
        iso3: bigMac.countryID,
        accountPrice: value,
        bigMacs: bigMacs,
      );

      /// ACCOUNT PRICE DOLLAR
      final double? _accPriceDollar = BigMac.localPriceToDollar(
        localPrice: _accPriceLocal,
        toDollarRate: _toDollarRate,
      );
      _output = Numeric.roundFractions(_accPriceDollar, 2);

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkMacsContainMac({
    required List<BigMac>? macs,
    required BigMac? mac,
  }){
    bool _output = false;

    if (macs != null && mac != null){
      _output = macs.contains(mac);
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// OTHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static double accountPriceInLocalCurrencyByCountryID({
    required String? iso3,
    required double? accountPrice,
    required List<BigMac>? bigMacs,
  }) {

    final double _bigMacsCountToBuyProAccount = bigMacsCountToBuyAccount(
      accountPrice: accountPrice,
      bigMacs: bigMacs,
    );

    final BigMac? _bigMac = getBigMacByISO3(
      iso3: iso3,
      bigMacs: bigMacs,
    );

    if (_bigMac == null){
      return 0;
    }
    else {

      final double _localBigMacPriceInLocalCurrency = _bigMac.localPrice ?? 0;

      final double _proAccountPriceInLocalCurrency = _localBigMacPriceInLocalCurrency * _bigMacsCountToBuyProAccount;

      return _proAccountPriceInLocalCurrency;

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double bigMacsCountToBuyAccount({
    required double? accountPrice,
    required List<BigMac>? bigMacs,
  }) {

    if (accountPrice == null || Lister.checkCanLoop(bigMacs) == false){
      return 0;
    }
    else {
      /// how many big macs can 5000 EGP buy
      final double? _bigMacPriceEGY = getBigMacByISO3(
        iso3: 'egy',
        bigMacs: bigMacs,
      )?.localPrice;

      if (_bigMacPriceEGY == null){
        return 0;
      }
      else {
        final double _count = accountPrice / _bigMacPriceEGY;
        return _count;
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double localPriceToDollar({
    required double? localPrice,
    required double? toDollarRate,
  }) {
    if (localPrice == null || toDollarRate == null){
      return 0;
    }
    else {
      final double _priceInDollar = localPrice / toDollarRate;
      return _priceInDollar;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<BigMac> getBigMacs() {

    /// BIG MACS PRICES
    /// https://hellosafe.ca/en/blog/big-mac-index

    final List<BigMac> _bigMacs = <BigMac>[
      const BigMac(
          countryID: 'arg',
          localPrice: 320,
          currencyID: 'ARS',
          toDollarRate: 85.3736),
      const BigMac(
          countryID: 'aus',
          localPrice: 6.48,
          currencyID: 'AUD',
          toDollarRate: 1.29996750081248),
      const BigMac(
          countryID: 'aze',
          localPrice: 3.95,
          currencyID: 'AZN',
          toDollarRate: 1.699),
      const BigMac(
          countryID: 'bhr',
          localPrice: 1.5,
          currencyID: 'BHD',
          toDollarRate: 0.377),
      const BigMac(
          countryID: 'bra',
          localPrice: 21.9,
          currencyID: 'BRL',
          toDollarRate: 5.5046),
      const BigMac(
          countryID: 'gbr',
          localPrice: 3.29,
          currencyID: 'GBP',
          toDollarRate: 0.741372280090447),
      const BigMac(
          countryID: 'can',
          localPrice: 6.77,
          currencyID: 'CAD',
          toDollarRate: 1.2803),
      const BigMac(
          countryID: 'chl',
          localPrice: 2940,
          currencyID: 'CLP',
          toDollarRate: 719.425),
      const BigMac(
          countryID: 'chn',
          localPrice: 22.4,
          currencyID: 'CNY',
          toDollarRate: 6.4751),
      const BigMac(
          countryID: 'col',
          localPrice: 12950,
          currencyID: 'COP',
          toDollarRate: 3460.5),
      const BigMac(
          countryID: 'cri',
          localPrice: 2350,
          currencyID: 'CRC',
          toDollarRate: 613.77),
      const BigMac(
          countryID: 'hrv',
          localPrice: 23,
          currencyID: 'HRK',
          toDollarRate: 6.23875),
      const BigMac(
          countryID: 'cze',
          localPrice: 89,
          currencyID: 'CZK',
          toDollarRate: 21.5909),
      const BigMac(
          countryID: 'dnk',
          localPrice: 30,
          currencyID: 'DKK',
          toDollarRate: 6.12065),
      const BigMac(
          countryID: 'egy',
          localPrice: 80,
          currencyID: 'EGP',
          toDollarRate: 22),
      const BigMac(
          countryID: 'euz',
          localPrice: 4.25,
          currencyID: 'EUR',
          toDollarRate: 0.823011398707872),
      const BigMac(
          countryID: 'gtm',
          localPrice: 25,
          currencyID: 'GTQ',
          toDollarRate: 7.8009),
      const BigMac(
          countryID: 'hnd',
          localPrice: 87,
          currencyID: 'HNL',
          toDollarRate: 24.103),
      const BigMac(
          countryID: 'hkg',
          localPrice: 20.5,
          currencyID: 'HKD',
          toDollarRate: 7.75535),
      const BigMac(
          countryID: 'hun',
          localPrice: 900,
          currencyID: 'HUF',
          toDollarRate: 297.42395),
      const BigMac(
          countryID: 'ind',
          localPrice: 190,
          currencyID: 'INR',
          toDollarRate: 73.39),
      const BigMac(
          countryID: 'idn',
          localPrice: 34000,
          currencyID: 'IDR',
          toDollarRate: 14125),
      const BigMac(
          countryID: 'isr',
          localPrice: 17,
          currencyID: 'ILS',
          toDollarRate: 3.179),
      const BigMac(
          countryID: 'jpn',
          localPrice: 390,
          currencyID: 'JPY',
          toDollarRate: 104.295),
      const BigMac(
          countryID: 'jor',
          localPrice: 2.3,
          currencyID: 'JOD',
          toDollarRate: 0.709),
      const BigMac(
          countryID: 'kwt',
          localPrice: 1.15,
          currencyID: 'KWD',
          toDollarRate: 0.3037),
      const BigMac(
          countryID: 'lbn',
          localPrice: 15500,
          currencyID: 'LBP',
          toDollarRate: 8750),
      const BigMac(
          countryID: 'mys',
          localPrice: 9.99,
          currencyID: 'MYR',
          toDollarRate: 4.052),
      const BigMac(
          countryID: 'mex',
          localPrice: 54,
          currencyID: 'MXN',
          toDollarRate: 20.11475),
      const BigMac(
          countryID: 'mda',
          localPrice: 50,
          currencyID: 'MDL',
          toDollarRate: 17.225),
      const BigMac(
          countryID: 'nzl',
          localPrice: 6.8,
          currencyID: 'NZD',
          toDollarRate: 1.39508928571429),
      const BigMac(
          countryID: 'nic',
          localPrice: 124,
          currencyID: 'NIO',
          toDollarRate: 34.8453),
      const BigMac(
          countryID: 'nor',
          localPrice: 52,
          currencyID: 'NOK',
          toDollarRate: 8.5439),
      const BigMac(
          countryID: 'omn',
          localPrice: 1.1,
          currencyID: 'OMR',
          toDollarRate: 0.385),
      const BigMac(
          countryID: 'pak',
          localPrice: 550,
          currencyID: 'PKR',
          toDollarRate: 160.35),
      const BigMac(
          countryID: 'per',
          localPrice: 11.9,
          currencyID: 'PEN',
          toDollarRate: 3.6207),
      const BigMac(
          countryID: 'phl',
          localPrice: 142,
          currencyID: 'PHP',
          toDollarRate: 48.0925),
      const BigMac(
          countryID: 'pol',
          localPrice: 13.08,
          currencyID: 'PLN',
          toDollarRate: 3.7226),
      const BigMac(
          countryID: 'qat',
          localPrice: 13,
          currencyID: 'QAR',
          toDollarRate: 3.641),
      const BigMac(
          countryID: 'rou',
          localPrice: 9.9,
          currencyID: 'RON',
          toDollarRate: 4.0089),
      const BigMac(
          countryID: 'rus',
          localPrice: 135,
          currencyID: 'RUB',
          toDollarRate: 74.63),
      const BigMac(
          countryID: 'sau',
          localPrice: 14,
          currencyID: 'SAR',
          toDollarRate: 3.7518),
      const BigMac(
          countryID: 'sgp',
          localPrice: 5.9,
          currencyID: 'SGD',
          toDollarRate: 1.3308),
      const BigMac(
          countryID: 'zaf',
          localPrice: 33.5,
          currencyID: 'ZAR',
          toDollarRate: 15.5225),
      const BigMac(
          countryID: 'kor',
          localPrice: 4500,
          currencyID: 'KRW',
          toDollarRate: 1097.35),
      const BigMac(
          countryID: 'lka',
          localPrice: 700,
          currencyID: 'LKR',
          toDollarRate: 189),
      const BigMac(
          countryID: 'swe',
          localPrice: 52.88,
          currencyID: 'SEK',
          toDollarRate: 8.29525),
      const BigMac(
          countryID: 'che',
          localPrice: 6.5,
          currencyID: 'CHF',
          toDollarRate: 0.89155),
      const BigMac(
          countryID: 'twn',
          localPrice: 72,
          currencyID: 'TWD',
          toDollarRate: 27.98),
      const BigMac(
          countryID: 'tha',
          localPrice: 128,
          currencyID: 'THB',
          toDollarRate: 30.13),
      const BigMac(
          countryID: 'tur',
          localPrice: 14.99,
          currencyID: 'TRY',
          toDollarRate: 7.4705),
      const BigMac(
          countryID: 'ukr',
          localPrice: 62,
          currencyID: 'UAH',
          toDollarRate: 28.14),
      const BigMac(
          countryID: 'are',
          localPrice: 14.75,
          currencyID: 'AED',
          toDollarRate: 3.67315),
      const BigMac(
          countryID: 'usa', localPrice: 5.66, currencyID: 'USD', toDollarRate: 1),
      const BigMac(
          countryID: 'ury',
          localPrice: 204,
          currencyID: 'UYU',
          toDollarRate: 42.495),
      const BigMac(
          countryID: 'vnm',
          localPrice: 66000,
          currencyID: 'VND',
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
