import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/e_db/fire/fire_models/query_models/fire_finder.dart';
import 'package:bldrs/e_db/fire/fire_models/query_models/query_order_by.dart';
export 'package:bldrs/e_db/fire/fire_models/query_models/query_order_by.dart';

class Fire {

  Fire();

// -----------------------------------------------------------------------------

  /// PATHS GETTERS

// ----------------------------
  static Future<void> initializeFirestore({
    @required BuildContext context,
    @required ValueNotifier<String> fireError,
  }) async {

    await tryAndCatch(
        context: context,
        functions: () async {

          final FirebaseApp _firebaseApp = await Firebase.initializeApp();

          blog('_firebaseApp.name : ${_firebaseApp.name}');
          blog('_firebaseApp.isAutomaticDataCollectionEnabled : ${_firebaseApp.isAutomaticDataCollectionEnabled}');
          blog('_firebaseApp.options :-');

          Mapper.blogMap(_firebaseApp.options.asMap);

        },
        onError: (String error) {
          fireError.value = error;
        });

  }
// -----------------------------------------------------------------------------

  /// PATHS GETTERS

// ----------------------------
  /// TESTED : NOT USED
/*
String pathOfDoc({
  @required String collName,
  @required String docName,
}) {
  return '$collName/$docName';
}
// ----------------------------
String pathOfSubColl({
  @required String collName,
  @required String docName,
  @required String subCollName,
}) {
  return '$collName/$docName/$subCollName';
}
// ----------------------------
String pathOfSubDoc({
  @required String collName,
  @required String docName,
  @required String subCollName,
  @required String subDocName,
}) {
  return '$collName/$docName/$subCollName/$subDocName';
}

 */
// -----------------------------------------------------------------------------

  /// REFERENCES

// ----------------------------
  /// TESTED : WORKS PERFECT
  static CollectionReference<Object> getCollectionRef(String collName) {
    final FirebaseFirestore _fireInstance = FirebaseFirestore.instance;
    final CollectionReference<Object> _collection = _fireInstance.collection(collName);
    return _collection;
  }
// ----------------------------
  /// TESTED : WORKS PERFECT
  static DocumentReference<Object> getDocRef({
    @required String collName,
    @required String docName,
  }) {
    final CollectionReference<Object> _collection = getCollectionRef(collName);
    final DocumentReference<Object> _doc = _collection.doc(docName);

    /// or this syntax
    /// final DocumentReference<Object> _doc =
    /// FirebaseFirestore.instance
    ///     .collection(collName)
    ///     .doc(docName)

    return _doc;
  }
// ----------------------------
  /// TESTED : WORKS PERFECT
  static CollectionReference<Object> getSubCollectionRef({
    @required String collName,
    @required String docName,
    @required String subCollName,
  }) {

    final FirebaseFirestore _fireInstance = FirebaseFirestore.instance;
    final CollectionReference<Object> _subCollection = _fireInstance
        .collection('$collName/$docName/$subCollName');

    /// or this syntax
    /// final CollectionReference<Object> _subCollection =
    /// FirebaseFirestore.instance
    ///     .collection(collName)
    ///     .doc(docName)
    ///     .collection(subCollName);

    return _subCollection;
  }
// ----------------------------
  /// TESTED : WORKS PERFECT
  static DocumentReference<Object> getSubDocRef({
    @required String collName,
    @required String docName,
    @required String subCollName,
    @required String subDocName,
  }) {

    final CollectionReference<Object> _subCollection = FirebaseFirestore
        .instance
        .collection('$collName/$docName/$subCollName');

    final DocumentReference<Object> _subDocRef = _subCollection.doc(subDocName);

    /// or this syntax
    /// final DocumentReference<Object> _subDocRef =
    /// FirebaseFirestore.instance
    ///     .collection(collName)
    ///     .doc(docName)
    ///     .collection(subCollName)
    ///     .doc(subDocName);

    return _subDocRef;
  }
// -----------------------------------------------------------------------------

  /// QUERIES

// ----------------------------
  static Query<Map<String, dynamic>> _superQuery({
    @required CollectionReference<Object> collRef,
    QueryOrderBy orderBy,
    int limit,
    QueryDocumentSnapshot<Object> startAfter,
    List<FireFinder> finders,
  }){

    Query<Map<String, dynamic>> query = FirebaseFirestore.instance.collection(collRef.path);

    /// ASSIGN SEARCH FINDERS
    if (Mapper.checkCanLoopList(finders) == true){
      query = FireFinder.createCompositeQueryByFinders(
          query: query,
          finders: finders
      );
    }
    /// ORDER BY A FIELD NAME
    if (orderBy != null){
      query = query.orderBy(orderBy.fieldName, descending: orderBy.descending);
    }
    /// LIMIT NUMBER OR RESULTS
    if (limit != null){
      query = query.limit(limit);
    }
    /// START AFTER A SPECIFIC SNAPSHOT
    if (startAfter != null){
      query = query.startAfterDocument(startAfter);
    }

    return query;
  }
// ----------------------------
  /// TESTED : WORKS PERFECT
  static Future<QuerySnapshot<Object>> _superCollectionQuery({
    @required CollectionReference<Object> collRef,
    QueryOrderBy orderBy,
    int limit,
    QueryDocumentSnapshot<Object> startAfter,
    List<FireFinder> finders,
  }) async {

    final Query<Map<String, dynamic>> query = _superQuery(
      collRef: collRef,
      orderBy: orderBy,
      limit: limit,
      startAfter: startAfter,
      finders: finders,
    );

    final QuerySnapshot<Object> _collectionSnapshot = await query.get();

    return _collectionSnapshot;
  }
// -----------------------------------------------------------------------------

  /// CREATE

// ----------------------------
  /// TESTED : WORKS PERFECT : creates firestore doc with auto generated ID then returns doc reference
  static Future<DocumentReference<Object>> createDoc({
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

        final CollectionReference<Object> _bzCollectionRef = getCollectionRef(collName);

        _docRef = _bzCollectionRef.doc();

        if (addDocID == true) {
          Mapper.insertPairInMap(
            map: input,
            key: 'id',
            value: _docRef.id,
          );
        }

        await _docRef.set(input);


        blog('Fire : createDoc : $collName/${_docRef.id} : ${input.keys.length} keys');
      },
      onError: (String error){

        _docRef = null;

      },
    );

    return _docRef;
  }
// ----------------------------
  /// TESTED : WORKS PERFECT
  static Future<DocumentReference<Object>> createNamedDoc({
    @required BuildContext context,
    @required String collName,
    @required String docName,
    @required Map<String, dynamic> input,
  }) async {
    DocumentReference<Object> _ref;

    await tryAndCatch(
        context: context,
        methodName: 'createNamedDoc',
        functions: () async {

          final DocumentReference<Object> _docRef = getDocRef(
            collName: collName,
            docName: docName,
          );

          // final SetOptions options = SetOptions(
          //   merge: true,
          //   mergeFields: <Object>[],
          // );

          await _docRef.set(input, );

          blog('createNamedDoc : ( $collName ) : ${_docRef.id}');
          _ref = _docRef;
        });

    return _ref;
  }
// ----------------------------
  /// TESTED : WORKS PERFECT : creates firestore sub doc with auto ID
  static Future<DocumentReference<Object>> createSubDoc({
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
// ----------------------------
  /// TESTED : WORKS PERFECT
  static Future<DocumentReference<Object>> createNamedSubDoc({
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

    final bool _success = await tryCatchAndReturnBool(
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

          blog('createNamedSubDoc : CREATED $collName/$docName/$subCollName/$subDocName/');
        });

    if (_success == true){
      return _subDocRef;
    }
    else {
      return null;
    }

  }
// -----------------------------------------------------------------------------

  /// READ

// ----------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> readCollectionDocs({
    @required BuildContext context,
    @required String collName,
    QueryOrderBy orderBy,
    int limit,
    QueryDocumentSnapshot<Object> startAfter,
    bool addDocSnapshotToEachMap = false,
    bool addDocsIDs = false,
    List<FireFinder> finders,
  }) async {

    List<Map<String, dynamic>> _maps = <Map<String,dynamic>>[];

    await tryAndCatch(
        context: context,
        functions: () async {

          final CollectionReference<Object> _collRef = getCollectionRef(collName);

          final QuerySnapshot<Object> _collectionSnapshot = await _superCollectionQuery(
            collRef: _collRef,
            orderBy: orderBy,
            limit: limit,
            startAfter: startAfter,
            finders: finders,
          );

          final List<QueryDocumentSnapshot<Object>> _queryDocumentSnapshots = _collectionSnapshot.docs;

          _maps = Mapper.getMapsFromQueryDocumentSnapshotsList(
              queryDocumentSnapshots: _queryDocumentSnapshots,
              addDocsIDs: addDocsIDs,
              addDocSnapshotToEachMap: addDocSnapshotToEachMap
          );

        }
    );


    return _maps;
  }
// ----------------------------
  /// TESTED : WORKS PERFECT
  static Future<dynamic> _getMapByDocRef({
    @required DocumentReference<Object> docRef,
    @required bool addDocID,
    @required bool addDocSnapshot,
  }) async {
    dynamic _map;

    final DocumentSnapshot<Object> snapshot = await docRef.get();

    if (snapshot.exists == true) {
      _map = Mapper.getMapFromDocumentSnapshot(
        docSnapshot: snapshot,
        addDocSnapshot: addDocSnapshot,
        addDocID: addDocID,
      );
    }

    return _map;
  }
// ----------------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>> readDoc({
    @required BuildContext context,
    @required String collName,
    @required String docName,
    bool addDocID = false,
    bool addDocSnapshot = false,
  }) async {


    Map<String, dynamic> _map; //QueryDocumentSnapshot

    final dynamic _result = await tryCatchAndReturnBool(
      context: context,
      methodName: 'readDoc',
      functions: () async {

        final DocumentReference<Object> _docRef = getDocRef(
          collName: collName,
          docName: docName,
        );
        // blog('readDoc() : _docRef : $_docRef');

        _map = await _getMapByDocRef(
          docRef: _docRef,
          addDocID: addDocID,
          addDocSnapshot: addDocSnapshot,
        );
        // blog('readDoc() : _map : $_map');
      },
    );

    final String _found = _map == null ? 'NOT FOUND' : 'FOUND';
    blog('readDoc() : reading doc : firestore/$collName/$docName : $_found');

    return _result.runtimeType == String ? null : _map;
  }
// ----------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> readSubCollectionDocs({
    @required BuildContext context,
    @required String collName,
    @required String docName,
    @required String subCollName,
    int limit,
    QueryOrderBy orderBy,
    QueryDocumentSnapshot<Object> startAfter,
    bool addDocsIDs = false,
    bool addDocSnapshotToEachMap = false,
    List<FireFinder> finders,
  }) async {

    List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

    await tryAndCatch(
        context: context,
        methodName: 'readSubCollectionDocs',
        functions: () async {

          final CollectionReference<Object> _subCollectionRef = getSubCollectionRef(
            collName: collName,
            docName: docName,
            subCollName: subCollName,
          );

          final QuerySnapshot<Object> _collectionSnapshot = await _superCollectionQuery(
            collRef: _subCollectionRef,
            orderBy: orderBy,
            limit: limit,
            startAfter: startAfter,
            finders: finders,
          );

          final List<QueryDocumentSnapshot<Object>> _queryDocumentSnapshots = _collectionSnapshot.docs;

          _maps =Mapper.getMapsFromQueryDocumentSnapshotsList(
              queryDocumentSnapshots: _queryDocumentSnapshots,
              addDocsIDs: addDocsIDs,
              addDocSnapshotToEachMap: addDocSnapshotToEachMap
          );

        }
    );

    return _maps;
  }
// ----------------------------
  /// TESTED : WORKS PERFECT
  static Future<dynamic> readSubDoc({
    @required BuildContext context,
    @required String collName,
    @required String docName,
    @required String subCollName,
    @required String subDocName,
    bool addDocSnapshot = false,
    bool addDocID = false,
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

          _map = await _getMapByDocRef(
            docRef: _subDocRef,
            addDocID: addDocID,
            addDocSnapshot: addDocSnapshot,
          );

        });

    return _map;
  }
// -----------------------------------------------------------------------------

  /// STREAMING

// ----------------------------
  /// TESTED : WORKS PERFECT
  static Stream<QuerySnapshot<Object>> streamCollection({
    @required String collName,
    QueryOrderBy orderBy,
    int limit,
    QueryDocumentSnapshot<Object> startAfter,
    List<FireFinder> finders,
  }) {

    final CollectionReference<Object> _collRef = getCollectionRef(collName);

    final Query<Map<String, dynamic>> _query = _superQuery(
      collRef: _collRef,
      orderBy: orderBy,
      startAfter: startAfter,
      limit: limit,
      finders: finders,
    );

    final Stream<QuerySnapshot<Object>> _snapshots = _query.snapshots();

    return _snapshots;
  }
// ----------------------------
  /// TESTED : WORKS PERFECT
  static Stream<QuerySnapshot<Object>> streamSubCollection({
    @required String collName,
    @required String docName,
    @required String subCollName,
    QueryOrderBy orderBy,
    QueryDocumentSnapshot<Object> startAfter,
    int limit,
    List<FireFinder> finders,
  }) {

    final CollectionReference<Object> _collRef = getSubCollectionRef(
      collName: collName,
      docName: docName,
      subCollName: subCollName,
    );

    final Query<Map<String, dynamic>> _query = _superQuery(
      collRef: _collRef,
      orderBy: orderBy,
      startAfter: startAfter,
      limit: limit,
      finders: finders,
    );

    final Stream<QuerySnapshot<Object>> _snapshots = _query.snapshots();

    return _snapshots;
  }
// ----------------------------
  static Stream<DocumentSnapshot<Object>> streamDoc({
    @required String collName,
    @required String docName,
  }) {

    final DocumentReference<Object> _docRef = getDocRef(
      collName: collName,
      docName: docName,
    );

    final Stream<DocumentSnapshot<Object>> _snapshots = _docRef.snapshots();

    return _snapshots;
  }
// ----------------------------
  static Stream<DocumentSnapshot<Object>> streamSubDoc({
    @required String collName,
    @required String docName,
    @required String subCollName,
    @required String subDocName,
  }) {

    final DocumentReference<Object> _docRef = getSubDocRef(
      collName: collName,
      docName: docName,
      subCollName: subCollName,
      subDocName: subDocName,
    );

    final Stream<DocumentSnapshot<Object>> _snapshots = _docRef.snapshots();

    return _snapshots;
  }
// ----------------------------

  /// UPDATE

// ----------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateDoc({
    @required BuildContext context,
    @required String collName,
    @required String docName,
    @required Map<String, dynamic> input,
  }) async {

    /// this creates a new doc that overrides existing doc,, same as createNamedDoc method

    await createNamedDoc(
      context: context,
      collName: collName,
      docName: docName,
      input: input,
    );

    /// or another syntax
    /// await tryAndCatch(
    ///     context: context,
    ///     functions: () async {
    ///
    ///       DocumentReference<Object> _docRef = getDocRef(collName, docName);
    ///       await _docRef.set(input);
    ///
    ///     }
    /// );
  }
// ----------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateDocField({
    @required BuildContext context,
    @required String collName,
    @required String docName,
    @required String field,
    @required dynamic input,
  }) async {

    final DocumentReference<Object> _doc = getDocRef(
      collName: collName,
      docName: docName,
    );

    await tryAndCatch(
        context: context,
        methodName: 'updateDocField',
        functions: () async {

          await _doc.update(<String, dynamic>{field: input});
          blog('Updated doc : $docName : field : [$field] : to : ${input.toString()}');

        });
  }
// ----------------------------
  static Future<void> updateSubDoc({
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
// ----------------------------
  /// this updates a field if exists, if absent it creates a new field and inserts the value
  static Future<void> updateSubDocField({
    @required BuildContext context,
    @required String collName,
    @required String docName,
    @required String subCollName,
    @required String subDocName,
    @required String field,
    @required dynamic input
  }) async {

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
        }
    );

  }
// -----------------------------------------------------------------------------

  /// DELETE

// ----------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteDoc({
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

          blog('deleteDoc : deleted : $collName : $docName');
        });
  }
// ----------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteSubDoc({
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

          blog('deleteSubDoc : deleted : $collName : $docName : $subCollName : $subDocName');
        }
    );
  }
// ----------------------------
  /// TASK : THIS SHOULD BE A CLOUD FUNCTION INSTEAD OF THIS BULLSHIT
  static Future<void> deleteAllCollectionDocs({
    @required BuildContext context,
    @required String collName,
  }) async {

    /// TASK : deleting collection and all its docs, sub collections & sub docs require a cloud function
    //
    /// for now : this method loops 1000 times in a collection,
    /// each time reads 5 docs, and deletes them one by one,
    /// then keeps repeating until it can not read any more documents
    /// to break the loop and end

    final bool _canContinue = await CenterDialog.showCenterDialog(
      context: context,
      title: 'DANGER',
      body: 'you will delete all documents in [ $collName ] collection\n Confirm delete ?',
      boolDialog: true,
      confirmButtonText: 'YES DELETE ALL',
    );

    if (_canContinue == true){

      for (int i = 0; i < 1000; i++){

        final List<Map<String, dynamic>> _maps = await readCollectionDocs(
          context: context,
          collName: collName,
          limit: 5,
          addDocsIDs: true,
        );

        if (_maps.isEmpty){
          break;
        }

        else {

          final List<String> _docIDs = Mapper.getMapsPrimaryKeysValues(
            maps: _maps,
            // primaryKey: 'id',
          );

          blog('docs IDs : ${_docIDs.toString()}');

          await _deleteCollectionDocsByIDs(
            context: context,
            collName: collName,
            docsIDs: _docIDs,
          );

        }

      }

    }

  }
// ----------------------------
  /// TASK : THIS SHOULD BE A CLOUD FUNCTION INSTEAD OF THIS BULLSHIT
  static Future<void> _deleteCollectionDocsByIDs({
    @required BuildContext context,
    @required collName,
    @required List<String> docsIDs,
  }) async {

    if (Mapper.checkCanLoopList(docsIDs) == true){

      for (final String id in docsIDs){

        await deleteDoc(
          context: context,
          collName: collName,
          docName: id,
        );

      }

    }

  }
// ----------------------------
  /// TASK : THIS SHOULD BE A CLOUD FUNCTION INSTEAD OF THIS BULLSHIT
  static Future<void> deleteSubCollection({
    @required BuildContext context,
    @required String collName,
    @required String docName,
    @required String subCollName,
    bool showAlertDialog = false,
  }) async {

    /// TASK : deleting sub collection and all its sub docs require a cloud function
    //
    /// does the same deletion algorithm with [deleteAllCollectionDocs]

    bool _canContinue = true;

    if (showAlertDialog == true){
      _canContinue =  await CenterDialog.showCenterDialog(
        context: context,
        title: 'DANGER',
        body: 'you will delete all documents in [ $collName / $docName / $subCollName ] collection\n Confirm delete ?',
        boolDialog: true,
        confirmButtonText: 'YES DELETE ALL',
      );
    }

    if (_canContinue == true){

      for (int i = 0; i < 1000; i++){

        final List<Map<String, dynamic>> _maps = await readSubCollectionDocs(
          context: context,
          collName: collName,
          docName: docName,
          subCollName: subCollName,
          limit: 5,
          addDocsIDs: true,
        );

        if (_maps.isEmpty){
          break;
        }

        else {

          final List<String> _docIDs = Mapper.getMapsPrimaryKeysValues(
            maps: _maps,
            // primaryKey: 'id',
          );

          blog('docs IDs : ${_docIDs.toString()}');

          await _deleteSubCollectionDocsBySubDocsIDs(
            context: context,
            collName: collName,
            docName: docName,
            subCollName: subCollName,
            subDocsIDs: _docIDs,
          );

        }

      }

    }


  }
// ----------------------------
  /// TASK : THIS SHOULD BE A CLOUD FUNCTION INSTEAD OF THIS BULLSHIT
  static Future<void> _deleteSubCollectionDocsBySubDocsIDs({
    @required BuildContext context,
    @required collName,
    @required docName,
    @required subCollName,
    @required List<String> subDocsIDs,
  }) async {

    if (Mapper.checkCanLoopList(subDocsIDs) == true){

      for (final String subDocID in subDocsIDs){

        await deleteSubDoc(
          context: context,
          collName: collName,
          docName: docName,
          subCollName: subCollName,
          subDocName: subDocID,
        );

      }

    }

  }
// ----------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteDocField({
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

    blog('delete field : $collName / $docName / { $field }');

    //     }
    // );
  }
// ----------------------------
  static Future<void> deleteSubDocField({
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
// ----------------------------

}
