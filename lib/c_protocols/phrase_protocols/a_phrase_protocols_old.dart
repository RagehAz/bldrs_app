import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/d_providers/general_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_doc.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/phrase_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:bldrs/x_dashboard/a_modules/b_phrases_editor/old_phrase_editor/phrase_fire_ops.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class PhraseProtocolsOLD {
// -----------------------------------------------------------------------------

  const PhraseProtocolsOLD();

// -----------------------------------------------------------------------------

  /// COMPOSING

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Phrase>> composeMixedLangPhrasesFromPhids({
    @required BuildContext context,
    @required List<String> phids,
  }) async {

    List<Phrase> _phrases = <Phrase>[];

    if (Mapper.checkCanLoopList(phids) == true){

      for (final String phid in phids){

        final List<Map<String,dynamic>> _phrasesMaps = await LDBOps.searchAllMaps(
          fieldToSortBy: 'id',
          searchField: 'id',
          fieldIsList: false,
          searchValue: phid,
          docName: LDBDoc.mainPhrases,
        );

        // blog('found these maps in basic phrases ldb doc');
        // Mapper.blogMaps(_phrasesMaps);

        final List<Phrase> _deciphered = Phrase.decipherMixedLangPhrases(
          maps: _phrasesMaps,
        );

        _phrases = Phrase.insertPhrases(
          insertIn: _phrases,
          phrasesToInsert: _deciphered,
          forceUpdate: true,
          allowDuplicateIDs: true,
        );

      }

    }

    return _phrases;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT : gets phrases from LDB or creates countries phrases then stores in LDB
  static Future<List<Phrase>> composeActiveCountriesMixedLangPhrases({
    @required BuildContext context,
  }) async {

    List<Phrase> _countriesMixedLangPhrases = <Phrase>[];
    final List<String> _activeCountriesIDs = getActiveCountriesIDs(context);

    /// GET THEM FROM LDB
    final List<Map<String, dynamic>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.countriesPhrases,
    );

    /// WHEN LDB IS EMPTY
    if (_maps == null || _maps.isEmpty == true){

      /// CREATE THEM FROM JSON
      _countriesMixedLangPhrases = await CountryModel.createMixedCountriesPhrases(
        langCodes: ['en', 'ar'],
        countriesIDs: _activeCountriesIDs,
      );

      /// THEN STORE THEM IN LDB
      await PhraseLDBOps.insertCountriesPhrases(
          countriesMixedLangsPhrases: _countriesMixedLangPhrases,
      );

    }

    /// WHEN LDB HAS VALUES
    else {

      final List<String> _mapsIDs = Mapper.getMapsPrimaryKeysValues(
        maps: _maps,
      );

      final List<String> _duplicatesCleaned = Stringer.cleanDuplicateStrings(
        strings: _mapsIDs,
      );

      final bool _noNewActiveCountries = Mapper.checkListsAreIdentical(
        list1: _duplicatesCleaned,
        list2: _activeCountriesIDs,
      );

      blog('generateActiveCountriesMixedLangPhrases : _noNewActiveCountries : '
          '$_noNewActiveCountries : _duplicatesCleaned : ${_duplicatesCleaned?.length} : '
          '_activeCountriesIDs : ${_activeCountriesIDs?.length}');

      /// NO CHANGES HAPPENED
      if (_noNewActiveCountries == true){

        _countriesMixedLangPhrases = Phrase.decipherMixedLangPhrases(
          maps: _maps,
        );

      }
      /// ACTIVE COUNTRIES LISTS HAD CHANGED
      else {

        /// CREATE THEM FROM JSON
        _countriesMixedLangPhrases = await CountryModel.createMixedCountriesPhrases(
          langCodes: ['en', 'ar'],
          countriesIDs: _activeCountriesIDs,
        );

        /// THEN STORE THEM IN LDB
        await PhraseLDBOps.updateCountriesPhrases(
            updatedCountriesMixedLangsPhrases: _countriesMixedLangPhrases,
        );


      }

    }

    return _countriesMixedLangPhrases;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
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

      _phrases = await PhraseProtocolsOLD.composeMixedLangPhrasesFromPhids(
        context: context,
        phids: _phids,
      );

    }

    return _phrases;
  }
// -----------------------------------------------------------------------------

  /// FETCHING PHRASES

// -------------------------------------
  /// TESTED : WORKS PERFECT : fetches all phrases
  static Future<List<Phrase>> fetchAllPhrasesByEnAndAr({
    @required BuildContext context,
  }) async {

    /// 1- get phrases from LDB
    List<Phrase> _allPhrases = await PhraseLDBOps.readMainPhrases();


    /// 2 - if not found in LDB , read from firebase
    if (Mapper.checkCanLoopList(_allPhrases) == false){
      blog('fetchPhrasesByLangCode : phrases NOT found in local db');

      /// 2.1 read from firebase
      final List<Phrase> _en = await readBasicPhrases(
        context: context,
        langCode: 'en',
      );
      final List<Phrase> _ar = await readBasicPhrases(
        context: context,
        langCode: 'ar',
      );
      _allPhrases = <Phrase>[..._en??[], ..._ar??[]];

      /// 2.2 if found on firebase, store in LDB
      if (Mapper.checkCanLoopList(_allPhrases) == true){
        blog('fetchPhrasesByLangCode : phrases found in Firestore');

        await PhraseLDBOps.insertMainPhrases(
          mixedLangsPhrases: _allPhrases,
        );

      }

    }

    return _allPhrases;

  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Phrase>> fetchBasicPhrasesByCurrentLang({
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
// -------------------------------------
  /*
  Future<void> getSetActiveCountriesPhrases({
    @required BuildContext context,
    // @required bool notify,
  }) async {

    final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);
    final List<Phrase> _phrases = await _phraseProvider.generateActiveCountriesMixedLangPhrases(
        context: context
    );

    blog('fetched ${_phrases.length} countries phrases');

    await LDBOps.insertMaps(
      inputs: Phrase.cipherMixedLangPhrases(phrases: _phrases),
      docName: LDBDoc.countriesPhrases,
      allowDuplicateIDs: true,
    );

    //
    // _countriesPhrases = _phrases;

    // if (notify == true){
    //   notifyListeners();
    // }

  }
   */
// -----------------------------------------------------------------------------

  /// RENOVATION : RELOADING PHRASES

// -------------------------------------
  static Future<void> reloadPhrases(BuildContext context) async {

    /// delete LDB phrases
    await LDBOps.deleteAllMapsAtOnce(docName: LDBDoc.mainPhrases);

    /// RELOAD APP LOCALIZATION
    final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);
    await _phraseProvider.changeAppLang(
      context: context,
      langCode: Wordz.languageCode(context),
    );

  }
// -----------------------------------------------------------------------------
}
