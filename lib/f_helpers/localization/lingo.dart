import 'package:bldrs/a_models/x_utilities/map_model.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
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
class Lang {
  /// --------------------------------------------------------------------------
  const Lang({
    @required this.code,
    @required this.name,
  });
  /// --------------------------------------------------------------------------
  final String code;
  final String name;
  /// --------------------------------------------------------------------------
  static List<MapModel> getLingoNamesMapModels(List<Lang> lingos) {
    final List<MapModel> _lingosMapModels = <MapModel>[];

    if (Mapper.checkCanLoopList(lingos)) {
      for (final Lang lingo in lingos) {
        _lingosMapModels.add(MapModel(
          key: lingo.code,
          value: lingo.name,
        ));
      }
    }

    return _lingosMapModels;
  }
  // -----------------------------------------------------------------------------
  static const List<Lang> allLanguages = <Lang>[
    englishLingo,
    arabicLingo,
    // spanishLingo,
    // frenchLingo,
    // russianLingo,
    // chineseLingo,
    // germanLingo,
  ];
  // -----------------------------------------------------------------------------
  static const String englishCode = 'en';
  static const Lang englishLingo = Lang(code: englishCode, name: 'English');

  static const String arabicCode = 'ar';
  static const Lang arabicLingo = Lang(code: arabicCode, name: 'عربي');

  static const String spanishCode = 'es';
  static const Lang spanishLingo = Lang(code: spanishCode, name: 'Español');

  static const String frenchCode = 'fr';
  static const Lang frenchLingo = Lang(code: frenchCode, name: 'Française');

  // static const String russianCode = 'ru';
  // static const Lingo russianLingo = Lingo(code: russianCode, name: 'русский');

  static const String chineseCode = 'zh';
  static const Lang chineseLingo = Lang(code: chineseCode, name: '中文');

  static const String germanCode = 'de';
  static const Lang germanLingo = Lang(code: germanCode, name: 'Deutsche');

  static const String italianCode = 'it';
  static const Lang italianLingo = Lang(code: italianCode, name: 'Italiano');
  // -----------------------------------------------------------------------------
  static List<String> getAllLingoCodes() {
    final List<String> _codes = <String>[];

    for (final Lang lingo in allLanguages) {
      _codes.add(lingo.code);
    }

    return _codes;
  }
// -----------------------------------------------------------------------------
}
