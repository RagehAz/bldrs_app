import 'package:bldrs/controllers/localization/change_language.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
class Namez{
  final String id;
  final List<Name> names;

  Namez({
    @required this.id,
    @required this.names,
});

}
// -----------------------------------------------------------------------------
class Name {
  /// language code
  final String code;

  /// name in this language
  final String value;

  Name({
    @required this.code,
    @required this.value,
  });
// -----------------------------------------------------------------------------
  Map<String, String> toMap() {
    return {
      'code': code,
      'value': value,
    };
  }
// -----------------------------------------------------------------------------
  static List<Map<String, dynamic>> cipherNamezz(List<Name> namezz) {
    List<Map<String, dynamic>> _namezMaps = new List();
    namezz.forEach((nm) {
      _namezMaps.add(nm.toMap());
    });
    return _namezMaps;
  }
// -----------------------------------------------------------------------------
  static Name decipherNamezMap(Map<String, dynamic> map) {
    return Name(
      code: 'code',
      value: 'value',
    );
  }
// -----------------------------------------------------------------------------
  static List<Name> decipherNamezzMaps(List<dynamic> maps) {
    List<Name> _namez = new List();
    maps?.forEach((map) {
      _namez.add(decipherNamezMap(map));
    });
    return _namez;
  }
// -----------------------------------------------------------------------------
  static String getNameWithCurrentLanguageFromListOfNames(BuildContext context,
      List<Name> namez) {
    String _currentLanguageCode = Wordz.languageCode(context);
    String _name;

    if (namez != null && namez.length != 0) {
      Name _englishNamez = namez?.firstWhere((name) =>
      name.code == Lingo.English, orElse: () => null);

      Name _namezInCurrentLanguage = namez?.firstWhere((name) =>
      name.code == _currentLanguageCode, orElse: () => null);

      _name = _namezInCurrentLanguage == null
          ? _englishNamez?.value
          : _namezInCurrentLanguage?.value;
    }

    return _name;
  }
// -----------------------------------------------------------------------------
}
// -----------------------------------------------------------------------------
