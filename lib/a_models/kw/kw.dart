import 'package:bldrs/a_models/kw/chain/chain.dart';
import 'package:bldrs/a_models/kw/specs/spec_model.dart';
import 'package:bldrs/a_models/secondary_models/name_model.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/localization/lingo.dart';
import 'package:flutter/cupertino.dart';

class KW {
  /// --------------------------------------------------------------------------
  const KW({
    @required this.id,
    @required this.names,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final List<Name> names;
  /// --------------------------------------------------------------------------
  Map<String, dynamic> toMap({@required bool toJSON}) {
    return <String, dynamic>{
      'id': id,
      'names': Name.cipherNames(names: names, addTrigrams: toJSON),
    };
  }
// -----------------------------------------------------------------------------
  static KW decipherKeyword({
    @required Map<String, dynamic> map,
    @required bool fromJSON
  }) {
    KW _keyword;

    if (map != null) {
      _keyword = KW(
        id: map['id'],
        names: Name.decipherNames(map['names']),
      );
    }

    return _keyword;
  }
// -----------------------------------------------------------------------------
  static Map<String, dynamic> cipherKeywordsToFirebaseMap(List<KW> keywords) {
    Map<String, dynamic> _map;

    if (Mapper.canLoopList(keywords)) {
      for (final KW kw in keywords) {
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
  static List<Map<String, dynamic>> cipherKeywordsToLDBMaps(List<KW> keywords) {
    final List<Map<String, dynamic>> maps = <Map<String, dynamic>>[];

    if (Mapper.canLoopList(keywords)) {
      for (final KW kw in keywords) {
        final Map<String, dynamic> _map = kw.toMap(toJSON: true);
        maps.add(_map);
      }
    }

    return maps;
  }
// -----------------------------------------------------------------------------
  static List<KW> decipherKeywordsFirebaseMap({
    @required Map<String, dynamic> map
  }) {
    final List<KW> _keywords = <KW>[];

    if (map != null) {
      final List<String> _keys = map.keys.toList();

      if (Mapper.canLoopList(_keys)) {
        for (final String key in _keys) {
          final KW _kw = decipherKeyword(map: map[key], fromJSON: false);

          _keywords.add(_kw);
        }
      }
    }

    return _keywords;
  }
// -----------------------------------------------------------------------------
  static List<KW> decipherKeywordsLDBMaps({
    @required List<Map<String, dynamic>> maps
  }) {
    final List<KW> _keywords = <KW>[];

    if (Mapper.canLoopList(maps)) {
      for (final Map<String, dynamic> map in maps) {
        final KW _kw = decipherKeyword(map: map, fromJSON: true);
        _keywords.add(_kw);
      }
    }

    return _keywords;
  }
// -----------------------------------------------------------------------------
  void blogKeyword({String methodName = 'PRINTING KEYWORD'}) {
    blog('$methodName ------------------------------- START');

    blog('id : $id');
    Name.printNames(names);

    blog('$methodName ------------------------------- END');
  }
// -----------------------------------------------------------------------------
  static String getKeywordArabicName(KW keyword) {
    final List<Name> _names = keyword.names;

    final Name _arabicName = _names.firstWhere(
        (Name name) => name.code == Lingo.arabicLingo.code,
        orElse: () => null);
    final String _name = _arabicName?.value;

    return _name;
  }
// -----------------------------------------------------------------------------
  static List<String> getKeywordsIDsFromKeywords(List<KW> keywords) {
    final List<String> _ids = <String>[];

    if (Mapper.canLoopList(keywords)) {
      for (final KW keyword in keywords) {
        _ids.add(keyword.id);
      }
    }

    return _ids;
  }
// -----------------------------------------------------------------------------
  static bool keywordsAreTheSame(KW _firstKeyword, KW _secondKeyword) {
    bool _keywordsAreTheSame;

    if (_firstKeyword == null || _secondKeyword == null) {
      _keywordsAreTheSame = false;
    } else if (_firstKeyword.id == _secondKeyword.id &&
        Name.namesListsAreTheSame(
                firstNames: _firstKeyword.names,
                secondNames: _secondKeyword.names) ==
            true) {
      _keywordsAreTheSame = true;
    } else {
      _keywordsAreTheSame = false;
    }

    return _keywordsAreTheSame;
  }
// -----------------------------------------------------------------------------
  static bool keywordsListsAreTheSame(List<KW> listA, List<KW> listB) {
    bool _same;

    if (listA != null && listB != null) {
      if (listA.length == listB.length) {
        for (int i = 0; i < listA.length; i++) {
          if (keywordsAreTheSame(listA[i], listB[i]) == true) {
            _same = true;
          } else {
            _same = false;
            break;
          }
        }
      }
    }

    return _same;
  }
// -----------------------------------------------------------------------------
  static List<KW> getAllKeywordsFromBldrsChain() {
    const Chain _bldrsChain = Chain.bldrsChain;

    final List<KW> _kws = getKeywordsFromChain(_bldrsChain);

    return _kws;
  }
// -----------------------------------------------------------------------------
  static List<KW> getKeywordsFromChain(Chain chain) {
    final List<KW> _keywords = <KW>[];

    if (chain != null) {
      if (Mapper.canLoopList(chain.sons)) {
        for (final dynamic son in chain.sons) {
          if (son.runtimeType == Chain) {
            final Chain _chain = son;
            final List<KW> _kws = getKeywordsFromChain(_chain);
            _keywords.addAll(_kws);
          } else if (son.runtimeType == KW) {
            final KW _kw = son;
            _keywords.add(_kw);
          }
        }
      }
    }

    return _keywords;
  }
// -----------------------------------------------------------------------------
  static String translateKeyword(BuildContext context, KW kw) {
    final String _name = Name.getNameByCurrentLingoFromNames(
        context: context,
        names: kw.names)?.value;

    return _name;
  }
// -----------------------------------------------------------------------------
  static bool keywordsContainKeyword({
    @required List<KW> keywords,
    @required KW keyword
  }) {
    bool _contains = false;

    if (Mapper.canLoopList(keywords) && keyword != null) {

      final KW _result = keywords.firstWhere(
          (KW kw) => KW.keywordsAreTheSame(kw, keyword) == true,
          orElse: () => null);

      if (_result == null) {
        _contains = false;
      }

      else {
        _contains = true;
      }
    }

    return _contains;
  }
// -----------------------------------------------------------------------------
  static List<String> getKeywordsIDsFromSpecs(List<SpecModel> specs) {
    final List<String> _keywordsIDs = <String>[];

    if (Mapper.canLoopList(specs)) {
      for (final SpecModel spec in specs) {
        // final SpecList _specList = SpecList.getSpecListFromSpecsListsByID(specsLists: specsLists, specListID: specListID)
        final dynamic _keywordID = spec.value;

        if (_keywordID.runtimeType == String) {
          _keywordsIDs.add(_keywordID);
        }
      }
    }

    return _keywordsIDs;
  }
// -----------------------------------------------------------------------------
  static KW getKeywordFromKeywordsByID({
    @required List<KW> sourceKeywords,
    @required String keywordID,
  }){

    KW _kw;

    if (Mapper.canLoopList(sourceKeywords) && keywordID != null && keywordID != ''){
      _kw = sourceKeywords.firstWhere((KW kw) => kw.id == keywordID, orElse: () => null);
    }

    return _kw;
  }
// -----------------------------------------------------------------------------
  static List<KW> getKeywordsFromKeywordsByIDs({
    @required List<KW> sourceKWs,
    @required List<String> keywordsIDs,
  }){

    final List<KW> _keywords = <KW>[];

    if (Mapper.canLoopList(sourceKWs) && Mapper.canLoopList(keywordsIDs)){
      for (final String id in keywordsIDs) {
        final KW _keyword = getKeywordFromKeywordsByID(
          sourceKeywords: sourceKWs,
          keywordID: id,
        );

        if (_keyword != null) {
          _keywords.add(_keyword);
        }
      }

    }

    return _keywords;
  }
// -----------------------------------------------------------------------------
  static List<KW> dummyKeywords({int length = 4}){

    final List<KW> _dummies = <KW>[];

    for (int i = 0; i <= length; i++){

      _dummies.add(
        KW(
          id: 'dummy_keywordID_$i',
          names: <Name>[
            Name(code: 'en', value: 'dummy_keyword_$i'),
            Name(code: 'ar', value: '_${i}_المفتاح_السحري')
          ],
        )
      );

    }

     return _dummies;
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
