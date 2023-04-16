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
    @required FirebaseOptions options,
    @required String persistentStoragePath,
  }) async {

      f_d.FirebaseDart.setup(storagePath: persistentStoragePath);

    final f_d.FirebaseApp app = await f_d.Firebase.initializeApp(
      options: f_d.FirebaseOptions(
        appId: options.appId,
        apiKey: options.apiKey,
        projectId: options.projectId,
        messagingSenderId: options.messagingSenderId,
        authDomain: options.authDomain, //'my_project.firebaseapp.com'
        databaseURL: options.databaseURL,
        measurementId: options.measurementId,
        storageBucket: options.storageBucket,
        appGroupId: options.appGroupId,
        androidClientId: options.androidClientId,
        deepLinkURLScheme: options.deepLinkURLScheme,
        iosBundleId: options.iosBundleId,
        iosClientId: options.iosClientId,
        trackingId: options.trackingId,
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
    @required FirebaseOptions options,
    @required String persistentStoragePath,
  }) async {

    final f_d.FirebaseStorage _storage = await NativeStorage.instance._initialize(
      options: options,
      persistentStoragePath: persistentStoragePath,
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
