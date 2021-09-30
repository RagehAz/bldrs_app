import 'package:flutter/material.dart';

/// --- BEHOLD ---

// TO ADD NEW LANGUAGE
// 1- CREATE NEW JSON FILE
// 2- UPDATE main.dart FILE
// 3- UPDATE pubspec.yaml FILE
// 4- UPDATE language_class FILE
// 5- UPDATE demo_localization FILE
// 6- UPDATE localization_constants FILE

/// --- TAWAKAL 3ALA ALLAH ---

// ‎ ‎ ‎ ‎
class Lingo{
  final String code;
  final String name;

  const Lingo ({
    @required this.code,
    @required this.name,
  });
// -----------------------------------------------------------------------------
  static Map<String, String> cipherLingoToMap(Lingo language){
    return
        {
          'id' : language.code,
          'value' : language.name,
        };
  }
// -----------------------------------------------------------------------------
  static List<Map<String, String>> cipherLingosToMaps(List<Lingo> lingos){
    List<Map<String, String>> _maps = <Map<String, String>>[];

    for (Lingo lingo in lingos){
      _maps.add(cipherLingoToMap(lingo));
    }

    return _maps;
  }
// -----------------------------------------------------------------------------
  static Lingo decipherFromMap(Map<String, String> map){
    Lingo _lingo;
    if (map != null){
      _lingo = Lingo(
        code: map['code'],
        name: map['name'],
      );
    }

    return _lingo;
  }
// -----------------------------------------------------------------------------
  static const List<Lingo> allLanguages = <Lingo>[
      englishLingo,
      arabicLingo,
      spanishLingo,
      frenchLingo,
      russianLingo,
      chineseLingo,
      germanLingo,
    ];
// -----------------------------------------------------------------------------
  static const String englishCode = 'en';
  static const Lingo englishLingo = const Lingo(code: englishCode, name: 'English');

  static const String arabicCode = 'ar';
  static const Lingo arabicLingo = const Lingo(code: arabicCode, name: 'عربي');

  static const String spanishCode = 'ar';
  static const Lingo spanishLingo = const Lingo(code: spanishCode, name: 'Español');

  static const String frenchCode = 'fr';
  static const Lingo frenchLingo = const Lingo(code: frenchCode, name: 'Française');

  static const String russianCode = 'ru';
  static const Lingo russianLingo = const Lingo(code: russianCode, name: 'русский');

  static const String chineseCode = 'zh';
  static const Lingo chineseLingo = const Lingo(code: chineseCode, name: '中文');

  static const String germanCode = 'de';
  static const Lingo germanLingo = const Lingo(code: germanCode, name: 'Deutsche');

  static const String italianCode = 'it';
  static const Lingo italianLingo = const Lingo(code: italianCode, name: 'Italiano');
// -----------------------------------------------------------------------------

}
