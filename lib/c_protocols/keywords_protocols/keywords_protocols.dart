import 'package:basics/helpers/maps/mapper.dart';
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
  // --------------------
  /// TASK : FUCK ME
  static Future<List<dynamic>> fetchChainedKeywords() async {

    // final Map<String, dynamic>? _keywordsMap = await KeywordsProtocols.fetch();
    //
    // final List<String> _paths = MapPathing.generatePathsFromMap(map: _keywordsMap);
    //
    // // final List<Chain> _reChained = ChainPathConverter.createChainsKeywordsMap(keywordsMap: _keywordsMap);
    // final List<Chain> _reChained = ChainPathConverter.createChainsFromPaths(paths: _paths);
    //
    // return _reChained;

    return [];
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>?> reFetch() async {

    await KeywordsLDBOps.delete();

    final Map<String, dynamic>? _output = await fetch();

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
