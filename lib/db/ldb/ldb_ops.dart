import 'package:bldrs/db/ldb/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/db/ldb/sembast/sembast.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:flutter/foundation.dart';



// -----------------------------------------------------------------------------

  /// REFERENCES

// ---------------------------------------------------
  String getPrimaryKey(String docName){

    switch (docName){
      case LDBDoc.follows : return 'followID';
      case LDBDoc.calls : return 'callID';
      case LDBDoc.shares : return 'shareID';
      case LDBDoc.views : return 'viewID';
      case LDBDoc.saves : return 'saveID';
      case LDBDoc.reviews : return 'reviewID';
      case LDBDoc.questions : return 'questionID';
      case LDBDoc.answers : return 'answerID';
      case LDBDoc.flyers : return 'id';
      case LDBDoc.bzz : return 'id';
      case LDBDoc.users : return 'id';
      case LDBDoc.keywords : return 'id';
      case LDBDoc.countries : return 'id';
      case LDBDoc.cities : return 'cityID';
      case LDBDoc.continents : return 'name';
      case LDBDoc.currencies : return 'currencies';
      default : return null;
    }

  }
// -----------------------------------------------------------------------------

  /// CREATE

// ---------------------------------------------------
  Future<void> insertMap({
    @required String primaryKey,
    @required Map<String, Object> input,
    @required String docName,
  }) async {

    await Sembast.insertAll(
      inputs: <Map<String, Object>>[input],//_cipherFirebaseMapsToSembastMaps(<Map<String, Object>>[input]),
      docName: docName,
      primaryKey: primaryKey,
    );

    print('LDBOps inserted in $docName');
  }
// ---------------------------------------------------
  Future<void> insertMaps({
    @required String primaryKey,
    @required List<Map<String, Object>> inputs,
    @required String docName,
  }) async {

    await Sembast.insertAll(
      inputs: inputs,//_cipherFirebaseMapsToSembastMaps(inputs),
      docName: docName,
      primaryKey: primaryKey,
    );

  }
// -----------------------------------------------------------------------------

  /// READ

// ---------------------------------------------------
  Future<List<Map<String, Object>>> readAllMaps({@required String docName}) async {

    final List<Map<String, Object>> _result = await Sembast.readAll(
      docName: docName,
    );

    final List<Map<String, Object>> _fixedMaps = _result; //_decipherSembastMapsToFirebaseMaps(_result);

    return _fixedMaps;
  }
// ---------------------------------------------------
  Future<Map<String, Object>> searchFirstMap({
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

    // print('LDBOps.searchMap in ${docName} : ${searchField} : ${searchValue} : _result has value ? : ${_result != null}');

    final Map<String, Object> _fixedMap = _result; //_decipherSembastMapToFirebaseMap(_result);

    return _fixedMap;

  }
// ---------------------------------------------------
  Future<List<Map<String, Object>>> searchAllMaps({
    @required String fieldToSortBy,
    @required String searchField,
    @required dynamic searchValue,
    @required String docName,
  }) async {

    final List<Map<String, Object>> _result = await Sembast.search(
      docName: docName,
      fieldToSortBy: fieldToSortBy,
      searchField: searchField,
      searchValue: searchValue,
    );

    // print('searchMaps : _result : $_result');

    final List<Map<String, Object>> _fixedMaps = _result; //_decipherSembastMapsToFirebaseMaps(_result);

    return _fixedMaps;

  }
// ---------------------------------------------------
  Future<List<Map<String, Object>>> searchTrigram({
    @required dynamic searchValue,
    @required String docName,
    @required String lingoCode,
  }) async {

    final List<Map<String, dynamic>> _result = await Sembast.search(
      fieldToSortBy: getPrimaryKey(docName),
      searchField: 'names.$lingoCode.trigram',
      searchValue: CountryModel.fixCountryName(searchValue),
      docName: docName,
    );

    return _result;
}
// -----------------------------------------------------------------------------

  /// UPDATE

// ---------------------------------------------------
  Future<void> updateMap({
    @required Map<String, Object> input,
    @required String objectID,
    @required String docName,
  }) async {

    final String _primaryKey = getPrimaryKey(docName);

    await Sembast.update(
      map: input,//_cipherFirebaseMapToSembastMap(input),
      docName: docName,
      searchPrimaryKey: _primaryKey,
      searchPrimaryValue: objectID,
    );

}
// -----------------------------------------------------------------------------

  /// DELETE

// ---------------------------------------------------
  Future<void> deleteMap({
    @required String objectID,
    @required String docName,
  }) async {

    final String _primaryKey = getPrimaryKey(docName);

    await Sembast.delete(
      docName: docName,
      searchPrimaryKey: _primaryKey,
      searchPrimaryValue: objectID,
    );

  }
// ---------------------------------------------------
  Future<void> deleteAllMaps({@required String docName}) async {

    await Sembast.deleteAll(
      docName: docName,
      primaryKey: getPrimaryKey(docName),
    );

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
//       print('_cipherFirebaseMapToSembastMap : _key : $_key : _value ${_value} : _objectIsDateTime : $_objectIsDateTime : _objectIsGeoPoint : $_objectIsGeoPoint');
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
