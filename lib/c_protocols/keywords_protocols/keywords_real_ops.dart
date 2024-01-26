// ignore_for_file: constant_identifier_names

import 'package:basics/helpers/maps/mapper.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:fire/super_fire.dart';
/// => TAMAM
class KeywordsFireOps{
  // --------------------------------------------------------------------------

  const KeywordsFireOps();

  // --------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// NOT NEEDED
  // --------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>?> readKeywordsMap() async {

    Map<String, dynamic>? _map = await Fire.readDoc(
      coll: FireColl.keywords,
      doc: FireDoc.keywords_map,
    );

    _map = Mapper.removePair(
        map: _map,
        fieldKey: 'id',
    );

    return Mapper.sortKeysAlphabetically(map: _map);
  }
  // --------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateKeywordsMap({
    required Map<String, dynamic> newMap,
  }) async {

    await Fire.updateDoc(
      coll: FireColl.keywords,
      doc: FireDoc.keywords_map,
      input: newMap,
    );

  }
  // --------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// NOT NEEDED
  // --------------------------------------------------------------------------
}
