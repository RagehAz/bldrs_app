import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_doc.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';

class PhraseLDBOps {
// -----------------------------------------------------------------------------

  const PhraseLDBOps();

// -----------------------------------------------------------------------------

/// CREATE

// ------------------------------------------

  static Future<void> insertMainPhrases({
    @required List<Phrase> mixedLangsPhrases,
  }) async {

    if (Mapper.checkCanLoopList(mixedLangsPhrases) == true){

      final List<Map<String, dynamic>> _allMaps = Phrase.cipherMixedLangPhrases(
        phrases: mixedLangsPhrases,
      );

      await LDBOps.insertMaps(
        inputs: _allMaps,
        docName: LDBDoc.mainPhrases,
        allowDuplicateIDs: true,
      );

    }

  }
// ------------------------------------------
  ///  TESTED : WORKS PERFECT
  static Future<void> insertCountriesPhrases({
    @required List<Phrase> countriesMixedLangsPhrases,
  }) async {

    if (Mapper.checkCanLoopList(countriesMixedLangsPhrases) == true){

      await LDBOps.insertMaps(
        inputs: Phrase.cipherMixedLangPhrases(phrases: countriesMixedLangsPhrases),
        docName: LDBDoc.countriesPhrases,
        allowDuplicateIDs: true,
      );

    }

  }
// -----------------------------------------------------------------------------

/// READ

// ------------------------------------------
  ///  TESTED : WORKS PERFECT
  static Future<List<Phrase>> readMainPhrases() async {

    List<Phrase> _mainPhrases;

    final List<Map<String, dynamic>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.mainPhrases,
    );

    if (Mapper.checkCanLoopList(_maps) == true){

      _mainPhrases = Phrase.decipherMixedLangPhrases(
        maps: _maps,
      );

    }

    return _mainPhrases;
  }
// ------------------------------------------

  static Future<List<Phrase>> readCountriesPhrases({
    @required List<String> activeCountriesIDs,
  }) async {

    /// GET THEM FROM LDB
    final List<Map<String, dynamic>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.countriesPhrases,
    );

    final List<Phrase> _countriesMixedLangPhrases = Phrase.decipherMixedLangPhrases(
      maps: _maps,
    );

    return _countriesMixedLangPhrases;
  }
// -----------------------------------------------------------------------------

/// UPDATE

// ------------------------------------------
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
// ------------------------------------------
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

// ------------------------------------------
  ///
  static Future<void> deleteMainPhrases() async {

    await LDBOps.deleteAllMapsAtOnce(
      docName: LDBDoc.mainPhrases,
    );

  }
// ------------------------------------------
  ///  TESTED : WORKS PERFECT
  static Future<void> deleteCountriesPhrases() async {

    await LDBOps.deleteAllMapsAtOnce(
      docName: LDBDoc.countriesPhrases,
    );

  }
// -----------------------------------------------------------------------------
}