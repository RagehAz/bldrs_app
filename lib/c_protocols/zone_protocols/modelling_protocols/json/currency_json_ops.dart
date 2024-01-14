import 'package:basics/bldrs_theme/assets/planet/paths.dart';
import 'package:basics/helpers/files/filers.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
/// => TAMAM
class CurrencyJsonOps {
  // -----------------------------------------------------------------------------

  const CurrencyJsonOps();

  // -----------------------------------------------------------------------------

  /// READ CURRENCIES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<CurrencyModel>> readAllCurrencies() async {

    final Map<String, dynamic>? _mappedJson = await Filers.readLocalJSON(
        path: WorldZoningPaths.currenciesFilePath,
    );

    return CurrencyModel.decipherCurrencies(_mappedJson);
  }
  // -----------------------------------------------------------------------------
}
