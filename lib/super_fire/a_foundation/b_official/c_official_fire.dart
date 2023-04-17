part of super_fire;

/// => TAMAM
class OfficialFire{
  // -----------------------------------------------------------------------------

  const OfficialFire();

  // -----------------------------------------------------------------------------

  /// REFERENCES

  // --------------------
  /// TASK : TEST ME
  static cloud.CollectionReference<Object> _getCollRef({
    @required String coll,
    String doc,
    String subColl,
  }) {

    /// GET FIREBASE CLOUD FIRESTORE COLLECTION REFERENCE

    assert(coll != null, 'coll can not be null');
    assert(
    (doc == null && subColl == null) || (doc != null && subColl != null),
    'doc & subColl should both be null or both have values'
    );


   if (doc == null || subColl == null){
      return OfficialFirebase.getFire().collection(coll);
    }
    else if (doc != null && subColl != null){
      /// return OfficialFirebase.getFire().collection('$coll/$doc/$subColl');
      return OfficialFirebase.getFire().collection(coll)
          .doc(doc)
          .collection(subColl);
    }
    else {
      return null;
    }

  }
  // --------------------
  /// TASK : TEST ME
  static cloud.DocumentReference<Object> _getDocRef({
    @required String coll,
    @required String doc,
    String subColl,
    String subDoc,
  }) {

    /// GET FIREBASE CLOUD FIRESTORE DOCUMENT REFERENCE

    assert(coll != null, 'coll can not be null');
    assert(doc != null, 'doc can not be null');

    assert((subColl == null && subDoc == null) || (subColl != null && subDoc != null),
    'doc & subColl should both be null or both have values'
    );

    if (subColl == null || subDoc == null){
      /// return OfficialFirebase.getFire().doc('$coll/$doc');
      return _getCollRef(coll: coll).doc(doc);
    }
    else if (subColl != null && subDoc != null){
      /// return OfficialFirebase.getFire().doc('$coll/$doc/$subColl/$subDoc');
      return _getCollRef(coll: coll)
          .doc(doc)
          .collection(subColl)
          .doc(subDoc);
    }
    else {
      return null;
    }

  }
  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TASK : TEST ME
  static Future<String> createDoc({
    @required Map<String, dynamic> input,
    @required String coll,
    String doc,
    String subColl,
    String subDoc,
    /// adds doc id to the input map in 'id' field
    bool addDocID = false,
  }) async {

    /// NOTE : creates firestore doc with auto generated ID then returns doc reference

    String _docID;

    if (input != null){

      final cloud.DocumentReference<Object> _docRef = _getDocRef(
        coll: coll,
        doc: doc,
        subColl: subColl,
        subDoc: subDoc,
      );

      if (addDocID == true) {
        Mapper.insertPairInMap(
          map: input,
          key: 'id',
          value: _docRef.id,
        );
      }

      await _setData(
        invoker: 'createDoc',
        input: input,
        ref: _docRef,
        onSuccess: (){
          _docID = _docRef.id;
          },
      );

    }

    return _docID;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> _setData({
    @required cloud.DocumentReference<Object> ref,
    @required Map<String, dynamic> input,
    @required String invoker,
    Function onSuccess,
    Function(String error) onError,
  }) async {

      final Map<String, dynamic> _upload = Mapper.cleanNullPairs(
        map: input,
      );

      if (_upload != null){

        await tryAndCatch(
          invoker: invoker,
          onError: onError,
          functions: () async {

              await ref.set(_upload);

              if (onSuccess != null){
                onSuccess();
              }

              blog('$invoker.setData : CREATED ${_upload.keys.length} keys in : ${ref.path}');

            },
        );

      }

    }
  // -----------------------------------------------------------------------------

  /// READ COLL

  // --------------------
  /// TASK : TEST ME
  static Future<List<Map<String, dynamic>>> readColl({
    @required FireQueryModel queryModel,
    cloud.QueryDocumentSnapshot<Object> startAfter,
    bool addDocSnapshotToEachMap = false,
    bool addDocsIDs = false,
  }) async {

    List<Map<String, dynamic>> _maps = <Map<String,dynamic>>[];

    await tryAndCatch(
        invoker: 'superCollPaginator',
        functions: () async {

          final cloud.Query<Map<String, dynamic>> query = _createCollQuery(
            collRef: _getCollRef(
              coll: queryModel.coll,
              doc: queryModel.doc,
              subColl: queryModel.subColl,
            ),
            orderBy: queryModel.orderBy,
            limit: queryModel.limit,
            startAfter: startAfter,
            finders: queryModel.finders,
          );

          final cloud.QuerySnapshot<Object> _collectionSnapshot = await query.get();

          final List<cloud.QueryDocumentSnapshot<Object>> _queryDocumentSnapshots = _collectionSnapshot.docs;

          _maps = Mapper.getMapsFromQueryDocumentSnapshotsList(
              queryDocumentSnapshots: _queryDocumentSnapshots,
              addDocsIDs: addDocsIDs,
              addDocSnapshotToEachMap: addDocSnapshotToEachMap
          );

        });

    return _maps;
  }
  // --------------------
  /// TASK : TEST ME
  static cloud.Query<Map<String, dynamic>> _createCollQuery({
    @required cloud.CollectionReference<Object> collRef,
    QueryOrderBy orderBy,
    int limit,
    cloud.QueryDocumentSnapshot<Object> startAfter,
    List<FireFinder> finders,
  }){

    cloud.Query<Map<String, dynamic>> query = OfficialFirebase.getFire().collection(collRef.path);

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
  // --------------------
  /// TASK : TEST ME
  static Future<Map<String, dynamic>> readDoc({
    @required String coll,
    @required String doc,
    String subColl,
    String subDoc,
    bool addDocSnapshot = false,
    bool addDocID = false,
  }) async {

    Map<String, dynamic> _output;

    await tryAndCatch(
        invoker: 'readSubDoc',
        functions: () async {

          final cloud.DocumentReference<Object> _docRef = _getDocRef(
            coll: coll,
            doc: doc,
            subColl: subColl,
            subDoc: subDoc,
          );

          final cloud.DocumentSnapshot<Object> snapshot = await _docRef.get();

          if (snapshot.exists == true) {
            _output = Mapper.getMapFromDocumentSnapshot(
              docSnapshot: snapshot,
              addDocSnapshot: addDocSnapshot,
              addDocID: addDocID,
            );
          }

        });

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// STREAMING

  // --------------------
  /// TASK : TEST ME
  static Stream<cloud.QuerySnapshot<Object>> streamColl({
    @required FireQueryModel queryModel,
    cloud.QueryDocumentSnapshot<Object> startAfter,
  }) {

    final cloud.Query<Map<String, dynamic>> _query = _createCollQuery(
      collRef: _getCollRef(
        coll: queryModel.coll,
        doc: queryModel.doc,
        subColl: queryModel.subColl,
      ),
      orderBy: queryModel.orderBy,
      startAfter: startAfter,
      limit: queryModel.limit,
      finders: queryModel.finders,
    );

    return _query.snapshots();
  }
  // --------------------
  /// TASK : TEST ME
  static Stream<cloud.DocumentSnapshot<Object>> streamDoc({
    @required String coll,
    @required String doc,
    String subColl,
    String subDoc,
  }) {

    final cloud.DocumentReference<Object> _docRef = _getDocRef(
      coll: coll,
      doc: doc,
      subColl: subColl,
      subDoc: subDoc,
    );

    return _docRef.snapshots();
  }
  // --------------------

  /// UPDATE

  // --------------------
  /// TASK : TEST ME
  static Future<void> updateDoc({
    @required Map<String, dynamic> input,
    @required String coll,
    @required String doc,
    String subColl,
    String subDoc,
  }) async {

    await createDoc(
      coll: coll,
      doc: doc,
      subColl: subColl,
      subDoc: subDoc,
      input: input,
    );

  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> updateDocField({
    @required dynamic input,
    @required String field,
    @required String coll,
    @required String doc,
    String subColl,
    String subDoc,
  }) async {

    // NOTES
    /// this updates a field if exists,
    /// if absent it creates a new field and inserts the value

    if (input != null){

      final cloud.DocumentReference<Object> _docRef = _getDocRef(
        coll: coll,
        doc: doc,
        subColl: subColl,
        subDoc: subDoc,
      );

      await _updateData(
        ref: _docRef,
        invoker: 'updateSubDocField',
        input: <String, dynamic>{field: input},
      );

    }

  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> _updateData({
    @required cloud.DocumentReference<Object> ref,
    @required Map<String, dynamic> input,
    @required String invoker,
    Function onSuccess,
  }) async {

      final Map<String, dynamic> _upload = Mapper.cleanNullPairs(
        map: input,
      );

      if (_upload != null){

        await tryAndCatch(
          invoker: invoker,
          functions: () async {

            // final SetOptions options = SetOptions(
            //   merge: true,
            //   mergeFields: <Object>[],
            // );

            await ref.update(_upload);

            if (onSuccess != null){
              onSuccess();
            }

            blog('$invoker.updateData : UPDATED ${_upload.keys.length} keys in : ${ref.path}');

          },
          // onError: (){},
        );




      }

    }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TASK : TEST ME
  static Future<void> deleteDoc({
    @required String coll,
    @required String doc,
    String subColl,
    String subDoc,
  }) async {

    await tryAndCatch(
        invoker: 'deleteSubDoc',
        functions: () async {

          final cloud.DocumentReference<Object> _subDoc = _getDocRef(
            coll: coll,
            doc: doc,
            subColl: subColl,
            subDoc: subDoc,
          );

          await _subDoc.delete();

          blog('deleteSubDoc : deleted : $coll : $doc : $subColl : $subDoc');
        }
    );
  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> deleteDocField({
    @required String coll,
    @required String doc,
    @required String field,
    String subColl,
    String subDoc,
  }) async {

    final cloud.DocumentReference<Object> _docRef = _getDocRef(
      coll: coll,
      doc: doc,
      subColl: subColl,
      subDoc: subDoc,
    );

    // Remove field from the document
    final Map<String, Object> updates = <String, Object>{};

    updates.addAll(<String, dynamic>{
      field: cloud.FieldValue.delete(),
    });

    await _updateData(
      ref: _docRef,
      invoker: 'deleteSubDocField',
      input: updates,
    );

  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> deleteColl({
    @required BuildContext context,
    @required String coll,
    String doc,
    String subColl,
    Function onDeleteDoc,
    int numberOfIterations = 1000,
    int numberOfReadsPerIteration = 5,
  }) async {

    /// PLAN : THIS SHOULD BE A CLOUD FUNCTION INSTEAD OF THIS BULLSHIT
    /// does the same deletion algorithm with [deleteAllCollectionDocs]

    for (int i = 0; i < numberOfIterations; i++){

        final List<Map<String, dynamic>> _maps = await readColl(
          queryModel: FireQueryModel(
            coll: coll,
            doc: doc,
            subColl: subColl,
            limit: numberOfReadsPerIteration,
          ),
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

          Stringer.blogStrings(strings: _docIDs, invoker: 'deleteColl : _docIDs ');

          await deleteDocs(
            coll: coll,
            doc: doc,
            subColl: subColl,
            docsIDs: _docIDs,
            onDeleteDoc: onDeleteDoc,
          );

        }

      }

  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> deleteDocs({
    @required String coll,
    @required List<String> docsIDs,
    String doc,
    String subColl,
    Function(String subDocID) onDeleteDoc
  }) async {

    /// PLAN : THIS SHOULD BE A CLOUD FUNCTION INSTEAD OF THIS BULLSHIT

    if (Mapper.checkCanLoopList(docsIDs) == true){

      final bool _isDeletingSubDocs = subColl != null && doc != null;

      for (final String docID in docsIDs){

        await Future.wait(<Future>[

          deleteDoc(
            coll: coll,
            doc: _isDeletingSubDocs == true ? doc : docID,
            subColl: subColl,
            subDoc: _isDeletingSubDocs == true ? docID : null,
          ),


          if (onDeleteDoc != null)
            onDeleteDoc(docID),

        ]);

      }

    }

  }
  // -----------------------------------------------------------------------------
}

  /// OLD METHODS
  /*
String pathOfDoc({
  @required String collName,
  @required String docName,
}) {
  return '$collName/$docName';
}
  // --------------------
String pathOfSubColl({
  @required String collName,
  @required String docName,
  @required String subCollName,
}) {
  return '$collName/$docName/$subCollName';
}
  // --------------------
String pathOfSubDoc({
  @required String collName,
  @required String docName,
  @required String subCollName,
  @required String subDocName,
}) {
  return '$collName/$docName/$subCollName/$subDocName';
}
  // --------------------
  /// TESTED : WORKS PERFECT
  static cloud.CollectionReference<Object> getCollectionRef(String collName) {
    return OfficialFirebase.getFire().collection(collName);
  }

    /// TESTED : WORKS PERFECT
  static Future<cloud.DocumentReference<Object>> createDoc({
    @required String collName,
    @required Map<String, dynamic> input,
    ValueChanged<cloud.DocumentReference> onFinish,
    bool addDocID = false,
  }) async {

    /// NOTE : creates firestore doc with auto generated ID then returns doc reference

    cloud.DocumentReference<Object> _output;

    if (input != null){

      final cloud.CollectionReference<Object> _bzCollectionRef = _getCollRef(
        coll: collName,
      );
      final cloud.DocumentReference<Object> _docRef = _bzCollectionRef.doc();

      if (addDocID == true) {
        Mapper.insertPairInMap(
          map: input,
          key: 'id',
          value: _docRef.id,
        );
      }

      await _setData(
          input: input,
          ref: _docRef,
          invoker: 'createDoc',
          onSuccess: (){
            _output = _docRef;
          }
      );

    }

    if (onFinish != null){
      onFinish(_output);
    }
    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<cloud.DocumentReference<Object>> createNamedDoc({
    @required String coll,
    @required String doc,
    @required Map<String, dynamic> input,
  }) async {
    cloud.DocumentReference<Object> _output;

    if (input != null){

      final cloud.DocumentReference<Object> _docRef = _getDocRef(
        coll: coll,
        doc: doc,
      );

      await _setData(
          input: input,
          ref: _docRef,
          invoker: 'createNamedDoc',
          onSuccess: (){
            _output = _docRef;
          }
      );

    }

    return _output;
  }

    // --------------------
  /// TESTED : WORKS PERFECT
  static Future<cloud.DocumentReference<Object>> createNamedDoc({
    @required Map<String, dynamic> input,
    @required String coll,
    String doc,
    String subColl,
    String subDoc,
  }) async {

    /// creates a new sub doc and new sub collection if didn't exists
    /// and uses the same directory if existed to add a new doc
    /// updates the sub doc if existed
    /// and creates random name for sub doc if sub doc name is null

    cloud.DocumentReference<Object> _output;

    if (input != null){

      final cloud.DocumentReference<Object> _ref = _getDocRef(
        coll: coll,
        doc: doc,
        subColl: subColl,
        subDoc: subDoc,
      );

      await _setData(
          input: input,
          ref: _ref,
          invoker: 'createNamedSubDoc',
          onSuccess: (){
            _output = _ref;
          }
      );

    }

    return _output;
  }

    /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> readCollectionDocs({
    @required String coll,
    QueryOrderBy orderBy,
    int limit,
    cloud.QueryDocumentSnapshot<Object> startAfter,
    bool addDocSnapshotToEachMap = false,
    bool addDocsIDs = false,
    List<FireFinder> finders,
  }) async {

    List<Map<String, dynamic>> _maps = <Map<String,dynamic>>[];

    await tryAndCatch(
        invoker: 'readCollectionDocs',
        functions: () async {

          final cloud.CollectionReference<Object> _collRef = _getCollRef(
            coll: coll,
          );

          final cloud.QuerySnapshot<Object> _collectionSnapshot = await _superCollectionQuery(
            collRef: _collRef,
            orderBy: orderBy,
            limit: limit,
            startAfter: startAfter,
            finders: finders,
          );

          final List<cloud.QueryDocumentSnapshot<Object>> _queryDocumentSnapshots = _collectionSnapshot.docs;

          _maps = Mapper.getMapsFromQueryDocumentSnapshotsList(
              queryDocumentSnapshots: _queryDocumentSnapshots,
              addDocsIDs: addDocsIDs,
              addDocSnapshotToEachMap: addDocSnapshotToEachMap
          );

        });

    return _maps;
  }
  \
  ----------
    // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> readSubCollectionDocs({
    @required String coll,
    @required String doc,
    @required String subColl,
    int limit,
    QueryOrderBy orderBy,
    cloud.QueryDocumentSnapshot<Object> startAfter,
    bool addDocsIDs = false,
    bool addDocSnapshotToEachMap = false,
    List<FireFinder> finders,
  }) async {

    List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

    await tryAndCatch(
        invoker: 'readSubCollectionDocs',
        functions: () async {

          final cloud.CollectionReference<Object> _subCollectionRef = _getCollRef(
            coll: coll,
            doc: doc,
            subColl: subColl,
          );

          final cloud.QuerySnapshot<Object> _collectionSnapshot = await _superCollectionQuery(
            collRef: _subCollectionRef,
            orderBy: orderBy,
            limit: limit,
            startAfter: startAfter,
            finders: finders,
          );

          final List<cloud.QueryDocumentSnapshot<Object>> _queryDocumentSnapshots = _collectionSnapshot.docs;

          _maps = Mapper.getMapsFromQueryDocumentSnapshotsList(
              queryDocumentSnapshots: _queryDocumentSnapshots,
              addDocsIDs: addDocsIDs,
              addDocSnapshotToEachMap: addDocSnapshotToEachMap
          );

        }
    );

    return _maps;
  }
-------------------------------

     /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>> readDoc({
    @required String collName,
    @required String docName,
    bool addDocID = false,
    bool addDocSnapshot = false,
  }) async {


    Map<String, dynamic> _map; //QueryDocumentSnapshot

    final dynamic _result = await tryCatchAndReturnBool(
      invoker: 'readDoc',
      functions: () async {

        final cloud.DocumentReference<Object> _docRef = _getDocRef(
          coll: collName,
          doc: docName,
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

    // final String _found = _map == null ? 'NOT FOUND' : 'FOUND';
    // blog('readDoc() : reading doc : firestore/$collName/$docName : $_found');

    return _result.runtimeType == String ? null : _map;
  }

  // --------------------
  /// TESTED : WORKS PERFECT
  static Stream<cloud.QuerySnapshot<Object>> streamSubCollection({
    @required String coll,
    @required String doc,
    @required String subColl,
    QueryOrderBy orderBy,
    cloud.QueryDocumentSnapshot<Object> startAfter,
    int limit,
    List<FireFinder> finders,
  }) {

    final cloud.CollectionReference<Object> _collRef = _getCollRef(
      coll: coll,
      doc: doc,
      subColl: subColl,
    );

    final cloud.Query<Map<String, dynamic>> _query = _superQuery(
      collRef: _collRef,
      orderBy: orderBy,
      startAfter: startAfter,
      limit: limit,
      finders: finders,
    );

    return _query.snapshots();
  }


  // --------------------
  /// TESTED : WORKS PERFECT
  static Stream<cloud.DocumentSnapshot<Object>> streamDoc({
    @required String collName,
    @required String docName,
  }) {

    final cloud.DocumentReference<Object> _docRef = _getDocRef(
      coll: collName,
      doc: docName,
    );

    return _docRef.snapshots();
  }
-------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateDoc({
    @required String coll,
    @required String doc,
    @required Map<String, dynamic> input,
  }) async {

    // NOTES
    /// this creates a new doc that overrides existing doc,, same as createNamedDoc method
    /// or another syntax
    /// --------------------
    /// await tryAndCatch(
    ///     context: context,
    ///     functions: () async {
    ///
    ///       cloudFire.DocumentReference<Object> _docRef = getDocRef(collName, docName);
    ///       await _docRef.set(input);
    ///
    ///     }
    /// );
    /// --------------------
    ///

    await createDoc(
      coll: coll,
      doc: doc,
      input: input,
    );


  }
  --------------------------
    /// TESTED : WORKS PERFECT
  static Future<void> updateDocField({
    @required String coll,
    @required String doc,
    @required String field,
    @required dynamic input,
  }) async {

    if (input != null){

      final cloud.DocumentReference<Object> _ref = _getDocRef(
        coll: coll,
        doc: doc,
      );

      await _updateData(
        ref: _ref,
        invoker: 'updateDocField',
        input: <String, dynamic>{field: input},
      );

    }

  }
---------------------
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteDoc({
    @required String coll,
    @required String doc,
  }) async {

    await tryAndCatch(
        invoker: 'deleteDoc',
        functions: () async {

          final cloud.DocumentReference<Object> _doc = _getDocRef(
            coll: coll,
            doc: doc,
          );

          await _doc.delete();

          blog('deleteDoc : deleted : $coll : $doc');
        });
  }
   -------------------------
     /// TESTED : WORKS PERFECT
  static Future<void> deleteDocField({
    @required String coll,
    @required String doc,
    @required String field,
  }) async {

    final cloud.DocumentReference<Object> _docRef = _getDocRef(
      coll: coll,
      doc: doc,
    );

    final Map<String, Object> updates = <String, Object>{};

    updates.addAll(<String, dynamic>{
      field: cloud.FieldValue.delete(),
    });

    await _updateData(
      ref: _docRef,
      invoker: 'deleteDocField',
      input: updates,
    );

  }
   -------------------------
     // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteCollDocsByIterations({
    @required BuildContext context,
    @required String coll,
    @required int numberOfIterations, // was 1000
    @required int numberOfReadsPerIteration, // was 5
  }) async {

      for (int i = 0; i < numberOfIterations; i++){

        final List<Map<String, dynamic>> _maps = await readColl(
          queryModel: FireQueryModel(
            coll: coll,
            limit: numberOfReadsPerIteration,
          ),
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

          blog('docs IDs : $_docIDs');

          await _deleteCollectionDocsByIDs(
            coll: coll,
            docsIDs: _docIDs,
          );

        }

      }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _deleteCollectionDocsByIDs({
    @required coll,
    @required List<String> docsIDs,
  }) async {

    /// PLAN : THIS SHOULD BE A CLOUD FUNCTION INSTEAD OF THIS BULLSHIT


    if (Mapper.checkCanLoopList(docsIDs) == true){

      for (final String id in docsIDs){

        await deleteDoc(
          coll: coll,
          doc: id,
        );

      }

    }

  }
   */
