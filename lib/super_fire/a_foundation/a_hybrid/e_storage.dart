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
      _url = await OfficialStorage.uploadBytesAndGetURL(
          bytes: bytes,
          path: path,
          picMetaModel: picMetaModel
      );
    }

    else {

      _url = await NativeStorage.uploadBytesAndGetURL(
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
      _url = await OfficialStorage.uploadFileAndGetURL(
          file: file,
          coll: coll,
          doc: doc,
          picMetaModel: picMetaModel
      );
    }

    else {
      _url = await NativeStorage.uploadFileAndGetURL(
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
      _url = await OfficialStorage.createURLByPath(path);
    }

    else {
      _url = await NativeStorage.createURLByPath(path);
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
      _url = await OfficialStorage.createURLByNodes(
          coll: coll,
          doc: doc,
      );
    }

    else {
      _url = await NativeStorage.createURLByNodes(
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
      _output = await OfficialStorage.readBytesByPath(
          path: path,
      );
    }

    else {
      _output = await NativeStorage.readBytesByPath(
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
      _output = await OfficialStorage.readBytesByURL(url);
    }

    else {
      _output = await NativeStorage.readBytesByURL(url);
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
      _output = await OfficialStorage.readFileByURL(
        url: url,
      );
    }

    else {
      _output = await NativeStorage.readFileByURL(
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
      _output = await OfficialStorage.readFileByNodes(
          coll: coll,
          doc: doc,
      );
    }

    else {
      _output = await NativeStorage.readFileByNodes(
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
      _output = await OfficialStorage.readMetaByPath(
          path: path,
      );
    }

    else {
      _output = await NativeStorage.readMetaByPath(
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
      _output = await OfficialStorage.readMetaByURL(
          url: url,
      );
    }

    else {
      _output = await NativeStorage.readMetaByURL(
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
      await OfficialStorage.updateMetaByURL(
        picURL: picURL,
        metaDataMap: metaDataMap,
      );
    }

    else {
      await NativeStorage.updateMetaByURL(
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
      await OfficialStorage.deleteDoc(
        path: path,
        currentUserID: currentUserID,
      );
    }

    else {
      await NativeStorage.deleteDoc(
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
      await OfficialStorage.deleteDocs(
        paths: paths,
        currentUserID: currentUserID,
      );
    }

    else {
      await NativeStorage.deleteDocs(
        paths: paths,
        currentUserID: currentUserID,
      );
    }

  }
  // -----------------------------------------------------------------------------
}
