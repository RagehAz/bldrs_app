import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/ldb/methods/ldb_ops.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
/// => TAMAM
class KeywordsLDBOps {
  // --------------------------------------------------------------------------

  KeywordsLDBOps();

  // --------------------------------------------------------------------------

  /// INSERT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insert({
    required Map<String, dynamic>? map,
  }) async {

    await LDBOps.insertMap(
        docName: LDBDoc.keywords,
        primaryKey: 'id',
        input: {
          'id': 'keywords',
          'map': map,
        },
    );

  }
  // --------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>?> read() async {

    final Map<String, dynamic>? _map = await LDBOps.readMap(
      docName: LDBDoc.keywords,
      id: 'keywords',
      primaryKey: 'id',
    );

    return Mapper.sortKeysAlphabetically(map: _map?['map']);

  }
  // --------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> delete() async {

    await LDBOps.deleteAllMapsAtOnce(
        docName: LDBDoc.keywords,
    );

  }
  // --------------------------------------------------------------------------
}
