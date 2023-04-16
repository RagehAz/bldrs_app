part of super_fire;

class NativeFire {
  // -----------------------------------------------------------------------------

  const NativeFire();

  // -----------------------------------------------------------------------------

  /// REFERENCE

  // --------------------
  /// TESTED : WORKS PERFECT
  static fd.CollectionReference getCollRef({
    @required String collName,
  }) {
    if (collName == null){
      return null;
    }
    else {
      return NativeFirebase.getFire().collection(collName);
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static fd.DocumentReference getDocRef({
    @required String collName,
    @required String docName,
  }){

    if (collName == null || docName == null){
      return null;
    }
    else {
      return getCollRef(collName: collName).document(docName);
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

      final fd.CollectionReference _collRef = getCollRef(collName: collName);
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

      final fd.DocumentReference _docRef = getDocRef(
        collName: collName,
        docName: docName,
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
