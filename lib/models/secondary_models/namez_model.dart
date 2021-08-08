import 'package:bldrs/controllers/localization/lingo.dart';
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
  static String getNameByCurrentLingoFromNames(BuildContext context, List<Name> namez,) {
    String _currentLanguageCode = Wordz.languageCode(context);
    String _name;

      _name = getNameByLingoFromNames(
        context: context,
        names: namez,
        LingoCode: _currentLanguageCode,
      );

    return _name;
  }
// -----------------------------------------------------------------------------
  static String getNameByLingoFromNames({BuildContext context, List<Name> names, String LingoCode}){

    String _foundName;

    if (names != null && names.length != 0) {

      Name _englishName = names.firstWhere((name) =>
      name.code == Lingo.English, orElse: () => null);

      Name _nameByLingo = names.firstWhere((name) =>
      name.code == LingoCode, orElse: () => null);

      _foundName = _nameByLingo == null ? _englishName?.value : _nameByLingo?.value;
    }

    return _foundName;
  }
// -----------------------------------------------------------------------------
}
