import 'package:basics/models/phrase_model.dart';
import 'package:bldrs/c_protocols/phrase_protocols/keywords_phrases_protocols/keywords_phrases_ldb_ops.dart';
import 'package:bldrs/c_protocols/phrase_protocols/keywords_phrases_protocols/keywords_phrases_real_ops.dart';
/// => TAMAM
class KeywordsPhrasesProtocols {
  // --------------------------------------------------------------------------

  const KeywordsPhrasesProtocols();

  // --------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> composePhrase({
    required String phid,
    required String langCode,
    required String value,
  }) async {

    await KeywordsPhrasesRealOps.createPhrase(
        phid: phid,
        langCode: langCode,
        value: value,
    );

    await KeywordsPhrasesLDBOps.insertPhrase(
        phrase: Phrase(
          id: phid,
          value: value,
          langCode: langCode,
        ),
    );

  }
  // --------------------------------------------------------------------------

  /// DOWNLOAD

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> downloadAll({
    required String langCode,
  }) async {

    final List<Phrase> _all = await KeywordsPhrasesRealOps.readAllPhrasesByLang(
        langCode: langCode,
        includeTrigram: true,
    );

    await KeywordsPhrasesLDBOps.insertPhrases(
        phrases: _all,
    );

  }
  // --------------------------------------------------------------------------

  /// FETCH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Phrase?> fetch({
    required String phid,
    required String langCode,
  }) async {

    Phrase? _output = await KeywordsPhrasesLDBOps.readPhrase(
      phid: phid,
      langCode: langCode,
    );

    if (_output == null){

      _output = await KeywordsPhrasesRealOps.readPhrase(
          phid: phid,
          langCode: langCode,
          includeTrigram: true,
      );

      if (_output != null){

        await KeywordsPhrasesLDBOps.insertPhrase(
            phrase: Phrase(
              id: phid,
              value: _output.value,
              langCode: langCode,
            ),
        );

      }

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> renovate({
    required String phid,
    required String langCode,
    required String newValue,
  }) async {

    await KeywordsPhrasesRealOps.updatePhrase(
      phid: phid,
      langCode: langCode,
      newValue: newValue,
    );

    await KeywordsPhrasesLDBOps.insertPhrase(
      phrase: Phrase(
        id: phid,
        value: newValue,
        langCode: langCode,
      ),
    );

  }
  // --------------------------------------------------------------------------

  /// WIPE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipe({
    required String phid,
    required String langCode,
  }) async {

    await Future.wait([

      KeywordsPhrasesRealOps.deletePhrase(phid: phid, langCode: langCode),

      KeywordsPhrasesLDBOps.deletePhrase(phid: phid, langCode: langCode),

    ]);

  }
  // --------------------------------------------------------------------------
}
