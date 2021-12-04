import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/localization/lingo.dart';
import 'package:bldrs/models/kw/chain/chain.dart';
import 'package:bldrs/models/kw/specs/spec_model.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:flutter/cupertino.dart';

class KW {
  final String id;
  final List<Name> names;

  const KW({
    @required this.id,
    @required this.names,
  });
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap({@required bool toJSON}){

    return <String, dynamic>{
      'id': id,
      'names' : Name.cipherNames(names: names, addTrigrams: toJSON),
    };

  }
// -----------------------------------------------------------------------------
  static KW decipherKeyword({@required Map<String, dynamic> map, @required bool fromJSON}){
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
  static Map<String, dynamic> cipherKeywordsToFirebaseMap(List<KW> keywords){

    Map<String, dynamic> _map;

    if (Mapper.canLoopList(keywords)){

      for (KW kw in keywords){

        _map = Mapper.insertPairInMap(
            map: _map,
            key: kw.id,
            value: kw.toMap(toJSON: false),
        );

      }

    }

    return _map;
  }
// -----------------------------------------------------------------------------
  static List<Map<String, dynamic>> cipherKeywordsToLDBMaps(List<KW> keywords){

    final List<Map<String, dynamic>> maps = <Map<String, dynamic>>[];

    if (Mapper.canLoopList(keywords)){

      for (KW kw in keywords){

        final Map<String, dynamic> _map = kw.toMap(toJSON: true);
        maps.add(_map);
      }

    }

    return maps;
  }
// -----------------------------------------------------------------------------
  static List<KW> decipherKeywordsFirebaseMap({@required Map<String, dynamic> map}){
    final List<KW> _keywords = <KW>[];

    if (map != null){
      final List<String> _keys = map.keys.toList();

      if (Mapper.canLoopList(_keys)){

        for (String key in _keys){

          final KW _kw = decipherKeyword(map: map[key], fromJSON: false);

          _keywords.add(_kw);

        }

      }

    }

    return _keywords;
  }
// -----------------------------------------------------------------------------
  static List<KW> decipherKeywordsLDBMaps({@required List<Map<String, dynamic>> maps}){

    final List<KW> _keywords = <KW>[];

    if (Mapper.canLoopList(maps)){

      for (Map<String, dynamic> map in maps){

        final KW _kw = decipherKeyword(map: map, fromJSON: true);
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

    final Name _arabicName = _names.firstWhere((Name name) => name.code == Lingo.arabicLingo.code, orElse: () => null);
    final String _name = _arabicName == null ? null : _arabicName.value;

    return _name;
  }
// -----------------------------------------------------------------------------
  static List<String> getKeywordsIDsFromKeywords(List<KW> keywords){
    final List<String> _ids = <String>[];

    if (Mapper.canLoopList(keywords)){
      for (KW keyword in keywords){

        _ids.add(keyword.id);
      }
    }

    return _ids;
  }
// -----------------------------------------------------------------------------
  static bool keywordsAreTheSame(KW _firstKeyword, KW _secondKeyword){
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
  static bool keywordsListsAreTheSame(List<KW> listA, List<KW> listB){
    bool _same;

    if(listA != null && listB != null){
      if (listA.length == listB.length){
        for (int i = 0; i < listA.length; i++){

          if (keywordsAreTheSame(listA[i], listB[i]) == true){
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
  static bool keywordsContainKeyword({@required List<KW> keywords, @required KW keyword}){
    bool _contains = false;

    if (Mapper.canLoopList(keywords) && keyword != null) {
      final KW _result = keywords.firstWhere((KW kw) => KW.keywordsAreTheSame(kw, keyword) == true, orElse: () => null);

      _contains = _result == null ? false : true;
    }

    return _contains;
  }
// -----------------------------------------------------------------------------
  static List<String> getKeywordsIDsFromSpecs(List<Spec> specs){
    final List<String> _keywordsIDs = <String>[];

    if (Mapper.canLoopList(specs)){

      for (Spec spec in specs){
        // final SpecList _specList = SpecList.getSpecListFromSpecsListsByID(specsLists: specsLists, specListID: specListID)
        final dynamic _keywordID = spec.value;

        if (_keywordID.runtimeType == String){
          _keywordsIDs.add(_keywordID);
        }

      }

    }

    return _keywordsIDs;
  }
// -----------------------------------------------------------------------------
}

/*

LIST OF SONS WITH NO ICONS,, MAYBE i WILL DO THEM LATE IN VERSION 16 OR SOMETHING,

ppt_lic_industrial
ppt_lic_educational
ppt_lic_hotel
ppt_lic_entertainment
ppt_lic_medical
ppt_lic_sports
ppt_lic_residential
ppt_lic_retail

sub_prd_app_wasteDisposal
sub_prd_app_snacks
sub_prd_app_refrigeration
sub_prd_app_outdoorCooking
sub_prd_app_media
sub_prd_app_indoorCooking
sub_prd_app_housekeeping
sub_prd_app_foodProcessors
sub_prd_app_drinks
sub_prd_app_bathroom


 */
