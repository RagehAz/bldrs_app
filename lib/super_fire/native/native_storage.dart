part of super_fire;

class NativeStorage {
  // -----------------------------------------------------------------------------

  /// NativeStorage SINGLETON

  // --------------------
  NativeStorage.singleton();
  static final NativeStorage _singleton = NativeStorage.singleton();
  static NativeStorage get instance => _singleton;
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// FirebaseStorage SINGLETON
  f_d.FirebaseStorage _storage;
  f_d.FirebaseStorage get storage => _storage;
  // --------------------
  ///
  Future<f_d.FirebaseStorage> _initialize({
    @required String appID,
    @required String apiKey,
    @required String projectID,
    @required String authDomain,
    @required String messagingSenderId,
    @required String persistentStoragePath,
    @required String databaseURL,
    @required String measurementId,
    @required String storageBucket,
  }) async {

      f_d.FirebaseDart.setup(storagePath: persistentStoragePath);

    final f_d.FirebaseApp app = await f_d.Firebase.initializeApp(
      options: f_d.FirebaseOptions(
        appId: appID,
        apiKey: apiKey,
        projectId: projectID,
        messagingSenderId: messagingSenderId,
        authDomain: authDomain, //'my_project.firebaseapp.com'
        databaseURL: databaseURL,
        measurementId: measurementId,
        storageBucket: storageBucket,
        // appGroupId: ,
        // androidClientId: ,
        // deepLinkURLScheme: ,
        // iosBundleId: ,
        // iosClientId: ,
        // trackingId: ,
      ),

    );

    final f_d.FirebaseStorage storage = f_d.FirebaseStorage.instanceFor(
      app: app,
      // bucket: ,
    );

    _storage = storage;

    blog('=> Native Firebase Storage has been initialized');

    return storage;
  }
  // --------------------
  ///
  static Future<f_d.FirebaseStorage> initializeNativeStorage({
    @required String appID,
    @required String apiKey,
    @required String projectID,
    @required String authDomain,
    @required String messagingSenderId,
    @required String persistentStoragePath,
    @required String databaseURL,
    @required String measurementId,
    @required String storageBucket,
  }) async {
    final f_d.FirebaseStorage _storage = await NativeStorage.instance._initialize(
      appID: appID,
      apiKey: apiKey,
      projectID: projectID,
      authDomain: authDomain,
      messagingSenderId: messagingSenderId,
      persistentStoragePath: persistentStoragePath,
      storageBucket: storageBucket,
      databaseURL: databaseURL,
      measurementId: measurementId,
    );

    return _storage;
  }
  // --------------------
  ///
  static f_d.FirebaseStorage getFirebaseStorage() => NativeStorage.instance.storage;
  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  ///
  static Future<void> create() async {}
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List> readPath({
    @required String picPath,
  }) async {
    Uint8List _output;

    if (picPath != null) {
      await tryAndCatch(
        functions: () async {
          _output = await getFirebaseStorage().ref(picPath).getData();
        },
      );
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
