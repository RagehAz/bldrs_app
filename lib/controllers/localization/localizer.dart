import 'dart:convert';
import 'package:bldrs/controllers/localization/lingo.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  Future load() async {
    String jsonStringValues =
        await rootBundle.loadString('assets/languages/${locale.languageCode}.json');

    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);

    _localizedValues = mappedJson.map((key, value) => MapEntry(key, value.toString()));
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
    Locale _temp = await setLocale(code);
    BldrsApp.setLocale(context, _temp);

    if (superUserID() != null){
      await Fire.updateDocField(
        context: context,
        collName: FireCollection.users,
        docName: superUserID(),
        field: 'language',
        input: code,
      );

      print('changed local language and firestore.user[\'language\']  updated to $code');
    }

  }
// -----------------------------------------------------------------------------
  static Future<void> switchBetweenArabicAndEnglish(BuildContext context) async {
    Wordz.languageCode(context) == Lingo.English ?
    await changeAppLanguage(context, Lingo.Arabic) :
    await changeAppLanguage(context, Lingo.English);
  }
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
  static Future<Locale> setLocale(String languageCode) async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('languageCode', languageCode);

    return _locale(languageCode);
  }
// -----------------------------------------------------------------------------
  static Locale _locale(String languageCode){
    Locale _temp;
    switch(languageCode){
      case Lingo.English:     _temp = Locale(languageCode, 'US'); break;
      case Lingo.Arabic:      _temp = Locale(languageCode, 'EG'); break;
      case Lingo.Spanish:     _temp = Locale(languageCode, 'ES'); break;
      case Lingo.French:      _temp = Locale(languageCode, 'FR'); break;
      case Lingo.Chinese:     _temp = Locale(languageCode, 'CN'); break;
      case Lingo.German:      _temp = Locale(languageCode, 'DE'); break;
      case Lingo.Italian:     _temp = Locale(languageCode, 'IT'); break;
      default:        _temp = Locale(Lingo.English, 'US');
    }
    return _temp;
  }
// -----------------------------------------------------------------------------
  static Future<Locale> getLocale() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String languageCode = _prefs.getString('languageCode') ?? Lingo.English;
    return _locale(languageCode);
//  await _prefs.setString(Language_Code, languageCode);
  }
// -----------------------------------------------------------------------------
  static bool appIsArabic(BuildContext context){
    bool _isArabic = Wordz.languageCode(context) == Lingo.Arabic ? true : false;
    return _isArabic;
  }
}
// -----------------------------------------------------------------------------
class _DemoLocalizationDelegate extends LocalizationsDelegate<Localizer> {

  const _DemoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar', 'es', 'fr', 'zh', 'de', 'it'].contains(locale.languageCode);
  }

  @override
  Future<Localizer> load(Locale locale) async{
    Localizer localization = new Localizer(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate old)=> false;

}
// -----------------------------------------------------------------------------
