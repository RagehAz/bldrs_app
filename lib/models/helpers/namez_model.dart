import 'package:bldrs/controllers/localization/lingo.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
class Namez{
  final String id;
  final List<Name> names;

  const Namez({
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

  const Name({
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
    final List<Map<String, dynamic>> _namezMaps = <Map<String, dynamic>>[];
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
    final List<Name> _namez = <Name>[];
    maps?.forEach((map) {
      _namez.add(decipherNamezMap(map));
    });
    return _namez;
  }
// -----------------------------------------------------------------------------
  static String getNameByCurrentLingoFromNames(BuildContext context, List<Name> namez,) {
    final String _currentLanguageCode = Wordz.languageCode(context);
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

      final Name _englishName = names.firstWhere((name) =>
      name.code == Lingo.englishLingo.code, orElse: () => null);

      final Name _nameByLingo = names.firstWhere((name) =>
      name.code == LingoCode, orElse: () => null);

      _foundName = _nameByLingo == null ? _englishName?.value : _nameByLingo?.value;
    }

    return _foundName;
  }
// -----------------------------------------------------------------------------
}
