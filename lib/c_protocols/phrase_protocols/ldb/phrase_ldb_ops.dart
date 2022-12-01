import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';

class PhraseLDBOps {
  // -----------------------------------------------------------------------------

  const PhraseLDBOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  ///  TESTED : WORKS PERFECT
  static Future<void> insertMainPhrases({
    @required List<Phrase> mixedLangsPhrases,
  }) async {

    if (Mapper.checkCanLoopList(mixedLangsPhrases) == true){

      final List<Map<String, dynamic>> _allMaps = Phrase.cipherMixedLangPhrasesToMaps(
        phrases: mixedLangsPhrases,
      );

      await LDBOps.insertMaps(
        inputs: _allMaps,
        docName: LDBDoc.mainPhrases,
        allowDuplicateIDs: true,
      );

    }

  }
  // --------------------
  ///  TESTED : WORKS PERFECT
  static Future<void> insertCountriesPhrases({
    @required List<Phrase> countriesMixedLangsPhrases,
  }) async {

    if (Mapper.checkCanLoopList(countriesMixedLangsPhrases) == true){

      await LDBOps.insertMaps(
        inputs: Phrase.cipherMixedLangPhrasesToMaps(phrases: countriesMixedLangsPhrases),
        docName: LDBDoc.countriesPhrases,
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

    if (Mapper.checkCanLoopList(_maps) == true){

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
    @required List<String> phids,
  }) async {

    List<Phrase> _output = <Phrase>[];

    final List<Map<String, dynamic>> _maps = await LDBOps.searchMultipleValues(
      docName: LDBDoc.mainPhrases,
      searchField: 'id',
      searchObjects: phids,
      fieldToSortBy: 'id',
    );

    if (Mapper.checkCanLoopList(_maps) == true){

      _output = Phrase.decipherMixedLangPhrasesFromMaps(
        maps: _maps,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  static Future<void> updateMainPhrases({
    @required List<Phrase> updatedMixedLangsPhrases,
  }) async {

    if (Mapper.checkCanLoopList(updatedMixedLangsPhrases) == true){

      await deleteMainPhrases();

      await insertMainPhrases(
        mixedLangsPhrases: updatedMixedLangsPhrases,
      );

    }

  }
  // --------------------
  static Future<void> updateCountriesPhrases({
    @required List<Phrase> updatedCountriesMixedLangsPhrases,
  }) async {

    if (Mapper.checkCanLoopList(updatedCountriesMixedLangsPhrases) == true){

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
