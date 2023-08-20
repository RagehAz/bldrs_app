import 'package:basics/helpers/classes/files/filers.dart';
import 'package:bldrs/world_zoning/world_zoning.dart';
/// => TAMAM
class ContinentJsonOps {
  // -----------------------------------------------------------------------------

  const ContinentJsonOps();

  static const continentsJsonPath = 'packages/basics/lib/bldrs_theme/assets/planet/continents.json';
  // -----------------------------------------------------------------------------

  /// READ CONTINENTS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Continent>> readAllContinents() async {

    final Map<String, dynamic> _mappedJson = await Filers.readLocalJSON(
        path: continentsJsonPath,
    );

    return Continent.decipherContinents(_mappedJson);
  }
  // -----------------------------------------------------------------------------
}
