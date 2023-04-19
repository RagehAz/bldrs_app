import 'dart:async';

import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/super_fire/super_fire.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:mapper/mapper.dart';
import 'package:flutter/material.dart';

class PhraseRealOps {
  // -----------------------------------------------------------------------------

  const PhraseRealOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  ///  TESTED : WORKS PERFECT
  static Future<void> createPhrasesForLang({
    @required String langCode,
    @required List<Phrase> phrases,
  }) async {

    if (langCode != null && Mapper.checkCanLoopList(phrases) == true){

      /// ASSURE ALL PHRASES ARE ON THIS LAND CODE
      final List<Phrase> _phrasesOfLang = Phrase.searchPhrasesByLang(
          phrases: phrases,
          langCode: langCode
      );

      if (Mapper.checkCanLoopList(_phrasesOfLang) == true){

        await Real.createNamedDoc(
            coll: RealColl.phrases,
            doc: langCode,
            map: Phrase.cipherPhrasesToPhidsMap(_phrasesOfLang),
        );

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  ///
  static Future<Phrase> readPhraseByLang({
    @required String lang,
    @required String phid,
    bool createTrigram = false,
  }) async {
    Phrase _output;

    if (lang != null && phid != null){

      final String _value = await Real.readPath(
          path: '${RealColl.phrases}/$lang/$phid',
      );

      if (_value != null){
        _output = Phrase(
          id: phid,
          value: _value,
          langCode: lang,
        );

        if (createTrigram == true){
          _output.completeTrigram();
        }

      }

    }

    return _output;
  }
  // --------------------
  ///  TESTED : WORKS PERFECT
  static Future<List<Phrase>> readPhrasesByLang({
    @required String langCode,
    @required bool createTrigram,
    ValueChanged<List<Phrase>> onFinish,
  }) async {

    List<Phrase> _output = <Phrase>[];

    if (langCode != null){

      final Map<String, dynamic> _map = await Real.readDoc(
        coll: RealColl.phrases,
        doc: langCode,
      );

      if (_map != null){

        _output = Phrase.decipherPhrasesFromPhidsMap(
          langCode: langCode,
          map: _map,
          includeTrigram: createTrigram,
        );

      }

    }

    if (onFinish != null){
      onFinish(_output);
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  static Future<void> updatePhrasesForLang({
    @required String langCode,
    @required List<Phrase> updatedPhrases,
  }) async {

    if (Mapper.checkCanLoopList(updatedPhrases) == true && langCode != null){

      await Real.updateDoc(
          coll: RealColl.phrases,
          doc: langCode,
          map: Phrase.cipherPhrasesToPhidsMap(updatedPhrases),
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  static Future<void> deletePhraseInMultipleLangs({
    @required String phid, // phrase id
    List<String> langCodes = const <String>['en', 'ar'],
  }) async {

    if (Mapper.checkCanLoopList(langCodes) == true){

      await Future.wait(<Future>[

        ...List.generate(langCodes.length, (index) async {

          final String _langCode = langCodes[index];

          await Real.deleteField(
              coll: RealColl.phrases,
              doc: _langCode,
              field: phid,
          );

      }),

      ]);

    }

  }
  // -----------------------------------------------------------------------------
}
