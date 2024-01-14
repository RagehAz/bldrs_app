// import 'package:fire/super_fire.dart';
// import 'package:basics/helpers/files/filers.dart';
// import 'package:flutter/material.dart';
// import 'package:basics/helpers/maps/mapper.dart';
// // -----------------------------------------------------------------------------
//
// /// GENERAL
//
// // --------------------
// Future<dynamic> subCollectionMapsByFieldValue({
//   required String coll,
//   required String doc,
//   required String subColl,
//   required String field,
//   required dynamic compareValue,
//   required FireComparison valueIs,
//   bool addDocsIDs = false,
//   bool addDocSnapshotToEachMap = false,
//   int limit = 3,
// }) async {
//   // Tracer.traceMethod(invoker: 'mapsByFieldValue', varName: field, varNewValue: compareValue, tracerIsOn: true);
//
//   final CollectionReference<Object> _collRef = OfficialFire.getCollRef(
//     coll: coll,
//     doc: doc,
//     subColl: subColl,
//   );
//
//   final QuerySnapshot<Object> _collectionSnapshot =
//   await _searchAndGetCollectionSnapshots(
//     collRef: _collRef,
//     valueIs: valueIs,
//     field: field,
//     compareValue: compareValue,
//     limit: limit,
//   );
//
//   // Tracer.traceMethod(invoker: 'mapsByFieldValue', varName: 'valueIs', varNewValue: valueIs, tracerIsOn: true);
//
//   final List<Map<String, dynamic>> _maps = Mapper.getMapsFromQuerySnapshot(
//     querySnapshot: _collectionSnapshot,
//     addDocsIDs: addDocsIDs,
//     addDocSnapshotToEachMap: addDocSnapshotToEachMap,
//   );
//
//   // Tracer.traceMethod(invoker: 'mapsByFieldValue', varName: '_maps', varNewValue: _maps, tracerIsOn: true);
//
//   return _maps;
// }
// // --------------------
// Future<QuerySnapshot<Object>> _searchAndGetCollectionSnapshots({
//   required CollectionReference<Object> collRef,
//   required FireComparison valueIs,
//   required String field,
//   required dynamic compareValue,
//   required int limit,
// }) async {
//   QuerySnapshot<Object> _collectionSnapshot;
//
//   await tryAndCatch(
//       invoker: '_getCollectionSnapshots',
//       functions: () async {
//         /// IF EQUAL TO
//         if (valueIs == FireComparison.equalTo) {
//           _collectionSnapshot = await collRef
//               .where(field, isEqualTo: compareValue)
//               .limit(limit)
//               .get();
//         }
//
//         /// IF GREATER THAN
//         else if (valueIs == FireComparison.greaterThan) {
//           _collectionSnapshot = await collRef
//               .where(field, isGreaterThan: compareValue)
//               .limit(limit)
//               .get();
//         }
//
//         /// IF GREATER THAN OR EQUAL
//         else if (valueIs == FireComparison.greaterOrEqualThan) {
//           _collectionSnapshot = await collRef
//               .where(field, isGreaterThanOrEqualTo: compareValue)
//               .limit(limit)
//               .get();
//         }
//
//         /// IF LESS THAN
//         else if (valueIs == FireComparison.lessThan) {
//           _collectionSnapshot = await collRef
//               .where(field, isLessThan: compareValue)
//               .limit(limit)
//               .get();
//         }
//
//         /// IF LESS THAN OR EQUAL
//         else if (valueIs == FireComparison.lessOrEqualThan) {
//           _collectionSnapshot = await collRef
//               .where(field, isLessThanOrEqualTo: compareValue)
//               .limit(limit)
//               .get();
//         }
//
//         /// IF IS NOT EQUAL TO
//         else if (valueIs == FireComparison.notEqualTo) {
//           _collectionSnapshot = await collRef
//               .where(field, isNotEqualTo: compareValue)
//               .limit(limit)
//               .get();
//         }
//
//         /// IF IS NULL
//         else if (valueIs == FireComparison.nullValue) {
//           _collectionSnapshot = await collRef
//               .where(field, isNull: compareValue)
//               .limit(limit)
//               .get();
//         }
//
//         /// IF whereIn
//         else if (valueIs == FireComparison.whereIn) {
//           _collectionSnapshot = await collRef
//               .where(field, whereIn: compareValue)
//               .limit(limit)
//               .get();
//         }
//
//         /// IF whereNotIn
//         else if (valueIs == FireComparison.whereNotIn) {
//           _collectionSnapshot = await collRef
//               .where(field, whereNotIn: compareValue)
//               .limit(limit)
//               .get();
//         }
//
//         /// IF array contains
//         else if (valueIs == FireComparison.arrayContains) {
//           _collectionSnapshot = await collRef
//               .where(field, arrayContains: compareValue)
//               .limit(limit)
//               .get();
//         }
//
//         /// IF array contains any
//         else if (valueIs == FireComparison.arrayContainsAny) {
//           _collectionSnapshot = await collRef
//               .where(field, arrayContainsAny: compareValue)
//               .limit(limit)
//               .get();
//         }
//       });
//
//   return _collectionSnapshot;
// }
// // --------------------
// Future<dynamic> mapsByFieldValue({
//   required String collName,
//   required String field,
//   required dynamic compareValue,
//   required FireComparison valueIs,
//   bool addDocsIDs = false,
//   bool addDocSnapshotToEachMap = false,
//   int limit = 3,
// }) async {
//   // Tracer.traceMethod(invoker: 'mapsByFieldValue', varName: field, varNewValue: compareValue, tracerIsOn: true);
//
//   final CollectionReference<Object> _collRef = OfficialFire.getCollRef(
//     coll: collName,
//   );
//
//   final QuerySnapshot<Object> _collectionSnapshot =
//   await _searchAndGetCollectionSnapshots(
//     collRef: _collRef,
//     valueIs: valueIs,
//     field: field,
//     compareValue: compareValue,
//     limit: limit,
//   );
//
//   // Tracer.traceMethod(invoker: 'mapsByFieldValue', varName: 'valueIs', varNewValue: valueIs, tracerIsOn: true);
//
//   final List<Map<String, dynamic>> _maps = Mapper.getMapsFromQuerySnapshot(
//     querySnapshot: _collectionSnapshot,
//     addDocsIDs: addDocsIDs,
//     addDocSnapshotToEachMap: addDocSnapshotToEachMap,
//   );
//
//   // Tracer.traceMethod(invoker: 'mapsByFieldValue', varName: '_maps', varNewValue: _maps, tracerIsOn: true);
//
//   return _maps;
// }
// // -----------------------------------------------------------------------------
// /*
// Future<dynamic> mapsByValueInArray({
//   required BuildContext context,
//   required CollectionReference<Object> collRef,
//   required String field,
//   required dynamic value,
//   bool addDocsIDs = false,
//   bool addDocSnapshotToEachMap = false,
// }) async {
//   List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];
//
//   await tryAndCatch(
//       context: context,
//       invoker: 'mapsByValueInArray',
//       functions: () async {
//         QuerySnapshot<Object> _collectionSnapshot;
//
//         /// if search value is just 1 string
//         if (value is String == true) {
//           _collectionSnapshot =
//           await collRef.where(field, arrayContains: value).get();
//         }
//
//         /// i search value is list of strings
//         else if (value is List == true) {
//           _collectionSnapshot =
//           await collRef.where(field, whereIn: value).get();
//         }
//
//         _maps = Mapper.getMapsFromQuerySnapshot(
//           querySnapshot: _collectionSnapshot,
//           addDocsIDs: addDocsIDs,
//           addDocSnapshotToEachMap: addDocSnapshotToEachMap,
//         );
//       });
//
//   return _maps;
// }
//  */
// // --------------------
// /*
//
// Future<dynamic> mapsByTwoValuesEqualTo({
//   required BuildContext context,
//   required String collName,
//   required String fieldA,
//   required dynamic valueA,
//   required String fieldB,
//   required dynamic valueB,
//   required int limit,
//   bool addDocsIDs = false,
//   bool addDocSnapshotToEachMap = false,
// }) async {
//
//   List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];
//
//   await tryAndCatch(
//       context: context,
//       invoker: 'mapsByTwoValuesEqualTo',
//       functions: () async {
//
//         final CollectionReference<Object> _collRef = Fire.getCollectionRef(collName);
//
//         final QuerySnapshot<Object> _collectionSnapshot = await _collRef
//             .where(fieldA, isEqualTo: valueA)
//             .where(fieldB, isEqualTo: valueB)
//             .limit(limit)
//             .get();
//
//         // blog('is not equal to null aho');
//
//         _maps = Mapper.getMapsFromQuerySnapshot(
//           querySnapshot: _collectionSnapshot,
//           addDocsIDs: addDocsIDs,
//           addDocSnapshotToEachMap: addDocSnapshotToEachMap,
//         );
//
//       });
//
//   return _maps;
// }
//  */
// // -----------------------------------------------------------------------------
