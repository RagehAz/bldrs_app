// ignore_for_file: noop_primitive_operations
import 'dart:convert';

import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

enum InsertionDuplicity {
  dontInsert,
  replace,
}

/// => TAMAM
class Mapper {
  // -----------------------------------------------------------------------------

  const Mapper();

  // -----------------------------------------------------------------------------

  /// STRINGS GETTERS FROM LISTS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getMapsPrimaryKeysValues({
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

  /// MAPS - QUERY SNAPSHOT - QUERY DOCUMENT SNAPSHOT

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> getMapsFromQuerySnapshot({
    @required QuerySnapshot<Object> querySnapshot,
    @required bool addDocsIDs,
    @required bool addDocSnapshotToEachMap,
  }) {

    return getMapsFromQueryDocumentSnapshotsList(
      queryDocumentSnapshots: querySnapshot?.docs,
      addDocsIDs: addDocsIDs,
      addDocSnapshotToEachMap: addDocSnapshotToEachMap,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> getMapsFromQueryDocumentSnapshotsList({
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

  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> getMapFromDocumentSnapshot({
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> getMapFromDataSnapshot({
    @required DataSnapshot snapshot,
    bool addDocID = true,
    Function onExists,
    Function onNull,
  }){
    Map<String, dynamic> _output;

    if (snapshot.exists) {

      // blog('snapshot.value : ${snapshot.value} : type : ${snapshot.value.runtimeType}');

      if (snapshot.value.runtimeType.toString() == '_InternalLinkedHashMap<Object?, Object?>'){
        _output = getMapFromIHLMOO(
          ihlmoo: snapshot.value,
        );
      }
      else {
        _output = Map<String, dynamic>.from(snapshot.value);
      }


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
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> getMapsFromDataSnapshot({
    @required DataSnapshot snapshot,
    // bool addDocID = true,
  }) {
    List<Map<String, dynamic>> _output;

    if (snapshot.exists) {

      // blog('snapshot type : ${snapshot.value.runtimeType}');

      // if (snapshot.value.runtimeType.toString() == 'List<Object?>'){

        _output = [];

        final List<dynamic> _dynamics = snapshot.children.toList();

        for (final dynamic object in _dynamics){

          final Map<String, dynamic> _maw = getMapFromDataSnapshot(
            snapshot: object,
            // addDocID: true,
          );

          _output.add(_maw);

        }

      // }

      // if (snapshot.value.runtimeType.toString() == '_InternalLinkedHashMap<Object?, Object?>'){
      //
      //   final Map<String, dynamic> _map = getMapFromInternalHashLinkedMapObjectObject(
      //     internalHashLinkedMapObjectObject: snapshot.value,
      //   );
      //
      //   Mapper.blogMap(_map, invoker: 'the fookin maw');
      //
      //   _output = [];
      //   if (_map != null){
      //     _output.add(_map);
      //   }
      //
      // }


    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> getMapsFromDataSnapshots({
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

  // --------------------
  /// NOT USED
  /*
  static List<Map<String, dynamic>> getMapsFromDynamics(List<dynamic> dynamics) {
    final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

    if (checkCanLoopList(dynamics) == true) {
      for (final dynamic map in dynamics) {
        _maps.add(map);
      }
    }

    return _maps;
  }
   */
  // --------------------
  /// NOT USED
  /*
  static Map<String, dynamic> getMapFromURLQuery({
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
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> getMapFromIHLMOO({
    @required Object ihlmoo,
  }){
    Map<String, dynamic> _output;

    /// NOTE : IHLMOO = Internal Hash Linked Map Object Object

    if (ihlmoo != null){
      _output = jsonDecode(jsonEncode(ihlmoo));
      // _output = Map<String, dynamic>.from(internalHashLinkedMapObjectObject);
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> getMapsFromIHLMOO({
    @required Object ihlmoo,
    bool addChildrenIDs = true,
  }){
    final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

    /// NOTE : IHLMOO = Internal Hash Linked Map Object Object

    if (ihlmoo != null){

      final Map<String, dynamic> _bigMap = jsonDecode(jsonEncode(ihlmoo));
      // Map.from(internalHashLinkedMapObjectObject);
      final List<String> _ids = _bigMap.keys.toList();

      for (final String id in _ids){

        Map<String, dynamic> _map = jsonDecode(jsonEncode(_bigMap[id]));
        // Map.from();

        if (addChildrenIDs == true){
          _map = insertPairInMap(
            map: _map,
            key: 'id',
            value: id,
          );
        }

        _maps.add(_map);

      }

    }

    return _maps;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, String> createStringStringMap({
    @required Map hashMap,
    @required bool stringifyNonStrings,
  }){
    Map<String, String> _output;

    // blog('1 - createStringStringMap : hashMap : $hashMap');

    if (hashMap != null){

      final List<String> _keys = hashMap.keys?.toList();

      // blog('1 - createStringStringMap : _keys : $_keys');

      if (checkCanLoopList(_keys) == true){
        _output = {};

        for (final String key in _keys){

          if (hashMap[key] is String){

            _output[key] = hashMap[key];

            // blog('2 - createStringStringMap : added : ($key : ${_output[key]})');

          }
          else {

            if (stringifyNonStrings == true){
              _output[key] = hashMap[key].toString();
              // blog('2 - createStringStringMap : added : ($key : ${_output[key].toString()})');

            }

          }

        }

      }

    }

    // blog('3 - createStringStringMap : _output : $_output');

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// MAP IN MAPS INDEX CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> getMapFromMapsByID({
    @required List<Map<String, dynamic>> maps,
    @required String id,
    String idFieldName = 'id',
  }){
    Map<String, dynamic> _output;

    if (checkCanLoopList(maps) == true && id != null){

      final int _index = getMapIndexByID(
        maps: maps,
        id: id,
        idFieldName: idFieldName,
      );

      /// NOT FOUND
      if (_index == -1){
        // output is null
      }
      /// FOUND
      else {
        _output = maps[_index];
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int getMapIndexByID({
    @required List<Map<String, dynamic>> maps,
    @required String id,
    String idFieldName,
  }) {
    if (checkCanLoopList(maps) == true){
      return maps.indexWhere((Map<String, dynamic> m) => m[idFieldName] == id);
    }
    else {
      return -1;
    }
  }
  // --------------------
  /// NOT USED
  /*
  static int indexOfMapByValueInListOfMaps({
    @required List<Map<String, dynamic>> listOfMaps,
    @required String key,
    @required dynamic value,
  }) {
    return listOfMaps.indexWhere((Map<String, dynamic> map) => map[key] == value);
  }
   */
  // -----------------------------------------------------------------------------

  /// MAPS MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> insertPairInMap({
    @required Map<String, dynamic> map,
    @required String key,
    @required dynamic value,
    bool overrideExisting = false,
  }) {

    Map<String, dynamic> _result = <String, dynamic>{};

    if (map != null){

      _result = map;

      /// PAIR IS NULL
      if (map[key] == null){
        _result.putIfAbsent(key, () => value);
      }

      /// PAIR HAS VALUE
      else {
        if (overrideExisting == true){
          _result[key] = value;
        }
      }

    }

    return _result;
  }
  // --------------------
  /// NOT USED
  /*
  static Map<String, Object> replacePair({
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
   */
  // --------------------
  /// NOT USED
  /*
  static Map<String, Object> removePair({
    @required Map<String, Object> map,
    @required String fieldKey,
  }) {
    final Map<String, Object> _map = cloneMap(map);

    _map.remove(fieldKey);

    return _map;
  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> insertMapInMap({
    @required Map<String, dynamic> baseMap,
    @required Map<String, dynamic> insert,
    bool replaceDuplicateKeys = true,
  }){
    Map<String, dynamic> _output = {};

    if (baseMap != null){

      _output = baseMap;

      if (insert != null){

        final List<String> _keys = insert.keys.toList();

        if (checkCanLoopList(_keys) == true){

          for (final String key in _keys){

              _output = insertPairInMap(
                map: _output,
                key: key,
                value: insert[key],
                overrideExisting: replaceDuplicateKeys,
              );

          }

        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> cleanDuplicateMaps({
    @required List<Map<String, dynamic>> maps,
  }){
    final List<Map<String, dynamic>> _output = <Map<String, dynamic>>[];

    if (checkCanLoopList(maps) == true){

      for (final Map<String, dynamic> map in maps){

        final bool _exists = checkMapsContainIdenticalMap(
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> cleanMapsOfDuplicateIDs({
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> replaceMapInMapsWithSameIDField({
    @required List<Map<String, dynamic>> baseMaps,
    @required Map<String, dynamic> mapToReplace,
    String idFieldName = 'id',
  }){
    List<Map<String, dynamic>> _output = <Map<String, dynamic>>[];

    // Mapper.blogMap(mapToReplace, invoker: 'replaceMapInMapsWithSameIDField');

    /// Note : if baseMaps is empty, there will be nothing to replace ya zaki
    if (checkCanLoopList(baseMaps) == true && mapToReplace != null){

      _output = <Map<String,dynamic>>[...baseMaps];

      final int _index = _output.indexWhere((map){
        final bool _condition = map[idFieldName] == mapToReplace[idFieldName];
        return _condition;
      });

      /// IF FOUND
      if (_index != -1){
        // blog('replaceMapInMapsWithSameIDField : found map to replace at index $_index');
        _output.removeAt(_index);
        _output.insert(_index, mapToReplace);
      }
      // else {
      //   blog('replaceMapInMapsWithSameIDField : did not find this map');
      // }


    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> removeMapFromMapsByIdField({
    @required List<Map<String, dynamic>> baseMaps,
    @required String mapIDToRemove,
    String idFieldName = 'id',
  }){
    List<Map<String, dynamic>> _output = <Map<String, dynamic>>[];

    // Mapper.blogMap(mapToReplace, invoker: 'replaceMapInMapsWithSameIDField');

    /// NOTE : if maps is empty, nothing to remove ya zaki bardo
    if (checkCanLoopList(baseMaps) == true && mapIDToRemove != null){

      _output = <Map<String,dynamic>>[...baseMaps];

      final int _index = _output.indexWhere((map){
        final bool _condition = map[idFieldName] == mapIDToRemove;
        return _condition;
      });

      /// IF FOUND
      if (_index != -1){
        // blog('removeMapFromMapsByIdField : found map to remove at index $_index');
        _output.removeAt(_index);
      }
      // else {
      //   blog('removeMapFromMapsByIdField : did not find this map and nothing is removed');
      // }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> cleanNullPairs(Map<String, dynamic> map){
    Map<String, dynamic> _output;

    if (map != null){

      _output = {};
      final List<String> _keys = map.keys.toList();

      for (final String key in _keys){

        if (map[key] != null){

          if (map[key] is Map<String, dynamic>){
            final Map<String, dynamic> _sub = cleanNullPairs(map[key]);
            _output = insertPairInMap(
              map: _output,
              key: key,
              value: _sub,
            );
          }

          else {
            _output = insertPairInMap(
              map: _output,
              key: key,
              value: map[key],
            );
          }

        }

        // else {
        //   blog('$key : value is null');
        // }

      }

      if (_output.keys.isEmpty == true){
        _output = null;
      }

    }

    // else {
    //   blog('cleanNullPairs: map is null');
    // }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DYNAMIC LISTS CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkCanLoopList(List<dynamic> list) {
    bool _canLoop = false;

    if (list != null && list.isNotEmpty) {
      _canLoop = true;
    }
    return _canLoop;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkListHasNullValue(List<dynamic> list){
    bool _hasNull = false;

    if (checkCanLoopList(list) == true){

      _hasNull = list.contains(null);

    }

    return _hasNull;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkListsAreIdentical({
    @required List<dynamic> list1,
    @required List<dynamic> list2
  }) {
    bool _listsAreIdentical = false;

    if (list1 == null && list2 == null){
      _listsAreIdentical = true;
    }
    else if (list1?.isEmpty == true && list2?.isEmpty == true){
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
  // --------------------
  /// NOT USED
  /*
  ///
  static bool checkIsLastListObject({
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
   */
  // -----------------------------------------------------------------------------

  /// IDENTICAL MAPS CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkMapsAreIdentical({
    @required Map<String, dynamic> map1,
    @required Map<String, dynamic> map2,
  }) {
    bool _mapsAreIdentical = false;

    /// BOTH ARE NULL
    if (map1 == null && map2 == null) {
      _mapsAreIdentical = true;
    }

    /// BOTH AREN'T NULL BUT ATLEAST ONE OF THEM IS NULL
    else if (map1 == null || map2 == null){
      _mapsAreIdentical = false;
    }

    /// NON OF THEM IS NULL
    else if (map1 != null && map2 != null){

      if (map1.toString() == map2.toString()){
        _mapsAreIdentical = true;
      }
      else {
        _mapsAreIdentical = false;
      }

      // final List<String> _map1Keys = map1.keys.toList();
      // final List<String> _map2Keys = map2.keys.toList();
      //
      // /// KEYS LENGTH ARE DIFFERENT
      // if (_map1Keys.length != _map2Keys.length) {
      //   _mapsAreIdentical = false;
      // }
      //
      // /// KEYS LENGTH ARE IDENTICAL
      // else {
      //
      //   /// FOR EACH PAIR
      //   for (int i = 0; i < _map1Keys.length; i++){
      //
      //     final String _key1 = _map1Keys[i];
      //     final String _key2 = _map1Keys[i];
      //
      //     /// KEYS ARE DIFFERENT
      //     if (_key1 != _key2){
      //       _mapsAreIdentical = false;
      //       break;
      //     }
      //
      //     /// KEYS ARE IDENTICAL
      //     else {
      //
      //       /// BOTH VALUES ARE NULL
      //       if (map1[_key1] == null && map2[_key2] == null){
      //         // continue looping
      //       }
      //
      //       /// BOTH VALUES ARE NOT NULL BUT ONE OF THEM IS
      //       else if (map1[_key1] == null || map2[_key2] == null){
      //         _mapsAreIdentical = false;
      //         break;
      //       }
      //
      //       /// BOTH VALUES ARE NOT NULL
      //       else {
      //
      //         /// VALUE TYPES ARE DIFFERENT
      //         if (map1[_key1].runtimeType != map2[_key2].runtimeType){
      //           _mapsAreIdentical = false;
      //           break;
      //         }
      //
      //         /// VALUE TYPES ARE IDENTICAL
      //         else {
      //
      //           if (
      //               map1[_key1] is String ||
      //               map1[_key1] is int ||
      //               map1[_key1] is double ||
      //               map1[_key1] is bool
      //           ){
      //
      //             if (map1[_key1] != map2[_key2]){
      //               _mapsAreIdentical = false;
      //               break;
      //             }
      //
      //           }
      //
      //           else if (map1[_key1] is List){
      //
      //           }
      //
      //         }
      //
      //       }
      //
      //
      //     }
      //
      //   }
      //
      //   // final List<dynamic> _map1Values = map1.values.toList();
      //   // final List<dynamic> _map2Values = map2.values.toList();
      //   //
      //   // if (
      //   //     checkListsAreIdentical(list1: _map1Keys, list2: _map2Keys) == true
      //   //     &&
      //   //     checkListsAreIdentical(list1: _map1Values, list2: _map2Values) == true
      //   // ){
      //   //   _mapsAreIdentical = true;
      //   // }
      //   //
      //   // else {
      //   //   _mapsAreIdentical = false;
      //   // }
      //
      // }

    }

    return _mapsAreIdentical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkMapsListsAreIdentical({
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

    if (_listsAreIdentical == false){
      blogMapsListsDifferences(
        maps1: maps1,
        maps2: maps2,
        invoker: 'checkMapsListsAreIdentical',
      );
    }
    return _listsAreIdentical;

  }
  // -----------------------------------------------------------------------------

  /// MAP CONTAINS ?

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkMapsContainMapWithID({
    @required List<Map<String, dynamic>> maps,
    @required Map<String, dynamic> map,
    String idFieldName = 'id',
  }){
    bool _include = false;

    /// Note : if baseMaps is empty, there will be nothing to replace ya zaki
    if (checkCanLoopList(maps) == true && map != null){

      final int _index = maps.indexWhere((maw){
        final bool _condition = maw[idFieldName] == map[idFieldName];
        return _condition;
      });

      /// IF FOUND
      if (_index != -1){
        _include = true;
      }

    }

    return _include;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkMapsContainIdenticalMap({
    @required List<Map<String, dynamic>> maps,
    @required Map<String, dynamic> map,
  }) {
    bool _contain = false;

    if (checkCanLoopList(maps) == true && map != null){

      for (final Map<String, dynamic> _map in maps){

        final bool _identical = checkMapsAreIdentical(
          map1: map,
          map2: _map,
        );

        if (_identical == true){
          _contain = true;
          break;
        }

      }

    }

    return _contain;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkMapsContainValue({
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
  // -----------------------------------------------------------------------------

  /// BLOGGING MAPS

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogMap(Map<dynamic, dynamic> map, {String invoker = ''}) {

    if (map != null){

      blog('$invoker ~~~> <String, dynamic>{');

      final List<dynamic> _keys = map.keys.toList();
      final List<dynamic> _values = map.values.toList();

      for (int i = 0; i < _keys.length; i++) {

        final String _index = Numeric.formatIndexDigits(
          index: i,
          listLength: _keys.length,
        );

        blog('         $_index. ${_keys[i]} : <${_values[i].runtimeType}>( ${_values[i]} ), ');
      }

      blog('      }.........Length : ${_keys.length} keys <~~~');

    }

    else {
      blog('MAP IS NULL');
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogMaps(List<Map<dynamic, dynamic>> maps, {String invoker}) {
    if (checkCanLoopList(maps)) {
      for (final Map<dynamic, dynamic> map in maps) {
        blogMap(map, invoker: invoker);
      }
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogMapsListsDifferences({
    @required List<Map<String, dynamic>> maps1,
    @required List<Map<String, dynamic>> maps2,
    @required String invoker,
  }){

    blog('blogMapsListsDifferences : START');

    if (maps1 == null && maps2 == null){
      blog('both maps lists are null');
    }

    if (maps1 == [] && maps2 == []){
      blog('both maps lists are empty');
    }

    if (checkCanLoopList(maps1) == true && checkCanLoopList(maps2) == true){

      if (maps1.length != maps2.length) {
        blog('maps1.length != maps2.length');
      }

      else {
        for (int i = 0; i < maps1.length; i++) {

          final bool _mapsAreIdentical = checkMapsAreIdentical(
            map1: maps1[i],
            map2: maps2[i],
          );

          if (_mapsAreIdentical == false) {
            blog('items at index ( $i ) do not match : ( ${maps1[i]} ) <=> ( ${maps2[i]} )');
            break;
          }

          else {
            blog('all maps are identical');
          }

        }
      }

    }

    blog('blogMapsListsDifferences : END');
  }
  // -----------------------------------------------------------------------------

  /// MAP<STRING, STRING> STUFF

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getKeysHavingThisValue({
    @required Map<String, String> map,
    @required String value,
  }){
    final List<String> _output = <String>[];

    if (map != null && value != null){

      final List<String> _keys = map.keys.toList();

      if (Mapper.checkCanLoopList(_keys) == true){

        for (final String key in _keys){

          final String _mapValue = map[key];

          if (_mapValue == value){
            _output.add(key);
          }

        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, String> _insertPairInMapWithStringValue({
    @required Map<String, String> map,
    @required String key,
    @required String value,
    @required bool replaceDuplicateKey, // otherwise will keep existing pair
  }) {

    Map<String, String> _result = <String, String>{};

    if (map != null){

      _result = _result..addAll(map);

      final String _existingValue = map[key];

      /// IF KEY IS Absent
      if (_existingValue == null){
        // _result.putIfAbsent(key, () => value);
        _result[key] = value;
      }

      /// IF KEY IS ALREADY PRESENT
      else {

        if (replaceDuplicateKey == true){
          _result[key] = value;
        }

      }

    }

    return _result;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, String> combineStringStringMap({
    @required Map<String, String> baseMap,
    @required Map<String, String> insert,
    @required bool replaceDuplicateKeys,
  }){
    Map<String, String> _output = {};

    if (baseMap != null){

      _output = baseMap;

      if (insert != null){

        final List<String> _keys = insert.keys.toList();

        if (checkCanLoopList(_keys) == true){

          for (final String key in _keys){

            _output = _insertPairInMapWithStringValue(
              map: _output,
              key: key,
              value: insert[key],
              replaceDuplicateKey: replaceDuplicateKeys,
            );

          }

        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, String> getStringStringMapFromImmutableMapStringObject(dynamic object){

    Map<String, String> _output = {};

    if (object != null){

      // blog('1 - FUCK : object ${object.runtimeType}');

      if (object.runtimeType.toString() == 'ImmutableMap<String, Object?>'){

        final Map _map =  object;
        // blog('3 - FUCK : _map : ${_map.runtimeType}');
        final List<String> _keys = _map.keys.toList();

        if (checkCanLoopList(_keys) == true){

          for (final String key in _keys){

            final String _value = _map[key] is String ? _map[key] : _map[key].toString();

            _output = _insertPairInMapWithStringValue(
              map: _output,
              key: key,
              value: _value,
              replaceDuplicateKey: true,
            );

          }

        }

      }

      else {
        // blog('getStringStringMapFromImmutableMapStringObject : starts : is NOT IMMUTABLE MAP');
      }

    }

    // blog('4 - getStringStringMapFromImmutableMapStringObject : _output ${_output.runtimeType}');
    // blogMap(_output);

    // assert(_output != null, 'DO NOT CONTINUE BITCH');

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// TO JSON

  // --------------------
  /// EXPERIMENT
  /*
         // static String mapsToJson(List<Map<String, dynamic>> map) {
         //   String res = '[';
         //
         //   for (var s in map) {
         //     res += '{';
         //
         //     for (String k in s.keys) {
         //       res += '"';
         //       res += k;
         //       res += '":"';
         //       res += s[k].toString();
         //       res += '",';
         //     }
         //     res = res.substring(0, res.length - 1);
         //
         //     res += '},';
         //     res = res.substring(0, res.length - 1);
         //   }
         //
         //   res += "]";
         //
         //   return res;
         // }
       */
  // -----------------------------------------------------------------------------
}
