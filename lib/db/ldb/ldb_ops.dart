import 'package:bldrs/db/ldb/sembast/sembast.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:flutter/foundation.dart';


abstract class LDBDoc {
  static const String myUserModel = 'myUserModel';
  static const String mySavedFlyers = 'mySavedFlyers';
  static const String myFollowedBzz = 'myFollowedBzz';
  static const String myFollows = 'myFollows';
  static const String myCalls = 'myCalls';
  static const String myShares = 'myShares';
  static const String myViews = 'myViews';
  static const String mySaves = 'mySaves';
  static const String myReviews = 'myReviews';
  static const String myQuestions = 'myQuestions';
  static const String myAnswers = 'myAnswers';
  static const String myBzz = 'myBzz';
  static const String myBzzFlyers = 'myBzzFlyers';
  static const String sessionFlyers = 'sessionFlyers';
  static const String sessionBzz = 'sessionBzz';
  static const String sessionUsers = 'sessionUsers';
  static const String keywords = 'keywords';
  static const String sessionCountries = 'sessionCountries';
  static const String sessionCities = 'sessionCities';
  static const String continents = 'continents';

  static const List<String> bzModelsDocs = const <String>[
    myFollowedBzz,
    myBzz,
    sessionBzz,
  ];

  static const List<String> flyerModelsDocs = const <String>[
    mySavedFlyers,
    myBzzFlyers,
    sessionFlyers,
  ];

  static const List<String> userModelsDocs = const <String>[
    myUserModel,
    sessionUsers,
  ];

  static const List<String> allDocs = <String>[
  myUserModel,
  mySavedFlyers,
  myFollowedBzz,
  myFollows,
  myCalls,
  myShares,
  myViews,
  mySaves,
  myReviews,
  myQuestions,
  myAnswers,
  myBzz,
  myBzzFlyers,
  sessionFlyers,
  sessionBzz,
  sessionUsers,
  keywords,
  sessionCountries,
  sessionCities,
  continents,
  ];
}

abstract class LDBOps{
// -----------------------------------------------------------------------------
  static String getPrimaryKey(String docName){

    switch (docName){
      case LDBDoc.myUserModel : return 'id';
      case LDBDoc.mySavedFlyers : return 'id';
      case LDBDoc.myFollowedBzz : return 'id';
      case LDBDoc.myFollows : return 'followID';
      case LDBDoc.myCalls : return 'callID';
      case LDBDoc.myShares : return 'shareID';
      case LDBDoc.myViews : return 'viewID';
      case LDBDoc.mySaves : return 'saveID';
      case LDBDoc.myReviews : return 'reviewID';
      case LDBDoc.myQuestions : return 'questionID';
      case LDBDoc.myAnswers : return 'answerID';
      case LDBDoc.myBzz : return 'id';
      case LDBDoc.myBzzFlyers : return 'id';
      case LDBDoc.sessionFlyers : return 'id';
      case LDBDoc.sessionBzz : return 'id';
      case LDBDoc.sessionUsers : return 'id';
      case LDBDoc.keywords : return 'id';
      case LDBDoc.sessionCountries : return 'id';
      case LDBDoc.sessionCities : return 'cityID';
      case LDBDoc.continents : return 'name';
      default : return null;
    }

  }
// -----------------------------------------------------------------------------
  static Future<void> insertMap({@required String primaryKey, @required Map<String, Object> input, @required String docName}) async {

    await Sembast.insertAll(
      inputs: <Map<String, Object>>[input],//_cipherFirebaseMapsToSembastMaps(<Map<String, Object>>[input]),
      docName: docName,
      primaryKey: primaryKey,
    );

    print('LDBOps inserted in ${docName}');
  }
// -----------------------------------------------------------------------------
  static Future<void> insertMaps({@required String primaryKey, @required List<Map<String, Object>> inputs, @required String docName}) async {

    await Sembast.insertAll(
      inputs: inputs,//_cipherFirebaseMapsToSembastMaps(inputs),
      docName: docName,
      primaryKey: primaryKey,
    );

  }
// -----------------------------------------------------------------------------
  static Future<Map<String, Object>> searchFirstMap({@required String fieldToSortBy, @required String searchField, @required dynamic searchValue, @required String docName}) async {

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
// -----------------------------------------------------------------------------
  static Future<List<Map<String, Object>>> searchAllMaps({@required String fieldToSortBy, @required String searchField, @required dynamic searchValue, @required String docName}) async {

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
// -----------------------------------------------------------------------------
  static Future<List<Map<String, Object>>> searchTrigram({@required dynamic searchValue, @required String docName, @required String lingoCode}) async {

    List<Map<String, dynamic>> _result = await Sembast.search(
      fieldToSortBy: getPrimaryKey(docName),
      searchField: 'names.$lingoCode.trigram',
      searchValue: CountryModel.fixCountryName(searchValue),
      docName: docName,
    );

    return _result;
}
// -----------------------------------------------------------------------------
  static Future<List<Map<String, Object>>> readAllMaps({@required String docName}) async {

    final List<Map<String, Object>> _result = await Sembast.readAll(
      docName: docName,
    );

    final List<Map<String, Object>> _fixedMaps = _result; //_decipherSembastMapsToFirebaseMaps(_result);

    return _fixedMaps;
  }
// -----------------------------------------------------------------------------
  static Future<void> updateMap({
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
  static Future<void> deleteMap({
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
// -----------------------------------------------------------------------------
  static Future<void> deleteAllMaps({@required String docName}) async {

    await Sembast.deleteAll(
      docName: docName,
      primaryKey: getPrimaryKey(docName),
    );

  }
// -----------------------------------------------------------------------------
//   static Map<String, Object> _cipherFirebaseMapToSembastMap(Map<String, Object> mapOfFirebase){
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
//   static List<Map<String, Object>> _cipherFirebaseMapsToSembastMaps(List<Map<String, Object>> firebaseMaps){
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
//   static Map<String, Object> _decipherSembastMapToFirebaseMap(Map<String, Object> sembastMap){
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
//   static List<Map<String, Object>> _decipherSembastMapsToFirebaseMaps(List<Map<String, Object>> sembastMaps){
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