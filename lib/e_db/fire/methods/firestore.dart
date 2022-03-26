import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------

/// PATHS

// ---------------------------------------------------
String pathOfDoc({
  @required String collName,
  @required String docName,
}) {
  return '$collName/$docName';
}
// ---------------------------------------------------
String pathOfSubColl({
  @required String collName,
  @required String docName,
  @required String subCollName,
}) {
  return '$collName/$docName/$subCollName';
}
// ---------------------------------------------------
String pathOfSubDoc({
  @required String collName,
  @required String docName,
  @required String subCollName,
  @required String subDocName,
}) {
  return '$collName/$docName/$subCollName/$subDocName';
}
// -----------------------------------------------------------------------------

/// REFERENCES

// ---------------------------------------------------
CollectionReference<Object> getCollectionRef(String collName) {
  final FirebaseFirestore _fireInstance = FirebaseFirestore.instance;
  final CollectionReference<Object> _collection =
      _fireInstance.collection(collName);
  return _collection;
}
// ---------------------------------------------------
DocumentReference<Object> getDocRef({
  @required String collName,
  @required String docName,
}) {
  final CollectionReference<Object> _collection = getCollectionRef(collName);
  final DocumentReference<Object> _doc = _collection.doc(docName);

  // or this syntax
  // final DocumentReference<Object> _doc =
  // FirebaseFirestore.instance
  //     .collection(collName)
  //     .doc(docName)

  return _doc;
}
// ---------------------------------------------------
CollectionReference<Object> getSubCollectionRef({
  @required String collName,
  @required String docName,
  @required String subCollName,
}) {
  final CollectionReference<Object> _subCollection =
      FirebaseFirestore.instance.collection('$collName/$docName/$subCollName');

  // or this syntax
  // final CollectionReference<Object> _subCollection =
  // FirebaseFirestore.instance
  //     .collection(collName)
  //     .doc(docName)
  //     .collection(subCollName);

  return _subCollection;
}
// ---------------------------------------------------
DocumentReference<Object> getSubDocRef({
  @required String collName,
  @required String docName,
  @required String subCollName,
  @required String subDocName,
}) {
  final CollectionReference<Object> _subCollection =
      FirebaseFirestore.instance.collection('$collName/$docName/$subCollName');
  final DocumentReference<Object> _subDocRef = _subCollection.doc(subDocName);

  // or this syntax
  // final DocumentReference<Object> _subDocRef =
  // FirebaseFirestore.instance
  //     .collection(collName)
  //     .doc(docName)
  //     .collection(subCollName)
  //     .doc(subDocName);

  return _subDocRef;
}
// -----------------------------------------------------------------------------

/// CREATE

// ---------------------------------------------------
/// creates firestore doc with auto generated ID then returns doc reference
Future<DocumentReference<Object>> createDoc({
  @required BuildContext context,
  @required String collName,
  @required Map<String, dynamic> input,
  bool addDocID = false,
}) async {
  DocumentReference<Object> _docRef;

  await tryAndCatch(
      context: context,
      methodName: 'createDoc',
      functions: () async {
        final CollectionReference<Object> _bzCollectionRef =
            getCollectionRef(collName);

        _docRef = _bzCollectionRef.doc();

        if (addDocID == true) {
          Mapper.insertPairInMap(
            map: input,
            key: 'id',
            value: _docRef.id,
          );
        }

        await _docRef.set(input);
      });

  return _docRef;
}
// ---------------------------------------------------
Future<DocumentReference<Object>> createNamedDoc({
  @required BuildContext context,
  @required String collName,
  @required String docName,
  @required Map<String, dynamic> input,
}) async {
  DocumentReference<Object> _docRef;

  await tryAndCatch(
      context: context,
      methodName: 'createNamedDoc',
      functions: () async {

        final DocumentReference<Object> _docRef = getDocRef(
          collName: collName,
          docName: docName,
        );

        await _docRef.set(input);

        blog('createNamedDoc : ${_docRef.id}');
      });

  return _docRef;
}
// ---------------------------------------------------
/// creates firestore sub doc with auto ID
Future<DocumentReference<Object>> createSubDoc({
  @required BuildContext context,
  @required String collName,
  @required String docName,
  @required String subCollName,
  @required Map<String, dynamic> input,
}) async {
  /// creates a new sub doc and new sub collection if didn't exists
  /// and uses the same directory if existed to add a new doc
  /// updates the sub doc if existed
  /// and creates random name for sub doc if sub doc name is null

  final DocumentReference<Object> _subDocRef = await createNamedSubDoc(
    context: context,
    collName: collName,
    docName: docName,
    subCollName: subCollName,
    subDocName: null, // to make it generate auto ID
    input: input,
  );

  return _subDocRef;
}
// ---------------------------------------------------
Future<DocumentReference<Object>> createNamedSubDoc({
  @required BuildContext context,
  @required String collName,
  @required String docName,
  @required String subCollName,
  @required String subDocName,
  @required Map<String, dynamic> input,
}) async {
  /// creates a new sub doc and new sub collection if didn't exists
  /// and uses the same directory if existed to add a new doc
  /// updates the sub doc if existed
  /// and creates random name for sub doc if sub doc name is null

  DocumentReference<Object> _subDocRef;

  await tryAndCatch(
      context: context,
      methodName: 'createNamedSubDoc',
      functions: () async {
        _subDocRef = getSubDocRef(
          collName: collName,
          docName: docName,
          subCollName: subCollName,
          subDocName: subDocName,
        );

        await _subDocRef.set(input);

        blog(
            'createNamedSubDoc : CREATED $collName/$docName/$subCollName/$subDocName/');
      });

  return _subDocRef;
}
// -----------------------------------------------------------------------------

/// READ

// ---------------------------------------------------
Future<dynamic> _getMapByDocRef(DocumentReference<Object> docRef) async {
  dynamic _map;

  final DocumentSnapshot<Object> snapshot = await docRef.get();

  if (snapshot.exists == true) {
    _map = Mapper.getMapFromDocumentSnapshot(snapshot);
  } else {
    _map = null;
  }

  //     .then<dynamic>((DocumentSnapshot snapshot) async {
  //   _map = Mapper.getMapFromDocumentSnapshot(snapshot);
  // });
  return _map;
}

// ---------------------------------------------------
Future<List<Map<String, dynamic>>> readCollectionDocs({
  @required String collName,
  @required String orderBy,
  @required int limit,
  QueryDocumentSnapshot<Object> startAfter,
  bool addDocSnapshotToEachMap = false,
  bool addDocsIDs = false,
}) async {
  final QueryDocumentSnapshot<Object> _startAfter = startAfter;

  QuerySnapshot<Object> _collectionSnapshot;

  if (_startAfter == null) {
    _collectionSnapshot = await FirebaseFirestore.instance
        .collection(collName)
        .orderBy(orderBy)
        .limit(limit)
        .get();
  } else {
    _collectionSnapshot = await FirebaseFirestore.instance
        .collection(collName)
        .orderBy(orderBy)
        .limit(limit)
        .startAfterDocument(startAfter)
        .get();
  }

  final List<QueryDocumentSnapshot<Object>> _docsSnapshots =
      _collectionSnapshot.docs;

  /// to return maps
  final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

  for (final QueryDocumentSnapshot<Object> docSnapshot in _docsSnapshots) {
    Map<String, dynamic> _map = docSnapshot.data();

    if (addDocsIDs == true) {
      _map = Mapper.insertPairInMap(
        map: _map,
        key: 'id',
        value: docSnapshot.id,
      );
    }

    if (addDocSnapshotToEachMap == true) {
      _map = Mapper.insertPairInMap(
        map: _map,
        key: 'docSnapshot',
        value: docSnapshot,
      );
    }

    _maps.add(_map);
  }
  // return <List<QueryDocumentSnapshot<Object>>>

  return _maps;
}
// ---------------------------------------------------
Future<Map<String, dynamic>> readDoc({
  @required BuildContext context,
  @required String collName,
  @required String docName,
}) async {
  blog('readDoc() : starting to read doc : firestore/$collName/$docName');
  // blog('lng : ${Wordz.languageCode(context)}');

  Map<String, dynamic> _map; //QueryDocumentSnapshot

  // blog('readDoc() : _map starts as : $_map');

  final dynamic _result = await tryCatchAndReturnBool(
    context: context,
    methodName: 'readDoc',
    functions: () async {

      final DocumentReference<Object> _docRef = getDocRef(
          collName: collName,
          docName: docName,
          );
      // blog('readDoc() : _docRef : $_docRef');

      _map = await _getMapByDocRef(_docRef);
      // blog('readDoc() : _map : $_map');
    },
  );

  // blog('readDoc() : _result : $_result');
  // blog('readDoc() : _map : $_map');
  // blog('lng : ${Wordz.languageCode(context)}');

  return _result.runtimeType == String ? null : _map;
}
// ---------------------------------------------------
/// TASK : delete Fire.readDocField if not used in release mode
Future<dynamic> readDocField({
  @required BuildContext context,
  @required String collName,
  @required String docName,
  @required String fieldName,
}) async {
  dynamic _map;

  await tryAndCatch(
      context: context,
      methodName: 'readDocField',
      functions: () async {
        _map = await readDoc(
          context: context,
          collName: collName,
          docName: docName,
        );
      });

  return _map[fieldName];
}
// ---------------------------------------------------
Future<List<Map<String, dynamic>>> readSubCollectionDocs({
  @required BuildContext context,
  @required String collName,
  @required String docName,
  @required String subCollName,
  @required int limit,
  @required String orderBy,
  bool addDocsIDs = false,
  bool addDocSnapshotToEachMap = false,
  QueryDocumentSnapshot<Object> startAfter,
}) async {
  /*

        final QueryDocumentSnapshot _startAfter = startAfter ?? null;

    QuerySnapshot<Object> _collectionSnapshot;


    if(_startAfter == null){
      _collectionSnapshot = await FirebaseFirestore.instance.collection(collName).orderBy(orderBy).limit(limit).get();
    }

    else {
      _collectionSnapshot = await FirebaseFirestore.instance.collection(collName).orderBy(orderBy).limit(limit).startAfterDocument(startAfter).get();
    }



    final List<QueryDocumentSnapshot> _docsSnapshots = _collectionSnapshot.docs;

    /// to return maps
    final List<dynamic> _maps = <dynamic>[];

    for (QueryDocumentSnapshot docSnapshot in _docsSnapshots){

      Map<String, dynamic> _map = docSnapshot.data();

      if (addDocID == true){
        _map = Mapper.insertPairInMap(
          map: _map,
          key: 'id',
          value: docSnapshot.id,
        );
      }

      if (addDocSnapshotToEachMap == true){
        _map = Mapper.insertPairInMap(
          map: _map,
          key: 'docSnapshot',
          value: docSnapshot,
        );
      }

      _maps.add(_map);

    }
    // return <List<QueryDocumentSnapshot>>

    return _maps;



     */

  List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

  await tryAndCatch(
      context: context,
      methodName: 'readSubCollectionDocs',
      functions: () async {

        final CollectionReference<Object> _subCollection = getSubCollectionRef(
          collName: collName,
          docName: docName,
          subCollName: subCollName,
        );

        QuerySnapshot<Object> _collectionSnapshot;

        final QueryDocumentSnapshot<Object> _startAfter = startAfter;

        if (_startAfter == null) {
          _collectionSnapshot = await _subCollection
              .orderBy(orderBy)
              .limit(limit)
              .get();
        }

        else {
          _collectionSnapshot = await _subCollection
              .orderBy(orderBy)
              .limit(limit)
              .startAfterDocument(startAfter)
              .get();
        }

        _maps = Mapper.getMapsFromQuerySnapshot(
          querySnapshot: _collectionSnapshot,
          addDocsIDs: addDocsIDs,
          addDocSnapshotToEachMap: addDocSnapshotToEachMap,
        );
      }
      );

  return _maps;
}

// ---------------------------------------------------
Future<dynamic> readSubDoc({
  @required BuildContext context,
  @required String collName,
  @required String docName,
  @required String subCollName,
  @required String subDocName,
}) async {
  dynamic _map;

  await tryAndCatch(
      context: context,
      methodName: 'readSubDoc',
      functions: () async {
        final DocumentReference<Object> _subDocRef = getSubDocRef(
          collName: collName,
          docName: docName,
          subCollName: subCollName,
          subDocName: subDocName,
        );

        _map = await _getMapByDocRef(_subDocRef);
      });

  return _map;
}
// ---------------------------------------------------
Stream<QuerySnapshot<Object>> streamCollection(String collectionName) {
  final CollectionReference<Object> _collection =
      getCollectionRef(collectionName);
  final Stream<QuerySnapshot<Object>> _snapshots = _collection.snapshots();
  return _snapshots;
}
// ---------------------------------------------------
Stream<QuerySnapshot<Object>> streamSubCollection({
  @required String collName,
  @required String docName,
  @required String subCollName,
  @required bool descending,
  @required String orderBy, // field name to order by
  String field,
  dynamic compareValue,
}) {
  final CollectionReference<Object> _collection = getSubCollectionRef(
    collName: collName,
    docName: docName,
    subCollName: subCollName,
  );

  Stream<QuerySnapshot<Object>> _snapshots;

  if (field != null && compareValue != null) {
    _snapshots = _collection
        .orderBy(orderBy, descending: descending)
        .where(field, isEqualTo: compareValue)
        .limit(10)
        .snapshots();
  } else {
    _snapshots =
        _collection.orderBy(orderBy, descending: descending).snapshots();
  }

  return _snapshots;
}
// ---------------------------------------------------
Stream<DocumentSnapshot<Object>> streamDoc({
  @required String collName,
  @required String docName,
}) {

  final DocumentReference<Object> _document = getDocRef(
      collName: collName,
      docName: docName,
  );

  final Stream<DocumentSnapshot<Object>> _snapshots = _document.snapshots();

  return _snapshots;
}
// ---------------------------------------------------
Stream<DocumentSnapshot<Object>> streamSubDoc({
  @required String collName,
  @required String docName,
  @required String subCollName,
  @required String subDocName,
}) {
  final DocumentReference<Object> _document = getSubDocRef(
    collName: collName,
    docName: docName,
    subCollName: subCollName,
    subDocName: subDocName,
  );

  final Stream<DocumentSnapshot<Object>> _snapshots = _document.snapshots();

  return _snapshots;
}
// -----------------------------------------------------------------------------

/// UPDATE

// ---------------------------------------------------
/// this creates a new doc that overrides existing doc,, same as createNamedDoc method
Future<void> updateDoc({
  @required BuildContext context,
  @required String collName,
  @required String docName,
  @required Map<String, dynamic> input,
}) async {

  await createNamedDoc(
    context: context,
    collName: collName,
    docName: docName,
    input: input,
  );

  // or another syntax
  // await tryAndCatch(
  //     context: context,
  //     functions: () async {
  //
  //       DocumentReference<Object> _docRef = getDocRef(collName, docName);
  //       await _docRef.set(input);
  //
  //     }
  // );
}
// ---------------------------------------------------
Future<void> updateDocField({
  @required BuildContext context,
  @required String collName,
  @required String docName,
  @required String field,
  @required dynamic input,
}) async {
  final DocumentReference<Object> _doc =
      getDocRef(collName: collName, docName: docName);

  await tryAndCatch(
      context: context,
      methodName: 'updateDocField',
      functions: () async {
        await _doc.update(<String, dynamic>{field: input});

        blog(
            'Updated doc : $docName : field : [$field] : to : ${input.toString()}');
      });
}
// ---------------------------------------------------
Future<void> updateSubDoc({
  @required BuildContext context,
  @required String collName,
  @required String docName,
  @required String subCollName,
  @required String subDocName,
  @required Map<String, dynamic> input,
}) async {
  await createNamedSubDoc(
    context: context,
    collName: collName,
    docName: docName,
    subCollName: subCollName,
    subDocName: subDocName,
    input: input,
  );
}
// ---------------------------------------------------
/// this updates a field if exists, if absent it creates a new field and inserts the value
Future<void> updateSubDocField(
    {@required BuildContext context,
    @required String collName,
    @required String docName,
    @required String subCollName,
    @required String subDocName,
    @required String field,
    @required dynamic input}) async {
  final DocumentReference<Object> _subDoc = getSubDocRef(
    collName: collName,
    docName: docName,
    subCollName: subCollName,
    subDocName: subDocName,
  );

  await tryAndCatch(
      context: context,
      methodName: 'updateSubDocField',
      functions: () async {
        await _subDoc.update(<String, dynamic>{field: input});
      });
}
// -----------------------------------------------------------------------------

/// DELETE

// ---------------------------------------------------
Future<void> deleteDoc({
  @required BuildContext context,
  @required String collName,
  @required String docName,
}) async {
  await tryAndCatch(
      context: context,
      methodName: 'deleteDoc',
      functions: () async {
        final DocumentReference<Object> _doc = getDocRef(
          collName: collName,
          docName: docName,
        );

        await _doc.delete();
      });
}
// ---------------------------------------------------
Future<void> deleteSubDoc({
  @required BuildContext context,
  @required String collName,
  @required String docName,
  @required String subCollName,
  @required String subDocName,
}) async {
  await tryAndCatch(
      context: context,
      methodName: 'deleteSubDoc',
      functions: () async {
        final DocumentReference<Object> _subDoc = getSubDocRef(
          collName: collName,
          docName: docName,
          subCollName: subCollName,
          subDocName: subDocName,
        );

        await _subDoc.delete();
      });
}
// ---------------------------------------------------
Future<void> deleteCollection({
  @required BuildContext context,
  @required String collName,
}) async {
  /// TASK : deleting collection and all its docs, sub collections & sub docs require a cloud function
}
// ---------------------------------------------------
Future<void> deleteSubCollection({
  @required BuildContext context,
  @required String collName,
  @required String docName,
  @required String subCollName,
}) async {
  /// TASK : deleting sub collection and all its sub docs require a cloud function
}
// ---------------------------------------------------
/// ALERT : deleting all sub docs from client device is super dangerous
Future<void> deleteAllSubDocs({
  @required BuildContext context,
  @required String collName,
  @required String docName,
  @required String subCollName,
}) async {
  // /// a - read all sub docs
  // final List<dynamic> _subDocs = await Fire.readSubCollectionDocs(
  //   context: context,
  //   addDocsIDs: true,
  //   collName: collName,
  //   docName: docName,
  //   subCollName: subCollName,
  //   addDocSnapshotToEachMap: false,
  //   orderBy: '',
  // );
  //
  // for(var map in _subDocs){
  //
  //   final String _docID = map['id'];
  //
  //   await Fire.deleteSubDoc(
  //     context: context,
  //     collName: collName,
  //     docName: docName,
  //     subCollName: subCollName,
  //     subDocName: _docID,
  //   );
  //
  // }
}
// ---------------------------------------------------
Future<void> deleteDocField({
  @required BuildContext context,
  @required String collName,
  @required String docName,
  @required String field,
}) async {
  final DocumentReference<Object> _docRef = getDocRef(
    collName: collName,
    docName: docName,
  );

  // await tryAndCatch(
  //     context: context,
  //     methodName: 'deleteSubDocField',
  //     functions: () async {

  // Remove field from the document
  final Map<String, Object> updates = <String, Object>{};

  updates.addAll(<String, dynamic>{
    field: FieldValue.delete(),
  });

  await _docRef.update(updates);

  //     }
  // );
}
// ---------------------------------------------------
Future<void> deleteSubDocField({
  @required BuildContext context,
  @required String collName,
  @required String docName,
  @required String field,
  @required String subCollName,
  @required String subDocName,
}) async {
  final DocumentReference<Object> _docRef = getSubDocRef(
    collName: collName,
    docName: docName,
    subCollName: subCollName,
    subDocName: subDocName,
  );

  await tryAndCatch(
      context: context,
      methodName: 'deleteSubDocField',
      functions: () async {
        // Remove field from the document
        final Map<String, Object> updates = <String, Object>{};

        updates.addAll(<String, dynamic>{
          field: FieldValue.delete(),
        });

        await _docRef.update(updates);
      });
}
// ---------------------------------------------------
