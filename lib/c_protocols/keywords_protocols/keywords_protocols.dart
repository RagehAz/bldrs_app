import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:bldrs/c_protocols/keywords_protocols/keywords_ldb_ops.dart';
import 'package:bldrs/c_protocols/keywords_protocols/keywords_real_ops.dart';
/// TAMAM
class KeywordsProtocols{
  // --------------------------------------------------------------------------

  const KeywordsProtocols();

  // --------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  /// NOT NEEDED
  // --------------------------------------------------------------------------

  /// FETCH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>?> fetch() async {

    Map<String, dynamic>? _output = await KeywordsLDBOps.read();

    if (_output == null){

      _output = await KeywordsRealOps.readKeywordsMap();

      if (_output != null){
        await KeywordsLDBOps.insert(map: _output);
      }

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> renovate({
    required Map<String, dynamic>? newMap,
  }) async {

    final Map<String, dynamic>? _oldMap = await fetch();

    if (
        newMap != null
        &&
        Mapper.checkMapsAreIdentical(map1: _oldMap, map2: newMap) == false
    ){

      await Future.wait(<Future>[

        KeywordsLDBOps.insert(map: newMap),

        KeywordsRealOps.updateKeywordsMap(newMap: newMap),

      ]);

    }

  }
  // --------------------------------------------------------------------------

  /// WIPE

  // --------------------
  /// NOT NEEDED
  // --------------------------------------------------------------------------
}
