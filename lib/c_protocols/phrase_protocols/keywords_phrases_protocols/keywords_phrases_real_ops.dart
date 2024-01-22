import 'package:basics/models/phrase_model.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:fire/super_fire.dart';

class KeywordsPhrasesRealOps {
  // --------------------------------------------------------------------------

  KeywordsPhrasesRealOps();

  // --------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> createPhrase({
    required String phid,
    required String langCode,
    required String value,
  }) async {

    await Real.updateDocField(
      coll: RealColl.keywordsPhrases,
      doc: langCode,
      field: phid,
      value: value,
    );

  }
  // --------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Phrase?> readPhrase({
    required String phid,
    required String langCode,
    required bool includeTrigram,
  }) async {

    final dynamic _value = await Real.readPath(
        path: RealPath.keywordsPhrases_lang_phid(langCode: langCode, phid: phid)
    );

    if (_value != null && _value is String){

      Phrase _phrase =Phrase(
        id: phid,
        langCode: langCode,
        value: _value,
      );

      if (includeTrigram == true){
        _phrase = _phrase.completeTrigram();
      }

      return _phrase;
    }

    else {
      return null;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Phrase>> readAllPhrasesByLang({
    required String langCode,
    required bool includeTrigram,
  }) async {

    final Map<String, dynamic>? _map = await Real.readPath(
        path: RealPath.keywordsPhrases_lang(langCode: langCode),
    );

    final List<Phrase> _output = Phrase.decipherPhrasesFromPhidsMap(
      langCode: langCode,
      map: _map,
      includeTrigram: includeTrigram,
    );

    return _output;
  }
  // --------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updatePhrase({
    required String phid,
    required String langCode,
    required String newValue,
  }) async {

    await createPhrase(
      phid: phid,
      langCode: langCode,
      value: newValue,
    );

  }
  // --------------------
  /// TASK : DO ME
  // static Future<void> updateAllLangPhrases({
  // }) async {
  //
  // }
  ///
  // --------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deletePhrase({
    required String phid,
    required String langCode,
  }) async {

    await Real.deleteField(
      coll: RealColl.keywordsPhrases,
      doc: langCode,
      field: phid,
    );

  }
  // --------------------------------------------------------------------------
}
