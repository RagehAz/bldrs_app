part of super_fire;

class Storage {
  // -----------------------------------------------------------------------------

  const Storage();

  // -----------------------------------------------------------------------------

  /// CREATE DOC

  // --------------------
  /// TASK : TEST ME
  static Future<String> uploadBytesAndGetURL({
    @required Uint8List bytes,
    @required String path,
    @required StorageMetaModel picMetaModel,
  }) async {

    String _url;

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      _url = await _OfficialStorage.uploadBytesAndGetURL(
          bytes: bytes,
          path: path,
          picMetaModel: picMetaModel
      );
    }

    else {

      _url = await _NativeStorage.uploadBytesAndGetURL(
          bytes: bytes,
          path: path,
          picMetaModel: picMetaModel
      );

    }

    return _url;
  }
  // --------------------
  /// TASK : TEST ME
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
  /// TASK : TEST ME
  static Future<String> createURLByPath(String path) async {
    String _url;

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      _url = await _OfficialStorage.createURLByPath(path);
    }

    else {
      _url = await _NativeStorage.createURLByPath(path);
    }

    return _url;
  }
  // --------------------
  /// TASK : TEST ME
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
  /// TASK : TEST ME
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
  /// TASK : TEST ME
  static Future<Uint8List> readBytesByURL(String url) async {
    Uint8List _output;

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      _output = await _OfficialStorage.readBytesByURL(url);
    }

    else {
      _output = await _NativeStorage.readBytesByURL(url);
    }

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
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
  /// TASK : TEST ME
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
  /// TASK : TEST ME
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
  /// TASK : TEST ME
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
  /// TASK : TEST ME
  static Future<void> updateMetaByURL({
    @required String picURL,
    Map<String, String> metaDataMap,
  }) async {

    if (FirebaseInitializer.isUsingOfficialPackages() == true) {
      await _OfficialStorage.updateMetaByURL(
        picURL: picURL,
        metaDataMap: metaDataMap,
      );
    }

    else {
      await _NativeStorage.updateMetaByURL(
        picURL: picURL,
        metaDataMap: metaDataMap,
      );
    }

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TASK : TEST ME
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
  /// TASK : TEST ME
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
