import 'dart:convert';
import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/localization/lingo.dart';
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:bldrs/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

//
// --- BEHOLD ---
//
// TO ADD NEW LANGUAGE
// 1- CREATE NEW JSON FILE
// 2- UPDATE main.dart FILE
// 3- UPDATE pubspec.yaml FILE
// 4- UPDATE language_class FILE
// 5- UPDATE demo_localization FILE
// 6- UPDATE localization_constants FILE
//
// --- TAWAKAL 3ALA ALLAH ---
//
// -----------------------------------------------------------------------------

/// check this https://pub.dev/packages/localize_and_translate
// -----------------------------------------------------------------------------
class Localizer {
// -----------------------------------------------------------------------------

  /// CONSTRUCTOR

// -------------------------------------
  Localizer(this.locale);
// -------------------------------------
  final Locale locale;
  Map<String, String> _localizedValues;
// -------------------------------------
  static Localizer of(BuildContext context) {
    return Localizations.of<Localizer>(context, Localizer);
  }
// -----------------------------------------------------------------------------

  /// DELEGATE

// -------------------------------------
  static const LocalizationsDelegate<Localizer> delegate = _DemoLocalizationDelegate();
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<LocalizationsDelegate> getLocalizationDelegates() {

    final List<LocalizationsDelegate> _localizationDelegates =
    <LocalizationsDelegate>[
      Localizer.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ];

    return _localizationDelegates;
  }
// -----------------------------------------------------------------------------

  /// INITIALIZATION

// -------------------------------------
  static Future<void> initializeLocale(ValueNotifier<Locale> locale) async {
    final Locale _gotLocale = await Localizer.getLocaleFromSharedPref();
    locale.value = _gotLocale;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> load() async {
    _localizedValues = await getJSONLangMap(langCode: locale.languageCode);
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  String getTranslatedValue(String key) {
    return _localizedValues[key];
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<Locale> getLocaleFromSharedPref() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    final String _languageCode =
        _prefs.getString('languageCode') ?? Lang.englishLingo.code;
    return _concludeLocaleByLingoCode(_languageCode);
//  await _prefs.setString(Language_Code, languageCode);
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<Locale> getSupportedLocales() {

    final List<Locale> _supportedLocales = <Locale>[
      const Locale('en', 'US'),
      const Locale('ar', 'EG'),
      const Locale('es', 'ES'),
      const Locale('fr', 'FR'),
      const Locale('zh', 'CN'),
      const Locale('de', 'DE'),
      const Locale('it', 'IT'),
    ];

    return _supportedLocales;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Locale localeResolutionCallback(Locale deviceLocale, Iterable<Locale> supportedLocales) {

    for (final Locale locale in supportedLocales) {
      if (locale.languageCode == deviceLocale.languageCode &&
          locale.countryCode == deviceLocale.countryCode) {
        return deviceLocale;
      }
    }

    return supportedLocales.first;
  }
// -----------------------------------------------------------------------------

  /// READING  LOCAL JSON

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, String>> getJSONLangMap({
    @required String langCode
  }) async {

    final String _jsonStringValues = await rootBundle
        .loadString('assets/languages/$langCode.json');

    final Map<String, dynamic> _mappedJson = json
        .decode(_jsonStringValues);

    final Map<String, String> _map = _mappedJson
        .map((String key, value) => MapEntry(key, value.toString()));

    return _map;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static String translate(BuildContext context, String key) {
    return Localizer.of(context).getTranslatedValue(key);
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<String> getTranslationFromJSONByLangCode({
    @required BuildContext context,
    @required String jsonKey,
    @required String langCode,
  }) async {

    String _jsonStringValues;
    String _output;

    final bool _result = await tryCatchAndReturnBool(
      context: context,
      methodName: 'getCountryNameByLingo',
      functions: () async {

        _jsonStringValues =
        await rootBundle.loadString('assets/languages/$langCode.json');

      },
      onError: (String error) {},
    );

    if (_result == true) {

      final Map<String, dynamic> _mappedJson = json.decode(_jsonStringValues);

      final Map<String, dynamic> _map = _mappedJson
          .map((String key, value) => MapEntry(key, value.toString()));

      _output = _map[jsonKey];
    }

    return _output;
  }
// -----------------------------------------------------------------------------

  /// LANGUAGE SWITCHING

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> changeAppLanguage(BuildContext context, String code) async {

    final Locale _temp = await setLocale(code);

    BldrsApp.setLocale(context, _temp);

    if (AuthFireOps.superUserID() != null) {
      await Fire.updateDocField(
        context: context,
        collName: FireColl.users,
        docName: AuthFireOps.superUserID(),
        field: 'language',
        input: code,
      );

      blog("changed local language and firestore.user['language']  updated to $code");
    }
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> switchBetweenArabicAndEnglish(BuildContext context) async {
    Wordz.languageCode(context) == Lang.englishLingo.code ?
    await changeAppLanguage(context, Lang.arabicLingo.code)
        :
    await changeAppLanguage(context, Lang.englishLingo.code);
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<Locale> setLocale(String languageCode) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('languageCode', languageCode);
    return _concludeLocaleByLingoCode(languageCode);
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Locale _concludeLocaleByLingoCode(String lingoCode) {
    Locale _temp;
    switch (lingoCode) {
      case Lang.englishCode:_temp = Locale(lingoCode, 'US');break;
      case Lang.arabicCode:_temp = Locale(lingoCode, 'EG');break;
      case Lang.spanishCode:_temp = Locale(lingoCode, 'ES');break;
      case Lang.frenchCode:_temp = Locale(lingoCode, 'FR');break;
      case Lang.chineseCode:_temp = Locale(lingoCode, 'CN');break;
      case Lang.germanCode:_temp = Locale(lingoCode, 'DE');break;
      case Lang.italianCode:_temp = Locale(lingoCode, 'IT');break;
      default:_temp = Locale(Lang.englishLingo.code, 'US');
    }
    return _temp;
  }
// -----------------------------------------------------------------------------

  /// CHECKERS

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static bool appIsArabic(BuildContext context) {
    bool _isArabic;

    if (Wordz.languageCode(context) == Lang.arabicLingo.code) {
      _isArabic = true;
    } else {
      _isArabic = false;
    }

    return _isArabic;
  }
// -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<String> translateLangCodeName({
    @required BuildContext context,
    @required String langCode,
  }) async {

    /// while app lang is english : langCode is ar : this should be : 'Arabic'
    final String _langNameByActiveAppLang = await getTranslationFromJSONByLangCode(
      context: context,
      langCode: langCode,
      jsonKey: 'activeLanguage',
    );

    // /// while app lang is english : langCode is ar : this should be : 'عربي'
    // final String _langNameByLangItself = await getTranslationFromJSONByLangCode(
    //   context: context,
    //   langCode: langCode,
    //   jsonKey: 'languageName',
    // );

    return '( $_langNameByActiveAppLang ) ';
  }
}
// -----------------------------------------------------------------------------
class _DemoLocalizationDelegate extends LocalizationsDelegate<Localizer> {
  const _DemoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return <String>['en', 'ar', 'es', 'fr', 'zh', 'de', 'it']
        .contains(locale.languageCode);
  }

  @override
  Future<Localizer> load(Locale locale) async {
    final Localizer localization = Localizer(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate old) => false;
}
// -----------------------------------------------------------------------------
