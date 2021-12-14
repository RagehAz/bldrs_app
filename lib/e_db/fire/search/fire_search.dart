import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

enum ValueIs {
  greaterThan,
  greaterOrEqualThan,
  lessThan,
  lessOrEqualThan,
  equalTo,
  notEqualTo,
  nullValue,
  whereIn,
  whereNotIn,
  arrayContains,
  arrayContainsAny,
}

// -----------------------------------------------------------------------------

/// GENERAL

// -----------------------------------------------
Future<QuerySnapshot<Object>> _searchAndGetCollectionSnapshots({
  @required BuildContext context,
  @required CollectionReference<Object> collRef,
  @required ValueIs valueIs,
  @required String field,
  @required dynamic compareValue,
  @required int limit,
}) async {
  QuerySnapshot<Object> _collectionSnapshot;

  await tryAndCatch(
      context: context,
      methodName: '_getCollectionSnapshots',
      functions: () async {
        /// IF EQUAL TO
        if (valueIs == ValueIs.equalTo) {
          _collectionSnapshot = await collRef
              .where(field, isEqualTo: compareValue)
              .limit(limit)
              .get();
        }

        /// IF GREATER THAN
        else if (valueIs == ValueIs.greaterThan) {
          _collectionSnapshot = await collRef
              .where(field, isGreaterThan: compareValue)
              .limit(limit)
              .get();
        }

        /// IF GREATER THAN OR EQUAL
        else if (valueIs == ValueIs.greaterOrEqualThan) {
          _collectionSnapshot = await collRef
              .where(field, isGreaterThanOrEqualTo: compareValue)
              .limit(limit)
              .get();
        }

        /// IF LESS THAN
        else if (valueIs == ValueIs.lessThan) {
          _collectionSnapshot = await collRef
              .where(field, isLessThan: compareValue)
              .limit(limit)
              .get();
        }

        /// IF LESS THAN OR EQUAL
        else if (valueIs == ValueIs.lessOrEqualThan) {
          _collectionSnapshot = await collRef
              .where(field, isLessThanOrEqualTo: compareValue)
              .limit(limit)
              .get();
        }

        /// IF IS NOT EQUAL TO
        else if (valueIs == ValueIs.notEqualTo) {
          _collectionSnapshot = await collRef
              .where(field, isNotEqualTo: compareValue)
              .limit(limit)
              .get();
        }

        /// IF IS NULL
        else if (valueIs == ValueIs.nullValue) {
          _collectionSnapshot = await collRef
              .where(field, isNull: compareValue)
              .limit(limit)
              .get();
        }

        /// IF whereIn
        else if (valueIs == ValueIs.whereIn) {
          _collectionSnapshot = await collRef
              .where(field, whereIn: compareValue)
              .limit(limit)
              .get();
        }

        /// IF whereNotIn
        else if (valueIs == ValueIs.whereNotIn) {
          _collectionSnapshot = await collRef
              .where(field, whereNotIn: compareValue)
              .limit(limit)
              .get();
        }

        /// IF array contains
        else if (valueIs == ValueIs.arrayContains) {
          _collectionSnapshot = await collRef
              .where(field, arrayContains: compareValue)
              .limit(limit)
              .get();
        }

        /// IF array contains any
        else if (valueIs == ValueIs.arrayContainsAny) {
          _collectionSnapshot = await collRef
              .where(field, arrayContainsAny: compareValue)
              .limit(limit)
              .get();
        }
      });

  return _collectionSnapshot;
}

// -----------------------------------------------
Future<dynamic> mapsByFieldValue({
  @required BuildContext context,
  @required String collName,
  @required String field,
  @required dynamic compareValue,
  @required ValueIs valueIs,
  bool addDocsIDs = false,
  bool addDocSnapshotToEachMap = false,
  int limit = 3,
}) async {
  // Tracer.traceMethod(methodName: 'mapsByFieldValue', varName: field, varNewValue: compareValue, tracerIsOn: true);

  final CollectionReference<Object> _collRef = Fire.getCollectionRef(collName);

  final QuerySnapshot<Object> _collectionSnapshot =
  await _searchAndGetCollectionSnapshots(
    context: context,
    collRef: _collRef,
    valueIs: valueIs,
    field: field,
    compareValue: compareValue,
    limit: limit,
  );

  // Tracer.traceMethod(methodName: 'mapsByFieldValue', varName: 'valueIs', varNewValue: valueIs, tracerIsOn: true);

  final List<Map<String, dynamic>> _maps = Mapper.getMapsFromQuerySnapshot(
    querySnapshot: _collectionSnapshot,
    addDocsIDs: addDocsIDs,
    addDocSnapshotToEachMap: addDocSnapshotToEachMap,
  );

  // Tracer.traceMethod(methodName: 'mapsByFieldValue', varName: '_maps', varNewValue: _maps, tracerIsOn: true);

  return _maps;
}

// -----------------------------------------------
Future<dynamic> subCollectionMapsByFieldValue({
  @required BuildContext context,
  @required String collName,
  @required String docName,
  @required String subCollName,
  @required String field,
  @required dynamic compareValue,
  @required ValueIs valueIs,
  bool addDocsIDs = false,
  bool addDocSnapshotToEachMap = false,
  int limit = 3,
}) async {
  // Tracer.traceMethod(methodName: 'mapsByFieldValue', varName: field, varNewValue: compareValue, tracerIsOn: true);

  final CollectionReference<Object> _collRef = Fire.getSubCollectionRef(
    collName: collName,
    docName: docName,
    subCollName: subCollName,
  );

  final QuerySnapshot<Object> _collectionSnapshot =
  await _searchAndGetCollectionSnapshots(
    context: context,
    collRef: _collRef,
    valueIs: valueIs,
    field: field,
    compareValue: compareValue,
    limit: limit,
  );

  // Tracer.traceMethod(methodName: 'mapsByFieldValue', varName: 'valueIs', varNewValue: valueIs, tracerIsOn: true);

  final List<Map<String, dynamic>> _maps = Mapper.getMapsFromQuerySnapshot(
    querySnapshot: _collectionSnapshot,
    addDocsIDs: addDocsIDs,
    addDocSnapshotToEachMap: addDocSnapshotToEachMap,
  );

  // Tracer.traceMethod(methodName: 'mapsByFieldValue', varName: '_maps', varNewValue: _maps, tracerIsOn: true);

  return _maps;
}

// -----------------------------------------------
Future<dynamic> mapsByValueInArray({
  @required BuildContext context,
  @required CollectionReference<Object> collRef,
  @required String field,
  @required dynamic value,
  bool addDocsIDs = false,
  bool addDocSnapshotToEachMap = false,
}) async {
  List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

  await tryAndCatch(
      context: context,
      methodName: 'mapsByValueInArray',
      functions: () async {
        QuerySnapshot<Object> _collectionSnapshot;

        /// if search value is just 1 string
        if (value is String == true) {
          _collectionSnapshot =
          await collRef.where(field, arrayContains: value).get();
        }

        /// i search value is list of strings
        else if (value is List == true) {
          _collectionSnapshot =
          await collRef.where(field, whereIn: value).get();
        }

        _maps = Mapper.getMapsFromQuerySnapshot(
          querySnapshot: _collectionSnapshot,
          addDocsIDs: addDocsIDs,
          addDocSnapshotToEachMap: addDocSnapshotToEachMap,
        );
      });

  return _maps;
}

// -----------------------------------------------
Future<dynamic> mapsByTwoValuesEqualTo({
  @required BuildContext context,
  @required CollectionReference<Object> collRef,
  @required String fieldA,
  @required dynamic valueA,
  @required String fieldB,
  @required dynamic valueB,
  bool addDocsIDs = false,
  bool addDocSnapshotToEachMap = false,
}) async {
  List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

  await tryAndCatch(
      context: context,
      methodName: 'mapsByTwoValuesEqualTo',
      functions: () async {
        QuerySnapshot<Object> _collectionSnapshot;

        _collectionSnapshot = await collRef
            .where(fieldA, isEqualTo: valueA)
            .where(fieldB, isEqualTo: valueB)
            .get();

        blog('is not equal to null aho');

        _maps = Mapper.getMapsFromQuerySnapshot(
          querySnapshot: _collectionSnapshot,
          addDocsIDs: addDocsIDs,
          addDocSnapshotToEachMap: addDocSnapshotToEachMap,
        );
      });

  return _maps;
}
// -----------------------------------------------------------------------------
