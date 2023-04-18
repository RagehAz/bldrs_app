part of super_fire;

class _NativeFire {
  // -----------------------------------------------------------------------------

  const _NativeFire();

  // -----------------------------------------------------------------------------

  /// REFERENCE

  // --------------------
  /// TASK : TEST ME
  static fd.CollectionReference _getCollRef({
    @required String coll,
    String doc,
    String subColl,
  }) {

    assert(coll != null, 'coll can not be null');
    assert(
    (doc == null && subColl == null) || (doc != null && subColl != null),
    'doc & subColl should both be null or both have values'
    );

   if (doc == null || subColl == null){
      return _NativeFirebase.getFire().collection(coll);
    }
    else if (doc != null && subColl != null){
      /// return NativeFirebase.getFire().collection('$coll/$doc/$subColl');
      return _NativeFirebase.getFire().collection(coll)
          .document(doc)
          .collection(subColl);
    }
    else {
      return null;
    }

  }
  // --------------------
  /// TASK : TEST ME
  static fd.DocumentReference _getDocRef({
    @required String coll,
    @required String doc,
    String subColl,
    String subDoc,
  }){

    assert(coll != null, 'coll can not be null');
    assert(doc != null, 'doc can not be null');

    assert((subColl == null && subDoc == null) || (subColl != null && subDoc != null),
    'doc & subColl should both be null or both have values'
    );

    if (subColl == null || subDoc == null){
      /// return NativeFirebase.getFire().document('$coll/$doc');
      return _getCollRef(coll: coll).document(doc);
    }
    else if (subColl != null && subDoc != null){
      /// return NativeFirebase.getFire().document('$coll/$doc/$subColl/$subDoc');
      return _getCollRef(coll: coll)
          .document(doc)
          .collection(subColl)
          .document(subDoc);
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

      final fd.DocumentReference _docRef = _getDocRef(
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
        invoker: 'NativeFire.createDoc',
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
    @required fd.DocumentReference ref,
    @required Map<String, dynamic> input,
    @required String invoker,
    Function onSuccess,
    Function(String error) onError,
  }) async {

    final Map<String, dynamic> _upload = Mapper.cleanNullPairs(
      map: input,
    );

    if (_upload != null) {

      await tryAndCatch(
        invoker: invoker,
        onError: onError,
        functions: () async {
          await ref.set(_upload);

          if (onSuccess != null) {
            onSuccess();
          }

          blog('$invoker.setData : CREATED ${_upload.keys.length} keys in : ${ref.path}');
        },
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TASK : TEST ME
  static Future<List<Map<String, dynamic>>> readColl({
    @required FireQueryModel queryModel,
    dynamic startAfter,
    bool addDocsIDs = false,
  }) async {
    List<Map<String, dynamic>> _output = <Map<String, dynamic>>[];

    await tryAndCatch(
        invoker: 'NativeFire.readColl',
        functions: () async {

          final fd.QueryReference query = _createCollQuery(
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

          final fd.Page<fd.Document> _page = await query.get();

          _output = NativeFireMapper.getMapsFromNativePage(
            page: _page,
            addDocsIDs: addDocsIDs,
          );

        });

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> readAllColl({
    @required String coll,
    String doc,
    String subColl,
    bool addDocsIDs = false,
  }) async {

    List<Map<String, dynamic>> _output = [];

    await tryAndCatch(
      invoker: 'NativeFire.readAllColl',
      functions: () async {

        final fd.CollectionReference _collRef = _getCollRef(
          coll: coll,
          doc: doc,
          subColl: subColl,
        );

        if (_collRef != null) {
          final fd.Page<fd.Document> _page = await _collRef?.get(
              // pageSize: ,
              // nextPageToken: ,
              );

          _output = NativeFireMapper.getMapsFromNativePage(
            page: _page,
            addDocsIDs: addDocsIDs,
          );

        }
      },

    );

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static fd.QueryReference _createCollQuery({
    @required fd.CollectionReference collRef,
    QueryOrderBy orderBy,
    int limit,
    dynamic startAfter,
    List<FireFinder> finders,
  }){

    fd.QueryReference query = _NativeFirebase
        .getFire()
        .collection(collRef.path)
        .where(null);//, isNull: true);

    /// ASSIGN SEARCH FINDERS
    if (Mapper.checkCanLoopList(finders) == true){
      query = FireFinder.createNativeCompositeQueryByFinders(
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
      assert(startAfter  == null, 'Native Fire Implementation does not support startAfter');
      // query = query.startAfterDocument(startAfter);
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
    bool addDocID = false,
  }) async {
    Map<String, dynamic> _output;

    await tryAndCatch(
        invoker: 'NativeFire.readDoc',
        functions: () async {

          final fd.DocumentReference _docRef = _getDocRef(
            coll: coll,
            doc: doc,
            subColl: subColl,
            subDoc: subDoc,
          );

          final fd.Document _document = await _docRef.get();
          _output = _document?.map;

          if (addDocID == true) {
            _output['id'] = _document.id;
          }

        });

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// STREAMING

  // --------------------
  /// TASK : TEST ME
  static Stream<List<Map<String, dynamic>>> streamColl({
    @required FireQueryModel queryModel,
  }) {

    final fd.CollectionReference _collRef = _getCollRef(
      coll: queryModel.coll,
      doc: queryModel.doc,
      subColl: queryModel.subColl,
    );

    return _collRef?.stream?.map(NativeFireMapper.mapDocs);
  }
  // --------------------
  /// TASK : TEST ME
  static Stream<Map<String, dynamic>> streamDoc({
    @required String coll,
    @required String doc,
    String subColl,
    String subDoc,
  }) {

    final fd.DocumentReference _docRef = _getDocRef(
      coll: coll,
      doc: doc,
      subColl: subColl,
      subDoc: subDoc,
    );

    return _docRef?.stream?.map(NativeFireMapper.mapDoc);

  }
  // -----------------------------------------------------------------------------

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

      final fd.DocumentReference _docRef = _getDocRef(
        coll: coll,
        doc: doc,
        subColl: subColl,
        subDoc: subDoc,
      );

      await _updateData(
        ref: _docRef,
        invoker: 'NativeFire.updateDocField',
        input: <String, dynamic>{field: input},
      );

    }

  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> _updateData({
    @required fd.DocumentReference ref,
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
        invoker: 'NativeFire.deleteDoc',
        functions: () async {

          final fd.DocumentReference _docRef = _getDocRef(
            coll: coll,
            doc: doc,
            subColl: subColl,
            subDoc: subDoc,
          );

          await _docRef.delete();

          blog('deleteDoc : deleted : $coll : $doc : $subColl : $subDoc');
        });
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

    final fd.DocumentReference _docRef = _getDocRef(
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
      invoker: 'NativeFire.deleteDocField',
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

          Stringer.blogStrings(strings: _docIDs, invoker: 'NativeFire.deleteColl : _docIDs ');

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
