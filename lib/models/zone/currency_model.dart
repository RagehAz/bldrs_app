import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:flutter/foundation.dart';

class CurrencyModel {
  final String code;
  final List<Name> names;
  final List<String> countriesIDs;

  CurrencyModel({
    @required this.code,
    @required this.names,
    @required this.countriesIDs,
});
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap(){

    return
        {
          'code' : code,
          'names' : Name.cipherNames(names: names),
          'countriesIDs' : countriesIDs,
        };
  }
// -----------------------------------------------------------------------------
  static Map<String, dynamic> cipherCurrencies(List<CurrencyModel> currencies){

    Map<String, dynamic> _map = {};

    if (Mapper.canLoopList(currencies)){

      for (var currency in currencies){

        _map = Mapper.insertPairInMap(
            map: _map,
            key: currency.code,
            value: currency.toMap(),
        );

      }

    }

    return _map;
  }
// -----------------------------------------------------------------------------
  static CurrencyModel decipherCurrency(Map<String, dynamic> map){

    CurrencyModel _currency;

    if (map != null){

      _currency = CurrencyModel(
          code: map['code'],
          names: Name.decipherNames(map['names']),
          countriesIDs: Mapper.getStringsFromDynamics(dynamics: map['countriesIDs']),
      );

    }

    return _currency;
  }
// -----------------------------------------------------------------------------
  static List<CurrencyModel> decipherCurrencies(Map<String, dynamic> map){

    List<CurrencyModel> _currencies = <CurrencyModel>[];

    List<String> _keys = map.keys.toList();

    if (Mapper.canLoopList(_keys)){
      for (String key in _keys){
        final CurrencyModel _currency = decipherCurrency(map[key]);
        _currencies.add(_currency);
      }
    }

    return _currencies;
  }
// -----------------------------------------------------------------------------

}