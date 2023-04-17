part of super_fire;

class Fire {
  // -----------------------------------------------------------------------------

  const Fire();

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
    bool addDocID = false,
  }) async {
    String _id;

    /// OFFICIAL
    if (FirebaseInitializer.isUsingOfficialPackages() == true) {
      _id = await OfficialFire.createDoc(
        input: input,
        coll: coll,
        subColl: subColl,
        subDoc: subDoc,
        addDocID: addDocID,
        doc: doc,
      );
    }

    /// NATIVE
    else {
      _id = await NativeFire.createDoc(
        input: input,
        coll: coll,
        subColl: subColl,
        subDoc: subDoc,
        addDocID: addDocID,
        doc: doc,
      );
    }

    return _id;
  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TASK : TEST ME
  static Future<List<Map<String, dynamic>>> readColl({
    @required FireQueryModel queryModel,
    cloud.QueryDocumentSnapshot<Object> startAfter,
    bool addDocSnapshotToEachMap = false,
    bool addDocsIDs = false,
  }) async {

    List<Map<String, dynamic>> _output;

    /// OFFICIAL
    if (FirebaseInitializer.isUsingOfficialPackages() == true) {
      _output = await OfficialFire.readColl(
        queryModel: queryModel,
        startAfter: startAfter,
        addDocSnapshotToEachMap: addDocSnapshotToEachMap,
        addDocsIDs: addDocsIDs,
      );
    }

    /// NATIVE
    else {
      _output = await NativeFire.readColl(
        queryModel: queryModel,
        startAfter: startAfter,
        addDocsIDs: addDocsIDs,
      );
    }

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<List<Map<String, dynamic>>> readAllColl({
    @required String coll,
    @required String doc,
    String subColl,
    String subDoc,
    bool addDocsIDs = false,
  }) async {
    List<Map<String, dynamic>> _output;

    if (FirebaseInitializer.isUsingOfficialPackages() == true) {
      _output = await OfficialFire.readAllColl(
        coll: coll,
        doc: doc,
        subColl: subColl,
        subDoc: subDoc,
        addDocsIDs: addDocsIDs,
      );
    }

    else {
      _output = await NativeFire.readAllColl(
        coll: coll,
        doc: doc,
        subColl: subColl,
        subDoc: subDoc,
        addDocsIDs: addDocsIDs,
      );
    }

    return _output;
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

    /// OFFICIAL
    if (FirebaseInitializer.isUsingOfficialPackages() == true) {
      _output = await OfficialFire.readDoc(
        coll: coll,
        subColl: subColl,
        subDoc: subDoc,
        addDocID: addDocID,
        doc: doc,
      );
    }

    /// NATIVE
    else {
      _output = await NativeFire.readDoc(
        coll: coll,
        subColl: subColl,
        subDoc: subDoc,
        addDocID: addDocID,
        doc: doc,
      );
    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
