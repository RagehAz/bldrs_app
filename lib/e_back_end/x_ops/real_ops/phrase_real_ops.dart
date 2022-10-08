import 'dart:async';

import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_colls.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';

class PhraseRealOps {
  // -----------------------------------------------------------------------------

  const PhraseRealOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  ///  TESTED : WORKS PERFECT
  static Future<void> createPhrasesForLang({
    @required BuildContext context,
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
            context: context,
            collName: RealColl.phrases,
            docName: langCode,
            map: Phrase.cipherPhrasesToReal(_phrasesOfLang),
        );

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  ///
  static Future<Phrase> readPhraseByLang({
    @required BuildContext context,
    @required String lang,
    @required String phid,
    bool createTrigram = false,
  }) async {
    Phrase _output;

    if (lang != null && phid != null){

      final String _value = await Real.readPath(
          context: context,
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
    @required BuildContext context,
    @required String langCode,
    @required bool createTrigram,
    ValueChanged<List<Phrase>> onFinish,
  }) async {

    List<Phrase> _output = <Phrase>[];

    if (langCode != null){

      final Map<String, dynamic> _map = await Real.readDocOnce(
        context: context,
        collName: RealColl.phrases,
        docName: langCode,
        addDocID: false,
      );

      if (_map != null){

        _output = Phrase.decipherPhrasesFromReal(
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
    @required BuildContext context,
    @required String langCode,
    @required List<Phrase> updatedPhrases,
  }) async {

    if (Mapper.checkCanLoopList(updatedPhrases) == true && langCode != null){

      await Real.updateDoc(
          context: context,
          collName: RealColl.phrases,
          docName: langCode,
          map: Phrase.cipherPhrasesToReal(updatedPhrases),
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  static Future<void> deletePhraseInMultipleLangs({
    @required BuildContext context,
    @required String phid, // phrase id
    List<String> langCodes = const <String>['en', 'ar'],
  }) async {

    if (Mapper.checkCanLoopList(langCodes) == true){

      await Future.wait(<Future>[

        ...List.generate(langCodes.length, (index) async {

          final String _langCode = langCodes[index];

          await Real.deleteField(
              context: context,
              collName: RealColl.phrases,
              docName: _langCode,
              fieldName: phid,
          );

      }),

      ]);

    }

  }
  // -----------------------------------------------------------------------------
}