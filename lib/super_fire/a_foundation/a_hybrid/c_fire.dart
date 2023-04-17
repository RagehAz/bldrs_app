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
}
