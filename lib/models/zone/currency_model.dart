import 'package:bldrs/controllers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CurrencyModel {
  final String code;
  final List<Name> names;
  final List<String> countriesIDs;
  final String symbol;
  final String nativeSymbol;
  final int digits;

  CurrencyModel({
    @required this.code,
    @required this.names,
    @required this.countriesIDs,
    @required this.symbol,
    @required this.nativeSymbol,
    @required this.digits,
});

// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap(){

    return

      <String, dynamic>{
          'code' : code,
          'names' : Name.cipherNames(names: names, addTrigrams: false),
          'countriesIDs' : countriesIDs,
          'symbol' : symbol,
          'nativeSymbol' : nativeSymbol,
          'digits' : digits,
        };

  }
// -----------------------------------------------------------------------------
  void printCurrency(){

    print('CURRENCY PRINT ----------------------------------------- START ');
    print('code : ${code} : symbol : ${symbol} : nativeSymbol : ${nativeSymbol} : digits : ${digits}');
    print('countries : ${countriesIDs}');
    Name.printNames(names);
    print('CURRENCY PRINT ----------------------------------------- END ');

  }
// -----------------------------------------------------------------------------
  static Map<String, dynamic> cipherCurrencies(List<CurrencyModel> currencies){

    Map<String, dynamic> _map = <String, dynamic>{};

    if (Mapper.canLoopList(currencies)){

      for (CurrencyModel currency in currencies){

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
        symbol: map['symbol'],
        nativeSymbol: map['nativeSymbol'],
        digits: map['digits'],
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
  static bool currenciesContainCurrency({@required List<CurrencyModel> currencies, @required String currencyCode}){

    bool _contains = false;

    if (Mapper.canLoopList(currencies) && currencyCode != null){

      for (CurrencyModel currency in currencies){

        if (currency.code == currencyCode){
          _contains = true;
          break;
        }

      }

    }

    return _contains;
  }
// -----------------------------------------------------------------------------
  static CurrencyModel getCurrencyFromCurrenciesByCountryID({@required List<CurrencyModel> currencies, @required String countryID}){

    CurrencyModel _currency;

    if (Mapper.canLoopList(currencies) == true && countryID != null){

      final CurrencyModel _currencyFound = currencies.firstWhere((CurrencyModel curr) => Mapper.stringsContainString(strings: curr.countriesIDs, string: countryID), orElse: () => null);

      if (_currencyFound != null){
        _currency = _currencyFound;
      }

    }

    return _currency;
  }
// -----------------------------------------------------------------------------
}


  // Future<List<CurrencyModel>> updateCurrencies(BuildContext context) async {
  //
  //   final List<CurrencyModel> _currencies = await ZoneOps.readCurrencies(context);
  //
  //   final List<CurrencyModel> _newCurrencies = <CurrencyModel>[];
  //
  //   for (CurrencyModel currency in _currencies){
  //
  //     Map<String, dynamic> _sexyMap = superMap[currency.code];
  //
  //     if (_sexyMap != null){
  //       final CurrencyModel _newCurrency = CurrencyModel(
  //         code: currency.code,
  //         names: <Name>[Name(code: 'en', value: _sexyMap['name']), Name(code: 'en_plural', value: _sexyMap['name_plural'])],
  //         countriesIDs: currency.countriesIDs,
  //         symbol: _sexyMap['symbol'],
  //         nativeSymbol: _sexyMap['symbol_native'],
  //         digits: _sexyMap['decimal_digits'],
  //       );
  //
  //       _newCurrencies.add(_newCurrency);
  //
  //     }
  //
  //   }
  //
  //   return _newCurrencies;
  // }
  //
  // Map<String,  dynamic> superMap = <String, dynamic>{
  //   "USD": <String, dynamic>{
  //     "symbol": "\$",
  //     "name": "US Dollar",
  //     "symbol_native": "\$",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "USD",
  //     "name_plural": "US dollars"
  //   },
  //   "CAD": <String, dynamic>{
  //     "symbol": "CA\$",
  //     "name": "Canadian Dollar",
  //     "symbol_native": "\$",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "CAD",
  //     "name_plural": "Canadian dollars"
  //   },
  //   "EUR": <String, dynamic>{
  //     "symbol": "€",
  //     "name": "Euro",
  //     "symbol_native": "€",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "EUR",
  //     "name_plural": "euros"
  //   },
  //   "AED": <String, dynamic>{
  //     "symbol": "AED",
  //     "name": "United Arab Emirates Dirham",
  //     "symbol_native": "د.إ",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "AED",
  //     "name_plural": "UAE dirhams"
  //   },
  //   "AFN": <String, dynamic>{
  //     "symbol": "Af",
  //     "name": "Afghan Afghani",
  //     "symbol_native": "؋",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "AFN",
  //     "name_plural": "Afghan Afghanis"
  //   },
  //   "ALL": <String, dynamic>{
  //     "symbol": "ALL",
  //     "name": "Albanian Lek",
  //     "symbol_native": "Lek",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "ALL",
  //     "name_plural": "Albanian lekë"
  //   },
  //   "AMD": <String, dynamic>{
  //     "symbol": "AMD",
  //     "name": "Armenian Dram",
  //     "symbol_native": "դր.",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "AMD",
  //     "name_plural": "Armenian drams"
  //   },
  //   "ARS": <String, dynamic>{
  //     "symbol": "AR\$",
  //     "name": "Argentine Peso",
  //     "symbol_native": "\$",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "ARS",
  //     "name_plural": "Argentine pesos"
  //   },
  //   "AUD": <String, dynamic>{
  //     "symbol": "AU\$",
  //     "name": "Australian Dollar",
  //     "symbol_native": "\$",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "AUD",
  //     "name_plural": "Australian dollars"
  //   },
  //   "AZN": <String, dynamic>{
  //     "symbol": "man.",
  //     "name": "Azerbaijani Manat",
  //     "symbol_native": "ман.",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "AZN",
  //     "name_plural": "Azerbaijani manats"
  //   },
  //   "BAM": <String, dynamic>{
  //     "symbol": "KM",
  //     "name": "Bosnia-Herzegovina Convertible Mark",
  //     "symbol_native": "KM",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "BAM",
  //     "name_plural": "Bosnia-Herzegovina convertible marks"
  //   },
  //   "BDT": <String, dynamic>{
  //     "symbol": "Tk",
  //     "name": "Bangladeshi Taka",
  //     "symbol_native": "৳",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "BDT",
  //     "name_plural": "Bangladeshi takas"
  //   },
  //   "BGN": <String, dynamic>{
  //     "symbol": "BGN",
  //     "name": "Bulgarian Lev",
  //     "symbol_native": "лв.",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "BGN",
  //     "name_plural": "Bulgarian leva"
  //   },
  //   "BHD": <String, dynamic>{
  //     "symbol": "BD",
  //     "name": "Bahraini Dinar",
  //     "symbol_native": "د.ب",
  //     "decimal_digits": 3,
  //     "rounding": 0,
  //     "code": "BHD",
  //     "name_plural": "Bahraini dinars"
  //   },
  //   "BIF": <String, dynamic>{
  //     "symbol": "FBu",
  //     "name": "Burundian Franc",
  //     "symbol_native": "FBu",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "BIF",
  //     "name_plural": "Burundian francs"
  //   },
  //   "BND": <String, dynamic>{
  //     "symbol": "BN\$",
  //     "name": "Brunei Dollar",
  //     "symbol_native": "\$",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "BND",
  //     "name_plural": "Brunei dollars"
  //   },
  //   "BOB": <String, dynamic>{
  //     "symbol": "Bs",
  //     "name": "Bolivian Boliviano",
  //     "symbol_native": "Bs",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "BOB",
  //     "name_plural": "Bolivian bolivianos"
  //   },
  //   "BRL": <String, dynamic>{
  //     "symbol": "R\$",
  //     "name": "Brazilian Real",
  //     "symbol_native": "R\$",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "BRL",
  //     "name_plural": "Brazilian reals"
  //   },
  //   "BWP": <String, dynamic>{
  //     "symbol": "BWP",
  //     "name": "Botswanan Pula",
  //     "symbol_native": "P",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "BWP",
  //     "name_plural": "Botswanan pulas"
  //   },
  //   "BYN": <String, dynamic>{
  //     "symbol": "Br",
  //     "name": "Belarusian Ruble",
  //     "symbol_native": "руб.",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "BYN",
  //     "name_plural": "Belarusian rubles"
  //   },
  //   "BZD": <String, dynamic>{
  //     "symbol": "BZ\$",
  //     "name": "Belize Dollar",
  //     "symbol_native": "\$",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "BZD",
  //     "name_plural": "Belize dollars"
  //   },
  //   "CDF": <String, dynamic>{
  //     "symbol": "CDF",
  //     "name": "Congolese Franc",
  //     "symbol_native": "FrCD",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "CDF",
  //     "name_plural": "Congolese francs"
  //   },
  //   "CHF": <String, dynamic>{
  //     "symbol": "CHF",
  //     "name": "Swiss Franc",
  //     "symbol_native": "CHF",
  //     "decimal_digits": 2,
  //     "rounding": 0.05,
  //     "code": "CHF",
  //     "name_plural": "Swiss francs"
  //   },
  //   "CLP": <String, dynamic>{
  //     "symbol": "CL\$",
  //     "name": "Chilean Peso",
  //     "symbol_native": "\$",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "CLP",
  //     "name_plural": "Chilean pesos"
  //   },
  //   "CNY": <String, dynamic>{
  //     "symbol": "CN¥",
  //     "name": "Chinese Yuan",
  //     "symbol_native": "CN¥",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "CNY",
  //     "name_plural": "Chinese yuan"
  //   },
  //   "COP": <String, dynamic>{
  //     "symbol": "CO\$",
  //     "name": "Colombian Peso",
  //     "symbol_native": "\$",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "COP",
  //     "name_plural": "Colombian pesos"
  //   },
  //   "CRC": <String, dynamic>{
  //     "symbol": "₡",
  //     "name": "Costa Rican Colón",
  //     "symbol_native": "₡",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "CRC",
  //     "name_plural": "Costa Rican colóns"
  //   },
  //   "CVE": <String, dynamic>{
  //     "symbol": "CV\$",
  //     "name": "Cape Verdean Escudo",
  //     "symbol_native": "CV\$",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "CVE",
  //     "name_plural": "Cape Verdean escudos"
  //   },
  //   "CZK": <String, dynamic>{
  //     "symbol": "Kč",
  //     "name": "Czech Republic Koruna",
  //     "symbol_native": "Kč",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "CZK",
  //     "name_plural": "Czech Republic korunas"
  //   },
  //   "DJF": <String, dynamic>{
  //     "symbol": "Fdj",
  //     "name": "Djiboutian Franc",
  //     "symbol_native": "Fdj",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "DJF",
  //     "name_plural": "Djiboutian francs"
  //   },
  //   "DKK": <String, dynamic>{
  //     "symbol": "Dkr",
  //     "name": "Danish Krone",
  //     "symbol_native": "kr",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "DKK",
  //     "name_plural": "Danish kroner"
  //   },
  //   "DOP": <String, dynamic>{
  //     "symbol": "RD\$",
  //     "name": "Dominican Peso",
  //     "symbol_native": "RD\$",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "DOP",
  //     "name_plural": "Dominican pesos"
  //   },
  //   "DZD": <String, dynamic>{
  //     "symbol": "DA",
  //     "name": "Algerian Dinar",
  //     "symbol_native": "د.ج",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "DZD",
  //     "name_plural": "Algerian dinars"
  //   },
  //   "EEK": <String, dynamic>{
  //     "symbol": "Ekr",
  //     "name": "Estonian Kroon",
  //     "symbol_native": "kr",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "EEK",
  //     "name_plural": "Estonian kroons"
  //   },
  //   "EGP": <String, dynamic>{
  //     "symbol": "EGP",
  //     "name": "Egyptian Pound",
  //     "symbol_native": "ج.م",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "EGP",
  //     "name_plural": "Egyptian pounds"
  //   },
  //   "ERN": <String, dynamic>{
  //     "symbol": "Nfk",
  //     "name": "Eritrean Nakfa",
  //     "symbol_native": "Nfk",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "ERN",
  //     "name_plural": "Eritrean nakfas"
  //   },
  //   "ETB": <String, dynamic>{
  //     "symbol": "Br",
  //     "name": "Ethiopian Birr",
  //     "symbol_native": "Br",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "ETB",
  //     "name_plural": "Ethiopian birrs"
  //   },
  //   "GBP": <String, dynamic>{
  //     "symbol": "£",
  //     "name": "British Pound Sterling",
  //     "symbol_native": "£",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "GBP",
  //     "name_plural": "British pounds sterling"
  //   },
  //   "GEL": <String, dynamic>{
  //     "symbol": "GEL",
  //     "name": "Georgian Lari",
  //     "symbol_native": "GEL",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "GEL",
  //     "name_plural": "Georgian laris"
  //   },
  //   "GHS": <String, dynamic>{
  //     "symbol": "GH₵",
  //     "name": "Ghanaian Cedi",
  //     "symbol_native": "GH₵",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "GHS",
  //     "name_plural": "Ghanaian cedis"
  //   },
  //   "GNF": <String, dynamic>{
  //     "symbol": "FG",
  //     "name": "Guinean Franc",
  //     "symbol_native": "FG",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "GNF",
  //     "name_plural": "Guinean francs"
  //   },
  //   "GTQ": <String, dynamic>{
  //     "symbol": "GTQ",
  //     "name": "Guatemalan Quetzal",
  //     "symbol_native": "Q",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "GTQ",
  //     "name_plural": "Guatemalan quetzals"
  //   },
  //   "HKD": <String, dynamic>{
  //     "symbol": "HK\$",
  //     "name": "Hong Kong Dollar",
  //     "symbol_native": "\$",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "HKD",
  //     "name_plural": "Hong Kong dollars"
  //   },
  //   "HNL": <String, dynamic>{
  //     "symbol": "HNL",
  //     "name": "Honduran Lempira",
  //     "symbol_native": "L",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "HNL",
  //     "name_plural": "Honduran lempiras"
  //   },
  //   "HRK": <String, dynamic>{
  //     "symbol": "kn",
  //     "name": "Croatian Kuna",
  //     "symbol_native": "kn",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "HRK",
  //     "name_plural": "Croatian kunas"
  //   },
  //   "HUF": <String, dynamic>{
  //     "symbol": "Ft",
  //     "name": "Hungarian Forint",
  //     "symbol_native": "Ft",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "HUF",
  //     "name_plural": "Hungarian forints"
  //   },
  //   "IDR": <String, dynamic>{
  //     "symbol": "Rp",
  //     "name": "Indonesian Rupiah",
  //     "symbol_native": "Rp",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "IDR",
  //     "name_plural": "Indonesian rupiahs"
  //   },
  //   "ILS": <String, dynamic>{
  //     "symbol": "₪",
  //     "name": "Israeli New Sheqel",
  //     "symbol_native": "₪",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "ILS",
  //     "name_plural": "Israeli new sheqels"
  //   },
  //   "INR": <String, dynamic>{
  //     "symbol": "Rs",
  //     "name": "Indian Rupee",
  //     "symbol_native": "টকা",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "INR",
  //     "name_plural": "Indian rupees"
  //   },
  //   "IQD": <String, dynamic>{
  //     "symbol": "IQD",
  //     "name": "Iraqi Dinar",
  //     "symbol_native": "د.ع",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "IQD",
  //     "name_plural": "Iraqi dinars"
  //   },
  //   "IRR": <String, dynamic>{
  //     "symbol": "IRR",
  //     "name": "Iranian Rial",
  //     "symbol_native": "﷼",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "IRR",
  //     "name_plural": "Iranian rials"
  //   },
  //   "ISK": <String, dynamic>{
  //     "symbol": "Ikr",
  //     "name": "Icelandic Króna",
  //     "symbol_native": "kr",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "ISK",
  //     "name_plural": "Icelandic krónur"
  //   },
  //   "JMD": <String, dynamic>{
  //     "symbol": "J\$",
  //     "name": "Jamaican Dollar",
  //     "symbol_native": "\$",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "JMD",
  //     "name_plural": "Jamaican dollars"
  //   },
  //   "JOD": <String, dynamic>{
  //     "symbol": "JD",
  //     "name": "Jordanian Dinar",
  //     "symbol_native": "د.أ",
  //     "decimal_digits": 3,
  //     "rounding": 0,
  //     "code": "JOD",
  //     "name_plural": "Jordanian dinars"
  //   },
  //   "JPY": <String, dynamic>{
  //     "symbol": "¥",
  //     "name": "Japanese Yen",
  //     "symbol_native": "￥",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "JPY",
  //     "name_plural": "Japanese yen"
  //   },
  //   "KES": <String, dynamic>{
  //     "symbol": "Ksh",
  //     "name": "Kenyan Shilling",
  //     "symbol_native": "Ksh",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "KES",
  //     "name_plural": "Kenyan shillings"
  //   },
  //   "KHR": <String, dynamic>{
  //     "symbol": "KHR",
  //     "name": "Cambodian Riel",
  //     "symbol_native": "៛",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "KHR",
  //     "name_plural": "Cambodian riels"
  //   },
  //   "KMF": <String, dynamic>{
  //     "symbol": "CF",
  //     "name": "Comorian Franc",
  //     "symbol_native": "FC",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "KMF",
  //     "name_plural": "Comorian francs"
  //   },
  //   "KRW": <String, dynamic>{
  //     "symbol": "₩",
  //     "name": "South Korean Won",
  //     "symbol_native": "₩",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "KRW",
  //     "name_plural": "South Korean won"
  //   },
  //   "KWD": <String, dynamic>{
  //     "symbol": "KD",
  //     "name": "Kuwaiti Dinar",
  //     "symbol_native": "د.ك",
  //     "decimal_digits": 3,
  //     "rounding": 0,
  //     "code": "KWD",
  //     "name_plural": "Kuwaiti dinars"
  //   },
  //   "KZT": <String, dynamic>{
  //     "symbol": "KZT",
  //     "name": "Kazakhstani Tenge",
  //     "symbol_native": "тңг.",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "KZT",
  //     "name_plural": "Kazakhstani tenges"
  //   },
  //   "LBP": <String, dynamic>{
  //     "symbol": "L.L.",
  //     "name": "Lebanese Pound",
  //     "symbol_native": "ل.ل",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "LBP",
  //     "name_plural": "Lebanese pounds"
  //   },
  //   "LKR": <String, dynamic>{
  //     "symbol": "SLRs",
  //     "name": "Sri Lankan Rupee",
  //     "symbol_native": "SL Re",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "LKR",
  //     "name_plural": "Sri Lankan rupees"
  //   },
  //   "LTL": <String, dynamic>{
  //     "symbol": "Lt",
  //     "name": "Lithuanian Litas",
  //     "symbol_native": "Lt",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "LTL",
  //     "name_plural": "Lithuanian litai"
  //   },
  //   "LVL": <String, dynamic>{
  //     "symbol": "Ls",
  //     "name": "Latvian Lats",
  //     "symbol_native": "Ls",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "LVL",
  //     "name_plural": "Latvian lati"
  //   },
  //   "LYD": <String, dynamic>{
  //     "symbol": "LD",
  //     "name": "Libyan Dinar",
  //     "symbol_native": "د.ل",
  //     "decimal_digits": 3,
  //     "rounding": 0,
  //     "code": "LYD",
  //     "name_plural": "Libyan dinars"
  //   },
  //   "MAD": <String, dynamic>{
  //     "symbol": "MAD",
  //     "name": "Moroccan Dirham",
  //     "symbol_native": "د.م",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "MAD",
  //     "name_plural": "Moroccan dirhams"
  //   },
  //   "MDL": <String, dynamic>{
  //     "symbol": "MDL",
  //     "name": "Moldovan Leu",
  //     "symbol_native": "MDL",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "MDL",
  //     "name_plural": "Moldovan lei"
  //   },
  //   "MGA": <String, dynamic>{
  //     "symbol": "MGA",
  //     "name": "Malagasy Ariary",
  //     "symbol_native": "MGA",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "MGA",
  //     "name_plural": "Malagasy Ariaries"
  //   },
  //   "MKD": <String, dynamic>{
  //     "symbol": "MKD",
  //     "name": "Macedonian Denar",
  //     "symbol_native": "MKD",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "MKD",
  //     "name_plural": "Macedonian denari"
  //   },
  //   "MMK": <String, dynamic>{
  //     "symbol": "MMK",
  //     "name": "Myanma Kyat",
  //     "symbol_native": "K",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "MMK",
  //     "name_plural": "Myanma kyats"
  //   },
  //   "MOP": <String, dynamic>{
  //     "symbol": "MOP\$",
  //     "name": "Macanese Pataca",
  //     "symbol_native": "MOP\$",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "MOP",
  //     "name_plural": "Macanese patacas"
  //   },
  //   "MUR": <String, dynamic>{
  //     "symbol": "MURs",
  //     "name": "Mauritian Rupee",
  //     "symbol_native": "MURs",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "MUR",
  //     "name_plural": "Mauritian rupees"
  //   },
  //   "MXN": <String, dynamic>{
  //     "symbol": "MX\$",
  //     "name": "Mexican Peso",
  //     "symbol_native": "\$",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "MXN",
  //     "name_plural": "Mexican pesos"
  //   },
  //   "MYR": <String, dynamic>{
  //     "symbol": "RM",
  //     "name": "Malaysian Ringgit",
  //     "symbol_native": "RM",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "MYR",
  //     "name_plural": "Malaysian ringgits"
  //   },
  //   "MZN": <String, dynamic>{
  //     "symbol": "MTn",
  //     "name": "Mozambican Metical",
  //     "symbol_native": "MTn",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "MZN",
  //     "name_plural": "Mozambican meticals"
  //   },
  //   "NAD": <String, dynamic>{
  //     "symbol": "N\$",
  //     "name": "Namibian Dollar",
  //     "symbol_native": "N\$",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "NAD",
  //     "name_plural": "Namibian dollars"
  //   },
  //   "NGN": <String, dynamic>{
  //     "symbol": "₦",
  //     "name": "Nigerian Naira",
  //     "symbol_native": "₦",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "NGN",
  //     "name_plural": "Nigerian nairas"
  //   },
  //   "NIO": <String, dynamic>{
  //     "symbol": "C\$",
  //     "name": "Nicaraguan Córdoba",
  //     "symbol_native": "C\$",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "NIO",
  //     "name_plural": "Nicaraguan córdobas"
  //   },
  //   "NOK": <String, dynamic>{
  //     "symbol": "Nkr",
  //     "name": "Norwegian Krone",
  //     "symbol_native": "kr",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "NOK",
  //     "name_plural": "Norwegian kroner"
  //   },
  //   "NPR": <String, dynamic>{
  //     "symbol": "NPRs",
  //     "name": "Nepalese Rupee",
  //     "symbol_native": "नेरू",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "NPR",
  //     "name_plural": "Nepalese rupees"
  //   },
  //   "NZD": <String, dynamic>{
  //     "symbol": "NZ\$",
  //     "name": "New Zealand Dollar",
  //     "symbol_native": "\$",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "NZD",
  //     "name_plural": "New Zealand dollars"
  //   },
  //   "OMR": <String, dynamic>{
  //     "symbol": "OMR",
  //     "name": "Omani Rial",
  //     "symbol_native": "ر.ع",
  //     "decimal_digits": 3,
  //     "rounding": 0,
  //     "code": "OMR",
  //     "name_plural": "Omani rials"
  //   },
  //   "PAB": <String, dynamic>{
  //     "symbol": "B/.",
  //     "name": "Panamanian Balboa",
  //     "symbol_native": "B/.",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "PAB",
  //     "name_plural": "Panamanian balboas"
  //   },
  //   "PEN": <String, dynamic>{
  //     "symbol": "S/.",
  //     "name": "Peruvian Nuevo Sol",
  //     "symbol_native": "S/.",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "PEN",
  //     "name_plural": "Peruvian nuevos soles"
  //   },
  //   "PHP": <String, dynamic>{
  //     "symbol": "₱",
  //     "name": "Philippine Peso",
  //     "symbol_native": "₱",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "PHP",
  //     "name_plural": "Philippine pesos"
  //   },
  //   "PKR": <String, dynamic>{
  //     "symbol": "PKRs",
  //     "name": "Pakistani Rupee",
  //     "symbol_native": "₨",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "PKR",
  //     "name_plural": "Pakistani rupees"
  //   },
  //   "PLN": <String, dynamic>{
  //     "symbol": "zł",
  //     "name": "Polish Zloty",
  //     "symbol_native": "zł",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "PLN",
  //     "name_plural": "Polish zlotys"
  //   },
  //   "PYG": <String, dynamic>{
  //     "symbol": "₲",
  //     "name": "Paraguayan Guarani",
  //     "symbol_native": "₲",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "PYG",
  //     "name_plural": "Paraguayan guaranis"
  //   },
  //   "QAR": <String, dynamic>{
  //     "symbol": "QR",
  //     "name": "Qatari Rial",
  //     "symbol_native": "ر.ق",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "QAR",
  //     "name_plural": "Qatari rials"
  //   },
  //   "RON": <String, dynamic>{
  //     "symbol": "RON",
  //     "name": "Romanian Leu",
  //     "symbol_native": "RON",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "RON",
  //     "name_plural": "Romanian lei"
  //   },
  //   "RSD": <String, dynamic>{
  //     "symbol": "din.",
  //     "name": "Serbian Dinar",
  //     "symbol_native": "дин.",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "RSD",
  //     "name_plural": "Serbian dinars"
  //   },
  //   "RUB": <String, dynamic>{
  //     "symbol": "RUB",
  //     "name": "Russian Ruble",
  //     "symbol_native": "₽.",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "RUB",
  //     "name_plural": "Russian rubles"
  //   },
  //   "RWF": <String, dynamic>{
  //     "symbol": "RWF",
  //     "name": "Rwandan Franc",
  //     "symbol_native": "FR",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "RWF",
  //     "name_plural": "Rwandan francs"
  //   },
  //   "SAR": <String, dynamic>{
  //     "symbol": "SR",
  //     "name": "Saudi Riyal",
  //     "symbol_native": "ر.س",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "SAR",
  //     "name_plural": "Saudi riyals"
  //   },
  //   "SDG": <String, dynamic>{
  //     "symbol": "SDG",
  //     "name": "Sudanese Pound",
  //     "symbol_native": "SDG",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "SDG",
  //     "name_plural": "Sudanese pounds"
  //   },
  //   "SEK": <String, dynamic>{
  //     "symbol": "Skr",
  //     "name": "Swedish Krona",
  //     "symbol_native": "kr",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "SEK",
  //     "name_plural": "Swedish kronor"
  //   },
  //   "SGD": <String, dynamic>{
  //     "symbol": "S\$",
  //     "name": "Singapore Dollar",
  //     "symbol_native": "\$",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "SGD",
  //     "name_plural": "Singapore dollars"
  //   },
  //   "SOS": <String, dynamic>{
  //     "symbol": "Ssh",
  //     "name": "Somali Shilling",
  //     "symbol_native": "Ssh",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "SOS",
  //     "name_plural": "Somali shillings"
  //   },
  //   "SYP": <String, dynamic>{
  //     "symbol": "SY£",
  //     "name": "Syrian Pound",
  //     "symbol_native": "ل.س",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "SYP",
  //     "name_plural": "Syrian pounds"
  //   },
  //   "THB": <String, dynamic>{
  //     "symbol": "฿",
  //     "name": "Thai Baht",
  //     "symbol_native": "฿",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "THB",
  //     "name_plural": "Thai baht"
  //   },
  //   "TND": <String, dynamic>{
  //     "symbol": "DT",
  //     "name": "Tunisian Dinar",
  //     "symbol_native": "د.ت",
  //     "decimal_digits": 3,
  //     "rounding": 0,
  //     "code": "TND",
  //     "name_plural": "Tunisian dinars"
  //   },
  //   "TOP": <String, dynamic>{
  //     "symbol": "T\$",
  //     "name": "Tongan Paʻanga",
  //     "symbol_native": "T\$",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "TOP",
  //     "name_plural": "Tongan paʻanga"
  //   },
  //   "TRY": <String, dynamic>{
  //     "symbol": "TL",
  //     "name": "Turkish Lira",
  //     "symbol_native": "TL",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "TRY",
  //     "name_plural": "Turkish Lira"
  //   },
  //   "TTD": <String, dynamic>{
  //     "symbol": "TT\$",
  //     "name": "Trinidad and Tobago Dollar",
  //     "symbol_native": "\$",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "TTD",
  //     "name_plural": "Trinidad and Tobago dollars"
  //   },
  //   "TWD": <String, dynamic>{
  //     "symbol": "NT\$",
  //     "name": "New Taiwan Dollar",
  //     "symbol_native": "NT\$",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "TWD",
  //     "name_plural": "New Taiwan dollars"
  //   },
  //   "TZS": <String, dynamic>{
  //     "symbol": "TSh",
  //     "name": "Tanzanian Shilling",
  //     "symbol_native": "TSh",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "TZS",
  //     "name_plural": "Tanzanian shillings"
  //   },
  //   "UAH": <String, dynamic>{
  //     "symbol": "₴",
  //     "name": "Ukrainian Hryvnia",
  //     "symbol_native": "₴",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "UAH",
  //     "name_plural": "Ukrainian hryvnias"
  //   },
  //   "UGX": <String, dynamic>{
  //     "symbol": "USh",
  //     "name": "Ugandan Shilling",
  //     "symbol_native": "USh",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "UGX",
  //     "name_plural": "Ugandan shillings"
  //   },
  //   "UYU": <String, dynamic>{
  //     "symbol": "\$U",
  //     "name": "Uruguayan Peso",
  //     "symbol_native": "\$",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "UYU",
  //     "name_plural": "Uruguayan pesos"
  //   },
  //   "UZS": <String, dynamic>{
  //     "symbol": "UZS",
  //     "name": "Uzbekistan Som",
  //     "symbol_native": "UZS",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "UZS",
  //     "name_plural": "Uzbekistan som"
  //   },
  //   "VEF": <String, dynamic>{
  //     "symbol": "Bs.F.",
  //     "name": "Venezuelan Bolívar",
  //     "symbol_native": "Bs.F.",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "VEF",
  //     "name_plural": "Venezuelan bolívars"
  //   },
  //   "VND": <String, dynamic>{
  //     "symbol": "₫",
  //     "name": "Vietnamese Dong",
  //     "symbol_native": "₫",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "VND",
  //     "name_plural": "Vietnamese dong"
  //   },
  //   "XAF": <String, dynamic>{
  //     "symbol": "FCFA",
  //     "name": "CFA Franc BEAC",
  //     "symbol_native": "FCFA",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "XAF",
  //     "name_plural": "CFA francs BEAC"
  //   },
  //   "XOF": <String, dynamic>{
  //     "symbol": "CFA",
  //     "name": "CFA Franc BCEAO",
  //     "symbol_native": "CFA",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "XOF",
  //     "name_plural": "CFA francs BCEAO"
  //   },
  //   "YER": <String, dynamic>{
  //     "symbol": "YR",
  //     "name": "Yemeni Rial",
  //     "symbol_native": "ر.ي",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "YER",
  //     "name_plural": "Yemeni rials"
  //   },
  //   "ZAR": <String, dynamic>{
  //     "symbol": "R",
  //     "name": "South African Rand",
  //     "symbol_native": "R",
  //     "decimal_digits": 2,
  //     "rounding": 0,
  //     "code": "ZAR",
  //     "name_plural": "South African rand"
  //   },
  //   "ZMK": <String, dynamic>{
  //     "symbol": "ZK",
  //     "name": "Zambian Kwacha",
  //     "symbol_native": "ZK",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "ZMK",
  //     "name_plural": "Zambian kwachas"
  //   },
  //   "ZWL": <String, dynamic>{
  //     "symbol": "ZWL\$",
  //     "name": "Zimbabwean Dollar",
  //     "symbol_native": "ZWL\$",
  //     "decimal_digits": 0,
  //     "rounding": 0,
  //     "code": "ZWL",
  //     "name_plural": "Zimbabwean Dollar"
  //   }
  // };