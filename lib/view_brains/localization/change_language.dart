import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
// === === === === === === === === === === === === === === === === === === ===
Future<void> changeAppLanguage(BuildContext context, String code) async {
  Locale temp = await setLocale(code);
  BldrsApp.setLocale(context, temp);
}
// === === === === === === === === === === === === === === === === === === ===
Future<void> switchBetweenArabicAndEnglish(BuildContext context) async {
  Wordz.languageCode(context) == 'en' ?
  await changeAppLanguage(context, Lingo.Arabic) :
  await changeAppLanguage(context, Lingo.English);
}
// === === === === === === === === === === === === === === === === === === ===
class Lingo{
  static const String English = 'en';
  static const String Arabic = 'ar';
  static const String Spanish = 'es';
  static const String French = 'fr';
  static const String Russian = 'ru';
  static const String Chinese = 'zh';
  static const String German = 'de';
  static const String Italian = 'it';
}
// === === === === === === === === === === === === === === === === === === ===
