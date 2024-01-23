import 'package:basics/ldb/methods/ldb_ops.dart';
import 'package:basics/models/phrase_model.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
/// => TAMAM
class KeywordsPhrasesLDBOps {
  // --------------------------------------------------------------------------

  const KeywordsPhrasesLDBOps();

  // --------------------------------------------------------------------------

  /// INSERT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertPhrase({
    required Phrase phrase,
  }) async {

    await insertPhrases(
      phrases: [phrase],
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertPhrases({
    required List<Phrase> phrases,
  }) async {

    final List<Map<String, dynamic>> _allMaps = Phrase.cipherMixedLangPhrasesToMaps(
      phrases: phrases,
      // includeTrigrams: true,
    );

    await LDBOps.insertMaps(
      inputs: _allMaps,
      docName: LDBDoc.keywordsPhrases,
      primaryKey: LDBDoc.getPrimaryKey(LDBDoc.keywordsPhrases),
      // allowDuplicateIDs: false,
    );

  }
  // --------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Phrase?> readPhrase({
    required String phid,
    required String langCode,
  }) async {
    Phrase? _output;

    final Map<String, dynamic>? _map = await LDBOps.readMap(
        docName: LDBDoc.keywordsPhrases,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.keywordsPhrases),
        id: Phrase.createPhraseLDBPrimaryKey(
          phid: phid,
          langCode: langCode,
        ),
    );

    if (_map != null){

      final List<Phrase> _phrases = Phrase.decipherMixedLangPhrasesFromMaps(
        maps: [_map],
      );

      _output = _phrases.first;

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Phrase>> readAll() async {

    final List<Map<String, dynamic>> maps = await LDBOps.readAllMaps(
      docName:  LDBDoc.keywordsPhrases,
    );

    return Phrase.decipherMixedLangPhrasesFromMaps(
      maps: maps,
    );

  }
  // --------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deletePhrase({
    required String phid,
    required String langCode,
  }) async {

    await LDBOps.deleteMap(
      docName: LDBDoc.keywordsPhrases,
      primaryKey: LDBDoc.getPrimaryKey(LDBDoc.keywordsPhrases),
      objectID: Phrase.createPhraseLDBPrimaryKey(
        phid: phid,
        langCode: langCode,
      ),
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteAll() async {

    await LDBOps.deleteAllMapsAtOnce(
        docName: LDBDoc.keywordsPhrases,
    );

  }
  // --------------------------------------------------------------------------
}
