import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/ldb/ops/phrase_ldb_ops.dart';
import 'package:bldrs/e_db/real/ops/phrase_real_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/theme/words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhraseProtocols {
// -----------------------------------------------------------------------------

  const PhraseProtocols();

// -----------------------------------------------------------------------------

/// COMPOSE

// -------------------------------------
  ///
  static Future<List<Phrase>> composeMixedLangPhrasesFromPhids({
    @required BuildContext context,
    @required List<String> phids,
  }) async {

    List<Phrase> _phrases = <Phrase>[];

    if (Mapper.checkCanLoopList(phids) == true){

      final List<Phrase> _found = await PhraseLDBOps.searchMainPhrasesByIDs(
          phids: phids
      );

      _phrases = Phrase.insertPhrases(
        insertIn: _phrases,
        phrasesToInsert: _found,
        forceUpdate: true,
        allowDuplicateIDs: true,
      );

    }

    return _phrases;
  }
// -------------------------------------
  ///
  static Future<List<Phrase>> composeCountriesMixedLangPhrases({
    @required BuildContext context,
    @required List<String> langCodes,
  }) async {

    /// NOTE : this generates all counties phrases
    // NOTE : gets phrases from LDB or creates countries phrases then stores in LDB

    /// 1 - GET THEM FROM LDB
    List<Phrase> _allCountriesPhrases = await PhraseLDBOps.readCountriesPhrases();

    /// 2 - WHEN LDB IS EMPTY
    if (Mapper.checkCanLoopList(_allCountriesPhrases) == false) {

      /// CREATE THEM FROM JSON
      _allCountriesPhrases = await CountryModel.createMixedCountriesPhrases(
        langCodes: langCodes,
        countriesIDs: CountryModel.getAllCountriesIDs(),
      );

      /// THEN STORE THEM IN LDB
      await PhraseLDBOps.insertCountriesPhrases(
        countriesMixedLangsPhrases: _allCountriesPhrases,
      );

    }

    return _allCountriesPhrases;
  }
// -------------------------------------
  ///
  static Future<List<Phrase>> generatePhrasesFromChain({
    @required Chain chain,
    @required BuildContext context,
  }) async {

    /// should include en - ar phrases for all IDs
    List<Phrase> _phrases = <Phrase>[];

    if (chain != null){

      final List<String> _phids = Chain.getOnlyStringsSonsIDsFromChain(
        chain: chain,
      );

      _phrases = await composeMixedLangPhrasesFromPhids(
        context: context,
        phids: _phids,
      );

    }

    return _phrases;
  }
// -----------------------------------------------------------------------------

/// FETCH

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Phrase>> fetchAllPhrasesByEnAndAr({
    @required BuildContext context,
  }) async {

    // NOTE : fetches all phrases

    /// 1- get phrases from LDB
    final List<Phrase> _allPhrases = await PhraseLDBOps.readMainPhrases();

    /// 2 - if not found in LDB , read from firebase
    if (Mapper.checkCanLoopList(_allPhrases) == false){
      // blog('fetchPhrasesByLangCode : phrases NOT found in local db');

      /// 2.1 read from firebase
      await Future.wait(<Future>[

        PhraseRealOps.readPhrasesByLang(
            context: context,
            langCode: 'en',
            createTrigram: true,
            onFinish: (List<Phrase> _enPhrases){
              _allPhrases.addAll(_enPhrases);
            }
            ),

        PhraseRealOps.readPhrasesByLang(
            context: context,
            langCode: 'ar',
            createTrigram: true,
            onFinish: (List<Phrase> _arPhrases){
              _allPhrases.addAll(_arPhrases);
            }
            ),

      ]);


      /// 2.2 if found on firebase, store in LDB
      if (Mapper.checkCanLoopList(_allPhrases) == true){
        // blog('fetchPhrasesByLangCode : phrases found in Firestore');

        await PhraseLDBOps.insertMainPhrases(
          mixedLangsPhrases: _allPhrases,
        );

      }

    }

    return _allPhrases;

  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Phrase>> fetchMainPhrasesByCurrentLang({
    @required BuildContext context,
  }) async {
    // blog('PhraseProtocols.fetchBasicPhrasesByCurrentLang : START');

    final List<Phrase> _phrases = await fetchAllPhrasesByEnAndAr(
      context: context,
    );

    final List<Phrase> _phrasesByLang = Phrase.getPhrasesByLangFromPhrases(
      phrases: _phrases,
      langCode: PhraseProvider.proGetCurrentLangCode(
        context: context,
        listen: false,
      ),
    );

    /// phrases received from the fetch include trigrams "that was stored in LDB"
    final List<Phrase> _cleaned = Phrase.removeTrigramsFromPhrases(_phrasesByLang);

    // blog('PhraseProtocols.fetchBasicPhrasesByCurrentLang : END');
    return _cleaned;
  }
// -----------------------------------------------------------------------------

/// RENOVATE

// -------------------------------------
  static Future<void> reloadMainPhrases(BuildContext context) async {

    /// delete LDB phrases
    await PhraseLDBOps.deleteMainPhrases();

    /// RELOAD APP LOCALIZATION
    final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);
    await _phraseProvider.changeAppLang(
      context: context,
      langCode: Words.languageCode(context),
    );

  }
// -----------------------------------------------------------------------------

/// WIPE

// -------------------------------------

// -----------------------------------------------------------------------------
}
