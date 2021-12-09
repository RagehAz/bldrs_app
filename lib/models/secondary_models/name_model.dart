import 'package:bldrs/controllers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/controllers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/controllers/drafters/tracers.dart';
import 'package:bldrs/controllers/localization/lingo.dart';
import 'package:bldrs/controllers/theme/wordz.dart' as Wordz;
import 'package:flutter/material.dart';

class Name {
  /// --------------------------------------------------------------------------
  const Name({
    @required this.code,
    @required this.value,
    this.trigram,
  });
  /// --------------------------------------------------------------------------
  final String code; /// language code
  final String value; /// name in this language
  final List<String> trigram;
  /// --------------------------------------------------------------------------
  Map<String, dynamic> toMap({bool addTrigram = true}) {

    Map<String, dynamic> _map = <String, dynamic>{
      'code': code,
      'value': value,
    };

    if (addTrigram == true){
      _map = Mapper.insertPairInMap(
          map: _map,
          key: 'trigram',
          value: TextGen.createTrigram(input: value),
      );
    }

    return _map;
  }
// -----------------------------------------------------------------------------
  static Map<String, dynamic> cipherNames({@required List<Name> names, bool addTrigrams = true}) {
    Map<String, dynamic> _namezMaps = <String, dynamic>{};

    if (Mapper.canLoopList(names)){

      for (final Name name in names){
        _namezMaps = Mapper.insertPairInMap(
          map: _namezMaps,
          key: name.code,
          value: name.toMap(addTrigram: addTrigrams),
        );
      }

    }

    return _namezMaps;
  }
// -----------------------------------------------------------------------------
  static Name decipherName(Map<String, dynamic> map) {

    // blog('decipherName : map : $map : map[\'code\'] : ${map['code']} : map[\'value\'] : ${map['value']}');

    return Name(
      code: map['code'],
      value: map['value'],
      trigram: Mapper.getStringsFromDynamics(dynamics: map['trigram']),
    );
  }
// -----------------------------------------------------------------------------
  static List<Name> decipherNames(Map<String, dynamic> map){
    final List<Name> _names = <Name>[];

    final List<String> _keys = map.keys.toList();

    if (Mapper.canLoopList(_keys)){

      for (int i = 0; i<_keys.length; i++){

        final String _key = _keys[i];
        final Name _name = decipherName(map[_key]);
        _names.add(_name);

      }

    }

    return _names;
  }
// -----------------------------------------------------------------------------
  static String getNameByCurrentLingoFromNames(BuildContext context, List<Name> names,) {
    final String _currentLanguageCode = Wordz.languageCode(context);
    String _name;

    if (Mapper.canLoopList(names)){
      _name = getNameByLingoFromNames(
        names: names,
        lingoCode: _currentLanguageCode,
      );
    }

    return _name;
  }
// -----------------------------------------------------------------------------
  static String getNameByLingoFromNames({@required List<Name> names, @required String lingoCode}){

    String _nameValue;

    if (Mapper.canLoopList(names)) {

      final Name _foundName = names.singleWhere((Name name) => name.code == lingoCode, orElse: () => null);

      if (_foundName == null){
        _nameValue = names.singleWhere((Name name) => name.code == Lingo.englishCode)?.value;
      }

      else {
        _nameValue = _foundName.value;
      }

    }

    return _nameValue;
  }
// -----------------------------------------------------------------------------
  void printName(){

    blog('NAME ------------------------------------- START');

    blog('code : $code');
    blog('value : $value');

    blog('NAME ------------------------------------- END');
  }
// -----------------------------------------------------------------------------
  static bool namesIncludesValueForThisLanguage({@required List<Name> names, @required String lingoCode}){
    bool _namesInclude = false;

    if (Mapper.canLoopList(names)){

      for (final Name name in names){

        if (name.code == lingoCode){
          if (name.value != null){

            _namesInclude = true;
            break;

          }
        }

      }

    }


    return _namesInclude;
  }
// -----------------------------------------------------------------------------
  /// TASK : TEST THIS
  static bool namesAreTheSame({@required Name firstName, @required Name secondName}){

    bool _namesAreTheSame = false;

    if (firstName != null && secondName != null){

      if (firstName.code == secondName.code){

        if (firstName.value == secondName.value){

          if (Mapper.listsAreTheSame(list1: firstName.trigram, list2: secondName.trigram)){

            _namesAreTheSame = true;

          }

        }

      }

    }

    return _namesAreTheSame;
  }
// -----------------------------------------------------------------------------
  /// TASK : TEST THIS
  static bool namesListsAreTheSame({@required List<Name> firstNames, @required List<Name> secondNames}){

    bool _listsAreTheSame = false;

    if (Mapper.canLoopList(firstNames) && Mapper.canLoopList(secondNames)){

      if (firstNames.length == secondNames.length){

        final List<String> codes = _getLingoCodesFromNames(firstNames);

        bool _allCodeValuesAreTheSame = true;

        for (final String code in codes){

          final String firstName = getNameByLingoFromNames(names: firstNames, lingoCode: code);
          final String secondName = getNameByLingoFromNames(names: secondNames, lingoCode: code);

          if (firstName == secondName){

            _allCodeValuesAreTheSame = true;

          }

          else {
            _allCodeValuesAreTheSame = false;
            break;
          }

        }

        if (_allCodeValuesAreTheSame == true){
          _listsAreTheSame = true;
        }

      }

    }

    return _listsAreTheSame;
  }
// -----------------------------------------------------------------------------
  static List<String> _getLingoCodesFromNames(List<Name> names){

    final List<String> _codes = <String>[];

    if (Mapper.canLoopList(names)){

      for (final Name name in names){
        _codes.add(name.code);
      }

    }

    return _codes;
  }
// -----------------------------------------------------------------------------
  static void printNames(List<Name> names){

    // blog('PRINTING NAME --------------------------------------- START');

    if (Mapper.canLoopList(names)){

      for (final Name name in names){
        blog('code : [ ${name.code} ] : name : [ ${name.value} ] : trigramLength : ${name.trigram?.length}');
      }

    }

    // blog('PRINTING NAME --------------------------------------- END');

  }
// -----------------------------------------------------------------------------
}
