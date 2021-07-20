import 'package:bldrs/controllers/localization/localization_constants.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/main.dart';
import 'package:flutter/material.dart';


// ‎ ‎ ‎ ‎
class Lingo{
  static const String English = 'en';
  static const String Arabic = 'ar';
  static const String Spanish = 'es';
  static const String French = 'fr';
  static const String Russian = 'ru';
  static const String Chinese = 'zh';
  static const String German = 'de';
  static const String Italian = 'it';

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
    Wordz.languageCode(context) == 'en' ?
    await changeAppLanguage(context, Lingo.Arabic) :
    await changeAppLanguage(context, Lingo.English);
  }
// -----------------------------------------------------------------------------

}
