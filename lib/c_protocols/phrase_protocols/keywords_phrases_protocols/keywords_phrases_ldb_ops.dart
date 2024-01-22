import 'package:basics/ldb/methods/ldb_ops.dart';
import 'package:basics/models/phrase_model.dart';

class KeywordsPhrasesLDBOps {
  // --------------------------------------------------------------------------

  const KeywordsPhrasesLDBOps();

  // --------------------------------------------------------------------------

  /// INSERT

  // --------------------
  ///
  static Future<void> insertPhrase({
    required Phrase phrase,
  }) async {

    // await LDBOps.insertMap(
    //     input: input,
    //     docName: docName,
    //     primaryKey: primaryKey
    // );
    //
    // await LDBOps.insertMaps(
    //   inputs: _allMaps,
    //   docName: LDBDoc.mainPhrases,
    //   primaryKey: LDBDoc.getPrimaryKey(LDBDoc.mainPhrases),
    //   allowDuplicateIDs: true,
    // );

  }
  // --------------------
  ///
  static Future<void> insertPhrases({
    required List<Phrase> phrases,
  }) async {

  }
  // --------------------------------------------------------------------------

  /// READ

  // --------------------
  ///
  static Future<Phrase?> readPhrase({
    required String phid,
    required String langCode,
  }) async {

  }
  // --------------------------------------------------------------------------

  /// DELETE

  // --------------------
  static Future<void> deletePhrase({
    required String phid,
    required String langCode,
  }) async {

  }
  // --------------------------------------------------------------------------

  /// UPDATE

  // --------------------

  // --------------------------------------------------------------------------
}
