import 'dart:async';

import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/d_providers/general_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/ops/phrase_ops.dart';
import 'package:bldrs/e_db/ldb/api/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/api/ldb_ops.dart' as LDBOps;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/router/route_names.dart';
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);
class PhraseProvider extends ChangeNotifier {
// -----------------------------------------------------------------------------

  /// CHANGE APP LANGUAGE

// --------------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> changeAppLang({
    @required BuildContext context,
    @required String langCode,
  }) async {

    triggerUILoading(
      context: context,
      listen: false,
      callerName: 'changeAppLang',
    );

    final PhraseProvider _phrasePro = getPhraseProvider(context);

    unawaited(
        WaitDialog.showWaitDialog(
          context: context,
          loadingPhrase: superPhrase(context, 'phid_change_app_lang_description',
              providerOverride: _phrasePro,
          ),
        )
    );

    await getSetCurrentLangAndPhrases(
      context: context,
      setLangCode: langCode,
    );

    await Localizer.changeAppLanguage(context, langCode);

    triggerUILoading(
      context: context,
      listen: false,
      callerName: 'changeAppLang',
    );

    WaitDialog.closeWaitDialog(context);

    await Nav.pushNamedAndRemoveAllBelow(context, Routez.logoScreen);
  }
// -------------------------------------
  Future<void> getSetCurrentLangAndPhrases({
    @required BuildContext context,
    String setLangCode,
  }) async {

    await getSetCurrentLangCode(
      context: context,
      notify: false,
      setLangCode: setLangCode,
    );

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

    await _zoneProvider.getSetActiveCountriesPhrases(
      context: context,
      notify: false,
    );

    await getSetBasicPhrases(
        context: context,
        notify: true
    );

  }
// -----------------------------------------------------------------------------

  /// FETCHING PHRASES

// -------------------------------------
  /// TESTED : WORKS PERFECT : fetches all phrases
  Future<List<Phrase>> fetchAllPhrasesByEnAndAr({
    @required BuildContext context,
}) async {

    List<Phrase> _allPhrases;

    /// 1- get phrases from LDB
    final List<Map<String, dynamic>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.basicPhrases,
    );

    if (Mapper.canLoopList(_maps) == true){
      blog('fetchPhrasesByLangCode : phrases found in local db ');
      _allPhrases = Phrase.decipherMixedLangPhrases(
        maps: _maps,
      );
    }

    /// 2 - if not found in LDB , read from firebase
    if (Mapper.canLoopList(_allPhrases) == false){
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
      if (Mapper.canLoopList(_allPhrases) == true){
        blog('fetchPhrasesByLangCode : phrases found in Firestore');

        final List<Map<String, dynamic>> _allMaps = Phrase.cipherMixedLangPhrases(
          phrases: _allPhrases,
          // includeTrigrams: true,
        );

        await LDBOps.insertMaps(
            primaryKey: 'primaryKey',
            inputs: _allMaps,
            docName: LDBDoc.basicPhrases,
        );

      }

    }

    return _allPhrases;

  }
// -------------------------------------
  /// TESTED : WORKS PERFECT : gets phrases from LDB or creates countries phrases then stores in LDB
  Future<List<Phrase>> generateActiveCountriesMixedLangPhrases({
    @required BuildContext context,
}) async {

    List<Phrase> _countriesMixedLangPhrases = <Phrase>[];

    /// GET THEM FROM LDB
    final List<Map<String, dynamic>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.countriesPhrases,
    );

    if (Mapper.canLoopList(_maps) == true){
      blog('fetchCountriesMixedLangPhrases : ${_maps.length} phrases found in LDB doc countriesMixedPhrases');

      _countriesMixedLangPhrases = Phrase.decipherMixedLangPhrases(
        maps: _maps,
      );

    }

    /// WHEN NOT IN LDB
    else {

    /// CREATE THEM FROM JSON
    _countriesMixedLangPhrases = await CountryModel.createMixedCountriesPhrases(
        langCodes: ['en', 'ar'],
        countriesIDs: getActiveCountriesIDs(context),
    );

    /// THEN STORE THEM IN LDB
      await LDBOps.insertMaps(
          primaryKey: 'primaryKey',
          inputs: Phrase.cipherMixedLangPhrases(phrases: _countriesMixedLangPhrases),
          docName: LDBDoc.countriesPhrases,
      );

    }

    return _countriesMixedLangPhrases;
  }
// -----------------------------------------------------------------------------

  /// RELOADING PHRASES

// -------------------------------------
  Future<void> reloadPhrases(BuildContext context) async {

    /// delete LDB phrases
    await LDBOps.deleteAllAtOnce(docName: LDBDoc.basicPhrases);

    /// RELOAD APP LOCALIZATION
    await changeAppLang(
        context: context,
        langCode: Wordz.languageCode(context),
    );

  }
// -----------------------------------------------------------------------------

/// CURRENT LANGUAGE

// -------------------------------------
  String _currentLangCode = 'en';
// -------------------------------------
  String get currentLangCode => _currentLangCode;
// -------------------------------------
  Future<void> getSetCurrentLangCode({
    @required BuildContext context,
    @required bool notify,
    String setLangCode,
  }) async {

    /// A. DETECT DEVICE LANGUAGE
    final String _langCode = setLangCode ?? Wordz.languageCode(context);

    /// C. SET CURRENT LANGUAGE
    _setCurrentLanguage(
      code: _langCode,
      notify: notify,
    );

  }
// -------------------------------------
  void _setCurrentLanguage({
    @required String code,
    @required bool notify,
  }){

    _currentLangCode = code;

    if (notify == true){
      notifyListeners();
    }

  }
// -----------------------------------------------------------------------------

/// BASIC PHRASES (keywords phids 'phid_k_' / specs phids 'phid_s_' / general phids 'phid_' )

// -------------------------------------
  /// does not include trigrams : used for superPhrase translating method only not for search engines
  List<Phrase> _basicPhrases = <Phrase>[];
// -------------------------------------
  List<Phrase> get basicPhrases  => _basicPhrases;
// -------------------------------------
  Future<void> getSetBasicPhrases({
    @required BuildContext context,
    @required bool notify,
}) async {

    final List<Phrase> _phrases = await fetchAllPhrasesByEnAndAr(
        context: context,
    );

    final List<Phrase> _phrasesByLang = Phrase.getPhrasesByLangFromPhrases(
        phrases: _phrases,
        langCode: _currentLangCode
    );

    /// phrases received from the fetch include trigrams "that was stored in LDB"
    final List<Phrase> _cleaned = Phrase.removeTrigramsFromPhrases(_phrasesByLang);

    _basicPhrases = _cleaned;

    if (notify == true){
      notifyListeners();
    }

  }
// -------------------------------------
  String getTranslatedPhraseByID(String id){

    String _translation = '...';

    if (
    _basicPhrases != null
        &&
    Mapper.canLoopList(_basicPhrases) == true
    ){

      final Phrase _phrase = _basicPhrases.singleWhere(
              (phrase) => phrase.id == id,
          orElse: ()=> null
      );

      if (_phrase != null){
        _translation = _phrase.value;
      }
    }

    return _translation;
  }
// -------------------------------------
  Future<List<Phrase>> generateMixedLangPhrasesFromPhids({
    @required BuildContext context,
    @required List<String> phids,
  }) async {

    List<Phrase> _phrases = <Phrase>[];

    if (Mapper.canLoopList(phids) == true){

      for (final String phid in phids){

        final List<Map<String,dynamic>> _phrasesMaps = await LDBOps.searchAllMaps(
            fieldToSortBy: 'id',
            searchField: 'id',
            fieldIsList: false,
            searchValue: phid,
            docName: LDBDoc.basicPhrases,
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
}

PhraseProvider getPhraseProvider(BuildContext context, {bool listen = false}){
  return Provider.of<PhraseProvider>(context, listen: listen);
}

String superPhrase(BuildContext context, String id, {PhraseProvider providerOverride}){
  final PhraseProvider _phraseProvider = providerOverride ??
      Provider.of<PhraseProvider>(context, listen: true);

  return _phraseProvider.getTranslatedPhraseByID(id);
}
