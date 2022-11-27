// ignore_for_file: always_put_control_body_on_new_line
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/e_back_end/d_ldb/sembast_api.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';

class LDBOps {
  // -----------------------------------------------------------------------------

  const LDBOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
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
  // --------------------
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

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> readMaps({
    @required List<String> ids,
    @required String docName,
  }) async {

    final String _primaryKey = LDBDoc.getPrimaryKey(docName);

    final List<Map<String, dynamic>> _maps = await Sembast.readMaps(
      primaryKeyName: _primaryKey,
      ids: ids,
      docName: docName,
    );

    return _maps;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, Object>>> readAllMaps({
    @required String docName,
  }) async {

    final List<Map<String, Object>> _result = await Sembast.readAll(
      docName: docName,
    );

    return _result;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, Object>> searchFirstMap({
    @required String sortFieldName,
    @required String searchFieldName,
    @required dynamic searchValue,
    @required String docName,
  }) async {

    final Map<String, Object> _result = await Sembast.findFirst(
      docName: docName,
      fieldToSortBy: sortFieldName,
      searchField: searchFieldName,
      searchValue: searchValue,
    );

    // blog('LDBOps.searchMap in ${docName} : ${searchField} : ${searchValue} : _result has value ? : ${_result != null}');

    final Map<String, Object> _fixedMap = _result; //_decipherSembastMapToFirebaseMap(_result);

    return _fixedMap;
  }
  // --------------------
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
  // --------------------
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
  // --------------------
  /// deprecated
  static Future<List<Map<String, Object>>> searchLDBDocTrigram({
    @required dynamic searchValue,
    @required String docName,
    @required String lingoCode,
  }) async {

    final List<Map<String, dynamic>> _result = await Sembast.search(
      fieldToSortBy: LDBDoc.getPrimaryKey(docName),
      searchField: 'phrases.$lingoCode.trigram',
      fieldIsList: true,
      searchValue: TextMod.fixCountryName(searchValue),
      docName: docName,
    );

    return _result;
  }
  // --------------------
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

  // --------------------
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
  // --------------------
  /// TASK : TEST ME
  static Future<void> deleteMaps ({
    @required List<String> ids,
    @required String docName,
  }) async {

    final String _primaryKey = LDBDoc.getPrimaryKey(docName);

    await Sembast.deleteMaps(
      docName: docName,
      primaryKeyName: _primaryKey,
      ids: ids,
    );

  }
  // --------------------
  /// DEPRECATED
  /*
  /// TESTED : WORKS PERFECT
  static Future<void> deleteAllMapsOneByOne({
    @required String docName,
  }) async {

    await Sembast.deleteAllOneByOne(
      docName: docName,
    );

  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteAllMapsAtOnce({
    @required String docName,
  }) async {

    await Sembast.deleteAllAtOnce(docName: docName);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeOutEntireLDB({
    bool flyers = true,
    bool bzz = true,
    bool users = true,
    bool bldrsChains = true,
    bool pickers = true,
    bool countries = true,
    bool cities = true,
    bool notes = true,
    bool mainPhrases = true,
    bool countriesPhrases = true,
    bool appState = true,
    bool appControls = true,
    bool authModel = true,
    bool userEditor = true,
    bool bzEditor = true,
    bool authorEditor = true,
    bool flyerMaker = true,
    bool reviewEditor = true,
    bool theLastWipe = true,
  }) async {

    final List<String> _docs = <String>[];

    if (flyers == true) {_docs.add(LDBDoc.flyers);}
    if (bzz == true) {_docs.add(LDBDoc.bzz);}
    if (users == true) {_docs.add(LDBDoc.users);}
    if (bldrsChains == true) {_docs.add(LDBDoc.bldrsChains);}
    if (pickers == true) {_docs.add(LDBDoc.pickers);}
    if (countries == true) {_docs.add(LDBDoc.countries);}
    if (cities == true) {_docs.add(LDBDoc.cities);}
    if (notes == true) {_docs.add(LDBDoc.notes);}
    if (mainPhrases == true) {_docs.add(LDBDoc.mainPhrases);}
    if (countriesPhrases == true) {_docs.add(LDBDoc.countriesPhrases);}
    if (appState == true) {_docs.add(LDBDoc.appState);}
    if (appControls == true) {_docs.add(LDBDoc.appControls);}
    if (authModel == true) {_docs.add(LDBDoc.authModel);}
    if (userEditor == true) {_docs.add(LDBDoc.userEditor);}
    if (bzEditor == true) {_docs.add(LDBDoc.bzEditor);}
    if (authorEditor == true) {_docs.add(LDBDoc.authorEditor);}
    if (flyerMaker == true) {_docs.add(LDBDoc.flyerMaker);}
    if (reviewEditor == true) {_docs.add(LDBDoc.reviewEditor);}
    if (theLastWipe == true) {_docs.add(LDBDoc.theLastWipe);}

    await Future.wait(<Future>[
      ...List.generate(_docs.length, (index){
        return deleteAllMapsAtOnce(
            docName: _docs[index],
        );
      }),
    ]);

  }
  // -----------------------------------------------------------------------------

  /// CHECKER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkMapExists({
    @required String id,
    @required String docName,
  }) async {
    bool _exists = false;

    if (id != null && docName != null){

      _exists = await Sembast.checkMapExists(
          docName: docName,
          id: id,
      );

    }

    return _exists;
  }
  // -----------------------------------------------------------------------------

  /// FIREBASE TO SEMBAST ADAPTERS

  // --------------------
  /*
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
//   // -----------------------------------------------------------------------------
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
//   // -----------------------------------------------------------------------------
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
//   // -----------------------------------------------------------------------------
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
//   // -----------------------------------------------------------------------------
 */
  // -----------------------------------------------------------------------------

  /// LDB REFRESH - DAILY WIPE

  // --------------------
  /// TASK : TEST ME
  static Future<bool> checkShouldRefreshLDB(BuildContext context) async {
    bool _shouldRefresh = true;

    /// NOTE : if did not find last wipe dateTime => will wipe
    /// if found and its more than {24 hours} => will wipe
    /// if found and its less than {24 hours} => will not wipe

    final List<Map<String, dynamic>> _maps = await LDBOps.readMaps(
        ids: ['theLastWipeMap'],
        docName: LDBDoc.theLastWipe,
    );

    if (Mapper.checkCanLoopList(_maps) == true){

      final DateTime _lastWipe = Timers.decipherTime(
          time: _maps.first['time'],
          fromJSON: true,
      );

      double _diff = Timers.calculateTimeDifferenceInHours(
          from: _lastWipe,
          to: DateTime.now(),
      )?.toDouble();

      _diff = Numeric.modulus(_diff);

      /// ONLY WHEN NOT EXCEEDED THE TIME SHOULD NOT REFRESH
      if (_diff != null && _diff < Standards.dailyLDBWipeIntervalInHours){
        _shouldRefresh = false;
      }

    }

    await LDBOps.insertMap(
        // allowDuplicateIDs: false,
        docName: LDBDoc.theLastWipe,
        input: {
          'id': 'theLastWipeMap',
          'time': Timers.cipherTime(time: DateTime.now(), toJSON: true),
        },
    );

    return _shouldRefresh;
  }
  // -----------------------------------------------------------------------------

}
