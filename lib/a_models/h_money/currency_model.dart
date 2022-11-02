import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class CurrencyModel {
  /// --------------------------------------------------------------------------
  const CurrencyModel({
    @required this.id,
    @required this.countriesIDs,
    @required this.symbol,
    @required this.digits,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final List<String> countriesIDs;
  final String symbol;
  final int digits;
  // -----------------------------------------------------------------------------

  /// STANDARDS

  // --------------------
  static const String currenciesMapID = 'currencies';

  static const String usaCurrencyID = 'currency_USD';
  static const String usaCountryID = 'usa';
  static const String euroCurrencyID = 'currency_EUR';
  static const String euroCountryID = 'euz';
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  CurrencyModel copyWith({
    String id,
    List<String> countriesIDs,
    String symbol,
    int digits,
  }){
    return CurrencyModel(
      id: id ?? this.id,
      countriesIDs: countriesIDs ?? this.countriesIDs,
      symbol: symbol ?? this.symbol,
      digits: digits ?? this.digits,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'countriesIDs': countriesIDs,
      'symbol': symbol,
      'digits': digits,
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static CurrencyModel decipherCurrency(Map<String, dynamic> map) {
    CurrencyModel _currency;

    if (map != null) {
      _currency = CurrencyModel(
        id: map['id'],
        countriesIDs: Stringer.getStringsFromDynamics(dynamics: map['countriesIDs']),
        symbol: map['symbol'],
        digits: map['digits'],
      );
    }

    return _currency;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> cipherCurrencies(List<CurrencyModel> currencies) {
    Map<String, dynamic> _map = <String, dynamic>{};

    if (Mapper.checkCanLoopList(currencies)) {
      for (final CurrencyModel currency in currencies) {
        _map = Mapper.insertPairInMap(
          map: _map,
          key: currency.id,
          value: currency.toMap(),
        );
      }

      _map = Mapper.insertPairInMap(
        map: _map,
        key: 'id',
        value: currenciesMapID,
      );

    }

    return _map;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<CurrencyModel> decipherCurrencies(Map<String, dynamic> map) {
    final List<CurrencyModel> _currencies = <CurrencyModel>[];

    if (map != null) {
      final List<String> _keys = map.keys.toList();

      if (Mapper.checkCanLoopList(_keys)) {
        for (final String key in _keys) {

          if (map[key] != currenciesMapID){
            final CurrencyModel _currency = decipherCurrency(map[key]);
            _currencies.add(_currency);
          }

        }
      }
    }

    return _currencies;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogCurrency() {
    blog('$id ( $symbol ) : ( digits : $digits ) : countries : $countriesIDs');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogCurrencies(List<CurrencyModel> currencies){

    if (Mapper.checkCanLoopList(currencies) == true){
      for (final CurrencyModel currency in currencies){

        currency.blogCurrency();

      }
    }

    else {
      blog('no currencies to blog');
    }

  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  static bool currenciesContainCurrency({
    @required List<CurrencyModel> currencies,
    @required String currencyCode,
  }) {
    bool _contains = false;

    if (Mapper.checkCanLoopList(currencies) && currencyCode != null) {
      for (final CurrencyModel currency in currencies) {
        if (currency.id == currencyCode) {
          _contains = true;
          break;
        }
      }
    }

    return _contains;
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static CurrencyModel getCurrencyFromCurrenciesByCountryID({
    @required List<CurrencyModel> currencies,
    @required String countryID,
  }) {
    CurrencyModel _currency;

    if (Mapper.checkCanLoopList(currencies) == true && countryID != null) {

      final CurrencyModel _currencyFound = currencies.firstWhere(
              (CurrencyModel curr) => Stringer.checkStringsContainString(
              strings: curr.countriesIDs, string: countryID),
          orElse: () => null);

      if (_currencyFound != null) {
        _currency = _currencyFound;
      }
    }

    return _currency;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getCurrenciesIDs(List<CurrencyModel> currencies){
    final List<String> _ids = <String>[];

    if (Mapper.checkCanLoopList(currencies) == true){

      for (final CurrencyModel currency in currencies){
        _ids.add(currency.id);
      }

    }

    return _ids;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static CurrencyModel getCurrencyByID({
    @required List<CurrencyModel> allCurrencies,
    @required String currencyID,
  }){
    CurrencyModel _currency;

    if (Mapper.checkCanLoopList(allCurrencies) == true && currencyID != null){

      _currency = allCurrencies.firstWhere(
              (element) => element.id == currencyID,
          orElse: () => null
      );

    }

    return _currency;
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<CurrencyModel> removeCurrencies({
    @required List<CurrencyModel> currencies,
    @required List<String> removeIDs,
  }){
    List<CurrencyModel> _output = <CurrencyModel>[];

    if (Mapper.checkCanLoopList(currencies) == true){
      _output = <CurrencyModel>[...currencies];

      if (Mapper.checkCanLoopList(removeIDs) == true){

        for (final String id in removeIDs){
          _output.removeWhere((element) => element.id == id);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
