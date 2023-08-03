import 'dart:convert';

import 'package:basics/bldrs_theme/classes/langs.dart';
import 'package:basics/helpers/classes/checks/error_helpers.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/ldb/methods/ldb_ops.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/main.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// -----------------------------------------------------------------------------

  /// LANG TIERS

// --------------------
/// ‎ ‎ ‎ ‎
// --------------------
/// A:-
/// AR:Arabic, ES:Spanish, FR:French, ZH:Chinese, DE:German, IT:Italian,
/// B:-
/// HI:Hindi, RU:Russian, TR:Turkish, PT:Portuguese
/// C:-
/// ID:Indonesian, BN:Bengali, SW:Swahili, FA: Farsi, JA:Japanese
/// D:-
/// UK:Ukrainian, PL:Polish, NL:Dutch, MS:Malay, PA:Punjabi,
/// E:-
/// TL:Tagalog, TE:Telugu, MR:Marathi, KO:Korean,
// -----------------------------------------------------------------------------
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
    required BuildContext context,
    required ValueNotifier<Locale?> locale,
    required bool mounted,
  }) async {

    final Locale? _locale = await Localizer._getCurrentLocaleFromLDB();

    blog('LDB _locale : ${_locale?.languageCode}');

    if (_locale != null){

      setNotifier(
        notifier: locale,
        mounted: mounted,
        value: _locale,
      );

      await _setLDBLangCode(langCode: _locale.languageCode);

      final Locale? _temp = _concludeLocaleByLingoCode(_locale.languageCode);

      BldrsAppStarter.setLocale(context, _temp);

      UiProvider.proSetCurrentLangCode(
          context: getMainContext(),
          langCode: _locale.languageCode,
          notify: true,
      );

    }

  }
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
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _load() async {
    _localizedValues = await getLangMap(langCode: locale?.languageCode);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  String? _getTranslatedValue(String key) {
    return _localizedValues?[key];
  }
  // -----------------------------------------------------------------------------

  /// SUPPORTED LANGS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Locale> getSupportedLocales() {
    return <Locale>[
      const Locale('en', 'US'),
      const Locale('ar', 'EG'),
      const Locale('es', 'ES'),
      const Locale('it', 'IT'),
      const Locale('de', 'DE'),
      const Locale('fr', 'FR'),
      const Locale('zh', 'CN'),
    ];
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> supportedLangCodes = <String>[
    'en',
    'ar',
    'es',
    'it',
    'de',
    'fr',
    'zh',
  ];
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getLangNameByCode(String langCode){

    switch(langCode){
      case 'en': return 'English';
      case 'ar': return 'عربي';
      case 'es': return 'Español';
      case 'it': return 'Italiano';
      case 'de': return 'Deutsche';
      case 'fr': return 'Français';
      case 'zh': return '中文';
      // case "ru": return "русский";
      default: return '';
    }

  }
  // -----------------------------------------------------------------------------

  /// LANG CODE IN LDB

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
  static Future<Locale?> _getCurrentLocaleFromLDB() async {
    final String? _langCode = await readLDBLangCode();
    final String _languageCode = _langCode ?? 'en';
    return _concludeLocaleByLingoCode(_languageCode);
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
  // -----------------------------------------------------------------------------

  /// READING  LOCAL JSON

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, String>?> getLangMap({
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
  static String? translate(String phid) {
    return Localizer.of(getMainContext())?._getTranslatedValue(phid);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> translateByLangCode({
    required String? phid,
    required String? langCode,
  }) async {

    String? _jsonStringValues;
    String? _output;

    if (phid != null){

      final bool _result = await tryCatchAndReturnBool(
        invoker: 'translateByLangCode',
        functions: () async {

          final String? _langFilePath = BldrsThemeLangs.getLangFilePath(
            langCode: langCode ?? 'en',
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

        _output = _map[phid];
      }

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

      final Locale? _temp  = _concludeLocaleByLingoCode(code);

      BldrsAppStarter.setLocale(context, _temp);

      UiProvider.proSetCurrentLangCode(
        context: context,
        langCode: code,
        notify: true,
      );

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
  // /// TESTED : WORKS PERFECT
  // static Future<Locale?> _setLocale(String languageCode) async {
  //
  //   await LDBOps.insertMap(
  //       docName: LDBDoc.langCode,
  //       primaryKey: LDBDoc.getPrimaryKey(LDBDoc.langCode),
  //       input: {
  //         'id': LDBDoc.langCode,
  //         LDBDoc.langCode: languageCode,
  //       },
  //   );
  //
  //   return _concludeLocaleByLingoCode(languageCode);
  // }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Locale? _concludeLocaleByLingoCode(String? langCode) {

    if (langCode == null){
      return null;
    }

    switch (langCode) {
      case 'en':    return const Locale('en', 'US');
      case 'ar':    return const Locale('ar', 'EG');
      case 'es':    return const Locale('es', 'ES');
      case 'it':    return const Locale('it', 'IT');
      case 'de':    return const Locale('de', 'DE');
      case 'fr':    return const Locale('fr', 'FR');
      case 'zh':    return const Locale('zh', 'CN');
      default:      return const Locale('en', 'US');
    }

  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  static String getCurrentLangCode(){
    return Localizer.translate('phid_languageCode')!;
  }
  // --------------------
  static String activeLanguage () => Localizer.translate('phid_activeLanguage')!;
  static String headlineFont () => Localizer.translate('phid_headlineFont')!;
  static String bodyFont () => Localizer.translate('phid_bodyFont')!;
  static String languageName () => Localizer.translate('phid_languageName')!;
  static String textDirection () => Localizer.translate('textDirection')!;
  // --------------------
}
//---------------------
class _DemoLocalizationDelegate extends LocalizationsDelegate<Localizer> {
  // -----------------------------------------------------------------------------
  const _DemoLocalizationDelegate();
  // --------------------
  @override
  bool isSupported(Locale locale) {
    return Localizer.supportedLangCodes.contains(locale.languageCode);
  }
  // --------------------
  @override
  Future<Localizer> load(Locale locale) async {
    final Localizer localization = Localizer(locale);
    await localization._load();
    return localization;
  }
  // --------------------
  @override
  bool shouldReload(LocalizationsDelegate old) => true;
  // -----------------------------------------------------------------------------
}
// -----------------------------------------------------------------------------
String? getWord(String? phid){
  if (phid == null){
    return null;
  }
  else {
    return Localizer.translate(phid);
  }
}
//---------------------
List<String> getWords(List<String> phids){
  final List<String> _output = <String>[];

  if (Mapper.checkCanLoopList(phids) == true){

    for (final String phid in phids){
      final String? _trans = getWord(phid);
      if (_trans != null){
        _output.add(_trans);
      }
    }

  }
  return _output;



}
//---------------------
Verse? getVerse(String? phid, {
  Casing? casing,
}){

  if (phid == null){
    return null;
  }

  else {
    return Verse(
      id: getWord(phid),
      translate: false,
      casing: casing,
    );
  }

}
// -----------------------------------------------------------------------------

/// SUPER SCRIPT - SUB SCRIPT

// --------------------
/*
// unicode_map = {
// // #           superscript     subscript
// '0'        : ('\u2070',   '\u2080'      ),
// '1'        : ('\u00B9',   '\u2081'      ),
// '2'        : ('\u00B2',   '\u2082'      ),
// '3'        : ('\u00B3',   '\u2083'      ),
// '4'        : ('\u2074',   '\u2084'      ),
// '5'        : ('\u2075',   '\u2085'      ),
// '6'        : ('\u2076',   '\u2086'      ),
// '7'        : ('\u2077',   '\u2087'      ),
// '8'        : ('\u2078',   '\u2088'      ),
// '9'        : ('\u2079',   '\u2089'      ),
// 'a'        : ('\u1d43',   '\u2090'      ),
// 'b'        : ('\u1d47',   '?'           ),
// 'c'        : ('\u1d9c',   '?'           ),
// 'd'        : ('\u1d48',   '?'           ),
// 'e'        : ('\u1d49',   '\u2091'      ),
// 'f'        : ('\u1da0',   '?'           ),
// 'g'        : ('\u1d4d',   '?'           ),
// 'h'        : ('\u02b0',   '\u2095'      ),
// 'i'        : ('\u2071',   '\u1d62'      ),
// 'j'        : ('\u02b2',   '\u2c7c'      ),
// 'k'        : ('\u1d4f',   '\u2096'      ),
// 'l'        : ('\u02e1',   '\u2097'      ),
// 'm'        : ('\u1d50',   '\u2098'      ),
// 'n'        : ('\u207f',   '\u2099'      ),
// 'o'        : ('\u1d52',   '\u2092'      ),
// 'p'        : ('\u1d56',   '\u209a'      ),
// 'q'        : ('?',        '?'           ),
// 'r'        : ('\u02b3',   '\u1d63'      ),
// 's'        : ('\u02e2',   '\u209b'      ),
// 't'        : ('\u1d57',   '\u209c'      ),
// 'u'        : ('\u1d58',   '\u1d64'      ),
// 'v'        : ('\u1d5b',   '\u1d65'      ),
// 'w'        : ('\u02b7',   '?'           ),
// 'x'        : ('\u02e3',   '\u2093'      ),
// 'y'        : ('\u02b8',   '?'           ),
// 'z'        : ('?',        '?'           ),
// 'A'        : ('\u1d2c',   '?'           ),
// 'B'        : ('\u1d2e',   '?'           ),
// 'C'        : ('?',        '?'           ),
// 'D'        : ('\u1d30',   '?'           ),
// 'E'        : ('\u1d31',   '?'           ),
// 'F'        : ('?',        '?'           ),
// 'G'        : ('\u1d33',   '?'           ),
// 'H'        : ('\u1d34',   '?'           ),
// 'I'        : ('\u1d35',   '?'           ),
// 'J'        : ('\u1d36',   '?'           ),
// 'K'        : ('\u1d37',   '?'           ),
// 'L'        : ('\u1d38',   '?'           ),
// 'M'        : ('\u1d39',   '?'           ),
// 'N'        : ('\u1d3a',   '?'           ),
// 'O'        : ('\u1d3c',   '?'           ),
// 'P'        : ('\u1d3e',   '?'           ),
// 'Q'        : ('?',        '?'           ),
// 'R'        : ('\u1d3f',   '?'           ),
// 'S'        : ('?',        '?'           ),
// 'T'        : ('\u1d40',   '?'           ),
// 'U'        : ('\u1d41',   '?'           ),
// 'V'        : ('\u2c7d',   '?'           ),
// 'W'        : ('\u1d42',   '?'           ),
// 'X'        : ('?',        '?'           ),
// 'Y'        : ('?',        '?'           ),
// 'Z'        : ('?',        '?'           ),
// '+'        : ('\u207A',   '\u208A'      ),
// '-'        : ('\u207B',   '\u208B'      ),
// '='        : ('\u207C',   '\u208C'      ),
// '('        : ('\u207D',   '\u208D'      ),
// ')'        : ('\u207E',   '\u208E'      ),
// ':alpha'   : ('\u1d45',   '?'           ),
// ':beta'    : ('\u1d5d',   '\u1d66'      ),
// ':gamma'   : ('\u1d5e',   '\u1d67'      ),
// ':delta'   : ('\u1d5f',   '?'           ),
// ':epsilon' : ('\u1d4b',   '?'           ),
// ':theta'   : ('\u1dbf',   '?'           ),
// ':iota'    : ('\u1da5',   '?'           ),
// ':pho'     : ('?',        '\u1d68'      ),
// ':phi'     : ('\u1db2',   '?'           ),
// ':psi'     : ('\u1d60',   '\u1d69'      ),
// ':chi'     : ('\u1d61',   '\u1d6a'      ),
// ':coffee'  : ('\u2615',   '\u2615'      )
// }

// ⁰ ¹ ² ³ ⁴ ⁵ ⁶ ⁷ ⁸ ⁹ ⁺ ⁻ ⁼ ⁽ ⁾ ₀ ₁ ₂ ₃ ₄ ₅ ₆ ₇ ₈ ₉ ₊ ₋ ₌ ₍ ₎
// ᵃ ᵇ ᶜ ᵈ ᵉ ᶠ ᵍ ʰ ⁱ ʲ ᵏ ˡ ᵐ ⁿ ᵒ ᵖ ʳ ˢ ᵗ ᵘ ᵛ ʷ ˣ ʸ ᶻ
// ᴬ ᴮ ᴰ ᴱ ᴳ ᴴ ᴵ ᴶ ᴷ ᴸ ᴹ ᴺ ᴼ ᴾ ᴿ ᵀ ᵁ ⱽ ᵂ
// ₐ ₑ ₕ ᵢ ⱼ ₖ ₗ ₘ ₙ ₒ ₚ ᵣ ₛ ₜ ᵤ ᵥ ₓ ᵅ ᵝ ᵞ ᵟ ᵋ ᶿ ᶥ ᶲ ᵠ ᵡ ᵦ ᵧ ᵨ ᵩ ᵪ
// 1ˢᵗ _ 2ⁿᵈ _ 3ʳᵈ _ 4ᵗʰ _ n² _ n³ - m² - م²
 */
// -----------------------------------------------------------------------------
