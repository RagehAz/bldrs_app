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

  Lingo ({
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
    List<Map<String, String>> _maps = new List();

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
  static List<Lingo> allLanguages(){
    return <Lingo>[
      Lingo(code: 'en' , name: 'English'),
      Lingo(code: 'ar' , name: 'عربي'),
      Lingo(code: 'es' , name: 'Español'),
      Lingo(code: 'fr' , name: 'Française'),
      Lingo(code: 'zh' , name: '中文'),
      Lingo(code: 'de' , name: 'Deutsche'),
      Lingo(code: 'it' , name: 'Italiano'),
    ];
  }
// -----------------------------------------------------------------------------
  static const String English = 'en';
  static const String Arabic = 'ar';
  static const String Spanish = 'es';
  static const String French = 'fr';
  static const String Russian = 'ru';
  static const String Chinese = 'zh';
  static const String German = 'de';
  static const String Italian = 'it';
// -----------------------------------------------------------------------------

}
