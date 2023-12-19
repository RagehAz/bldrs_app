

import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/mapper_ss.dart';
import 'package:basics/ldb/methods/ldb_ops.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:fire/super_fire.dart';

class LangMapProtocols {
  // --------------------------------------------------------------------------

  const LangMapProtocols();

  // --------------------------------------------------------------------------

  /// FETCH

  // --------------------
  ///
  static Future<Map<String, String>> fetchLangMap({
    required String? langCode,
  }) async {
    Map<String, String>? _map;

    blog('LangMapProtocols fetchLangMap : fetching');

    if (langCode != null){

      Map<String, String>? _map = await _readLDBLanMap(
        langCode: langCode,
      );

      if (_map == null){

        _map = await _readRealLangMap(
          langCode: langCode,
        );

        if (_map != null){

          _map['id'] = langCode;

          await _insertLDBLangMap(
            map: _map,
          );

        }

      }

    }

    return _map ?? {};
  }
  // --------------------------------------------------------------------------

  /// REAL

  // --------------------
  ///
  static Future<Map<String, String>?> _readRealLangMap({
    required String langCode,
  }) async {

    final Map<String, dynamic>? _map = await Real.readDoc(
        coll: RealColl.phrases,
        doc: langCode,
    );

    return MapperSS.createStringStringMap(
        hashMap: _map,
        stringifyNonStrings: false,
    );

  }
  // --------------------------------------------------------------------------

  /// LDB

  // --------------------
  ///
  static Future<void> _insertLDBLangMap({
    required Map<String, String> map
  }) async {

    await LDBOps.insertMap(
      docName: LDBDoc.langMaps,
      primaryKey: 'id',
      input: map,
    );

  }
  // --------------------
  ///
  static Future<Map<String, String>?> _readLDBLanMap({
    required String langCode,
  }) async {

    final Map<String, dynamic>? _map = await LDBOps.readMap(
      docName: LDBDoc.langMaps,
      id: langCode,
      primaryKey: 'id',
    );

    return MapperSS.createStringStringMap(
      hashMap: _map,
      stringifyNonStrings: false,
    );

  }
// --------------------------------------------------------------------------
}
