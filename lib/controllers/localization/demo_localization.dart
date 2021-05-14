import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
class DemoLocalization{
  final Locale locale;
  Map<String, String> _localizedValues;

  DemoLocalization(this.locale);
// -----------------------------------------------------------------------------
  static DemoLocalization of(BuildContext context) {
    return Localizations.of<DemoLocalization>(context, DemoLocalization);
  }
// -----------------------------------------------------------------------------
  static const LocalizationsDelegate<DemoLocalization> delegate = _DemoLocalizationDelegate();
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
}
// -----------------------------------------------------------------------------
class _DemoLocalizationDelegate extends LocalizationsDelegate<DemoLocalization> {

  const _DemoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar', 'es', 'fr', 'zh', 'de', 'it'].contains(locale.languageCode);
  }

  @override
  Future<DemoLocalization> load(Locale locale) async{
    DemoLocalization localization = new DemoLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate old)=> false;

}
// -----------------------------------------------------------------------------
