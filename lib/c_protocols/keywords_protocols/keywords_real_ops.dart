import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:fire/super_fire.dart';
/// => TAMAM
class KeywordsRealOps{
  // --------------------------------------------------------------------------

  const KeywordsRealOps();

  // --------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// NOT NEEDED
  // --------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>?> readKeywordsMap() async {

    final Map<String, dynamic>? _map = await Real.readPath(
        path: RealColl.keywords,
    );

    return _map;
  }
  // --------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateKeywordsMap({
    required Map<String, dynamic> newMap,
  }) async {

    await Real.updateColl(
        coll: RealColl.keywords,
        map: newMap,
    );

  }
  // --------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// NOT NEEDED
  // --------------------------------------------------------------------------
}
