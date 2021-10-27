import 'package:bldrs/controllers/drafters/object_checkers.dart';
import 'package:bldrs/controllers/drafters/text_mod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:sembast/utils/value_utils.dart';

abstract class Mapper{
// -----------------------------------------------------------------------------
  /// TODO : check getFirstValuesFromMaps if not used in production
  /// [
  /// {'key' : 'ID'         , 'key' : 'Value'       },
  /// {'key' : 'firstValue' , 'key' : 'secondValue' },
  /// ]
  static List<String> getFirstValuesFromMaps(List<Map<String, Object>> listOfMaps){
    List<String> _listOfFirstValues = <String>[];

    for (int x = 0; x<listOfMaps.length; x++){
      final String _firstValue = (listOfMaps[x].values.toList())[0];
      _listOfFirstValues.add(_firstValue);
    }

    return _listOfFirstValues;
  }
// -----------------------------------------------------------------------------
  /// TODO : check getFirstValuesFromMaps if not used in production
  /// [
  /// {'key' : 'ID'         , 'key' : 'Value'       },
  /// {'key' : 'firstValue' , 'key' : 'secondValue' },
  /// ]
  static List<String> getSecondValuesFromMaps(List<Map<String, Object>> listOfMaps){
    List<String> _listOfValues = <String>[];

    for (int x = 0; x<listOfMaps.length; x++){
      final String _secondValue = (listOfMaps[x].values.toList())[1];
      _listOfValues.add(_secondValue);
    }

    return _listOfValues;
  }
// -----------------------------------------------------------------------------
  static List<String> cloneListOfStrings(List<String> list){
    List<dynamic> _newList = <dynamic>[];

    for (var x in list){
      _newList.add(x);
    }
    return _newList;
  }
// -----------------------------------------------------------------------------
  static List<Map<String, dynamic>> getMapsFromQuerySnapshot({
    @required QuerySnapshot querySnapshot,
    @required bool addDocsIDs,
    @required bool addDocSnapshotToEachMap,
  }){

    final List<QueryDocumentSnapshot> _docsSnapshots = querySnapshot.docs;

    final List<Map<String, dynamic>> _maps = getMapsFromQueryDocumentSnapshotsList(
      queryDocumentSnapshots: _docsSnapshots,
      addDocsIDs: addDocsIDs,
      addDocSnapshotToEachMap: addDocSnapshotToEachMap,
    );

    return _maps;
  }
// -----------------------------------------------------------------------------
  static List<Map<String, dynamic>> getMapsFromQueryDocumentSnapshotsList({
    @required List<QueryDocumentSnapshot> queryDocumentSnapshots,
    @required bool addDocsIDs,
    @required bool addDocSnapshotToEachMap,
  }){

    List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

    for (var docSnapshot in queryDocumentSnapshots){

      final String _docID = docSnapshot.id;

      Map<String, dynamic> _map = docSnapshot.data();

      if (addDocsIDs == true){
        _map['id'] = _docID;
      }

      if (addDocSnapshotToEachMap == true){
        _map = Mapper.insertPairInMap(
          map: _map,
          key: 'docSnapshot',
          value: docSnapshot,
        );
      }


      _maps.add(_map);
    }

    return _maps;
  }
// -----------------------------------------------------------------------------
  static Map<String, dynamic> getMapFromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    final Map<String, dynamic> _map = documentSnapshot.data();
    return _map;

  }
// -----------------------------------------------------------------------------
  static bool listOfMapsContainValue({@required List<dynamic> listOfMaps, @required String field, @required String value}){

    bool _listOfMapContainsTheValue;

    for (var map in listOfMaps){

      if (map[field] == value){
        _listOfMapContainsTheValue = true;
        break;
      } else {
        _listOfMapContainsTheValue = false;
      }

    }

    return _listOfMapContainsTheValue;
  }
// -----------------------------------------------------------------------------
  /// listOfMaps = [
  /// {'key1' : 'value', 'key2' : 'value2'}
  /// {'key1' : 'value', 'key2' : 'value2'}
  /// {'key1' : 'value', 'key2' : 'value2'}
  /// ];
  ///
  /// map = {'key1' : 'value', 'key2' : 'value2'};
  static bool listOfMapsContainMap({@required List<Map<String, dynamic>> listOfMaps, @required Map<String, dynamic> map}){

    bool _listOfMapContainsTheMap;

    final bool _inputsAreInvalid = listOfMaps == null || listOfMaps.length == 0 || map == null ? true : false;

    if(_inputsAreInvalid == true){
      _listOfMapContainsTheMap = false;
    }

    else {

    for (var _map in listOfMaps){

      if (mapsAreTheSame(_map, map)){
        _listOfMapContainsTheMap = true;
        break;
      } else {
        _listOfMapContainsTheMap = false;
      }

    }

    }

    return _listOfMapContainsTheMap;
  }
// -----------------------------------------------------------------------------
  static bool listsAreTheSame({@required List<dynamic> list1, @required List<dynamic> list2}){
    bool listsAreTheSame;

    if (list1.length != list2.length){
      listsAreTheSame = false;
    }

    else {

      for (int i = 0; i<list1.length; i++){

        if (list1[i] != list2[i]){
          listsAreTheSame = false;
          break;
        }

        else{
          listsAreTheSame = true;
        }

      }

    }


    return listsAreTheSame;
  }
// -----------------------------------------------------------------------------
  static bool mapsAreTheSame(Map<String, dynamic> map1, Map<String, dynamic> map2){
    bool _mapsAreTheSame;

    final bool _inputsAreInvalid = map1 == null || map2 == null ? true : false;

    if (_inputsAreInvalid == true){
      _mapsAreTheSame = null;
    }

    else {
      final List<String> _map1Keys = map1.keys.toList();
      final List<dynamic> _map1Values = map1.values.toList();

      final List<String> _map2Keys = map2.keys.toList();
      final List<dynamic> _map2Values = map2.values.toList();

      if(_map1Keys.length != _map2Keys.length){
        _mapsAreTheSame = false;
      }

      else{

        if (
            listsAreTheSame(list1: _map1Keys, list2: _map2Keys) == true
            &&
            listsAreTheSame(list1: _map1Values, list2: _map2Values) == true
        ){
          _mapsAreTheSame = true;
        }

        else {
          _mapsAreTheSame = false;
        }

      }

    }

    return _mapsAreTheSame;
  }
// -----------------------------------------------------------------------------
  static int indexOfMapInListOfMaps(List<Map<String, dynamic>> listOfMaps, Map<String,dynamic> map){
    final int _indexOfTheMap = listOfMaps.indexWhere((m) => Mapper.mapsAreTheSame(m, map));
    return _indexOfTheMap;
  }
// -----------------------------------------------------------------------------
  static int indexOfMapByValueInListOfMaps({@required List<Map<String, dynamic>> listOfMaps, @required String key, @required dynamic value}){
    final int _indexOfTheMap = listOfMaps.indexWhere((map) => map[key] == value);
    return _indexOfTheMap;
  }
// -----------------------------------------------------------------------------
  static Map<String, dynamic> insertPairInMap({@required Map<String,dynamic> map, @required String key, @required dynamic value}){
    map.putIfAbsent(key, () => value);

    Map<String, dynamic> _result = {};
    _result.addAll(map);

    return _result;
  }
// -----------------------------------------------------------------------------
  /// url query looks like "key1=value1&key1=value2&key3=value3"
  static Map<String, dynamic> getMapFromURLQuery({@required String urlQuery}){
    /// url query should look like this
    /// 'country=eg&category=business&apiKey=65f7556ec76449fa7dc7c0069f040ca';

    Map<String, dynamic> _output = {};

    final int _numberOfAnds = '&'.allMatches(urlQuery).length;
    final int _numberOfEquals = '='.allMatches(urlQuery).length;
    final bool _countsOfPairsAreGood = _numberOfAnds + 1 == _numberOfEquals;

    /// if urlQuery counts are good
    if (_countsOfPairsAreGood == true){

      /// pairs should look like this : key=value
      final List<String> _pairs = <String>[];

      /// holds temp trimmed url in here while trimming loops
      String _trimmedURL = urlQuery;

      print('_trimmedURL : $_trimmedURL');

      /// trim urlQuery into string pairs
      for (int i = 0; i < _numberOfAnds; i++){

        final String _beforeAnd = TextMod.trimTextAfterFirstSpecialCharacter(_trimmedURL, '&');
        _pairs.add(_beforeAnd);

        final String _afterAnd = TextMod.trimTextBeforeFirstSpecialCharacter(_trimmedURL, '&');

        if (i == _numberOfAnds - 1){
          _pairs.add(_afterAnd);
        } else {
          _trimmedURL = _afterAnd;
        }

      }

      /// add pairs to a map
      for (String pair in _pairs){

        final String _key = TextMod.trimTextAfterFirstSpecialCharacter(pair, '=');
        final String _value = TextMod.trimTextBeforeFirstSpecialCharacter(pair, '=');

        _output = Mapper.insertPairInMap(map: _output, key: _key,value: _value,);

      }

    }

    /// if counts are no good
    else {
      print('getMapFromURLQuery : _countsOfPairsAreGood : $_countsOfPairsAreGood');
      print('getMapFromURLQuery : something is wrong in this : urlQuery : $urlQuery');
    }


    return _output;
  }
// -----------------------------------------------------------------------------
  static List<String> getStringsFromDynamics({@required List<dynamic> dynamics}){
    final List<String> _strings = <String>[];

    if (Mapper.canLoopList(dynamics)){
      for (dynamic thing in dynamics){

        if (ObjectChecker.objectIsString(thing) == true){
          _strings.add(thing);
        }

        else {
          _strings.add(thing.toString());
        }

      }
    }


    return _strings;
  }
// -----------------------------------------------------------------------------
  static Map<String, Object> replacePair({@required Map<String, Object> map,@required  String fieldKey,@required  dynamic inputValue}){

    final Map<String, Object> _aMap = cloneMap(map);

    try {

      _aMap[fieldKey] = inputValue;

    } catch (e){

      print('error is : $e');
      print('map is : ${map}');
      print('fieldKey is : $fieldKey');
      print('inputValue : $inputValue');

    }

    return _aMap;
}
// -----------------------------------------------------------------------------
  static Map<String, Object> removePair({@required Map<String, Object> map,@required  String fieldKey}){

    final Map<String, Object> _map = cloneMap(map);

    _map.remove(fieldKey);

    return _map;
  }
// -----------------------------------------------------------------------------
  static bool canLoopList(List<dynamic> list){

    bool _canLoop = false;

    if (list != null && list.length > 0){
      _canLoop = true;
    }
    return _canLoop;
  }
// -----------------------------------------------------------------------------
  static void printMap(Map<String, dynamic> map){

    print('MAP-PRINT --------------------------------------------------START');

    final List<String> _keys = map.keys.toList();
    final List<dynamic> _values = map.values.toList();

    for (int i = 0; i <_keys.length; i++){
      print('MAP-PRINT : ${_keys[i]} : ${_values[i]}');
    }

    print('MAP-PRINT --------------------------------------------------END');

  }
// -----------------------------------------------------------------------------
  static void printMaps(List<dynamic> maps){

    if (canLoopList(maps)){

      maps.forEach((map) {
        printMap(map);
      });

    }

  }
// -----------------------------------------------------------------------------
  static List<Map<String, dynamic>> getMapsFromDynamics(List<dynamic> dynamics){

    List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

    if (canLoopList(dynamics)){

      for (dynamic map in dynamics){

        _maps.add(map);

      }

    }

    return _maps;
  }
// -----------------------------------------------------------------------------
  static bool stringsContainString({@required List<String> strings,@required  String string}){

    bool _containsIt = false;

    if (canLoopList(strings) && string != null){

      _containsIt = strings.contains(string);

    }

    return _containsIt;
  }
// -----------------------------------------------------------------------------
}
