import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:sembast/utils/value_utils.dart';
// -----------------------------------------------------------------------------
  /*
  typedef dMap = Map<String, dynamic>;
   */
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
/// TESTED : WORKS PERFECT
List<String> getStringsFromDynamics({
  @required List<dynamic> dynamics,
}) {
  final List<String> _strings = <String>[];

  if (checkCanLoopList(dynamics)) {
    for (final dynamic thing in dynamics) {
      if (thing is String == true) {
        _strings.add(thing);
      } else {
        _strings.add(thing.toString());
      }
    }
  }

  // blog('getStringsFromDynamics : _strings : $_strings');

  return _strings;
}
// -------------------------------------
List<String> getUniqueStringsFromStrings({
  @required List<String> strings,
}){

  final List<String> _output = <String>[];

  if (checkCanLoopList(strings) == true){

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

  if (checkCanLoopList(maps) == true){

    for (final Map<String, dynamic> map in maps){

      final String _id = map[primaryKey];

      _primaryKeys.add(_id);

    }

  }

  return _primaryKeys;
}
// -----------------------------------------------------------------------------

/// STRINGS MODIFIERS

// -------------------------------------
/// TESTED : WORKS PERFECT
List<String> removeStringsFromStrings({
  @required List<String> removeFrom,
  @required List<String> removeThis,
}){

  final List<String> _output = <String>[];

  if (checkCanLoopList(removeFrom) == true){

      for (final String string in removeFrom){

        final bool _canRemove = checkStringsContainString(
            strings: removeThis,
            string: string
        );

        if (_canRemove == true){
          blog('removeStringsFromStrings : removing : $string');
        }
        else {
          _output.add(string);
        }

      }

  }

  return _output;
}
// -------------------------------------
/// TESTED : WORKS PERFECT
List<String> putStringInStringsIfAbsent({
  @required List<String> strings,
  @required String string,
}){

  List<String> _output = <String>[];

  if (checkCanLoopList(strings) == true){

    _output = <String>[...strings];

  }

  final bool _contains = checkStringsContainString(
    strings: _output,
    string: string,
  );

  if (_contains == false){
    _output.add(string);
  }


  return _output;
}
// -------------------------------------
List<String> cleanDuplicateStrings({
  @required List<String> strings,
}){
  final List<String> _output = <String>[];

  if (checkCanLoopList(strings) == true){

    for (final String string in strings){

      if (_output.contains(string) == false){
        _output.add(string);
      }

    }

  }

  return _output;
}
// -----------------------------------------------------------------------------

/// MAPS - QUERY SNAPSHOT - QUERY DOCUMENT SNAPSHOT

// -------------------------------------
List<Map<String, dynamic>> getMapsFromQuerySnapshot({
  @required QuerySnapshot<Object> querySnapshot,
  @required bool addDocsIDs,
  @required bool addDocSnapshotToEachMap,
}) {

  final List<QueryDocumentSnapshot<Object>> _docsSnapshots = querySnapshot?.docs;

  final List<Map<String, dynamic>> _maps = getMapsFromQueryDocumentSnapshotsList(
    queryDocumentSnapshots: _docsSnapshots,
    addDocsIDs: addDocsIDs,
    addDocSnapshotToEachMap: addDocSnapshotToEachMap,
  );

  return _maps;
}
// -------------------------------------
/// TESTED : WORKS PERFECT
List<Map<String, dynamic>> getMapsFromQueryDocumentSnapshotsList({
  @required List<QueryDocumentSnapshot<Object>> queryDocumentSnapshots,
  @required bool addDocsIDs,
  @required bool addDocSnapshotToEachMap,
}) {

  final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

  if (checkCanLoopList(queryDocumentSnapshots)) {
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
// -----------------------------------------------------------------------------

/// MAPS - SNAPSHOTS

// -------------------------------------
/// TESTED : WORKS PERFECT
Map<String, dynamic> getMapFromDocumentSnapshot({
  @required DocumentSnapshot<Object> docSnapshot,
  @required bool addDocID,
  @required bool addDocSnapshot,
}) {

  Map<String, dynamic> _map = docSnapshot?.data();

  if (docSnapshot != null && docSnapshot.exists == true){

    if (addDocID == true) {
      _map['id'] = docSnapshot.id;
    }

    if (addDocSnapshot == true) {
      _map = insertPairInMap(
        map: _map,
        key: 'docSnapshot',
        value: docSnapshot,
      );
    }

  }

  return _map;
}
// -------------------------------------
/// TESTED : WORKS PERFECT
Map<String, dynamic> getMapFromDataSnapshot({
  @required DataSnapshot snapshot,
  bool addDocID = true,
  Function onExists,
  Function onNull,
}){

  Map<String, dynamic> _output;

  if (snapshot.exists) {
    _output = Map<String, dynamic>.from(snapshot.value);

    if (addDocID == true){
      _output = insertPairInMap(
          map: _output,
          key: 'id',
          value: snapshot.key,
      );
    }

    if (onExists != null){
      onExists();
    }
  }

  else {
    if (onNull != null){
      onNull();
    }
  }

  return _output;
}
// -------------------------------------
List<Map<String, dynamic>> getMapsFromDataSnapshots({
  @required List<DataSnapshot> snapshots,
  bool addDocsIDs = true,
}){

  final List<Map<String, dynamic>> _output = <Map<String, dynamic>>[];

  if (checkCanLoopList(snapshots) == true){

    for (final DataSnapshot snap in snapshots){

      final Map<String, dynamic> _map = getMapFromDataSnapshot(
        snapshot: snap,
        addDocID: addDocsIDs,
      );

      _output.add(_map);

    }

  }

  return _output;
}

// -----------------------------------------------------------------------------

/// MAP GETTERS FROM (URL - DYNAMIC - STRING STRING IMMUTABLE MAP STRING OBJECT)

// -------------------------------------
List<Map<String, dynamic>> getMapsFromDynamics(List<dynamic> dynamics) {
  final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

  if (checkCanLoopList(dynamics)) {
    for (final dynamic map in dynamics) {
      _maps.add(map);
    }
  }

  return _maps;
}
// -------------------------------------

Map<String, dynamic> getMapFromURLQuery({
  @required String urlQuery,
}) {

  /// url query should look like this
  /// 'country=eg&category=business&apiKey=65f7556ec76449fa7dc7c0069f040ca';
  /// url query looks like "key1=value1&key1=value2&key3=value3"

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
// -------------------------------------
/// TESTED : WORKS PERFECT
Map<String, String> getStringStringMapFromImmutableMapStringObject(dynamic object){

  Map<String, String> _output = {};

  if (object != null){

      blog('1 - FUCK : object ${object.runtimeType}');

      if (object.runtimeType.toString() == 'ImmutableMap<String, Object?>'){

        final Map _map =  object;
        blog('3 - FUCK : _map : ${_map.runtimeType}');
        final List<String> _keys = _map.keys.toList();

        if (checkCanLoopList(_keys) == true){

          for (final String key in _keys){

            final String _value = _map[key] is String ? _map[key] : _map[key].toString();

            _output = _insertPairInMapWithStringValue(
                map: _output,
                key: key,
                value: _value,
            );

          }

        }

      }

      else {
        blog('getStringStringMapFromImmutableMapStringObject : starts : is NOT IMMUTABLE MAP');
      }

  }

  blog('4 - getStringStringMapFromImmutableMapStringObject : _output ${_output.runtimeType}');
  blogMap(_output);

  // assert(_output != null, 'DO NOT CONTINUE BITCH');

  return _output;
}
// -----------------------------------------------------------------------------

/// MAP IN MAPS INDEX CHECKERS

// -------------------------------------
int indexOfMapInListOfMaps(List<Map<String, dynamic>> listOfMaps, Map<String, dynamic> map) {
  final int _indexOfTheMap =
      listOfMaps.indexWhere(
              (Map<String, dynamic> m) =>
                  checkMapsAreIdentical(
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
/// TESTED : WORKS PERFECT
Map<String, String> _insertPairInMapWithStringValue({
  @required Map<String, String> map,
  @required String key,
  @required String value,
}) {

  Map<String, String> _result = <String, String>{};

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
// -------------------------------------
/// TESTED : WORKS PERFECT
List<Map<String, dynamic>> cleanDuplicateMaps({
  @required List<Map<String, dynamic>> maps,
}){
  final List<Map<String, dynamic>> _output = <Map<String, dynamic>>[];
  
  if (checkCanLoopList(maps) == true){
    
    for (final Map<String, dynamic> map in maps){
      
      final bool _exists = checkMapsContainMap(
          maps: _output,
          map: map,
      );
      
      if (_exists == false){
        _output.add(map);
      }
      
    }
    
  }
  
  return _output;
}
// -------------------------------------
/// TESTED : WORKS PERFECT
List<Map<String, dynamic>> cleanMapsOfDuplicateIDs({
  @required List<Map<String, dynamic>> maps,
  @required String idFieldName,
}){
  final List<Map<String, dynamic>> _output = <Map<String, dynamic>>[];

  if (checkCanLoopList(maps) == true){

    for (final Map<String, dynamic> map in maps){

      final int _index = _output.indexWhere((m) => m[idFieldName] == map[idFieldName]);

      if (_index == -1){
        _output.add(map);
      }

    }

  }

  return _output;
}
// -----------------------------------------------------------------------------

/// CHECKERS

// -------------------------------------
/// TESTED : WORKS PERFECT
bool checkCanLoopList(List<dynamic> list) {
  bool _canLoop = false;

  if (list != null && list.isNotEmpty) {
    _canLoop = true;
  }
  return _canLoop;
}
// -------------------------------------
/// TESTED : WORKS PERFECT
bool checkListHasNullValue(List<dynamic> list){
  bool _hasNull = false;

  if (checkCanLoopList(list) == true){

    _hasNull = list.contains(null);

  }

  return _hasNull;
}
// -------------------------------------
/// TESTED : WORKS PERFECT
bool checkMapsAreIdentical({
  Map<String, dynamic> map1,
  Map<String, dynamic> map2,
}) {
  bool _mapsAreIdentical = false;

  if (map1 == null && map2 == null) {
    _mapsAreIdentical = true;
  }

  else if (map1 == null || map2 == null){
    _mapsAreIdentical = false;
  }

  else if (map1 != null && map2 != null){

    final List<String> _map1Keys = map1.keys.toList();
    final List<String> _map2Keys = map2.keys.toList();

    if (_map1Keys.length != _map2Keys.length) {
      _mapsAreIdentical = false;
    }

    else {

      final List<dynamic> _map1Values = map1.values.toList();
      final List<dynamic> _map2Values = map2.values.toList();

      if (
      checkListsAreIdentical(list1: _map1Keys, list2: _map2Keys) == true
          &&
      checkListsAreIdentical(list1: _map1Values, list2: _map2Values) == true
      ){
        _mapsAreIdentical = true;
      }

      else {
        _mapsAreIdentical = false;
      }
    }

  }

  return _mapsAreIdentical;
}
// -------------------------------------
/// TESTED : WORKS PERFECT
bool checkMapsListsAreIdentical({
  @required List<Map<String, dynamic>> maps1,
  @required List<Map<String, dynamic>> maps2,
}){
  bool _listsAreIdentical = false;

  if (maps1 == null && maps2 == null){
    _listsAreIdentical = true;
  }

  else if (maps1 == [] && maps2 == []){
    _listsAreIdentical = true;
  }

  else if (checkCanLoopList(maps1) == true && checkCanLoopList(maps2) == true){

    if (maps1.length != maps2.length) {
      // blog('lists do not have the same length : list1 is ${maps1.length} : list2 is ${maps2.length}');
      // blog(' ---> lis1 is ( ${maps1.toString()} )');
      // blog(' ---> lis2 is ( ${maps2.toString()} )');
      _listsAreIdentical = false;
    }

    else {
      for (int i = 0; i < maps1.length; i++) {

        final bool _mapsAreIdentical = checkMapsAreIdentical(
          map1: maps1[i],
          map2: maps2[i],
        );

        if (_mapsAreIdentical == false) {
          // blog('items at index ( $i ) do not match : ( ${maps1[i]} ) <=> ( ${maps2[i]} )');
          _listsAreIdentical = false;
          break;
        }

        else {
          _listsAreIdentical = true;
        }

      }
    }

  }

  return _listsAreIdentical;

}
// -------------------------------------
bool checkMapsContainValue({
  @required List<Map<String, dynamic>> listOfMaps,
  @required String field,
  @required String value,
}) {
  bool _listOfMapContainsTheValue;

  for (final Map<String, dynamic> map in listOfMaps) {

    if (map[field] == value) {
      _listOfMapContainsTheValue = true;
      break;
    }

    else {
      _listOfMapContainsTheValue = false;
    }

  }

  return _listOfMapContainsTheValue;
}
// -------------------------------------
bool checkMapsContainMap({
  @required List<Map<String, dynamic>> maps,
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

  if (maps == null || maps.isEmpty || map == null) {
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

    for (final Map<String, dynamic> _map in maps) {

      final bool _mapsAreIdentical = checkMapsAreIdentical(
        map1: _map,
        map2: map,
      );

      if (_mapsAreIdentical == true) {
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
/// TESTED : WORKS PERFECT
bool checkListsAreIdentical({
  @required List<dynamic> list1,
  @required List<dynamic> list2
}) {
  bool _listsAreIdentical = false;

  if (list1 == null && list2 == null){
    _listsAreIdentical = true;
  }
  else if (list1.isEmpty && list2.isEmpty){
    _listsAreIdentical = true;
  }

  else if (checkCanLoopList(list1) == true && checkCanLoopList(list2) == true){

    if (list1.length != list2.length) {
      // blog('lists do not have the same length : list1 is ${list1.length} : list2 is ${list2.length}');
      // blog(' ---> lis1 is ( ${list1.toString()} )');
      // blog(' ---> lis2 is ( ${list2.toString()} )');
      _listsAreIdentical = false;
    }

    else {
      for (int i = 0; i < list1.length; i++) {

        if (list1[i] != list2[i]) {
          // blog('items at index ( $i ) do not match : ( ${list1[i]} ) <=> ( ${list2[i]} )');
          _listsAreIdentical = false;
          break;
        }

        else {
          _listsAreIdentical = true;
        }

      }
    }

  }

  return _listsAreIdentical;
}
// -------------------------------------
/// TESTED : WORKS PERFECT
bool checkStringsContainString({
  @required List<String> strings,
  @required String string,
}) {
  bool _containsIt = false;

  if (checkCanLoopList(strings) && string != null) {
    _containsIt = strings.contains(string);
  }

  return _containsIt;
}
// -------------------------------------

bool checkIsLastListObject({
  @required List<dynamic> list,
  @required int index,
}){

  bool _isAtLast = false;

  if (checkCanLoopList(list) == true){

    if (index != null){

      _isAtLast = index == (list.length - 1);

    }

  }

  return _isAtLast;
}
// -----------------------------------------------------------------------------

/// BLOGGING MAPS

// -------------------------------------
/// TESTED : WORKS PERFECT
void blogMap(Map<dynamic, dynamic> map, {String methodName = ''}) {
  blog('MAP-PRINT $methodName : --------------------------------------------------START');

  if (map != null){
    final List<dynamic> _keys = map.keys.toList();
    final List<dynamic> _values = map.values.toList();

    for (int i = 0; i < _keys.length; i++) {
      blog('MAP-PRINT : ${_keys[i]} : ${_values[i]}');
    }
  }
  else {
    blog('map is null : can not blog');
  }

  blog('MAP-PRINT $methodName : --------------------------------------------------END');
}
// -------------------------------------
/// TESTED : WORKS PERFECT
void blogMaps(List<Map<dynamic, dynamic>> maps, {String methodName}) {
  if (checkCanLoopList(maps)) {
    for (final Map<dynamic, dynamic> map in maps) {
      blogMap(map, methodName: methodName);
    }
  }
}
// -----------------------------------------------------------------------------

/// ?

// -------------------------------------
/// TESTED : WORKS PERFECT
List<double> getDoublesFromDynamics(List<dynamic> dynamics){

  final List<double> _output = <double>[];

  if (checkCanLoopList(dynamics) == true){

    for (final dynamic dyn in dynamics){

      if (dyn is double){
        final double _double = dyn;
        _output.add(_double);
      }

    }

  }

  return _output;
}
