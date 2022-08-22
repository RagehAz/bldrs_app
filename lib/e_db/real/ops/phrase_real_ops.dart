import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/e_db/real/foundation/real.dart';
import 'package:bldrs/e_db/real/foundation/real_colls.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';

class PhraseRealOps {
// -----------------------------------------------------------------------------

  const PhraseRealOps();

// -----------------------------------------------------------------------------

/// CREATE

// ------------------------------------------
  static Future<void> createPhrasesForLang({
    @required BuildContext context,
    @required String langCode,
    @required List<Phrase> phrases,
  }) async {

    if (langCode != null && Mapper.checkCanLoopList(phrases) == true){

      /// ASSURE ALL PHRASES ARE ON THIS LAND CODE
      final List<Phrase> _phrasesOfLang = Phrase.getPhrasesByLangFromPhrases(
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

// ------------------------------------------
  static Future<List<Phrase>> readPhrasesByLang({
    @required BuildContext context,
    @required String langCode,
  }) async {

    List<Phrase> _output = <Phrase>[];

    if (langCode != null){

      final Map<String, dynamic> _map = await Real.readDocOnce(
          context: context,
          collName: RealColl.phrases,
          docName: langCode,
      );

      if (_map != null){

        _output = Phrase.decipherPhrasesFromReal(
            langCode: langCode,
            map: _map,
        );

      }

    }

    return _output;
  }
// -----------------------------------------------------------------------------

/// UPDATE

// ------------------------------------------
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

// ------------------------------------------
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
