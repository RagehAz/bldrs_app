import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/a_models/secondary_models/translation_model.dart';
import 'package:bldrs/e_db/fire/ops/trans_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/xxx_dashboard/a_modules/translations_manager/translations/ar.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/xxx_dashboard/a_modules/translations_manager/translations/en.dart';
import 'package:bldrs/e_db/ldb/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/ldb_ops.dart' as LDBOps;
import 'package:provider/provider.dart';
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;

// final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);
class PhraseProvider extends ChangeNotifier {

  /// CHANGE APP LANGUAGE

  Future<void> changeAppLang({
    @required BuildContext context,
    @required String langCode,
  }) async {

    await Localizer.changeAppLanguage(context, langCode);

    await getSetCurrentLangAndTransModel(context);
  }
// -------------------------------------
  Future<void> getSetCurrentLangAndTransModel(BuildContext context) async {

    await getSetCurrentLangCode(
      context: context,
      notify: false,
    );

    await getSetTranslations(
        context: context,
        notify: true
    );

  }
// -------------------------------------

  /// FETCHING PHRASES

// -------------------------------------
  Future<TransModel> fetchPhrasesByLangCode({
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
      _phrases = Phrase.decipherPhrasesMaps(
        maps: _maps,
      );
    }

    /// 2 - if not found in LDB , read from firebase
    if (Mapper.canLoopList(_phrases) == false){
      blog('fetchPhrasesByLangCode : phrases NOT found in local db : langCode : $langCode');

      /// 2.1 read from firebase
      _phrases = await readPhrases(
          context: context,
          langCode: langCode,
      );

      /// 2.2 if found on firebase, store in LDB
      if (Mapper.canLoopList(_phrases) == true){
        blog('fetchPhrasesByLangCode : phrases found in Firestore : langCode : $langCode');

        final List<Map<String, dynamic>> _maps = Phrase.cipherPhrasesToMaps(
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

    return TransModel(
      langCode: langCode,
      phrases: _phrases,
    );

  }
// -------------------------------------
  Future<void> updatePhrases(BuildContext context) async {

    /// delete LDB phrases
    await LDBOps.deleteAllMaps(docName: LDBDoc.enPhrases);
    await LDBOps.deleteAllMaps(docName: LDBDoc.arPhrases);

    /// reload all phrases by current langCode
    await getSetCurrentLangAndTransModel(context);

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
  TransModel _currentTransModel;
// -------------------------------------
  TransModel get translations  => _currentTransModel;
// -------------------------------------
  Future<void> getSetTranslations({
    @required BuildContext context,
    @required bool notify,
}) async {

    final TransModel _translations = await fetchPhrasesByLangCode(
        context: context,
        langCode: _currentLangCode,
    );

    _setTranslations(
        translations: _translations,
        notify: notify,
    );

  }
// -------------------------------------
  void _setTranslations({
    @required TransModel translations,
    @required bool notify,
}){
    _currentTransModel = translations;

    if (notify == true){
      notifyListeners();
    }

  }
// -----------------------------------------------------------------------------
  String getTranslatedPhraseByID(String id){

    String _translation = '...';

    if (
    _currentTransModel != null
        &&
    Mapper.canLoopList(_currentTransModel.phrases) == true
    ){

      final Phrase _phrase = _currentTransModel.phrases.singleWhere(
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

String superPhrase(BuildContext context, String id){
  final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);
  return _phraseProvider.getTranslatedPhraseByID(id);
}
