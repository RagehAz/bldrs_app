import 'package:bldrs/a_models/secondary_models/translation_model.dart';
import 'package:bldrs/xxx_dashboard/a_modules/translations_manager/translations/ar.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/xxx_dashboard/a_modules/translations_manager/translations/en.dart';


class PhraseProvider extends ChangeNotifier {

  /// CHANGE APP LANGUAGE

  Future<void> changeAppLanguage(BuildContext context) async {

  }

// -------------------------------------

  /// FETCHING PHRASES

// -------------------------------------
  Future<TransModel> fetchPhrasesByLangCode({
    @required BuildContext context,
    @required String languageCode,
}) async {

    /// TEMP SHIT
    if (languageCode == 'en'){
      return bldrsTranslationsEnglish;
    }

    else if (languageCode == 'ar'){
      return bldrsTranslationsArabic;
    }

    else {
      return null;
    }
  }
// -----------------------------------------------------------------------------

/// CURRENT LANGUAGE

// -------------------------------------
  String _currentLanguage = 'en';
// -------------------------------------
  String get currentLanguage => _currentLanguage;
// -------------------------------------
  Future<void> getSetCurrentLanguage(BuildContext context) async {

    const String _code = 'en';

    /// A. DETECT DEVICE LANGUAGE

    /// B. ??

    /// C. SET CURRENT LANGUAGE
    setCurrentLanguage(
      code: _code,
      notify: true,
    );

  }
// -------------------------------------
  void setCurrentLanguage({
    @required String code,
    @required bool notify,
  }){

    _currentLanguage = code;

    if (notify == true){
      notifyListeners();
    }

  }
// -----------------------------------------------------------------------------

/// CURRENT TRANSLATIONS

// -------------------------------------
  TransModel _translations;
// -------------------------------------
  TransModel get translations  => _translations;
// -------------------------------------
  Future<void> getSetTranslations({
    @required BuildContext context,
    @required String languageCode,
    @required bool notify,
}) async {

    final TransModel _translations = await fetchPhrasesByLangCode(
        context: context,
        languageCode: languageCode
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
    _translations = translations;

    if (notify == true){
      notifyListeners();
    }

  }
// -----------------------------------------------------------------------------
}
