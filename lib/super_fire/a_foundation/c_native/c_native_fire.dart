part of super_fire;

class NativeFire {
  // -----------------------------------------------------------------------------

  const NativeFire();

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
      return NativeFirebase.getFire().collection(coll);
    }
    else if (doc != null && subColl != null){
      /// return NativeFirebase.getFire().collection('$coll/$doc/$subColl');
      return NativeFirebase.getFire().collection(coll)
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













  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> readCollDocs({
    @required String collName,
  }) async {
    final List<Map<String, dynamic>> _output = [];

    if (collName != null){

      final fd.CollectionReference _collRef = _getCollRef(coll: collName);
      final fd.Page<fd.Document> _page = await _collRef?.get(
        // pageSize: ,
        // nextPageToken: ,
      );

      if (_page != null && _page.isNotEmpty == true){

        for (final fd.Document _doc in _page){
          _output.add(_doc.map);
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>> redDoc({
    @required String collName,
    @required String docName,
  }) async {
    Map<String, dynamic> _output;

    if (collName != null && docName != null){

      final fd.DocumentReference _docRef = _getDocRef(
        coll: collName,
        doc: docName,
      );

      final fd.Document _document = await _docRef.get();
      _output = _document?.map;
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  ///
  static Future<void> update() async {}
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  ///
  static Future<void> delete() async {}
  // -----------------------------------------------------------------------------
}
