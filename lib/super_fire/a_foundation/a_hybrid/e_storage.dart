part of super_fire;

/// => TAMAM9
class Storage {
  // -----------------------------------------------------------------------------

  const Storage();

  // -----------------------------------------------------------------------------

  /// CREATE DOC

  // --------------------
  /// TESTED: WORKS PERFECT
  static Future<String> uploadBytesAndGetURL({
    @required Uint8List bytes,
    @required String path,
    @required StorageMetaModel storageMetaModel,
  }) async {

    String _url;

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      _url = await _OfficialStorage.uploadBytesAndGetURL(
          bytes: bytes,
          path: path,
          storageMetaModel: storageMetaModel
      );
    }

    else {

      _url = await _NativeStorage.uploadBytesAndGetURL(
          bytes: bytes,
          path: path,
          storageMetaModel: storageMetaModel
      );

    }

    return _url;
  }
  // --------------------
  /// TESTED: WORKS PERFECT
  static Future<String> uploadFileAndGetURL({
    @required File file,
    @required String coll,
    @required String doc,
    @required StorageMetaModel picMetaModel,
  }) async {
    String _url;

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      _url = await _OfficialStorage.uploadFileAndGetURL(
          file: file,
          coll: coll,
          doc: doc,
          picMetaModel: picMetaModel
      );
    }

    else {
      _url = await _NativeStorage.uploadFileAndGetURL(
          file: file,
          coll: coll,
          doc: doc,
          picMetaModel: picMetaModel
      );
    }

    return _url;
  }
  // -----------------------------------------------------------------------------

  /// CREATE URL

  // --------------------
  /// TESTED: WORKS PERFECT
  static Future<String> createURLByPath({
    @required String path,
  }) async {
    String _url;

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      _url = await _OfficialStorage.createURLByPath(
        path: path,
      );
    }

    else {
      _url = await _NativeStorage.createURLByPath(
        path: path,
      );
    }

    return _url;
  }
  // --------------------
  /// TESTED: WORKS PERFECT
  static Future<String> createURLByNodes({
    @required String coll,
    @required String doc, // without extension
  }) async {
    String _url;

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      _url = await _OfficialStorage.createURLByNodes(
          coll: coll,
          doc: doc,
      );
    }

    else {
      _url = await _NativeStorage.createURLByNodes(
          coll: coll,
          doc: doc,
      );
    }

    return _url;
  }
  // -----------------------------------------------------------------------------

  /// READ DOC

  // --------------------
  /// TESTED: WORKS PERFECT
  static Future<Uint8List> readBytesByPath({
    @required String path,
  }) async {
    Uint8List _output;

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      _output = await _OfficialStorage.readBytesByPath(
          path: path,
      );
    }

    else {
      _output = await _NativeStorage.readBytesByPath(
          path: path,
      );
    }

    return _output;
  }
  // --------------------
  /// TESTED: WORKS PERFECT
  static Future<Uint8List> readBytesByURL({
    @required String url,
  }) async {
    Uint8List _output;

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      _output = await _OfficialStorage.readBytesByURL(
        url: url,
      );
    }

    else {
      _output = await _NativeStorage.readBytesByURL(
        url: url,
      );
    }

    return _output;
  }
  // --------------------
  /// TESTED: WORKS PERFECT
  static Future<File> readFileByURL({
    @required String url,
  }) async {
    File _output;

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      _output = await _OfficialStorage.readFileByURL(
        url: url,
      );
    }

    else {
      _output = await _NativeStorage.readFileByURL(
        url: url,
      );
    }

    return _output;
  }
  // --------------------
  /// TESTED: WORKS PERFECT
  static Future<File> readFileByNodes({
    @required String coll,
    @required String doc,
  }) async {
    File _output;

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      _output = await _OfficialStorage.readFileByNodes(
          coll: coll,
          doc: doc,
      );
    }

    else {
      _output = await _NativeStorage.readFileByNodes(
          coll: coll,
          doc: doc,
      );
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// READ META DATA

  // --------------------
  /// TESTED: WORKS PERFECT
  static Future<StorageMetaModel> readMetaByPath({
    @required String path,
  }) async {
    StorageMetaModel _output;

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      _output = await _OfficialStorage.readMetaByPath(
          path: path,
      );
    }

    else {
      _output = await _NativeStorage.readMetaByPath(
          path: path,
      );
    }

    return _output;
  }
  // --------------------
  /// TESTED: WORKS PERFECT
  static Future<StorageMetaModel> readMetaByURL({
    @required String url,
  }) async {
    StorageMetaModel _output;

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      _output = await _OfficialStorage.readMetaByURL(
          url: url,
      );
    }

    else {
      _output = await _NativeStorage.readMetaByURL(
          url: url,
      );
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE META

  // --------------------
  /// TESTED: WORKS PERFECT
  static Future<void> updateMetaByURL({
    @required String url,
    @required StorageMetaModel meta,
  }) async {

    if (FirebaseInitializer.isUsingOfficialPackages() == true) {
      await _OfficialStorage.updateMetaByURL(
        url: url,
        meta: meta,
      );
    }

    else {
      await _NativeStorage.updateMetaByURL(
        url: url,
        meta: meta,
      );
    }

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED: WORKS PERFECT
  static Future<void> deleteDoc({
    @required String path,
    @required String currentUserID,
  }) async {

    if (FirebaseInitializer.isUsingOfficialPackages() == true) {
      await _OfficialStorage.deleteDoc(
        path: path,
        currentUserID: currentUserID,
      );
    }

    else {
      await _NativeStorage.deleteDoc(
        path: path,
        currentUserID: currentUserID,
      );
    }

  }
  // --------------------
  /// TESTED: WORKS PERFECT
  static Future<void> deleteDocs({
    @required List<String> paths,
    @required String currentUserID,
  }) async {

    if (FirebaseInitializer.isUsingOfficialPackages() == true) {
      await _OfficialStorage.deleteDocs(
        paths: paths,
        currentUserID: currentUserID,
      );
    }

    else {
      await _NativeStorage.deleteDocs(
        paths: paths,
        currentUserID: currentUserID,
      );
    }

  }
  // -----------------------------------------------------------------------------
}
