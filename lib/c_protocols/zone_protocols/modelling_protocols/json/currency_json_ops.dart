import 'dart:convert';

import 'package:bldrs/a_models/d_zone/x_money/currency_model.dart';
import 'package:bldrs/world_zoning/world_zoning.dart';
import 'package:flutter/services.dart';
/// => TAMAM
class CurrencyJsonOps {
  // -----------------------------------------------------------------------------

  const CurrencyJsonOps();

  // -----------------------------------------------------------------------------

  /// READ CURRENCIES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<CurrencyModel>> readAllCurrencies() async {
    const String _currenciesFilePath = BldrsThemeCurrencies.currenciesFilePath;
    final String _jsonStringValues = await rootBundle.loadString(_currenciesFilePath);
    final Map<String, dynamic> _mappedJson = json.decode(_jsonStringValues);
    return CurrencyModel.decipherCurrencies(_mappedJson);
  }
  // -----------------------------------------------------------------------------
}
