import 'dart:async';

import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/aaa_phider.dart';
import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
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

  // --------------------
  /// => ALREADY COMPOSED AND NO NEED TO RE-COMPOSE
  // -----------------------------------------------------------------------------

  /// FETCH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Phrase>> fetchMainMixedLangPhrases({
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
  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static Future<List<Phrase>> fetchMainPhrasesByCurrentLang({
    @required BuildContext context,
  }) async {
    // blog('PhraseProtocols.fetchBasicPhrasesByCurrentLang : START');

    final List<Phrase> _phrases = await fetchMainMixedLangPhrases(
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
   */
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  static Future<void> renovateMainPhrases({
    @required BuildContext context,
    @required List<Phrase> updatedMixedMainPhrases,
    @required bool showWaitDialog,
  }) async {

    if (Mapper.checkCanLoopList(updatedMixedMainPhrases) == true){

      if (showWaitDialog == true){
        unawaited(WaitDialog.showWaitDialog(
          context: context,
          loadingVerse: const Verse(text: 'Syncing', translate: false),
        ));
      }

      final List<Phrase> _en = Phrase.searchPhrasesByLang(
        phrases: updatedMixedMainPhrases,
        langCode: 'en',
      );

      final List<Phrase> _ar = Phrase.searchPhrasesByLang(
        phrases: updatedMixedMainPhrases,
        langCode: 'ar',
      );

      /// REAL UPDATE
      await Future.wait(<Future>[

        PhraseRealOps.updatePhrasesForLang(
            context: context,
            langCode: 'en',
            updatedPhrases: _en
        ),

        PhraseRealOps.updatePhrasesForLang(
            context: context,
            langCode: 'ar',
            updatedPhrases: _ar
        ),

        /// LOCAL UPDATE
        updateMainPhrasesLocally(
          context: context,
          newMainPhrases: updatedMixedMainPhrases,
        )

      ]);

      if (showWaitDialog == true){
        WaitDialog.closeWaitDialog(context);
      }

    }

  }
  // --------------------
  static Future<void> updateMainPhrasesLocally({
    @required BuildContext context,
    @required List<Phrase> newMainPhrases,
  }) async {

    if (Mapper.checkCanLoopList(newMainPhrases) == true){

      /// UPDATE LDB
      await PhraseLDBOps.updateMainPhrases(
        updatedMixedLangsPhrases: newMainPhrases,
      );

      /// UPDATE PRO
      final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);
      _phraseProvider.setMainPhrases(
        setTo: newMainPhrases,
        notify: true,
      );

      _phraseProvider.refreshPhidsPendingTranslation();

    }

  }
  // --------------------
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

  // --------------------
  ///
  // -----------------------------------------------------------------------------

  /// GENERATE PHRASES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Phrase>> generateMixedLangPhrasesFromPhids({
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Phrase>> generateCountriesMixedLangPhrases({
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Phrase>> generatePhrasesFromChain({
    @required Chain chain,
    @required BuildContext context,
  }) async {

    /// should include en - ar phrases for all IDs
    List<Phrase> _phrases = <Phrase>[];

    if (chain != null){

      final List<String> _sonsPhids = Chain.getOnlyPhidsSonsFromChain(
        chain: chain,
      );

      if (chain.id != ''){
        _sonsPhids.add(chain.id);
      }

      _phrases = await generateMixedLangPhrasesFromPhids(
        context: context,
        phids: Phider.removePhidsIndexes(<String>[..._sonsPhids,]),
      );

    }

    return _phrases;
  }
  // --------------------
  ///
  static Future<List<Phrase>> generatePhrasesFromChains({
    @required List<Chain> chains,
    @required BuildContext context,
  }) async {
    final List<Phrase> _phrases = <Phrase>[];

    if (Mapper.checkCanLoopList(chains) == true){

      Future<void> _generate(Chain chain) async {
        final List<Phrase> _chainPhrases = await generatePhrasesFromChain(
          chain: chain,
          context: context,
        );
        _phrases.addAll(_chainPhrases);
      }

      await Future.wait(<Future>[
        ...List.generate(chains.length, (index){
          return _generate(chains[index]);
        }),
      ]);

    }

    return _phrases;
  }
// -----------------------------------------------------------------------------
}
