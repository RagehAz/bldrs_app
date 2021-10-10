import 'package:bldrs/controllers/drafters/atlas.dart';
import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/object_checkers.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/db/ldb/sembast/sembast.dart';

/// Bldrs Local DataBases
/// using noSQL 'sembast' LDB
enum BLDB{
  meAndPrefs,
  mySavedFlyers,
  myFollowedBzz,

  myFollows,
  myCalls,
  myShares,
  myViews,
  mySaves,
  myReviews,
  myQuestions, // includes draft questions
  myAnswers, // includes draft answers

  myBzz,
  myBzzFlyers,

  sessionFlyers,
  sessionBzz,

  keywords,

}

abstract class BLDBMethod{
// -----------------------------------------------------------------------------
  static String getDocName(BLDB bldb){

    switch (bldb){
      case BLDB.meAndPrefs : return 'meAndPrefs';
      case BLDB.mySavedFlyers : return 'mySavedFlyers';
      case BLDB.myFollowedBzz : return 'myFollowedBzz';
      case BLDB.myFollows : return 'myFollows';
      case BLDB.myCalls : return 'myCalls';
      case BLDB.myShares : return 'myShares';
      case BLDB.myViews : return 'myViews';
      case BLDB.mySaves : return 'mySaves';
      case BLDB.myReviews : return 'myReviews';
      case BLDB.myQuestions : return 'myQuestions';
      case BLDB.myAnswers : return 'myAnswers';
      case BLDB.myBzz : return 'myBzz';
      case BLDB.myBzzFlyers : return 'myBzzFlyers';
      case BLDB.sessionFlyers : return 'sessionFlyers';
      case BLDB.sessionBzz : return 'sessionBzz';
      case BLDB.keywords : return 'keywords';
      default : return null;
    }

  }
// -----------------------------------------------------------------------------
  static BLDB getBLDBByDocName(String docName){

    switch (docName){
      case 'meAndPrefs' : return BLDB.meAndPrefs;
      case 'mySavedFlyers' : return BLDB.mySavedFlyers;
      case 'myFollowedBzz' : return BLDB.myFollowedBzz;
      case 'myFollows' : return BLDB.myFollows;
      case 'myCalls' : return BLDB.myCalls;
      case 'myShares' : return BLDB.myShares;
      case 'myViews' : return BLDB.myViews;
      case 'mySaves' : return BLDB.mySaves;
      case 'myReviews' : return BLDB.myReviews;
      case 'myQuestions' : return BLDB.myQuestions;
      case 'myAnswers' : return BLDB.myAnswers;
      case 'myBzz' : return BLDB.myBzz;
      case 'myBzzFlyers' : return BLDB.myBzzFlyers;
      case 'sessionFlyers' : return BLDB.sessionFlyers;
      case 'sessionBzz' : return BLDB.sessionBzz;
      case 'keywords' : return BLDB.keywords;
      default : return null;
    }

  }
// -----------------------------------------------------------------------------
  static String getPrimaryKey(BLDB bldb){

    switch (bldb){
      case BLDB.meAndPrefs : return 'userID'; /// TASK : this is wrong
      case BLDB.mySavedFlyers : return 'flyerID';
      case BLDB.myFollowedBzz : return 'bzID';
      case BLDB.myFollows : return 'followID';
      case BLDB.myCalls : return 'callID';
      case BLDB.myShares : return 'shareID';
      case BLDB.myViews : return 'viewID';
      case BLDB.mySaves : return 'saveID';
      case BLDB.myReviews : return 'reviewID';
      case BLDB.myQuestions : return 'questionID';
      case BLDB.myAnswers : return 'answerID';
      case BLDB.myBzz : return 'bzID';
      case BLDB.myBzzFlyers : return 'flyerID';
      case BLDB.sessionFlyers : return 'flyerID';
      case BLDB.sessionBzz : return 'bzID';
      case BLDB.keywords : return 'keywordID';
      default : return null;
    }

  }
// -----------------------------------------------------------------------------
  static Future<void> insert({List<Map<String, Object>> inputs,BLDB bldb}) async {

    final String _docName = getDocName(bldb);

    await Sembast.insert(
      inputs: cipherFirebaseMapsToSembastMaps(inputs),
      docName: _docName,
    );

  }
// -----------------------------------------------------------------------------
  static Future<void> update({Map<String, Object> input, String objectID, BLDB bldb}) async {

    final String _docName = getDocName(bldb);
    final String _primaryKey = getPrimaryKey(bldb);

    await Sembast.update(
      map: cipherFirebaseMapToSembastMap(input),
      docName: _docName,
      searchPrimaryKey: _primaryKey,
      searchPrimaryValue: objectID,
    );

}
// -----------------------------------------------------------------------------
  static Future<void> delete({String objectID, BLDB bldb}) async {

    final String _docName = getDocName(bldb);
    final String _primaryKey = getPrimaryKey(bldb);

    await Sembast.delete(
      docName: _docName,
      searchPrimaryKey: _primaryKey,
      searchPrimaryValue: objectID,
    );

  }
// -----------------------------------------------------------------------------
  static Future<List<Map<String, Object>>> search({String fieldToSortBy, String searchField, dynamic searchValue, BLDB bldb}) async {

    final String _docName = getDocName(bldb);

    final List<Map<String, Object>> _result = await Sembast.search(
      docName: _docName,
      fieldToSortBy: fieldToSortBy,
      searchField: searchField,
      searchValue: searchValue,
    );

    final List<Map<String, Object>> _fixedMaps = decipherSembastMapsToFirebaseMaps(_result);

    return _fixedMaps;

}
// -----------------------------------------------------------------------------
  static Future<List<Map<String, Object>>> readAll({BLDB bldb}) async {

    final String _docName = getDocName(bldb);

    final List<Map<String, Object>> _result = await Sembast.readAll(
      docName: _docName,
    );

    final List<Map<String, Object>> _fixedMaps = decipherSembastMapsToFirebaseMaps(_result);

    return _fixedMaps;
  }
// -----------------------------------------------------------------------------
  static Map<String, Object> cipherFirebaseMapToSembastMap(Map<String, Object> mapOfFirebase){

    Map<String, Object> _fixedMap = mapOfFirebase;
    final List<String> _keys = mapOfFirebase.keys.toList();
    final List<Object> _values = mapOfFirebase.values.toList();

    for (int i = 0; i<_keys.length; i++){

      final _value = _values[i];

      if (ObjectChecker.objectIsDateTime(_value)){

        _fixedMap = Mapper.replacePair(
          fieldKey: _keys[i],
          inputValue: Timers.cipherDateTimeIso8601(_value),
          map: mapOfFirebase,
        );

        _fixedMap = Mapper.insertPairInMap(
          map: _fixedMap,
          key: 'cipheredDateTime',
          value: '${_keys[i]}',
        );

      }

      else if (ObjectChecker.objectIsGeoPoint(_value)){

        _fixedMap = Mapper.replacePair(
          fieldKey: _keys[i],
          inputValue: Atlas.sqlCipherGeoPoint(_value),
          map: mapOfFirebase,
        );

        _fixedMap = Mapper.insertPairInMap(
          map: _fixedMap,
          key: 'cipheredGeoPoint',
          value: '${_keys[i]}',
        );


      }


    }

    return _fixedMap;

  }
// -----------------------------------------------------------------------------
  static List<Map<String, Object>> cipherFirebaseMapsToSembastMaps(List<Map<String, Object>> firebaseMaps){

    final List<Map<String, Object>> _fixedMaps = <Map<String, Object>>[];

    for (var firebaseMap in firebaseMaps){

      final Map<String, Object> _fixedMap = cipherFirebaseMapToSembastMap(firebaseMap);

      _fixedMaps.add(_fixedMap);
    }

    return _fixedMaps;
  }
// -----------------------------------------------------------------------------
  static Map<String, Object> decipherSembastMapToFirebaseMap(Map<String, Object> sembastMap){

    Map<String, Object> _fixedMap = sembastMap;
    final List<String> _keys = sembastMap.keys.toList();
    final List<Object> _values = sembastMap.values.toList();

    String _keyOfCipheredDateTime;
    String _keyOfCipheredGeoPoint;

    for (int i = 0; i<_keys.length; i++){

      final String _key = _keys[i];
      final dynamic _value = _values[i];

      final bool _isACipheredDateTime = _key == 'cipheredDateTime';
      final bool _isACipheredGeoPoint = _key == 'cipheredGeoPoint';

      if (_isACipheredDateTime == true){
        _keyOfCipheredDateTime = _value;
      }

      if (_isACipheredGeoPoint == true){
        _keyOfCipheredGeoPoint = _value;
      }

    }

    if (_keyOfCipheredDateTime != null){

      _fixedMap = Mapper.replacePair(
        map: _fixedMap,
        fieldKey: _keyOfCipheredDateTime,
        inputValue: Timers.decipherDateTimeIso8601(_fixedMap[_keyOfCipheredDateTime]),
      );

      _fixedMap = Mapper.removePair(
        map: _fixedMap,
        fieldKey: 'cipheredDateTime',
      );

    }

    if (_keyOfCipheredGeoPoint != null){

      _fixedMap = Mapper.replacePair(
        map: _fixedMap,
        fieldKey: _keyOfCipheredGeoPoint,
        inputValue: Atlas.sqlDecipherGeoPoint(_fixedMap[_keyOfCipheredGeoPoint]),
      );

      _fixedMap = Mapper.removePair(
        map: _fixedMap,
        fieldKey: 'cipheredGeoPoint',
      );

    }

    return _fixedMap;
  }
// -----------------------------------------------------------------------------
  static List<Map<String, Object>> decipherSembastMapsToFirebaseMaps(List<Map<String, Object>> sembastMaps){
    final List<Map<String, Object>> _fixedMaps = <Map<String, Object>>[];

    for (var sembastMap in sembastMaps){

      final Map<String, Object> _fixedMap = decipherSembastMapToFirebaseMap(sembastMap);

      _fixedMaps.add(_fixedMap);
    }

    return _fixedMaps;
  }
// -----------------------------------------------------------------------------
}