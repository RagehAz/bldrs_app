import 'package:bldrs/controllers/localization/change_language.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
class Namez {
  /// language code
  final String code;
  /// name in this language
  final String value;

  Namez({
    @required this.code,
    @required this.value,
  });
// -----------------------------------------------------------------------------
  Map<String,String> toMap(){
    return {
      'code' : code,
      'value' : value,
    };
  }
// -----------------------------------------------------------------------------
  static List<Map<String, dynamic>> cipherNamezz(List<Namez> namezz){
    List<Map<String, dynamic>> _namezMaps = new List();
    namezz.forEach((nm) {
      _namezMaps.add(nm.toMap());
    });
    return _namezMaps;
  }
// -----------------------------------------------------------------------------
  static Namez decipherNamezMap(Map<String, dynamic> map){
    return Namez(
      code : 'code',
      value : 'value',
    );
  }
// -----------------------------------------------------------------------------
  static List<Namez> decipherNamezzMaps(List<dynamic> maps){
    List<Namez> _namez = new List();
    maps?.forEach((map) {
      _namez.add(decipherNamezMap(map));
    });
    return _namez;
  }
// -----------------------------------------------------------------------------
  static String getNameWithCurrentLanguageFromListOfNamez(BuildContext context, List<Namez> namez){
    String _currentLanguageCode = Wordz.languageCode(context);
    String _name;

    if (namez != null && namez.length != 0){
      Namez _englishNamez = namez?.firstWhere((name) => name.code == Lingo.English, orElse: () => null);

      Namez _namezInCurrentLanguage = namez?.firstWhere((name) => name.code == _currentLanguageCode, orElse: () => null);

      _name = _namezInCurrentLanguage == null ? _englishNamez?.value : _namezInCurrentLanguage?.value;
    }

    return _name;
  }
// -----------------------------------------------------------------------------
}
