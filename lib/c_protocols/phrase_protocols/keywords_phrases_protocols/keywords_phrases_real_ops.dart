import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/models/phrase_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:fire/super_fire.dart';
/// => TAMAM
class KeywordsPhrasesFireOps {
  // --------------------------------------------------------------------------

  KeywordsPhrasesFireOps();

  // --------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> createPhrase({
    required String phid,
    required String langCode,
    required String value,
  }) async {

    await Fire.updateDocField(
      coll: FireColl.keywords,
      doc: langCode,
      field: phid,
      input: value,
    );

  }
  // --------------------
  ///
  // static Future<void> createPhrases({
  //   required List<Phrase> phrases,
  // }) async {
  //
  //
  //
  // }
  // --------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Phrase?> readPhrase({
    required String phid,
    required String langCode,
    required bool includeTrigram,
  }) async {

    final Map<String, dynamic>? _x = await Fire.readDoc(
      coll: FireColl.keywords,
      doc: langCode,
    );

    final dynamic _value = _x?[phid];

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

    final Map<String, dynamic>? _map = await Fire.readDoc(
      coll: FireColl.keywords,
      doc: langCode,
    );

    blog('readAllPhrasesByLang => : ${_map?.keys.length} keywords phrases keys} ');

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

    await Fire.deleteDocField(
        coll: FireColl.keywords,
        doc: langCode,
        field: phid,
    );

  }
  // --------------------------------------------------------------------------
}
