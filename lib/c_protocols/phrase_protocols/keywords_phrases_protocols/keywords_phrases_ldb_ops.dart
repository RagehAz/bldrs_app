import 'package:basics/ldb/methods/ldb_ops.dart';
import 'package:basics/models/phrase_model.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
/// => TAMAM
class KeywordsPhrasesLDBOps {
  // --------------------------------------------------------------------------

  const KeywordsPhrasesLDBOps();

  // --------------------------------------------------------------------------

  /// DOC

  // --------------------
  static const String keywordsPhrases = 'keywordsPhrases';
  static const String primaryKey = 'primaryKey';
  // --------------------
  /// TESTED : WORKS PERFECT
  static String generateLDBDoc({required String langCode}){
    return '${keywordsPhrases}_$langCode';
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> generateAllLDBDocsForHardReboot(){

    const List<String> _supportedLangs = Localizer.supportedLangCodes;

    final List<String> _output = [
      keywordsPhrasesAreDownloadedLDBDoc,
    ];

    for (final String langCode in _supportedLangs){
      _output.add(generateLDBDoc(langCode: langCode));
    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// INSERT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertPhrase({
    required Phrase phrase,
  }) async {

    if (phrase.langCode != null){

      await insertPhrases(
        phrases: [phrase],
        langCode: phrase.langCode!,
      );

    }


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertPhrases({
    required List<Phrase> phrases,
    required String langCode,
  }) async {

    final List<Map<String, dynamic>> _allMaps = Phrase.cipherMixedLangPhrasesToMaps(
      phrases: phrases,
      // includeTrigrams: true,
    );

    await LDBOps.insertMaps(
      inputs: _allMaps,
      docName: generateLDBDoc(langCode: langCode),
      primaryKey: primaryKey,
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
        docName: generateLDBDoc(langCode: langCode),
        primaryKey: primaryKey,
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
  static Future<List<Phrase>> readAll({
    required String langCode,
  }) async {

    final List<Map<String, dynamic>> maps = await LDBOps.readAllMaps(
      docName:  generateLDBDoc(langCode: langCode),
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
      docName: generateLDBDoc(langCode: langCode),
      primaryKey: primaryKey,
      objectID: Phrase.createPhraseLDBPrimaryKey(
        phid: phid,
        langCode: langCode,
      ),
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteAll({
    required String langCode,
  }) async {

    await Future.wait([

      /// keywordsPhrasesAreDownloadedLDBDoc
      LDBOps.deleteMap(
        objectID: langCode,
        docName: keywordsPhrasesAreDownloadedLDBDoc,
        primaryKey: 'id',
      ),

      LDBOps.deleteAllMapsAtOnce(
        docName: generateLDBDoc(langCode: langCode),
      ),

    ]);

  }
  // --------------------------------------------------------------------------

  /// DOWNLOAD TRACKING

  // --------------------
  static const String keywordsPhrasesAreDownloadedLDBDoc = 'keywordsPhrasesAreDownloaded';
  // --------------------
  ///
  static Future<void> setAllKeywordsPhrasesAreDownloaded({
    required String langCode,
  }) async {

    await LDBOps.insertMap(
      docName: keywordsPhrasesAreDownloadedLDBDoc,
      primaryKey: 'id',
      input: {
        'id': langCode,
      },
    );

  }
  // --------------------
  ///
  static Future<bool> checkKeywordsPhrasesAreDownloaded({
    required String langCode,
  }) async {

    final Map<String, dynamic>? _map = await LDBOps.searchFirstMap(
      docName: keywordsPhrasesAreDownloadedLDBDoc,
      sortFieldName: 'id',
      searchFieldName: 'id',
      searchValue: langCode,
    );

    return _map != null;
  }
  // --------------------------------------------------------------------------
}
