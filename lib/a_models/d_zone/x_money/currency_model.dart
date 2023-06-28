import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';
import 'package:basics/helpers/classes/files/filers.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
/// => TAMAM
@immutable
class CurrencyModel {
  // -----------------------------------------------------------------------------
  const CurrencyModel({
    required this.id,
    required this.countriesIDs,
    required this.symbol,
    required this.digits,
  });
  // --------------------
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
    String? id,
    List<String>? countriesIDs,
    String? symbol,
    int? digits,
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
          overrideExisting: true,
        );
      }

      _map = Mapper.insertPairInMap(
        map: _map,
        key: 'id',
        value: currenciesMapID,
        overrideExisting: true,
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
  /// TESTED : WORKS PERFECT
  static bool currenciesContainCurrency({
    required List<CurrencyModel> currencies,
    required String currencyCode,
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
  static CurrencyModel? getCurrencyFromCurrenciesByCountryID({
    required List<CurrencyModel>? currencies,
    required String? countryID,
  }) {
    CurrencyModel? _currency;

    if (Mapper.checkCanLoopList(currencies) == true && countryID != null) {

      final CurrencyModel? _currencyFound = currencies!.firstWhereOrNull(
              (CurrencyModel curr) => Stringer.checkStringsContainString(
                  strings: curr.countriesIDs,
                  string: countryID
              ),
          );

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
  static CurrencyModel? getCurrencyByID({
    required List<CurrencyModel>? allCurrencies,
    required String? currencyID,
  }){
    CurrencyModel? _currency;

    if (Mapper.checkCanLoopList(allCurrencies) == true && currencyID != null){

      _currency = allCurrencies!.firstWhereOrNull(
              (element) => element.id == currencyID,
      );

    }

    return _currency;
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<CurrencyModel> removeCurrencies({
    required List<CurrencyModel> currencies,
    required List<String> removeIDs,
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

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkCurrenciesAreIdentical({
    required CurrencyModel cur1,
    required CurrencyModel cur2,
  }){
    bool _identical = false;

    if (cur1 == null && cur2 == null){
      _identical = true;
    }

    else if (cur1 != null && cur2 != null){

      if (
          cur1.id == cur2.id &&
          Mapper.checkListsAreIdentical(list1: cur1.countriesIDs, list2: cur2.countriesIDs) == true &&
          cur1.symbol == cur2.symbol &&
          cur1.digits == cur2.digits
      ){
        _identical = true;
      }

    }

    return _identical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is CurrencyModel){
      _areIdentical = checkCurrenciesAreIdentical(
        cur1: this,
        cur2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      id.hashCode^
      countriesIDs.hashCode^
      symbol.hashCode^
      digits.hashCode;
  // -----------------------------------------------------------------------------
}
