import 'package:bldrs/e_db/ldb/foundation/ldb_doc.dart';
import 'package:bldrs/e_db/ldb/foundation/sembast_api.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/foundation.dart';

class LDBOps {
// -----------------------------------------------------------------------------

  const LDBOps();

// -----------------------------------------------------------------------------

  /// REFERENCES

// ----------------------------------------
  /// TESTED : WORKS PERFECT
  static String getPrimaryKey(String docName) {
    switch (docName) {
      case LDBDoc.follows: return 'recordID';
      case LDBDoc.calls: return 'recordID';
      case LDBDoc.shares: return 'recordID';
      case LDBDoc.views: return 'recordID';
      case LDBDoc.saves: return 'recordID';
      case LDBDoc.reviews: return 'reviewID';
      case LDBDoc.questions: return 'questionID';
      case LDBDoc.answers: return 'answerID';
      case LDBDoc.flyers: return 'id';
      case LDBDoc.bzz: return 'id';
      case LDBDoc.users: return 'id';
      case LDBDoc.bigChainK: return 'id';
      case LDBDoc.bigChainS: return 'id';
      case LDBDoc.countries: return 'id';
      case LDBDoc.cities: return 'cityID';
      case LDBDoc.continents: return 'name';
      case LDBDoc.currencies: return 'id';
      case LDBDoc.mainPhrases: return 'id';
      case LDBDoc.countriesPhrases: return 'id';
      case LDBDoc.appState: return 'id';
      case LDBDoc.appControls: return 'primaryKey'; /// TASK : WTF
      case LDBDoc.authModel: return 'uid';
      case LDBDoc.notes: return 'id';
      case LDBDoc.pickers: return 'id';

      case LDBDoc.userEditor: return 'id';
      case LDBDoc.bzEditor: return 'id';
      case LDBDoc.authorEditor: return 'id';
      case LDBDoc.flyerMaker: return 'id';

      case 'test': return 'id';
      default: return null;
    }
  }
// -----------------------------------------------------------------------------

  /// CREATE

// ----------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertMap({
    @required Map<String, Object> input,
    @required String docName,
    bool allowDuplicateIDs = false,
  }) async {

    await Sembast.insert(
      map: input,
      docName: docName,
      allowDuplicateIDs: allowDuplicateIDs,
    );

  }
// ----------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertMaps({
    @required List<Map<String, Object>> inputs,
    @required String docName,
    bool allowDuplicateIDs = false,
  }) async {

    await Sembast.insertAll(
      maps: inputs,
      docName: docName,
      allowDuplicateIDs: allowDuplicateIDs,
    );

  }
// -----------------------------------------------------------------------------

  /// READ

// ----------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> readMaps({
    @required List<String> ids,
    @required String docName,
  }) async {

    final String _primaryKey = getPrimaryKey(docName);

    final List<Map<String, dynamic>> _maps = await Sembast.readMaps(
      primaryKeyName: _primaryKey,
      ids: ids,
      docName: docName,
    );

    return _maps;
  }
// ----------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, Object>>> readAllMaps({
    @required String docName,
  }) async {

    final List<Map<String, Object>> _result = await Sembast.readAll(
      docName: docName,
    );

    return _result;
  }
// ----------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, Object>> searchFirstMap({
    @required String fieldToSortBy,
    @required String searchField,
    @required dynamic searchValue,
    @required String docName,
  }) async {

    final Map<String, Object> _result = await Sembast.findFirst(
      docName: docName,
      fieldToSortBy: fieldToSortBy,
      searchField: searchField,
      searchValue: searchValue,
    );

    // blog('LDBOps.searchMap in ${docName} : ${searchField} : ${searchValue} : _result has value ? : ${_result != null}');

    final Map<String, Object> _fixedMap = _result; //_decipherSembastMapToFirebaseMap(_result);

    return _fixedMap;
  }
// ----------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, Object>>> searchAllMaps({
    @required String fieldToSortBy,
    @required String searchField,
    @required bool fieldIsList,
    @required dynamic searchValue,
    @required String docName,
  }) async {

    final List<Map<String, Object>> _result = await Sembast.search(
      docName: docName,
      fieldToSortBy: fieldToSortBy,
      fieldIsList: fieldIsList,
      searchField: searchField,
      searchValue: searchValue,
    );

    // blog('searchMaps : _result : $_result');

    final List<Map<String, Object>> _fixedMaps = _result; //_decipherSembastMapsToFirebaseMaps(_result);

    return _fixedMaps;
  }
// ----------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, Object>>> searchPhrasesDoc({
    @required dynamic searchValue,
    @required String docName,
    @required String lingCode,
  }) async {

    blog('receiving value : $searchValue');

    final List<Map<String, dynamic>> _result = await Sembast.searchArrays(
      searchValue: searchValue,
      docName: docName,
      fieldToSortBy: 'value',
      searchField: 'trigram',
    );

    if (Mapper.checkCanLoopList(_result) == true){
      blog('searchPhrases : found ${_result.length} phrases');

      return _result;

    }
    else {
      blog('searchPhrases : did not find anything');

      return null;
    }

  }
// ----------------------------------------
  /// deprecated
  static Future<List<Map<String, Object>>> searchLDBDocTrigram({
    @required dynamic searchValue,
    @required String docName,
    @required String lingoCode,
  }) async {

    final List<Map<String, dynamic>> _result = await Sembast.search(
      fieldToSortBy: getPrimaryKey(docName),
      searchField: 'phrases.$lingoCode.trigram',
      fieldIsList: true,
      searchValue: TextMod.fixCountryName(searchValue),
      docName: docName,
    );

    return _result;
  }
// ----------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, Object>>> searchMultipleValues({
    @required String docName,
    @required String fieldToSortBy,
    @required String searchField,
    @required List<Object> searchObjects,
  }) async {

    final List<Map<String, Object>> _result = await Sembast.searchMultiple(
      docName: docName,
      searchField: searchField,
      searchObjects: searchObjects,
      fieldToSortBy: fieldToSortBy,
    );

    return _result;
  }
// -----------------------------------------------------------------------------

  /// DELETE

// ----------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteMap({
    @required String objectID,
    @required String docName,
  }) async {

    await Sembast.deleteMap(
      docName: docName,
      objectID: objectID,
    );

  }
// ----------------------------------------
  static Future<void> deleteMaps ({
    @required List<String> ids,
    @required String docName,
  }) async {

    final String _primaryKey = getPrimaryKey(docName);

    await Sembast.deleteMaps(
      docName: docName,
      primaryKeyName: _primaryKey,
      ids: ids,
    );

  }
// ----------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteAllMapsOneByOne({
    @required String docName,
  }) async {

    await Sembast.deleteAllOneByOne(
      docName: docName,
    );

  }
// ----------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteAllMapsAtOnce({
    @required String docName,
  }) async {

    await Sembast.deleteAllAtOnce(docName: docName);

  }
// ----------------------------------------
  static Future<void> wipeOutEntireLDB() async {

    const List<String> _docs = LDBDoc.allDocs;

    for (final String docName in _docs){

      await deleteAllMapsAtOnce(
          docName: docName
      );

    }

  }
// -----------------------------------------------------------------------------

/// FIREBASE TO SEMBAST ADAPTERS
// -----------------------------------------------------------------------------
//   Map<String, Object> _cipherFirebaseMapToSembastMap(Map<String, Object> mapOfFirebase){
//
//     Map<String, Object> _fixedMap = mapOfFirebase;
//     final List<String> _keys = mapOfFirebase.keys.toList();
//     final List<Object> _values = mapOfFirebase.values.toList();
//
//     for (int i = 0; i<_keys.length; i++){
//
//       final _value = _values[i];
//       final String _key = _keys[i];
//       final bool _objectIsDateTime = ObjectChecker.objectIsDateTime(_value);
//       final bool _objectIsGeoPoint = ObjectChecker.objectIsGeoPoint(_value);
//
//       blog('_cipherFirebaseMapToSembastMap : _key : $_key : _value ${_value} : _objectIsDateTime : $_objectIsDateTime : _objectIsGeoPoint : $_objectIsGeoPoint');
//
//       if (_objectIsDateTime == true){
//
//         _fixedMap = Mapper.replacePair(
//           fieldKey: _key,
//           inputValue: Timers.cipherDateTimeIso8601(_value),
//           map: _fixedMap,
//         );
//
//         _fixedMap = Mapper.insertPairInMap(
//           map: _fixedMap,
//           key: 'cipheredDateTime',
//           value: _key,
//         );
//
//       }
//
//       else if (_objectIsGeoPoint){
//
//         _fixedMap = Mapper.replacePair(
//           fieldKey: _keys[i],
//           inputValue: Atlas.sqlCipherGeoPoint(_value),
//           map: _fixedMap,
//         );
//
//         _fixedMap = Mapper.insertPairInMap(
//           map: _fixedMap,
//           key: 'cipheredGeoPoint',
//           value: '${_keys[i]}',
//         );
//
//
//       }
//
//
//     }
//
//     return _fixedMap;
//
//   }
// // -----------------------------------------------------------------------------
//   List<Map<String, Object>> _cipherFirebaseMapsToSembastMaps(List<Map<String, Object>> firebaseMaps){
//
//     final List<Map<String, Object>> _fixedMaps = <Map<String, Object>>[];
//
//     for (var firebaseMap in firebaseMaps){
//
//       final Map<String, Object> _fixedMap = _cipherFirebaseMapToSembastMap(firebaseMap);
//
//       _fixedMaps.add(_fixedMap);
//     }
//
//     return _fixedMaps;
//   }
// // -----------------------------------------------------------------------------
//   Map<String, Object> _decipherSembastMapToFirebaseMap(Map<String, Object> sembastMap){
//
//     Map<String, Object> _fixedMap = sembastMap;
//
//     if (_fixedMap != null){
//
//       final List<String> _keys = sembastMap.keys.toList();
//       final List<Object> _values = sembastMap.values.toList();
//
//       String _keyOfCipheredDateTime;
//       String _keyOfCipheredGeoPoint;
//
//       for (int i = 0; i<_keys.length; i++){
//
//         final String _key = _keys[i];
//         final dynamic _value = _values[i];
//
//         final bool _isACipheredDateTime = _key == 'cipheredDateTime';
//         final bool _isACipheredGeoPoint = _key == 'cipheredGeoPoint';
//
//         if (_isACipheredDateTime == true){
//           _keyOfCipheredDateTime = _value;
//         }
//
//         if (_isACipheredGeoPoint == true){
//           _keyOfCipheredGeoPoint = _value;
//         }
//
//       }
//
//       if (_keyOfCipheredDateTime != null){
//
//         _fixedMap = Mapper.replacePair(
//           map: _fixedMap,
//           fieldKey: _keyOfCipheredDateTime,
//           inputValue: Timers.decipherDateTimeIso8601ToTimeStamp(_fixedMap[_keyOfCipheredDateTime]),
//         );
//
//         _fixedMap = Mapper.removePair(
//           map: _fixedMap,
//           fieldKey: 'cipheredDateTime',
//         );
//
//       }
//
//       if (_keyOfCipheredGeoPoint != null){
//
//         _fixedMap = Mapper.replacePair(
//           map: _fixedMap,
//           fieldKey: _keyOfCipheredGeoPoint,
//           inputValue: Atlas.sqlDecipherGeoPoint(_fixedMap[_keyOfCipheredGeoPoint]),
//         );
//
//         _fixedMap = Mapper.removePair(
//           map: _fixedMap,
//           fieldKey: 'cipheredGeoPoint',
//         );
//
//       }
//
//     }
//
//     return _fixedMap;
//   }
// // -----------------------------------------------------------------------------
//   List<Map<String, Object>> _decipherSembastMapsToFirebaseMaps(List<Map<String, Object>> sembastMaps){
//     final List<Map<String, Object>> _fixedMaps = <Map<String, Object>>[];
//
//     for (var sembastMap in sembastMaps){
//
//       final Map<String, Object> _fixedMap = _decipherSembastMapToFirebaseMap(sembastMap);
//
//       _fixedMaps.add(_fixedMap);
//     }
//
//     return _fixedMaps;
//   }
// // -----------------------------------------------------------------------------

}
