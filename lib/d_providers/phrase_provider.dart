import 'dart:async';

import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/d_providers/general_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/e_db/fire/ops/phrase_ops.dart';
import 'package:bldrs/e_db/ldb/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/ldb_ops.dart' as LDBOps;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/router/route_names.dart';
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart' as TextChecker;

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

    triggerUILoading(context, listen: false);

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

    triggerUILoading(context, listen: false);

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

    await getSetActiveCountriesPhrases(
      context: context,
      notify: false,
    );

    await getSetPhrases(
        context: context,
        notify: true
    );

  }
// -----------------------------------------------------------------------------

  /// FETCHING PHRASES

// -------------------------------------
  /// TESTED : WORKS PERFECT
  Future<List<Phrase>> fetchBasicPhrasesByLangCode({
    @required BuildContext context,
    @required String langCode,
}) async {

    List<Phrase> _phrases;
    final String _ldbDocName = langCode == 'ar' ? LDBDoc.arPhrases : LDBDoc.enPhrases;

    /// 1- get phrases from LDB
    final List<Map<String, dynamic>> _maps = await LDBOps.readAllMaps(
      docName: _ldbDocName,
    );

    if (Mapper.canLoopList(_maps) == true){
      blog('fetchPhrasesByLangCode : phrases found in local db : langCode : $langCode');
      _phrases = Phrase.decipherOneLangPhrasesMaps(
        maps: _maps,
      );
    }

    /// 2 - if not found in LDB , read from firebase
    if (Mapper.canLoopList(_phrases) == false){
      blog('fetchPhrasesByLangCode : phrases NOT found in local db : langCode : $langCode');

      /// 2.1 read from firebase
      _phrases = await readBasicPhrases(
          context: context,
          langCode: langCode,
      );

      /// 2.2 if found on firebase, store in LDB
      if (Mapper.canLoopList(_phrases) == true){
        blog('fetchPhrasesByLangCode : phrases found in Firestore : langCode : $langCode');

        final List<Map<String, dynamic>> _maps = Phrase.cipherOneLangPhrasesToMaps(
          phrases: _phrases,
          addTrigrams: true,
        );

        await LDBOps.insertMaps(
            primaryKey: 'id',
            inputs: _maps,
            docName: _ldbDocName
        );

      }

    }

    return _phrases;

  }
// -------------------------------------
  Future<Phrase> fetchCountryPhrase({
    @required BuildContext context,
    @required String countryID,
    @required String langCode,
}) async {

    /// GET FROM LOCAL PHRASES
    Phrase _countryPhrase = Phrase.getPhraseByIDAndLangCodeFromPhrases(
        langCode: langCode,
        phid: countryID,
        phrases: _basicPhrases,
    );

    /// IF NOT FOUND LOCALLY SEARCH LDB
    if (_countryPhrase == null){
      // _countryPhrase =

      /// ADD TO LOCAL PHRASES
      if (_countryPhrase != null){

      }
    }

    /// IF NOT FOUND SEARCH FIREBASE
    if (_countryPhrase == null){
      // _countryPhrase =

      /// ADD TO LDB AND LOCAL PHRASES
      if (_countryPhrase != null){

      }
    }

    return _countryPhrase;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  Future<List<Phrase>> fetchActiveCountriesMixedLangPhrases({
    @required BuildContext context,
}) async {

    List<Phrase> _countriesMixedLangPhrases = <Phrase>[];

    /// GET THEM FROM LDB
    final List<Map<String, dynamic>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.countriesMixedPhrases,
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
          docName: LDBDoc.countriesMixedPhrases,
      );

    }

    return _countriesMixedLangPhrases;
  }
// -----------------------------------------------------------------------------

  /// RELOADING PHRASES

// -------------------------------------
  Future<void> reloadPhrases(BuildContext context) async {

    /// delete LDB phrases
    await LDBOps.deleteAllAtOnce(docName: LDBDoc.enPhrases);
    await LDBOps.deleteAllAtOnce(docName: LDBDoc.arPhrases);

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

/// CURRENT PHRASES

// -------------------------------------
  List<Phrase> _basicPhrases = <Phrase>[];
// -------------------------------------
  List<Phrase> get basicPhrases  => _basicPhrases;
// -------------------------------------
  Future<void> getSetPhrases({
    @required BuildContext context,
    @required bool notify,
}) async {

    final List<Phrase> _phrases = await fetchBasicPhrasesByLangCode(
        context: context,
        langCode: _currentLangCode,
    );

    _basicPhrases = _phrases;

    if (notify == true){
      notifyListeners();
    }

  }
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------

/// COUNTRIES PHRASES

// -------------------------------------
  /*
  /// mixed langs phrases
   List<Phrase> _countriesPhrases = <Phrase>[];
// -------------------------------------
   List<Phrase> get countriesPhrases => _countriesPhrases;
// -------------------------------------
   */
  Future<void> getSetActiveCountriesPhrases({
    @required BuildContext context,
    @required bool notify,
}) async {

    final List<Phrase> _phrases = await fetchActiveCountriesMixedLangPhrases(
        context: context
    );

    blog('fetched ${_phrases.length} countries phrases');

    //
    // _countriesPhrases = _phrases;

    // if (notify == true){
    //   notifyListeners();
    // }

  }
// -------------------------------------
  Future<List<Phrase>> searchCountriesPhrasesByName({
    @required BuildContext context,
    @required String countryName,
    @required String lingoCode
  }) async {

    List<Phrase> _phrases = <Phrase>[];

    final List<Map<String, dynamic>> _maps = await LDBOps.searchPhrasesDoc(
      docName: LDBDoc.countriesMixedPhrases,
      lingCode: lingoCode,
      searchValue: countryName,
    );
    if (Mapper.canLoopList(_maps) == true){
      _phrases = Phrase.decipherMixedLangPhrases(maps: _maps,);
    }

    return _phrases;
  }
// -------------------------------------

  /// SEARCHED COUNTRIES

// -------------------------------------
  List<Phrase> _searchedCountries = <Phrase>[];
// -------------------------------------
  List<Phrase> get searchedCountries => <Phrase>[..._searchedCountries];
// -------------------------------------
  Future<void> getSetSearchedCountries({
    @required BuildContext context,
    @required String input,
  }) async {

    /// SEARCH COUNTRIES MODELS FROM FIREBASE
    // final List<CountryModel> _foundCountries = await ZoneSearch.countriesModelsByCountryName(
    //     context: context,
    //     countryName: input,
    //     lingoCode: TextChecker.concludeEnglishOrArabicLingo(input),
    // );

    /// SEARCH COUNTRIES FROM LOCAL PHRASES
    final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);
    final List<Phrase> _foundCountries = await _phraseProvider.searchCountriesPhrasesByName(
      context: context,
      lingoCode: TextChecker.concludeEnglishOrArabicLingo(input),
      countryName: input,
    );

    /// INSERT FOUND COUNTRIES TO LDB
    // if (_foundCountries.isNotEmpty){
    //   for (final CountryModel country in _foundCountries){
    //     await LDBOps.insertMap(
    //       input: country.toMap(toJSON: true),
    //       docName: LDBDoc.countries,
    //       primaryKey: 'id',
    //     );
    //   }
    // }

    /// SET FOUND COUNTRIES
    _setSearchedCountries(_foundCountries);
  }
// -------------------------------------
  void _setSearchedCountries(List<Phrase> countriesPhrases){
    _searchedCountries = countriesPhrases;
    notifyListeners();
  }
// -------------------------------------
  void clearSearchedCountries(){
    _setSearchedCountries(<Phrase>[]);
  }
// -----------------------------------------------------------------------------

}

PhraseProvider getPhraseProvider(BuildContext context, {bool listen = false}){
  return Provider.of<PhraseProvider>(context, listen: listen);
}

String superPhrase(BuildContext context, String id, {PhraseProvider providerOverride}){
  final PhraseProvider _phraseProvider = providerOverride ??
      Provider.of<PhraseProvider>(context, listen: true);

  return _phraseProvider.getTranslatedPhraseByID(id);
}
