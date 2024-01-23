import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/models/phrase_model.dart';
import 'package:basics/ldb/methods/ldb_ops.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
/// => TAMAM
class CountriesPhraseLDBOps {
  // -----------------------------------------------------------------------------

  const CountriesPhraseLDBOps();

  // -----------------------------------------------------------------------------

  /// INSERT

  // --------------------
  ///  TESTED : WORKS PERFECT
  static Future<void> insertCountriesPhrases({
    required List<Phrase> countriesMixedLangsPhrases,
  }) async {

    if (Lister.checkCanLoop(countriesMixedLangsPhrases) == true){

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
  static Future<List<Phrase>> readCountriesPhrases() async {

    final List<Map<String, dynamic>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.countriesPhrases,
    );

    final List<Phrase> _countriesMixedLangPhrases = Phrase.decipherMixedLangPhrasesFromMaps(
      maps: _maps,
    );

    return _countriesMixedLangPhrases;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  ///  TESTED : WORKS PERFECT
  static Future<void> updateCountriesPhrases({
    required List<Phrase> updatedCountriesMixedLangsPhrases,
  }) async {

    if (Lister.checkCanLoop(updatedCountriesMixedLangsPhrases) == true){

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
  static Future<void> deleteCountriesPhrases() async {

    await LDBOps.deleteAllMapsAtOnce(
      docName: LDBDoc.countriesPhrases,
    );

  }
  // -----------------------------------------------------------------------------
}
