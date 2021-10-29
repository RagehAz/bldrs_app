import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/localization/lingo.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:bldrs/models/kw/chain.dart';
import 'package:flutter/cupertino.dart';

class KW {
  final String id;
  final List<Name> names;

  const KW({
    @required this.id,
    @required this.names,
  });
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap(){

    return {
      'id': id,
      'names' : Name.cipherNames(names: names, addTrigrams: false),
    };

  }
// -----------------------------------------------------------------------------
  static KW decipherKeyword(Map<String, dynamic> map){
    KW _keyword;

    if (map != null){
      _keyword = KW(
        id: map['id'],
        names: Name.decipherNames(map['names']),
      );
    }

    return _keyword;
  }
// -----------------------------------------------------------------------------
  static Map<String, dynamic> cipherKeywordsToMap(List<KW> keywords){

    Map<String, dynamic> _map;

    if (Mapper.canLoopList(keywords)){

      for (var kw in keywords){

        _map = Mapper.insertPairInMap(
            map: _map,
            key: kw.id,
            value: kw.toMap(),
        );

      }

    }

    return _map;
  }
// -----------------------------------------------------------------------------
  static List<Map<String, dynamic>> cipherKeywordsToMaps(List<KW> keywords){

    final List<Map<String, dynamic>> maps = <Map<String, dynamic>>[];

    if (Mapper.canLoopList(keywords)){

      for (var kw in keywords){

        final Map<String, dynamic> _map = kw.toMap();
        maps.add(_map);
      }

    }

    return maps;
  }
// -----------------------------------------------------------------------------
  static List<KW> decipherKeywordsMap({@required Map<String, dynamic> map}){
    final List<KW> _keywords = <KW>[];

    if (map != null){
      final List<String> _keys = map.keys.toList();

      if (Mapper.canLoopList(_keys)){

        for (String key in _keys){

          final KW _kw = decipherKeyword(map[key]);

          _keywords.add(_kw);

        }

      }

    }

    return _keywords;
  }
// -----------------------------------------------------------------------------
  static List<KW> decipherKeywordsMaps({@required List<Map<String, dynamic>> maps}){

    final List<KW> _keywords = <KW>[];

    if (Mapper.canLoopList(maps)){

      for (var map in maps){

        final KW _kw = decipherKeyword(map);
        _keywords.add(_kw);
      }

    }

    return _keywords;
  }
// -----------------------------------------------------------------------------
  void printKeyword({String methodName = 'PRINTING KEYWORD'}){

    print('$methodName ------------------------------- START');

    print('id : ${id}');
    print('names : ${names}');

    print('${methodName} ------------------------------- END');
  }

// -----------------------------------------------------------------------------
  static String getKeywordArabicName(KW keyword){
    List<Name> _names = keyword.names;

    final Name _arabicName = _names.firstWhere((name) => name.code == Lingo.arabicLingo.code, orElse: () => null);
    final String _name = _arabicName == null ? null : _arabicName.value;

    return _name;
  }
// -----------------------------------------------------------------------------
  static List<String> getKeywordsIDsFromKeywords(List<KW> keywords){
    final List<String> _ids = <String>[];

    if (Mapper.canLoopList(keywords)){
      for (var keyword in keywords){

        _ids.add(keyword.id);
      }
    }

    return _ids;
  }
// -----------------------------------------------------------------------------
  static bool KeywordsAreTheSame(KW _firstKeyword, KW _secondKeyword){
    final bool _keywordsAreTheSame =
    _firstKeyword == null || _secondKeyword == null ? false
        :
    _firstKeyword.id == _secondKeyword.id && Name.namesListsAreTheSame(firstNames : _firstKeyword.names, secondNames: _secondKeyword.names) == true ?
    true
        :
    false;

    return _keywordsAreTheSame;
  }
// -----------------------------------------------------------------------------
  static bool KeywordsListsAreTheSame(List<KW> listA, List<KW> listB){
    bool _same;

    if(listA != null && listB != null){
      if (listA.length == listB.length){
        for (int i = 0; i < listA.length; i++){

          if (KeywordsAreTheSame(listA[i], listB[i]) == true){
            _same = true;
          }
          else {
            _same = false;
            break;
          }
        }
      }
    }

    return _same;
  }
// -----------------------------------------------------------------------------
  static List<KW> getAllKeywordsFromBldrsChain(){

    const Chain _bldrsChain = Chain.bldrsChain;

    List<KW> _kws = getKeywordsFromChain(_bldrsChain);

    return _kws;
  }
// -----------------------------------------------------------------------------
  static List<KW> getKeywordsFromChain(Chain chain){

    List<KW> _keywords = <KW>[];

    if (chain != null){

      if (Mapper.canLoopList(chain.sons)){

        for (dynamic son in chain.sons){

          if (son.runtimeType == Chain){

            final Chain _chain = son;
            List<KW> _kws = getKeywordsFromChain(_chain);
            _keywords.addAll(_kws);
          }

          else if (son.runtimeType == KW){

            final KW _kw = son;
            _keywords.add(_kw);
          }
        }

      }

    }

    return _keywords;
  }
// -----------------------------------------------------------------------------
  static String translateKeyword(BuildContext context, KW kw){
    final String _name = Name.getNameByCurrentLingoFromNames(context, kw.names);
    return _name;
  }
// -----------------------------------------------------------------------------
}
