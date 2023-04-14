part of super_fire;

class NativeFire {
  // -----------------------------------------------------------------------------
  /// https://www.youtube.com/watch?v=Tw7L2NkhwPc&t=185s
  // -----------------------------------------------------------------------------

  /// NativeAuth SINGLETON

  // --------------------
  NativeFire.singleton();
  static final NativeFire _singleton = NativeFire.singleton();
  static NativeFire get instance => _singleton;
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// FIREBASE AUTH SINGLETON
  fd.Firestore _firestore;
  fd.Firestore get firestore => _firestore;
  // --------------------
  /// TESTED : WORKS PERFECT
  fd.Firestore _initialize({
    @required fd.FirebaseAuth firebaseAuth,
    @required String projectID,
  }) {
    fd.Firestore _store;

    assert(projectID != null, 'you forgot to add project ID');

    if (firebaseAuth == null) {
      _store = fd.Firestore.initialize(
        projectID,
        // databaseId: ,
        // emulator: ,
      );
    }

    else {
      _store = fd.Firestore(
        projectID,
        auth: firebaseAuth,
        // databaseId: ,
        // emulator: ,
      );
    }

    _firestore = _store;
    blog('=> Native Firebase Firestore has been initialized');

    return _store;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static fd.Firestore initializeNativeFireWithAuth({
    @required fd.FirebaseAuth firebaseAuth,
    @required String projectID,
  }){
    return NativeFire.instance._initialize(
      firebaseAuth: firebaseAuth,
      projectID: projectID,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> initializeNativeFireWithoutAuth({
    @required String projectID,
  }) async {

    return NativeFire.instance._initialize(
      firebaseAuth: null,
      projectID: projectID,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static fd.Firestore getFirestore() => NativeFire.instance.firestore;
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
      return getFirestore().collection(collName);
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
