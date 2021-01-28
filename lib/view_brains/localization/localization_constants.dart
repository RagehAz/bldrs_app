import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'demo_localization.dart';

// === === === === === === === === === === === === === === === === === === ===
/// --- BEHOLD ---
///
/// TO ADD NEW LANGUAGE
/// 1- CREATE NEW JSON FILE
/// 2- UPDATE main.dart FILE
/// 3- UPDATE pubspec.yaml FILE
/// 4- UPDATE language_class FILE
/// 5- UPDATE demo_localization FILE
/// 6- UPDATE localization_constants FILE
///
/// --- TAWAKAL 3ALA ALLAH ---
///
String translate(BuildContext context, String key){
  return DemoLocalization.of(context).getTranslatedValue(key);
}
// === === === === === === === === === === === === === === === === === === ===
const String English = 'en';
const String Arabic = 'ar';
const String Spanish = 'es';
const String French = 'fr';
const String Russian = 'ru';
const String Chinese = 'zh';
const String German = 'de';
const String Italian = 'it';
const String Language_Code = 'languageCode';
// === === === === === === === === === === === === === === === === === === ===
Future<Locale> setLocale(String languageCode) async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
 await _prefs.setString(Language_Code, languageCode);

 return _locale(languageCode);
}
// === === === === === === === === === === === === === === === === === === ===
Locale _locale(String languageCode){
    Locale _temp;
    switch(languageCode){
      case English:   _temp = Locale(languageCode, 'US'); break;
      case Arabic:    _temp = Locale(languageCode, 'EG'); break;
      case Spanish:   _temp = Locale(languageCode, 'ES'); break;
      case French:    _temp = Locale(languageCode, 'FR'); break;
      case Chinese:   _temp = Locale(languageCode, 'CN'); break;
      case German:   _temp = Locale(languageCode, 'DE'); break;
      case Italian:   _temp = Locale(languageCode, 'IT'); break;
      default:        _temp = Locale(English, 'US');
    }
    return _temp;
}
// === === === === === === === === === === === === === === === === === === ===
Future<Locale> getLocale() async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(Language_Code) ?? English;
  return _locale(languageCode);
//  await _prefs.setString(Language_Code, languageCode);
}
// === === === === === === === === === === === === === === === === === === ===
