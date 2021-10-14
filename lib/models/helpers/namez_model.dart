import 'package:bldrs/controllers/drafters/mappers.dart';
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
  static List<Map<String, dynamic>> cipherNames(List<Name> names) {
    final List<Map<String, dynamic>> _namezMaps = <Map<String, dynamic>>[];

    if (Mapper.canLoopList(names)){

      names.forEach((name) {
        _namezMaps.add(name.toMap());
      });

    }

    return _namezMaps;
  }
// -----------------------------------------------------------------------------
  static Name decipherName(Map<String, dynamic> map) {

    // print('decipherName : map : $map : map[\'code\'] : ${map['code']} : map[\'value\'] : ${map['value']}');

    return Name(
      code: map['code'],
      value: map['value'],
    );
  }
// -----------------------------------------------------------------------------
  static List<Name> decipherNames(List<dynamic> maps) {
    final List<Name> _namez = <Name>[];

    if (Mapper.canLoopList(maps)){

      maps?.forEach((map) {
        _namez.add(decipherName(map));
      });

    }

    return _namez;
  }
// -----------------------------------------------------------------------------
  static String getNameByCurrentLingoFromNames(BuildContext context, List<Name> names,) {
    final String _currentLanguageCode = Wordz.languageCode(context);
    String _name;

      _name = getNameByLingoFromNames(
        names: names,
        lingoCode: _currentLanguageCode,
      );

    return _name;
  }
// -----------------------------------------------------------------------------
  static String getNameByLingoFromNames({@required List<Name> names, @required String lingoCode}){

    String _nameValue;

    if (Mapper.canLoopList(names)) {

      Name _foundName = names.singleWhere((name) => name.code == lingoCode, orElse: () => null);

      if (_foundName == null){
        _nameValue = names.singleWhere((name) => name.code == Lingo.englishCode).value;
      }

      else {
        _nameValue = _foundName.value;
      }

    }

    return _nameValue;
  }
// -----------------------------------------------------------------------------
  void printName(){

    print('NAME ------------------------------------- START');

    print('code : $code');
    print('value : $value');

    print('NAME ------------------------------------- END');
  }
// -----------------------------------------------------------------------------
}
