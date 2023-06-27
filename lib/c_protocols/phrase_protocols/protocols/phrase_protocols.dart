import 'dart:async';


import 'package:basics/animators/helpers/sliders.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/c_chain/aaa_phider.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/app_state_real_ops.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/phrase_protocols/ldb/phrase_ldb_ops.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/c_protocols/phrase_protocols/real/phrase_real_ops.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/world_zoning/world_zoning.dart';
import 'package:basics/helpers/classes/files/filers.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:provider/provider.dart';
import 'package:basics/helpers/classes/space/scale.dart';
/// => TAMAM
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
  static Future<List<Phrase>> fetchMainMixedLangPhrases() async {

    // blog('fetchMainMixedLangPhrases : START');

    // NOTE : fetches all phrases

    /// 1- get phrases from LDB
    final List<Phrase> _allPhrases = await PhraseLDBOps.readMainPhrases();

    /// 2 - if not found in LDB , read from firebase
    if (Mapper.checkCanLoopList(_allPhrases) == false){
      // blog('fetchPhrasesByLangCode : phrases NOT found in local db');

      /// 2.1 read from firebase
      await Future.wait(<Future>[

        PhraseRealOps.readPhrasesByLang(
            langCode: 'en',
            createTrigram: true,
            onFinish: (List<Phrase> _enPhrases){
              _allPhrases.addAll(_enPhrases);
            }
        ),

        PhraseRealOps.readPhrasesByLang(
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

    // blog('fetchMainMixedLangPhrases : END');

    return _allPhrases;

  }
  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static Future<List<Phrase>> fetchMainPhrasesByCurrentLang({
    required BuildContext context,
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Phrase> _fetchPhid({
    required String langCode,
    required String phid,
  }) async {

    Phrase _phrase = await PhraseLDBOps.searchPhraseByIDAndCode(
      phid: phid,
      langCode: langCode,
    );

    _phrase ??= await PhraseRealOps.readPhraseByLang(
      lang: langCode,
      phid: phid,
    );

    _phrase ??= await PhraseRealOps.readPhraseByLang(
      lang: 'en',
      phid: phid,
    );

    _phrase ??= Phrase(
      value: phid,
      id: phid,
    );

    return _phrase;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String> translate({
    required String langCode,
    required String phid,
  }) async {
    final Phrase _phrase = await _fetchPhid(
      langCode: langCode,
      phid: phid,
    );

    return _phrase?.value;
  }
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> renovateMainPhrases({
    required BuildContext context,
    required List<Phrase> updatedMixedMainPhrases,
    required bool showWaitDialog,
  }) async {

    if (Mapper.checkCanLoopList(updatedMixedMainPhrases) == true){

      if (showWaitDialog == true){
        pushWaitDialog(
          verse: const Verse(
              id: 'phid_uploading',
              translate: true,
          ),
        );
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
            langCode: 'en',
            updatedPhrases: _en
        ),

        PhraseRealOps.updatePhrasesForLang(
            langCode: 'ar',
            updatedPhrases: _ar
        ),

        /// LOCAL UPDATE
        updateMainPhrasesLocally(
          newMainPhrases: updatedMixedMainPhrases,
        ),

        AppStateRealOps.updateGlobalLDBVersion(),

      ]);

      if (showWaitDialog == true){
        await WaitDialog.closeWaitDialog();
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateMainPhrasesLocally({
    required List<Phrase> newMainPhrases,
  }) async {

    if (Mapper.checkCanLoopList(newMainPhrases) == true){

      /// UPDATE LDB
      await PhraseLDBOps.updateMainPhrases(
        updatedMixedLangsPhrases: newMainPhrases,
      );

      /// UPDATE PRO
      final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(getMainContext(), listen: false);
      _phraseProvider.setMainPhrases(
        setTo: newMainPhrases,
        notify: true,
      );

      _phraseProvider.refreshPhidsPendingTranslation();

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> reloadMainPhrases() async {

    /// delete LDB phrases
    await PhraseLDBOps.deleteMainPhrases();

    /// RELOAD APP LOCALIZATION
    final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(getMainContext(), listen: false);
    await _phraseProvider.changeAppLang(
      langCode: Localizer.getCurrentLangCode(),
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
    required BuildContext context,
    required List<String> phids,
  }) async {

    List<Phrase> _phrases = <Phrase>[];

    if (Mapper.checkCanLoopList(phids) == true){

      final List<Phrase> _found = await PhraseLDBOps.searchMainPhrasesByIDs(
          phids: phids
      );

      _phrases = Phrase.insertPhrases(
        insertIn: _phrases,
        phrasesToInsert: _found,
        overrideDuplicateID: true,
        allowDuplicateIDs: true,
      );

    }

    return _phrases;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Phrase>> composeCountriesMixedLangPhrases({
    required BuildContext context,
    required List<String> langCodes,
  }) async {

    /// NOTE : this generates all counties phrases
    // NOTE : gets phrases from LDB or creates countries phrases then stores in LDB

    /// 1 - GET THEM FROM LDB
    List<Phrase> _allCountriesPhrases = await PhraseLDBOps.readCountriesPhrases();

    /// 2 - WHEN LDB IS EMPTY
    if (Mapper.checkCanLoopList(_allCountriesPhrases) == false) {

      /// CREATE THEM
      _allCountriesPhrases = Flag.createAllCountriesPhrasesForLDB(
        langCodes: langCodes,
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
    required Chain chain,
    required BuildContext context,
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
  /// TESTED : WORKS PERFECT
  static Future<List<Phrase>> generatePhrasesFromChains({
    required List<Chain> chains,
    required BuildContext context,
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

///  TESTED : WORKS PERFECT
List<Phrase> onSearchPhrases({
  required ValueNotifier<bool> isSearching,
  required TextEditingController searchController,
  required List<Phrase> phrasesToSearchIn,
  required PageController pageController,
  required bool mounted,
  /// mixes between en & ar values in one list
  ValueNotifier<List<Phrase>> mixedSearchResult,
}){

  List<Phrase> _foundPhrases = <Phrase>[];

  if (isSearching.value  == true){

    // final List<Phrase> _enResults = Phrase.searchPhrases(
    //   phrases: enPhrase,
    //   text: searchController.text,
    //   byValue: true,
    // );
    //
    // blog('onSearchPhrases : _enResults = $_enResults');

    // final List<Phrase> _result
    _foundPhrases = Phrase.searchPhrasesRegExp(
      phrases: phrasesToSearchIn,
      text: searchController.text,
      lookIntoValues: true,
      // byID: true,
    );

    final List<String> _phids = Phrase.getPhrasesIDs(_foundPhrases);

    _foundPhrases = Phrase.searchPhrasesByIDs(
      phrases: phrasesToSearchIn,
      phids: _phids,
    );

    // blog('onSearchPhrases : _arResults = $_arResults');
    //
    // _foundPhrases = Phrase.insertPhrases(
    //   insertIn: _foundPhrases,
    //   phrasesToInsert: _enResults,
    //   forceUpdate: false,
    //   addLanguageCode: 'en',
    //   allowDuplicateIDs: false,
    // );
    //
    // blog('onSearchPhrases : _foundPhrases.length = ${_foundPhrases.length} after adding en');
    //
    // _foundPhrases = Phrase.insertPhrases(
    //   insertIn: _foundPhrases,
    //   phrasesToInsert: _arResults,
    //   forceUpdate: false,
    //   addLanguageCode: 'ar',
    //   allowDuplicateIDs: false,
    // );

    _foundPhrases = Phrase.cleanIdenticalPhrases(_foundPhrases);

  }

  if (mixedSearchResult != null){
    if (isSearching.value  == true){
      setNotifier(notifier: mixedSearchResult, mounted: mounted, value: _foundPhrases);
    }
    else {
      setNotifier(notifier: mixedSearchResult, mounted: mounted, value: <Phrase>[]);
    }
  }

  if (pageController != null){
    if (pageController.position.pixels >= Scale.screenWidth(getMainContext()) == true){
      Sliders.slideToBackFrom(
        pageController: pageController,
        currentSlide: 1,
      );
    }
  }

  return _foundPhrases;
}
