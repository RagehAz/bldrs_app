import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CurrencyModel {
  /// --------------------------------------------------------------------------
  CurrencyModel({
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

  /// CYPHERS

// ----------------------------
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'countriesIDs': countriesIDs,
      'symbol': symbol,
      'digits': digits,
    };
  }
// ----------------------------
  static CurrencyModel decipherCurrency(Map<String, dynamic> map) {
    CurrencyModel _currency;

    if (map != null) {
      _currency = CurrencyModel(
        id: map['id'],
        countriesIDs: Mapper.getStringsFromDynamics(dynamics: map['countriesIDs']),
        symbol: map['symbol'],
        digits: map['digits'],
      );
    }

    return _currency;
  }
// ----------------------------
  static Map<String, dynamic> cipherCurrencies(List<CurrencyModel> currencies) {
    Map<String, dynamic> _map = <String, dynamic>{};

    if (Mapper.canLoopList(currencies)) {
      for (final CurrencyModel currency in currencies) {
        _map = Mapper.insertPairInMap(
          map: _map,
          key: currency.id,
          value: currency.toMap(),
        );
      }
    }

    return _map;
  }
// ----------------------------
  static List<CurrencyModel> decipherCurrencies(Map<String, dynamic> map) {
    final List<CurrencyModel> _currencies = <CurrencyModel>[];

    if (map != null) {
      final List<String> _keys = map.keys.toList();

      if (Mapper.canLoopList(_keys)) {
        for (final String key in _keys) {
          final CurrencyModel _currency = decipherCurrency(map[key]);
          _currencies.add(_currency);
        }
      }
    }

    return _currencies;
  }
// -----------------------------------------------------------------------------

  /// BLOGGING

// ----------------------------
  void blogCurrency() {
    blog('$id ( $symbol ) : ( digits : $digits ) : countries : $countriesIDs');
  }

  static void blogCurrencies(List<CurrencyModel> currencies){

    if (Mapper.canLoopList(currencies) == true){
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

// ----------------------------
  static bool currenciesContainCurrency({
    @required List<CurrencyModel> currencies,
    @required String currencyCode,
  }) {
    bool _contains = false;

    if (Mapper.canLoopList(currencies) && currencyCode != null) {
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

// ----------------------------
  static CurrencyModel getCurrencyFromCurrenciesByCountryID({
    @required List<CurrencyModel> currencies,
    @required String countryID,
  }) {
    CurrencyModel _currency;

    if (Mapper.canLoopList(currencies) == true && countryID != null) {
      final CurrencyModel _currencyFound = currencies.firstWhere(
          (CurrencyModel curr) => Mapper.stringsContainString(
              strings: curr.countriesIDs, string: countryID),
          orElse: () => null);

      if (_currencyFound != null) {
        _currency = _currencyFound;
      }
    }

    return _currency;
  }
// -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static List<String> getCurrenciesIDs(List<CurrencyModel> currencies){
    final List<String> _ids = <String>[];

    if (Mapper.canLoopList(currencies) == true){

      for (final CurrencyModel currency in currencies){
        _ids.add(currency.id);
      }

    }

    return _ids;
  }
// -----------------------------------------------------------------------------
}
