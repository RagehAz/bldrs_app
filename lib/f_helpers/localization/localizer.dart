import 'dart:convert';

import 'package:basics/bldrs_theme/classes/langs.dart';
import 'package:basics/helpers/classes/checks/error_helpers.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:fire/super_fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/f_helpers/localization/lingo.dart';
import 'package:bldrs/f_helpers/theme/words.dart';
import 'package:bldrs/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:basics/ldb/methods/ldb_ops.dart';

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
  final Locale? locale;
  Map<String, String>? _localizedValues;
  // --------------------
  static Localizer? of(BuildContext context) {
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
    required ValueNotifier<Locale?> locale,
    required bool mounted,
  }) async {

    final Locale? _locale = await Localizer.getCurrentLocaleFromLDB();

    setNotifier(
        notifier: locale,
        mounted: mounted,
        value: _locale,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> load() async {
    _localizedValues = await getJSONLangMap(langCode: locale?.languageCode);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  String? getTranslatedValue(String key) {
    return _localizedValues?[key];
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Locale?> getCurrentLocaleFromLDB() async {
    final String? _langCode = await readLDBLangCode();
    final String? _languageCode = _langCode ?? Lang.englishLingo.code;
    return _concludeLocaleByLingoCode(_languageCode);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> readLDBLangCode() async {
    final String? _langCode = await LDBOps.readField(
      id: 'userSelectedLang',
      docName: LDBDoc.langCode,
      fieldName: 'code',
      primaryKey: 'id',
    );
    return _langCode;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _setLDBLangCode({
    required String langCode,
  }) async {

    await LDBOps.insertMap(
      docName: LDBDoc.langCode,
      primaryKey: 'id',
      input: {
        'id': 'userSelectedLang',
        'code': langCode,
      },
    );

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
  static List<String> supportedLangCodes = <String>[
    'en',
    'ar',
    'es',
    'fr',
    'zh',
    'de',
    'it',
  ];
  // --------------------
  /// TESTED : WORKS PERFECT
  static Locale? localeResolutionCallback(Locale? deviceLocale, Iterable<Locale> supportedLocales) {

    for (final Locale locale in supportedLocales) {
      if (locale.languageCode == deviceLocale?.languageCode &&
          locale.countryCode == deviceLocale?.countryCode) {
        return deviceLocale;
      }
    }

    return supportedLocales.first;
  }
  // -----------------------------------------------------------------------------

  /// READING  LOCAL JSON

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, String>?> getJSONLangMap({
    required String? langCode
  }) async {

    Map<String, String>? _output;

    final String? _langFilePath = BldrsThemeLangs.getLangFilePath(
      langCode: langCode,
    );

    if (_langFilePath == null){
      return null;
    }

    await tryAndCatch(
      invoker: 'getJSONLangMap',
      functions: () async {

        final String _jsonStringValues = await rootBundle.loadString(_langFilePath);

        final Map<String, dynamic> _mappedJson = json.decode(_jsonStringValues);

        _output = _mappedJson.map((String key, value) => MapEntry(key, value.toString()));

        },
    );

    return _output ?? {};
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? translate(String key) {
    return Localizer.of(getMainContext())?.getTranslatedValue(key);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> getTranslationFromJSONByLangCode({
    required String jsonKey,
    required String langCode,
  }) async {

    String? _jsonStringValues;
    String? _output;

    final bool _result = await tryCatchAndReturnBool(
      invoker: 'getCountryNameByLingo',
      functions: () async {

        final String? _langFilePath = BldrsThemeLangs.getLangFilePath(
          langCode: langCode,
        );

        if (_langFilePath != null){
          _jsonStringValues = await rootBundle.loadString(_langFilePath);
        }


      },
      onError: (String error) {},
    );

    if (_result == true && _jsonStringValues != null) {

      final Map<String, dynamic> _mappedJson = json.decode(_jsonStringValues!);

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
  static Future<void> changeAppLanguage({
    required BuildContext context,
    required String? code,
  }) async {

    if (code != null){

      await _setLDBLangCode(
        langCode: code,
      );

      final Locale? _temp = await setLocale(code);

      BldrsAppStarter.setLocale(context, _temp);

      final UserModel? _user = UsersProvider.proGetMyUserModel(
        context: context,
        listen: false,
      );

      if (Authing.userIsSignedUp(_user?.signInMethod) == true) {
        await Fire.updateDocField(
          coll: FireColl.users,
          doc: Authing.getUserID()!,
          field: 'language',
          input: code,
        );

        blog("changed local language and firestore.user['language']  updated to $code");
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> switchBetweenArabicAndEnglish(BuildContext context) async {

    if (getCurrentLangCode() == Lang.englishLingo.code){
      await changeAppLanguage(
          context: context,
          code: Lang.arabicLingo.code,
      );
    }

    else {
      await changeAppLanguage(
          context: context,
          code: Lang.englishLingo.code,
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Locale?> setLocale(String languageCode) async {

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
  static Locale? _concludeLocaleByLingoCode(String? lingoCode) {

    if (lingoCode == null){
      return null;
    }

    switch (lingoCode) {
      case Lang.englishCode:  return Locale(lingoCode, 'US');
      case Lang.arabicCode:   return Locale(lingoCode, 'EG');
      case Lang.spanishCode:  return Locale(lingoCode, 'ES');
      case Lang.frenchCode:   return Locale(lingoCode, 'FR');
      case Lang.chineseCode:  return Locale(lingoCode, 'CN');
      case Lang.germanCode:   return Locale(lingoCode, 'DE');
      case Lang.italianCode:  return Locale(lingoCode, 'IT');
      default:                return Locale(Lang.englishLingo.code, 'US');
    }

  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool appIsArabic(BuildContext context) {

    if (getCurrentLangCode() == Lang.arabicLingo.code) {
      return true;
    }

    else {
      return false;
    }

  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<String> translateLangCodeName({
    required String langCode,
  }) async {

    /// while app lang is english : langCode is ar : this should be : 'Arabic'
    final String? _langNameByActiveAppLang = await getTranslationFromJSONByLangCode(
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
  static String getCurrentLangCode(){
    return Words.languageCode();
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
