import 'package:basics/bldrs_theme/classes/langs.dart';
import 'package:basics/helpers/files/filers.dart';
/// => TAMAM
class MainPhrasesJsonOps {
  // --------------------------------------------------------------------------

  const MainPhrasesJsonOps();

  // --------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// MANUAL DONE BY G SHEET IMPORTS IN DASHBOARD
  // --------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, String>> readAll({
    required String? langCode,
  }) async {

    Map<String, String>? _output;

    // final Map<String, String>
    // _output = await LangMapProtocols.fetchLangMap(
    //   langCode: langCode,
    // );

    final String? _langFilePath = BldrsThemeLangs.getLangFilePath(
      langCode: langCode,
    );

    if (_langFilePath != null){

      final Map<String, dynamic>? _mappedJson = await Filers.readLocalJSON(
        path: _langFilePath,
      );

      if (_mappedJson != null){
        _output = _mappedJson.map((String key, value) => MapEntry(key, value.toString()));
      }

    }

    return _output ?? {};

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> translatePhid({
    required String? phid,
    required String? langCode,
  }) async {

    if (phid == null){
      return null;
    }

    else {
      final Map<String, String> _langMap = await readAll(
        langCode: langCode,
      );

      return _langMap[phid];
    }

  }
  // --------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// MANUAL DONE BY G-SHEET
  // --------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// MANUAL DONE BY G SHEET
  // --------------------------------------------------------------------------
}
