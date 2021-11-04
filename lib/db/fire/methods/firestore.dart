import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/models/secondary_models/error_helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class Fire{
// -----------------------------------------------------------------------------

  /// PATHS

// ---------------------------------------------------
  static String pathOfDoc({
    @required String collName,
    @required String docName,
  }){
    return '$collName/$docName';
  }
// ---------------------------------------------------
  static String pathOfSubColl({
    @required String collName,
    @required String docName,
    @required String subCollName,
  }){
    return '$collName/$docName/$subCollName';
  }
// ---------------------------------------------------
  static String pathOfSubDoc({
    @required String collName,
    @required String docName,
    @required String subCollName,
    @required String subDocName,
  }){
    return '$collName/$docName/$subCollName/$subDocName';
  }
// -----------------------------------------------------------------------------

  /// REFERENCES

// ---------------------------------------------------
  static CollectionReference getCollectionRef (String collName){
    final FirebaseFirestore _fireInstance = FirebaseFirestore.instance;
    final CollectionReference _collection = _fireInstance.collection(collName);
    return _collection;
  }
// ---------------------------------------------------
  static DocumentReference getDocRef ({
    @required String collName,
    @required String docName,
  }){
    final CollectionReference _collection = Fire.getCollectionRef(collName);
    final DocumentReference _doc =  _collection.doc(docName);

    // or this syntax
    // final DocumentReference _doc =
    // FirebaseFirestore.instance
    //     .collection(collName)
    //     .doc(docName)

    return _doc;
  }
// ---------------------------------------------------
  static CollectionReference getSubCollectionRef ({
    @required String collName,
    @required String docName,
    @required String subCollName
  }){
    final CollectionReference _subCollection = FirebaseFirestore.instance
        .collection('$collName/$docName/$subCollName');

    // or this syntax
    // final CollectionReference _subCollection =
    // FirebaseFirestore.instance
    //     .collection(collName)
    //     .doc(docName)
    //     .collection(subCollName);

    return _subCollection;
  }
// ---------------------------------------------------
  static DocumentReference getSubDocRef ({
    @required String collName,
    @required String docName,
    @required String subCollName,
    @required String subDocName,
  }){
    final CollectionReference _subCollection = FirebaseFirestore.instance
        .collection('$collName/$docName/$subCollName');
    final DocumentReference _subDocRef = _subCollection.doc(subDocName);

    // or this syntax
    // final DocumentReference _subDocRef =
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
  static Future<DocumentReference> createDoc({
    @required BuildContext context,
    @required String collName,
    bool addDocID = false,
    @required Map<String, dynamic> input,
  }) async {

    DocumentReference _docRef;

    await tryAndCatch(
        context: context,
        methodName: 'createDoc',
        functions: () async {

          final CollectionReference _bzCollectionRef = Fire.getCollectionRef(collName);

          _docRef = _bzCollectionRef.doc();

          if (addDocID == true){

            Mapper.insertPairInMap(
              map: input,
              key: 'id',
              value: _docRef.id,
            );

          }

          await _docRef.set(input);

        }
    );

    return _docRef;
  }
// ---------------------------------------------------
  static Future<DocumentReference> createNamedDoc({
    @required BuildContext context,
    @required String collName,
    @required String docName,
    @required Map<String, dynamic> input,
  }) async {

    DocumentReference _docRef;

    await tryAndCatch(
        context: context,
        methodName: 'createNamedDoc',
        functions: () async {

          final _docRef = getDocRef(
            collName: collName,
            docName: docName,
          );

          await _docRef.set(input);

          print('createNamedDoc : ${_docRef.id}');
        }
    );

    return _docRef;
  }
// ---------------------------------------------------
  /// creates firestore sub doc with auto ID
  static Future<DocumentReference> createSubDoc({
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

    final DocumentReference _subDocRef = await createNamedSubDoc(
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
  static Future<DocumentReference> createNamedSubDoc({
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

    DocumentReference _subDocRef;

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

          print('createNamedSubDoc : CREATED ${collName}/${docName}/${subCollName}/${subDocName}/');

        }
    );

    return _subDocRef;
  }
// -----------------------------------------------------------------------------

  /// READ

// ---------------------------------------------------
  static Future<dynamic> _getMapByDocRef(DocumentReference docRef) async {
    dynamic _map;

    final DocumentSnapshot snapshot = await docRef.get();

    if (snapshot.exists == true){
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
  static Future<List<dynamic>> readCollectionDocs({
    @required String collName,
    @required String orderBy,
    @required int limit,
    QueryDocumentSnapshot startAfter,
    bool addDocSnapshotToEachMap = false,
    bool addDocsIDs = false,
  }) async {

    final QueryDocumentSnapshot _startAfter = startAfter ?? null;

    QuerySnapshot _collectionSnapshot;


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

      if (addDocsIDs == true){
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
  }
// ---------------------------------------------------
  static Future<dynamic> readDoc({
    @required BuildContext context,
    @required String collName,
    @required String docName
  }) async {

    print('readDoc() : starting to read doc : firestore/$collName/$docName');
    // print('lng : ${Wordz.languageCode(context)}');

    Map<String, dynamic> _map; //QueryDocumentSnapshot

    // print('readDoc() : _map starts as : $_map');

    final dynamic _result = await tryCatchAndReturn(
      context: context,
      methodName: 'readDoc',
      functions: () async {

        final DocumentReference _docRef = Fire.getDocRef(
            collName: collName,
            docName: docName
        );
        // print('readDoc() : _docRef : $_docRef');

        _map = await _getMapByDocRef(_docRef);
        // print('readDoc() : _map : $_map');

      },
    );

    // print('readDoc() : _result : $_result');
    // print('readDoc() : _map : $_map');
    // print('lng : ${Wordz.languageCode(context)}');

    return
      _result.runtimeType == String ? null : _map;
  }
// ---------------------------------------------------
  /// TODO : delete Fire.readDocField if not used in release mode
  static Future<dynamic> readDocField({
    @required BuildContext context,
    @required String collName,
    @required String docName,
    @required String fieldName,
  }) async {

    dynamic _map;

    tryAndCatch(
        context: context,
        methodName: 'readDocField',
        functions: () async {
          _map = await Fire.readDoc(
            context: context,
            collName: collName,
            docName: docName,
          );

        }
    );

    return _map[fieldName];
  }
// ---------------------------------------------------
  static Future<dynamic> readSubCollectionDocs({
    @required BuildContext context,
    @required bool addDocsIDs,
    @required String collName,
    @required String docName,
    @required String subCollName,
    QueryDocumentSnapshot startAfter,
    @required int limit,
    @required String orderBy,
    @required bool addDocSnapshotToEachMap,
  }) async {

    /*

        final QueryDocumentSnapshot _startAfter = startAfter ?? null;

    QuerySnapshot _collectionSnapshot;


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

          final CollectionReference _subCollection = getSubCollectionRef(
            collName: collName,
            docName: docName,
            subCollName: subCollName,
          );

          QuerySnapshot _collectionSnapshot;

          final QueryDocumentSnapshot _startAfter = startAfter ?? null;

          if(_startAfter == null){
            _collectionSnapshot = await _subCollection.orderBy(orderBy).limit(limit).get();
          }

          else {
            _collectionSnapshot = await _subCollection.orderBy(orderBy).limit(limit).startAfterDocument(startAfter).get();
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
  static Future<dynamic> readSubDoc({
    @required BuildContext context,
    @required String collName,
    @required String docName,
    @required String subCollName,
    @required String subDocName
  }) async {

    dynamic _map;

    await tryAndCatch(
        context: context,
        methodName: 'readSubDoc',
        functions: () async {

          final DocumentReference _subDocRef = getSubDocRef(
            collName: collName,
            docName: docName,
            subCollName: subCollName,
            subDocName: subDocName,
          );

          _map = await _getMapByDocRef(_subDocRef);

        }
    );

    return _map;
  }
// ---------------------------------------------------
  static Stream<QuerySnapshot> streamCollection(String collectionName){
    final CollectionReference _collection = Fire.getCollectionRef(collectionName);
    final Stream<QuerySnapshot> _snapshots = _collection.snapshots();
    return _snapshots;
  }
// ---------------------------------------------------
  static Stream<QuerySnapshot> streamSubCollection({
    @required String collName,
    @required String docName,
    @required String subCollName,
    @required bool descending,
    @required String orderBy, // field name to order by
    String field,
    dynamic compareValue,
  }){

    final CollectionReference _collection = Fire.getSubCollectionRef(
      collName: collName,
      docName: docName,
      subCollName: subCollName,
    );

    Stream<QuerySnapshot> _snapshots;

    if (field != null && compareValue != null){
      _snapshots = _collection
          .orderBy(orderBy, descending: descending)
          .where('$field', isEqualTo: compareValue)
          .limit(10)
          .snapshots();
    }

    else {
      _snapshots = _collection
          .orderBy(orderBy, descending: descending)
          .snapshots();
    }


    return _snapshots;
  }
// ---------------------------------------------------
  static Stream<DocumentSnapshot> streamDoc(String collectionName, String documentName){
    final DocumentReference _document = Fire.getDocRef(
        collName: collectionName,
        docName: documentName
    );
    final Stream<DocumentSnapshot> _snapshots = _document.snapshots();
    return _snapshots;
  }
// ---------------------------------------------------
  static Stream<DocumentSnapshot> streamSubDoc({
    @required String collName,
    @required String docName,
    @required String subCollName,
    @required String subDocName,
  }){

    final DocumentReference _document = Fire.getSubDocRef(
      collName: collName,
      docName: docName,
      subCollName: subCollName,
      subDocName: subDocName,
    );

    final Stream<DocumentSnapshot> _snapshots = _document.snapshots();

    return _snapshots;
  }
// -----------------------------------------------------------------------------

  /// UPDATE

// ---------------------------------------------------
  /// this creates a new doc that overrides existing doc,, same as createNamedDoc method
  static Future<void> updateDoc({
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
    //       DocumentReference _docRef = getDocRef(collName, docName);
    //       await _docRef.set(input);
    //
    //     }
    // );

  }
// ---------------------------------------------------
  static Future<void> updateDocField({
    @required BuildContext context ,
    @required String collName,
    @required String docName,
    @required String field,
    @required dynamic input
  }) async {

    final DocumentReference _doc =  Fire.getDocRef(
        collName: collName,
        docName: docName
    );

    await tryAndCatch(
        context: context,
        methodName: 'updateDocField',
        functions: () async {

          await _doc.update({field : input});

          print('Updated doc : $docName : field : [$field] : to : ${input.toString()}');

        }
    );

  }
// ---------------------------------------------------
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
// ---------------------------------------------------
  /// this updates a field if exists, if absent it creates a new field and inserts the value
  static Future<void> updateSubDocField({
    @required BuildContext context ,
    @required String collName,
    @required String docName,
    @required String subCollName,
    @required String subDocName,
    @required String field,
    @required dynamic input
  }) async {

    final DocumentReference _subDoc =  Fire.getSubDocRef(
      collName: collName,
      docName: docName,
      subCollName: subCollName,
      subDocName: subDocName,
    );

    await tryAndCatch(
        context: context,
        methodName: 'updateSubDocField',
        functions: () async {
          await _subDoc.update({field : input});
        }
    );

  }
// -----------------------------------------------------------------------------

  /// DELETE

// ---------------------------------------------------
  static Future<void> deleteDoc({
    @required BuildContext context,
    @required String collName,
    @required String docName,
  }) async {

    await tryAndCatch(
        context: context,
        methodName: 'deleteDoc',
        functions: () async {

          final DocumentReference _doc = Fire.getDocRef(
            collName: collName,
            docName: docName,
          );

          await _doc.delete();
        }
    );

  }
// ---------------------------------------------------
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

          final DocumentReference _subDoc = Fire.getSubDocRef(
            collName: collName,
            docName: docName,
            subCollName: subCollName,
            subDocName: subDocName,
          );

          await _subDoc.delete();
        }
    );

  }
// ---------------------------------------------------
  static Future<void> deleteCollection({
    @required BuildContext context,
    @required String collName,
  }) async {

    /// TASK : deleting collection and all its docs, sub collections & sub docs require a cloud function


  }
// ---------------------------------------------------
  static Future<void> deleteSubCollection({
    @required BuildContext context,
    @required String collName,
    @required String docName,
    @required String subCollName,
  }) async {

    /// TASK : deleting sub collection and all its sub docs require a cloud function

  }
// ---------------------------------------------------
  /// ALERT : deleting all sub docs from client device is super dangerous
  static Future<void> deleteAllSubDocs({
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
  static Future<void> deleteDocField({
    @required BuildContext context,
    @required String collName,
    @required String docName,
    @required String field,
  }) async {

    final DocumentReference _docRef = Fire.getDocRef(
      collName: collName,
      docName: docName,
    );

    // await tryAndCatch(
    //     context: context,
    //     methodName: 'deleteSubDocField',
    //     functions: () async {

    // Remove field from the document
    final Map<String, Object> updates = new Map();

    updates.addAll({
      field : FieldValue.delete(),
    });

    await _docRef.update(updates);

    //     }
    // );

  }
// ---------------------------------------------------
  static Future<void> deleteSubDocField({
    @required BuildContext context,
    @required String collName,
    @required String docName,
    @required String field,
    @required String subCollName,
    @required String subDocName,
  }) async {

    final DocumentReference _docRef = Fire.getSubDocRef(
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
          final Map<String, Object> updates = new Map();

          updates.addAll({
            field : FieldValue.delete(),
          });

          await _docRef.update(updates);

        }
    );

  }
// -----------------------------------------------------------------------------
}
