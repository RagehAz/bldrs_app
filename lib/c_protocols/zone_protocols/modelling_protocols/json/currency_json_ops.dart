import 'package:basics/helpers/classes/files/filers.dart';
import 'package:bldrs/world_zoning/world_zoning.dart';
/// => TAMAM
class CurrencyJsonOps {
  // -----------------------------------------------------------------------------

  const CurrencyJsonOps();

  // -----------------------------------------------------------------------------

  /// READ CURRENCIES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<CurrencyModel>> readAllCurrencies() async {

    final Map<String, dynamic> _mappedJson = await Filers.readLocalJSON(
        path: BldrsThemeCurrencies.currenciesFilePath,
    );

    return CurrencyModel.decipherCurrencies(_mappedJson);
  }
  // -----------------------------------------------------------------------------
}
