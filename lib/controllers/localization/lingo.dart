import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/models/secondary_models/map_model.dart';
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
  /// lang codes tiers
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

  final String code;
  final String name;

  const Lingo ({
    @required this.code,
    @required this.name,
  });
// -----------------------------------------------------------------------------
  static List<MapModel> getLingoNamesMapModels(List<Lingo> lingos){
    final List<MapModel> _lingosMapModels = <MapModel>[];

    if (Mapper.canLoopList(lingos)){

      lingos.forEach((lingo) {

        _lingosMapModels.add(
            MapModel(
                key: lingo.code,
                value: lingo.name,
            )
        );

      });

    }

    return _lingosMapModels;
  }
// -----------------------------------------------------------------------------
  static const List<Lingo> allLanguages = <Lingo>[
      englishLingo,
      arabicLingo,
      spanishLingo,
      frenchLingo,
      // russianLingo,
      chineseLingo,
      germanLingo,
    ];
// -----------------------------------------------------------------------------
  static const String englishCode = 'en';
  static const Lingo englishLingo = const Lingo(code: englishCode, name: 'English');

  static const String arabicCode = 'ar';
  static const Lingo arabicLingo = const Lingo(code: arabicCode, name: 'عربي');

  static const String spanishCode = 'es';
  static const Lingo spanishLingo = const Lingo(code: spanishCode, name: 'Español');

  static const String frenchCode = 'fr';
  static const Lingo frenchLingo = const Lingo(code: frenchCode, name: 'Française');

  // static const String russianCode = 'ru';
  // static const Lingo russianLingo = const Lingo(code: russianCode, name: 'русский');

  static const String chineseCode = 'zh';
  static const Lingo chineseLingo = const Lingo(code: chineseCode, name: '中文');

  static const String germanCode = 'de';
  static const Lingo germanLingo = const Lingo(code: germanCode, name: 'Deutsche');

  static const String italianCode = 'it';
  static const Lingo italianLingo = const Lingo(code: italianCode, name: 'Italiano');
// -----------------------------------------------------------------------------
  static List<String> getAllLingoCodes(){
    final List<String> _codes = <String>[];

    for (Lingo lingo in allLanguages){
      _codes.add(lingo.code);
    }

    return _codes;
  }
// -----------------------------------------------------------------------------
}
