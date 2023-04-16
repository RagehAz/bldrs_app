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
  ///
  static Future<void> create() async {}
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
