import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/e_db/fire/ops/phrase_ops.dart';
import 'package:bldrs/e_db/ldb/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/ldb_ops.dart' as LDBOps;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);
class PhraseProvider extends ChangeNotifier {
// -----------------------------------------------------------------------------

  /// CHANGE APP LANGUAGE

// --------------------------------------------
  Future<void> changeAppLang({
    @required BuildContext context,
    @required String langCode,
  }) async {

    await Localizer.changeAppLanguage(context, langCode);

    await getSetCurrentLangAndPhrases(context);
  }
// -------------------------------------
  Future<void> getSetCurrentLangAndPhrases(BuildContext context) async {

    await getSetCurrentLangCode(
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

        final List<Map<String, dynamic>> _maps = Phrase.cipherOneLnagPhrasesToMaps(
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
        phrases: _currentPhrases,
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
  }) async {

    /// A. DETECT DEVICE LANGUAGE
    final String _langCode = Wordz.languageCode(context);

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

/// CURRENT TRANSLATIONS

// -------------------------------------
  List<Phrase> _currentPhrases;
// -------------------------------------
  List<Phrase> get phrases  => _currentPhrases;
// -------------------------------------
  Future<void> getSetPhrases({
    @required BuildContext context,
    @required bool notify,
}) async {

    final List<Phrase> _phrases = await fetchBasicPhrasesByLangCode(
        context: context,
        langCode: _currentLangCode,
    );

    _setPhrases(
        phrases: _phrases,
        notify: notify,
    );

  }
// -------------------------------------
  void _setPhrases({
    @required List<Phrase> phrases,
    @required bool notify,
}){
    _currentPhrases = phrases;

    if (notify == true){
      notifyListeners();
    }

  }
// -----------------------------------------------------------------------------
  String getTranslatedPhraseByID(String id){

    String _translation = '...';

    if (
    _currentPhrases != null
        &&
    Mapper.canLoopList(_currentPhrases) == true
    ){

      final Phrase _phrase = _currentPhrases.singleWhere(
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

String superPhrase(BuildContext context, String id, {PhraseProvider providerOverride}){
  final PhraseProvider _phraseProvider = providerOverride ??
      Provider.of<PhraseProvider>(context, listen: true);

  return _phraseProvider.getTranslatedPhraseByID(id);
}
