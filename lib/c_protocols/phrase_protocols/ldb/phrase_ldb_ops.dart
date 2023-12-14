import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/models/phrase_model.dart';
import 'package:basics/ldb/methods/ldb_ops.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
/// => TAMAM
class PhraseLDBOps {
  // -----------------------------------------------------------------------------

  const PhraseLDBOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  ///  TESTED : WORKS PERFECT
  static Future<void> insertMainPhrases({
    required List<Phrase> mixedLangsPhrases,
  }) async {

    if (Lister.checkCanLoopList(mixedLangsPhrases) == true){

      final List<Map<String, dynamic>> _allMaps = Phrase.cipherMixedLangPhrasesToMaps(
        phrases: mixedLangsPhrases,
      );

      await LDBOps.insertMaps(
        inputs: _allMaps,
        docName: LDBDoc.mainPhrases,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.mainPhrases),
        allowDuplicateIDs: true,
      );

    }

  }
  // --------------------
  ///  TESTED : WORKS PERFECT
  static Future<void> insertCountriesPhrases({
    required List<Phrase> countriesMixedLangsPhrases,
  }) async {

    if (Lister.checkCanLoopList(countriesMixedLangsPhrases) == true){

      await LDBOps.insertMaps(
        inputs: Phrase.cipherMixedLangPhrasesToMaps(phrases: countriesMixedLangsPhrases),
        docName: LDBDoc.countriesPhrases,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.countriesPhrases),
        allowDuplicateIDs: true,
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  ///  TESTED : WORKS PERFECT
  static Future<List<Phrase>> readMainPhrases() async {

    List<Phrase> _mainPhrases = <Phrase>[];

    final List<Map<String, dynamic>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.mainPhrases,
    );

    if (Lister.checkCanLoopList(_maps) == true){

      _mainPhrases = Phrase.decipherMixedLangPhrasesFromMaps(
        maps: _maps,
      );

    }

    return _mainPhrases;
  }
  // --------------------
  ///  TESTED : WORKS PERFECT
  static Future<List<Phrase>> readCountriesPhrases() async {

    final List<Map<String, dynamic>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.countriesPhrases,
    );

    final List<Phrase> _countriesMixedLangPhrases = Phrase.decipherMixedLangPhrasesFromMaps(
      maps: _maps,
    );

    return _countriesMixedLangPhrases;
  }
  // --------------------
  ///  TESTED : WORKS PERFECT
  static Future<List<Phrase>> searchMainPhrasesByIDs({
    required List<String> phids,
  }) async {

    List<Phrase> _output = <Phrase>[];

    final List<Map<String, dynamic>> _maps = await LDBOps.searchMultipleValues(
      docName: LDBDoc.mainPhrases,
      searchField: 'id',
      searchObjects: phids,
      fieldToSortBy: 'id',
    );

    // Mapper.blogMaps(_maps);

    if (Lister.checkCanLoopList(_maps) == true){

      _output = Phrase.decipherMixedLangPhrasesFromMaps(
        maps: _maps,
      );

    }

    return _output;
  }
  // --------------------
  ///  TESTED : WORKS PERFECT
  static Future<Phrase?> searchPhraseByIDAndCode({
    required String? phid,
    required String? langCode,
  }) async {
    Phrase? _output;

    if (phid != null && langCode != null){

      final List<Map<String, dynamic>> _maps = await LDBOps.readMaps(
        ids: [phid],
        docName: LDBDoc.mainPhrases,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.mainPhrases),
      );

      if (Lister.checkCanLoopList(_maps) == true){

        final List<Phrase> _phrases = Phrase.decipherMixedLangPhrasesFromMaps(
          maps: _maps,
        );

        _output = Phrase.searchFirstPhraseByLang(
            phrases: _phrases,
            langCode: langCode,
        );

      }


    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  ///  TESTED : WORKS PERFECT
  static Future<void> updateMainPhrases({
    required List<Phrase> updatedMixedLangsPhrases,
  }) async {

    if (Lister.checkCanLoopList(updatedMixedLangsPhrases) == true){

      await deleteMainPhrases();

      await insertMainPhrases(
        mixedLangsPhrases: updatedMixedLangsPhrases,
      );

    }

  }
  // --------------------
  ///  TESTED : WORKS PERFECT
  static Future<void> updateCountriesPhrases({
    required List<Phrase> updatedCountriesMixedLangsPhrases,
  }) async {

    if (Lister.checkCanLoopList(updatedCountriesMixedLangsPhrases) == true){

      await deleteCountriesPhrases();

      await insertCountriesPhrases(
        countriesMixedLangsPhrases: updatedCountriesMixedLangsPhrases,
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  ///  TESTED : WORKS PERFECT
  static Future<void> deleteMainPhrases() async {

    await LDBOps.deleteAllMapsAtOnce(
      docName: LDBDoc.mainPhrases,
    );

  }
  // --------------------
  ///  TESTED : WORKS PERFECT
  static Future<void> deleteCountriesPhrases() async {

    await LDBOps.deleteAllMapsAtOnce(
      docName: LDBDoc.countriesPhrases,
    );

  }
  // -----------------------------------------------------------------------------
}
