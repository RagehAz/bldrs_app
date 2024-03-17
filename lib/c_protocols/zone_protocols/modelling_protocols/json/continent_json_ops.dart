import 'package:basics/bldrs_theme/assets/planet/paths.dart';
import 'package:basics/filing/filing.dart';
import 'package:basics/models/continent_model.dart';
/// => TAMAM
class ContinentJsonOps {
  // -----------------------------------------------------------------------------

  const ContinentJsonOps();

  // -----------------------------------------------------------------------------

  /// READ CONTINENTS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Continent>> readAllContinents() async {

    final Map<String, dynamic>? _mappedJson = await LocalJSON.read(
        path: WorldZoningPaths.continentsJsonPath,
    );

    return Continent.decipherContinents(_mappedJson);
  }
  // -----------------------------------------------------------------------------
}
