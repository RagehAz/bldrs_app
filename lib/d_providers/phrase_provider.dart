import 'dart:async';

import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/d_providers/general_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
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

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

    await _zoneProvider.getSetActiveCountriesPhrases(
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
}

PhraseProvider getPhraseProvider(BuildContext context, {bool listen = false}){
  return Provider.of<PhraseProvider>(context, listen: listen);
}

String superPhrase(BuildContext context, String id, {PhraseProvider providerOverride}){
  final PhraseProvider _phraseProvider = providerOverride ??
      Provider.of<PhraseProvider>(context, listen: true);

  return _phraseProvider.getTranslatedPhraseByID(id);
}
