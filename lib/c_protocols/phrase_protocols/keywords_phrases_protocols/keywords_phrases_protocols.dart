import 'dart:async';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper_ss.dart';
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

    await KeywordsPhrasesFireOps.createPhrase(
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

      _output = await KeywordsPhrasesFireOps.readPhrase(
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Phrase>> fetchAll({
    required String langCode,
  }) async {
    List<Phrase> _output = [];

    final bool _isDownloaded = await KeywordsPhrasesLDBOps.checkKeywordsPhrasesAreDownloaded(
      langCode: langCode,
    );

    if (_isDownloaded == true){

      blog('qq=> ALL FOUND ON LDB');
      _output = await KeywordsPhrasesLDBOps.readAll(langCode: langCode);

    }
    else {

      blog('qq=> READING FROM REAL');
      _output = await KeywordsPhrasesFireOps.readAllPhrasesByLang(
        langCode: langCode,
        includeTrigram: true,
      );
      blog('qq=> READING FROM REAL : ${_output.length} phrases');

      unawaited(_insertAllPhrasesFetched(
        phrases: _output,
        langCode: langCode,
      ));


    }

    return _output;
  }

  static Future<void> _insertAllPhrasesFetched({
    required List<Phrase> phrases,
    required String langCode,
  }) async {

    if (Lister.checkCanLoop(phrases) == true){

      /// INSERT PHRASES IN LDB
      await KeywordsPhrasesLDBOps.insertPhrases(
        phrases: phrases,
        langCode: langCode,
      );

      /// SET THAT WE DOWNLOADED THE PHRASES
      await KeywordsPhrasesLDBOps.setAllKeywordsPhrasesAreDownloaded(
          langCode: langCode
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, String>> addMapToLocalizedValues({
    required String? langCode,
    required Map<String, String>? localizedValues,
  }) async {
    Map<String, String> _output = localizedValues ?? {};

    if (langCode != null){

      final List<Phrase> _phrases = await fetchAll(langCode: langCode);
      blog('bo -> ${_phrases.length} phrases');

      final Map<String, dynamic>? _keywordsPhraseMap = Phrase.cipherPhrasesToPhidsMap(_phrases);
      blog('bo -> ${_keywordsPhraseMap?.keys.length} map keys');


      _output = MapperSS.combineStringStringMap(
        replaceDuplicateKeys: true,
        baseMap: _output,
        insert: MapperSS.createStringStringMap(
          hashMap: _keywordsPhraseMap,
          stringifyNonStrings: true,
        ),
      );

      blog('bo -> ${_output.keys.length} _output keys');

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

    await KeywordsPhrasesFireOps.updatePhrase(
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

      KeywordsPhrasesFireOps.deletePhrase(phid: phid, langCode: langCode),

      KeywordsPhrasesLDBOps.deletePhrase(phid: phid, langCode: langCode),

    ]);

  }
  // --------------------------------------------------------------------------
}
