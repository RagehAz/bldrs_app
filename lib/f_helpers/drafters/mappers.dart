import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:sembast/utils/value_utils.dart';

// -----------------------------------------------------------------------------

/// STRINGS GETTERS FROM LISTS

// -------------------------------------
List<String> getFirstValuesFromMaps(List<Map<String, Object>> listOfMaps) {

  /// TASK : check getFirstValuesFromMaps if not used in production
  /// [
  /// {'key' : 'ID'         , 'key' : 'Value'       },
  /// {'key' : 'firstValue' , 'key' : 'secondValue' },
  /// ]

  final List<String> _listOfFirstValues = <String>[];

  for (int x = 0; x < listOfMaps.length; x++) {
    final String _firstValue = (listOfMaps[x].values.toList())[0];
    _listOfFirstValues.add(_firstValue);
  }

  return _listOfFirstValues;
}
// -----------------------------------------------------------------------------
List<String> getSecondValuesFromMaps(List<Map<String, Object>> listOfMaps) {

  /// TASK : check getFirstValuesFromMaps if not used in production
  /// [
  /// {'key' : 'ID'         , 'key' : 'Value'       },
  /// {'key' : 'firstValue' , 'key' : 'secondValue' },
  /// ]

  final List<String> _listOfValues = <String>[];

  for (int x = 0; x < listOfMaps.length; x++) {
    final String _secondValue = (listOfMaps[x].values.toList())[1];
    _listOfValues.add(_secondValue);
  }

  return _listOfValues;
}
// -------------------------------------
List<String> getStringsFromDynamics({
  @required List<dynamic> dynamics,
}) {
  final List<String> _strings = <String>[];

  if (canLoopList(dynamics)) {
    for (final dynamic thing in dynamics) {
      if (thing is String == true) {
        _strings.add(thing);
      } else {
        _strings.add(thing.toString());
      }
    }
  }

  return _strings;
}
// -------------------------------------
List<String> getUniqueStringsFromStrings({
  @required List<String> strings,
}){

  final List<String> _output = <String>[];

  if (canLoopList(strings) == true){

    for (final String string in strings){

      if (_output.contains(string) == false){
        _output.add(string);
      }

    }

  }

  return _output;
}
// -------------------------------------
/// TESTED : WORKS PERFECT
List<String> getMapsPrimaryKeysValues({
  @required List<Map<String, dynamic>> maps,
  String primaryKey = 'id',
}){

  final List<String> _primaryKeys = <String>[];

  if (canLoopList(maps) == true){

    for (final Map<String, dynamic> map in maps){

      final String _id = map[primaryKey];

      _primaryKeys.add(_id);

    }

  }

  return _primaryKeys;
}
// -----------------------------------------------------------------------------

/// MAPS GETTERS FROM OTHER THINGS

// -------------------------------------
List<Map<String, dynamic>> getMapsFromQuerySnapshot({
  @required QuerySnapshot<Object> querySnapshot,
  @required bool addDocsIDs,
  @required bool addDocSnapshotToEachMap,
}) {
  final List<QueryDocumentSnapshot<Object>> _docsSnapshots =
      querySnapshot?.docs;

  final List<Map<String, dynamic>> _maps =
      getMapsFromQueryDocumentSnapshotsList(
    queryDocumentSnapshots: _docsSnapshots,
    addDocsIDs: addDocsIDs,
    addDocSnapshotToEachMap: addDocSnapshotToEachMap,
  );

  return _maps;
}
// -------------------------------------
List<Map<String, dynamic>> getMapsFromQueryDocumentSnapshotsList({
  @required List<QueryDocumentSnapshot<Object>> queryDocumentSnapshots,
  @required bool addDocsIDs,
  @required bool addDocSnapshotToEachMap,
}) {
  final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

  if (canLoopList(queryDocumentSnapshots)) {
    for (final QueryDocumentSnapshot<Object> docSnapshot in queryDocumentSnapshots) {

      Map<String, dynamic> _map = docSnapshot.data();

      if (addDocsIDs == true) {
        _map['id'] = docSnapshot.id;
      }

      if (addDocSnapshotToEachMap == true) {
        _map = insertPairInMap(
          map: _map,
          key: 'docSnapshot',
          value: docSnapshot,
        );
      }

      _maps.add(_map);
    }
  }

  return _maps;
}
// -------------------------------------
List<Map<String, dynamic>> getMapsFromDynamics(List<dynamic> dynamics) {
  final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

  if (canLoopList(dynamics)) {
    for (final dynamic map in dynamics) {
      _maps.add(map);
    }
  }

  return _maps;
}
// -------------------------------------
Map<String, dynamic> getMapFromDocumentSnapshot(dynamic documentSnapshot) {
  final Map<String, dynamic> _map = documentSnapshot.data();
  return _map;
}
// -------------------------------------
/// url query looks like "key1=value1&key1=value2&key3=value3"
Map<String, dynamic> getMapFromURLQuery({
  @required String urlQuery,
}) {
  /// url query should look like this
  /// 'country=eg&category=business&apiKey=65f7556ec76449fa7dc7c0069f040ca';

  Map<String, dynamic> _output = <String, dynamic>{};

  final int _numberOfAnds = '&'.allMatches(urlQuery).length;
  final int _numberOfEquals = '='.allMatches(urlQuery).length;
  final bool _countsOfPairsAreGood = _numberOfAnds + 1 == _numberOfEquals;

  /// if urlQuery counts are good
  if (_countsOfPairsAreGood == true) {
    /// pairs should look like this : key=value
    final List<String> _pairs = <String>[];

    /// holds temp trimmed url in here while trimming loops
    String _trimmedURL = urlQuery;

    blog('_trimmedURL : $_trimmedURL');

    /// trim urlQuery into string pairs
    for (int i = 0; i < _numberOfAnds; i++) {
      final String _beforeAnd =
      TextMod.removeTextAfterFirstSpecialCharacter(_trimmedURL, '&');
      _pairs.add(_beforeAnd);

      final String _afterAnd =
      TextMod.removeTextBeforeFirstSpecialCharacter(_trimmedURL, '&');

      if (i == _numberOfAnds - 1) {
        _pairs.add(_afterAnd);
      } else {
        _trimmedURL = _afterAnd;
      }
    }

    /// add pairs to a map
    for (final String pair in _pairs) {
      final String _key =
      TextMod.removeTextAfterFirstSpecialCharacter(pair, '=');
      final String _value =
      TextMod.removeTextBeforeFirstSpecialCharacter(pair, '=');

      _output = insertPairInMap(
        map: _output,
        key: _key,
        value: _value,
      );
    }
  }

  /// if counts are no good
  else {
    blog('getMapFromURLQuery : _countsOfPairsAreGood : $_countsOfPairsAreGood');
    blog(
        'getMapFromURLQuery : something is wrong in this : urlQuery : $urlQuery');
  }

  return _output;
}
// -----------------------------------------------------------------------------

/// MAP IN MAPS INDEX CHECKERS

// -------------------------------------
int indexOfMapInListOfMaps(List<Map<String, dynamic>> listOfMaps, Map<String, dynamic> map) {
  final int _indexOfTheMap =
      listOfMaps.indexWhere(
              (Map<String, dynamic> m) =>
                  mapsAreTheSame(
                     map1: m,
                     map2: map
                 )
      );
  return _indexOfTheMap;
}
// -------------------------------------
int indexOfMapByValueInListOfMaps({
  @required List<Map<String, dynamic>> listOfMaps,
  @required String key,
  @required dynamic value}) {
  final int _indexOfTheMap =
      listOfMaps.indexWhere((Map<String, dynamic> map) => map[key] == value);
  return _indexOfTheMap;
}
// -----------------------------------------------------------------------------

/// CLONING

// -------------------------------------
List<String> cloneListOfStrings(List<String> list) {
  final List<dynamic> _newList = <dynamic>[];

  for (final String x in list) {
    _newList.add(x);
  }
  return _newList;
}
// -----------------------------------------------------------------------------

/// MAPS MODIFIERS

// -------------------------------------
/// TESTED : WORKS PERFECT
Map<String, dynamic> insertPairInMap({
  @required Map<String, dynamic> map,
  @required String key,
  @required dynamic value,
}) {

  Map<String, dynamic> _result = <String, dynamic>{};

  if (map != null){
    map.putIfAbsent(key, () => value);
    _result = _result..addAll(map);
  }

  return _result;
}
// -------------------------------------
Map<String, Object> replacePair({
  @required Map<String, Object> map,
  @required String fieldKey,
  @required dynamic inputValue,
}) {
  final Map<String, Object> _aMap = cloneMap(map);

  try {
    _aMap[fieldKey] = inputValue;
  } on Exception catch (e) {
    blog('error is : $e');
    blog('map is : $map');
    blog('fieldKey is : $fieldKey');
    blog('inputValue : $inputValue');
  }

  return _aMap;
}
// -------------------------------------
Map<String, Object> removePair({
  @required Map<String, Object> map,
  @required String fieldKey,
}) {
  final Map<String, Object> _map = cloneMap(map);

  _map.remove(fieldKey);

  return _map;
}
// -----------------------------------------------------------------------------

/// CHECKERS

// -------------------------------------
/// TESTED : WORKS PERFECT
bool canLoopList(List<dynamic> list) {
  bool _canLoop = false;

  if (list != null && list.isNotEmpty) {
    _canLoop = true;
  }
  return _canLoop;
}
// -------------------------------------
bool mapsAreTheSame({
  Map<String, dynamic> map1,
  Map<String, dynamic> map2,
}) {
  bool _mapsAreTheSame;

  bool _inputsAreInvalid;

  if (map1 == null || map2 == null) {
    _inputsAreInvalid = true;
  } else {
    _inputsAreInvalid = false;
  }

  if (_inputsAreInvalid == true) {
    _mapsAreTheSame = null;
  } else {
    final List<String> _map1Keys = map1.keys.toList();
    final List<dynamic> _map1Values = map1.values.toList();

    final List<String> _map2Keys = map2.keys.toList();
    final List<dynamic> _map2Values = map2.values.toList();

    if (_map1Keys.length != _map2Keys.length) {
      _mapsAreTheSame = false;
    } else {
      if (listsAreTheSame(list1: _map1Keys, list2: _map2Keys) == true &&
          listsAreTheSame(list1: _map1Values, list2: _map2Values) == true) {
        _mapsAreTheSame = true;
      } else {
        _mapsAreTheSame = false;
      }
    }
  }

  return _mapsAreTheSame;
}
// -------------------------------------
bool listOfMapsContainValue({
  @required List<Map<String, dynamic>> listOfMaps,
  @required String field,
  @required String value,
}) {
  bool _listOfMapContainsTheValue;

  for (final Map<String, dynamic> map in listOfMaps) {
    if (map[field] == value) {
      _listOfMapContainsTheValue = true;
      break;
    } else {
      _listOfMapContainsTheValue = false;
    }
  }

  return _listOfMapContainsTheValue;
}
// -------------------------------------
bool listOfMapsContainMap({
  @required List<Map<String, dynamic>> listOfMaps,
  @required Map<String, dynamic> map,
}) {

  /// listOfMaps = [
  /// {'key1' : 'value', 'key2' : 'value2'}
  /// {'key1' : 'value', 'key2' : 'value2'}
  /// {'key1' : 'value', 'key2' : 'value2'}
  /// ];
  ///
  /// map = {'key1' : 'value', 'key2' : 'value2'};

  // ---------------------------------
  bool _inputsAreInvalid;

  if (listOfMaps == null || listOfMaps.isEmpty || map == null) {
    _inputsAreInvalid = true;
  } else {
    _inputsAreInvalid = false;
  }
  // ---------------------------------
  bool _listOfMapContainsTheMap;

  if (_inputsAreInvalid == true) {
    _listOfMapContainsTheMap = false;
  }

  else {

    for (final Map<String, dynamic> _map in listOfMaps) {

      final bool _mapsAreTheSame = mapsAreTheSame(
        map1: _map,
        map2: map,
      );

      if (_mapsAreTheSame == true) {
        _listOfMapContainsTheMap = true;
        break;
      }

      else {
        _listOfMapContainsTheMap = false;
      }

    }
  }

  return _listOfMapContainsTheMap;
}
// -------------------------------------
bool listsAreTheSame({
  @required List<dynamic> list1,
  @required List<dynamic> list2
}) {
  bool listsAreTheSame = false;

  if (list1 == null && list2 == null){
    listsAreTheSame = true;
  }
  else if (list1 == [] && list2 == []){
    listsAreTheSame = true;
  }

  else if (canLoopList(list1) == true && canLoopList(list2) == true){

    if (list1.length != list2.length) {
      listsAreTheSame = false;
    }

    else {
      for (int i = 0; i < list1.length; i++) {

        if (list1[i] != list2[i]) {
          listsAreTheSame = false;
          break;
        }

        else {
          listsAreTheSame = true;
        }

      }
    }

  }



  return listsAreTheSame;
}
// -------------------------------------
/// TESTED : WORKS PERFECT
bool stringsContainString({
  @required List<String> strings,
  @required String string,
}) {
  bool _containsIt = false;

  if (canLoopList(strings) && string != null) {
    _containsIt = strings.contains(string);
  }

  return _containsIt;
}
// -----------------------------------------------------------------------------

/// BLOGGING MAPS

// -------------------------------------
void blogMap(Map<String, dynamic> map) {
  blog('MAP-PRINT --------------------------------------------------START');

  final List<String> _keys = map.keys.toList();
  final List<dynamic> _values = map.values.toList();

  for (int i = 0; i < _keys.length; i++) {
    blog('MAP-PRINT : ${_keys[i]} : ${_values[i]}');
  }

  blog('MAP-PRINT --------------------------------------------------END');
}
// -------------------------------------
void blogMaps(List<Map<String, dynamic>> maps) {
  if (canLoopList(maps)) {
    for (final Map<String, dynamic> map in maps) {
      blogMap(map);
    }
  }
}
// -----------------------------------------------------------------------------
