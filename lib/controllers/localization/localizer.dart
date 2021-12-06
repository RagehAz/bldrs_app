import 'dart:convert';

import 'package:bldrs/controllers/localization/lingo.dart';
import 'package:bldrs/controllers/theme/wordz.dart' as Wordz;
import 'package:bldrs/db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/db/fire/methods/paths.dart';
import 'package:bldrs/db/fire/ops/auth_ops.dart' as FireAuthOps;
import 'package:bldrs/main.dart';
import 'package:bldrs/models/secondary_models/error_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

class Localizer{
  final Locale locale;
  Map<String, String> _localizedValues;

  Localizer(this.locale);
// -----------------------------------------------------------------------------
  static Localizer of(BuildContext context) {
    return Localizations.of<Localizer>(context, Localizer);
  }
// -----------------------------------------------------------------------------
  static const LocalizationsDelegate<Localizer> delegate = _DemoLocalizationDelegate();
// -----------------------------------------------------------------------------
  Future<void> load() async {
    final String _jsonStringValues =
        await rootBundle.loadString('assets/languages/${locale.languageCode}.json');

    final Map<String, dynamic> _mappedJson = json.decode(_jsonStringValues);

    _localizedValues = _mappedJson.map((String key, value) => MapEntry(key, value.toString()));
  }
// -----------------------------------------------------------------------------
  String getTranslatedValue(String key) {
    return _localizedValues[key];
  }
// -----------------------------------------------------------------------------
  static String translate(BuildContext context, String key){
    return Localizer.of(context).getTranslatedValue(key);
  }
// -----------------------------------------------------------------------------
  static Future<void> changeAppLanguage(BuildContext context, String code) async {

    final Locale _temp = await setLocale(code);

    BldrsApp.setLocale(context, _temp);

    if (FireAuthOps.superUserID() != null){
      await Fire.updateDocField(
        context: context,
        collName: FireColl.users,
        docName: FireAuthOps.superUserID(),
        field: 'language',
        input: code,
      );

      print("changed local language and firestore.user[\'language\']  updated to $code");
    }

  }
// -----------------------------------------------------------------------------
  static Future<void> switchBetweenArabicAndEnglish(BuildContext context) async {
    Wordz.languageCode(context) == Lingo.englishLingo.code ?
    await changeAppLanguage(context, Lingo.arabicLingo.code)
        :
    await changeAppLanguage(context, Lingo.englishLingo.code);
  }
// -----------------------------------------------------------------------------
  static Future<Locale> setLocale(String languageCode) async{
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('languageCode', languageCode);

    return _locale(languageCode);
  }
// -----------------------------------------------------------------------------
  static Locale _locale(String lingoCode){
    Locale _temp;
    switch(lingoCode){
      case Lingo.englishCode:     _temp = Locale(lingoCode, 'US'); break;
      case Lingo.arabicCode:      _temp = Locale(lingoCode, 'EG'); break;
      case Lingo.spanishCode:     _temp = Locale(lingoCode, 'ES'); break;
      case Lingo.frenchCode:      _temp = Locale(lingoCode, 'FR'); break;
      case Lingo.chineseCode:     _temp = Locale(lingoCode, 'CN'); break;
      case Lingo.germanCode:      _temp = Locale(lingoCode, 'DE'); break;
      case Lingo.italianCode:     _temp = Locale(lingoCode, 'IT'); break;
      default:
        _temp = Locale(Lingo.englishLingo.code, 'US');
    }
    return _temp;
  }
// -----------------------------------------------------------------------------
  static Future<Locale> getLocale() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    final String _languageCode = _prefs.getString('languageCode') ?? Lingo.englishLingo.code;
    return _locale(_languageCode);
//  await _prefs.setString(Language_Code, languageCode);
  }
// -----------------------------------------------------------------------------
  static bool appIsArabic(BuildContext context){

    bool _isArabic;

    if (Wordz.languageCode(context) == Lingo.arabicLingo.code){
      _isArabic = true;
    }
    else {
      _isArabic = false;
    }

    return _isArabic;
  }
// -----------------------------------------------------------------------------
  static List<Locale> getSupportedLocales(){

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
// -----------------------------------------------------------------------------
  static List<LocalizationsDelegate> getLocalizationDelegates(){
    final List<LocalizationsDelegate> _localizationDelegates = <LocalizationsDelegate>[
      Localizer.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ];

    return _localizationDelegates;
  }
// -----------------------------------------------------------------------------
  static Future<String> getCountryNameByLingo({@required BuildContext context, @required String countryID, @required String lingoCode}) async {

    String _jsonStringValues;
    String _output;

    final bool _result = await tryCatchAndReturn(
      context: context,
      methodName: 'getCountryNameByLingo',
      functions: () async {

        _jsonStringValues = await rootBundle.loadString('assets/languages/${lingoCode}.json');

        },
      onError: (String error){},
    );

    if (_result == true){

      final Map<String, dynamic> _mappedJson = json.decode(_jsonStringValues);

      final Map<String, dynamic> _map = _mappedJson.map((String key, value) => MapEntry(key, value.toString()));

      _output = _map[countryID];

    }

    return _output;
  }

}
// -----------------------------------------------------------------------------
class _DemoLocalizationDelegate extends LocalizationsDelegate<Localizer> {

  const _DemoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return <String>['en', 'ar', 'es', 'fr', 'zh', 'de', 'it'].contains(locale.languageCode);
  }

  @override
  Future<Localizer> load(Locale locale) async{
    final Localizer localization = new Localizer(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate old)=> false;

}
// -----------------------------------------------------------------------------
