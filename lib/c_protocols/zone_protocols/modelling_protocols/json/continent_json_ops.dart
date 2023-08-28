import 'package:basics/bldrs_theme/assets/planet/paths.dart';
import 'package:basics/helpers/classes/files/filers.dart';
import 'package:basics/helpers/models/continent_model.dart';
/// => TAMAM
class ContinentJsonOps {
  // -----------------------------------------------------------------------------

  const ContinentJsonOps();

  // -----------------------------------------------------------------------------

  /// READ CONTINENTS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Continent>> readAllContinents() async {

    final Map<String, dynamic>? _mappedJson = await Filers.readLocalJSON(
        path: WorldZoningPaths.continentsJsonPath,
    );

    return Continent.decipherContinents(_mappedJson);
  }
  // -----------------------------------------------------------------------------
}
