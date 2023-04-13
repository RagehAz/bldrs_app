import 'dart:convert';

import 'package:bldrs/super_fire/super_fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/f_helpers/localization/lingo.dart';
import 'package:bldrs/f_helpers/theme/words.dart';
import 'package:bldrs/main.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ldb/ldb.dart';

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

class Localizer {
  // -----------------------------------------------------------------------------

  /// CONSTRUCTOR

  // --------------------
  Localizer(this.locale);
  // --------------------
  final Locale locale;
  Map<String, String> _localizedValues;
  // --------------------
  static Localizer of(BuildContext context) {
    return Localizations.of<Localizer>(context, Localizer);
  }
  // -----------------------------------------------------------------------------

  /// DELEGATE

  // --------------------
  static const LocalizationsDelegate<Localizer> delegate = _DemoLocalizationDelegate();
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<LocalizationsDelegate> getLocalizationDelegates() {

    return <LocalizationsDelegate>[
      Localizer.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ];

  }
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  static Future<void> initializeLocale({
    @required ValueNotifier<Locale> locale,
    @required bool mounted,
  }) async {

    final Locale _locale = await Localizer.getCurrentLocaleFromLDB();

    setNotifier(
        notifier: locale,
        mounted: mounted,
        value: _locale,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> load() async {
    _localizedValues = await getJSONLangMap(langCode: locale.languageCode);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  String getTranslatedValue(String key) {
    return _localizedValues[key];
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Locale> getCurrentLocaleFromLDB() async {
    final String _langCode = await LDBOps.readField(
      id: LDBDoc.langCode,
      docName: LDBDoc.langCode,
      fieldName: LDBDoc.langCode,
      primaryKey: LDBDoc.getPrimaryKey(LDBDoc.langCode),
    );
    final String _languageCode = _langCode ?? Lang.englishLingo.code;
    return _concludeLocaleByLingoCode(_languageCode);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Locale> getSupportedLocales() {
    return <Locale>[
      const Locale('en', 'US'),
      const Locale('ar', 'EG'),
      const Locale('es', 'ES'),
      const Locale('fr', 'FR'),
      const Locale('zh', 'CN'),
      const Locale('de', 'DE'),
      const Locale('it', 'IT'),
    ];
  }
  // --------------------
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

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, String>> getJSONLangMap({
    @required String langCode
  }) async {

    final String _langFilePath = BldrsThemeLangs.getLangFilePath(
      langCode: langCode,
    );

    final String _jsonStringValues = await rootBundle.loadString(_langFilePath);

    final Map<String, dynamic> _mappedJson = json.decode(_jsonStringValues);

    return _mappedJson.map((String key, value) => MapEntry(key, value.toString()));
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String translate(BuildContext context, String key) {
    return Localizer.of(context).getTranslatedValue(key);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String> getTranslationFromJSONByLangCode({
    @required String jsonKey,
    @required String langCode,
  }) async {

    String _jsonStringValues;
    String _output;

    final bool _result = await tryCatchAndReturnBool(
      invoker: 'getCountryNameByLingo',
      functions: () async {

        final String _langFilePath = BldrsThemeLangs.getLangFilePath(
          langCode: langCode,
        );

        _jsonStringValues = await rootBundle.loadString(_langFilePath);

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

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> changeAppLanguage(BuildContext context, String code) async {

    final Locale _temp = await setLocale(code);

    BldrsAppStarter.setLocale(context, _temp);

    if (Authing.getUserID() != null) {
      await Fire.updateDocField(
        collName: FireColl.users,
        docName: Authing.getUserID(),
        field: 'language',
        input: code,
      );

      blog("changed local language and firestore.user['language']  updated to $code");
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> switchBetweenArabicAndEnglish(BuildContext context) async {

    if (getCurrentLangCode(context) == Lang.englishLingo.code){
      await changeAppLanguage(context, Lang.arabicLingo.code);
    }

    else {
      await changeAppLanguage(context, Lang.englishLingo.code);
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Locale> setLocale(String languageCode) async {

    await LDBOps.insertMap(
        docName: LDBDoc.langCode,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.langCode),
        input: {
          'id': LDBDoc.langCode,
          LDBDoc.langCode: languageCode,
        },
    );

    return _concludeLocaleByLingoCode(languageCode);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Locale _concludeLocaleByLingoCode(String lingoCode) {

    switch (lingoCode) {
      case Lang.englishCode:  return Locale(lingoCode, 'US');break;
      case Lang.arabicCode:   return Locale(lingoCode, 'EG');break;
      case Lang.spanishCode:  return Locale(lingoCode, 'ES');break;
      case Lang.frenchCode:   return Locale(lingoCode, 'FR');break;
      case Lang.chineseCode:  return Locale(lingoCode, 'CN');break;
      case Lang.germanCode:   return Locale(lingoCode, 'DE');break;
      case Lang.italianCode:  return Locale(lingoCode, 'IT');break;
      default:                return Locale(Lang.englishLingo.code, 'US');
    }

  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool appIsArabic(BuildContext context) {

    if (getCurrentLangCode(context) == Lang.arabicLingo.code) {
      return true;
    }

    else {
      return false;
    }

  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<String> translateLangCodeName({
    @required String langCode,
  }) async {

    /// while app lang is english : langCode is ar : this should be : 'Arabic'
    final String _langNameByActiveAppLang = await getTranslationFromJSONByLangCode(
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
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  static String getCurrentLangCode(BuildContext context){
    return Words.languageCode(context);
  }
  // -----------------------------------------------------------------------------
}

class _DemoLocalizationDelegate extends LocalizationsDelegate<Localizer> {
  // -----------------------------------------------------------------------------
  const _DemoLocalizationDelegate();
  // --------------------
  @override
  bool isSupported(Locale locale) {
    return <String>['en', 'ar', 'es', 'fr', 'zh', 'de', 'it']
        .contains(locale.languageCode);
  }
  // --------------------
  @override
  Future<Localizer> load(Locale locale) async {
    final Localizer localization = Localizer(locale);
    await localization.load();
    return localization;
  }
  // --------------------
  @override
  bool shouldReload(LocalizationsDelegate old) => false;
  // -----------------------------------------------------------------------------
}
