part of super_fire;

class _NativeFirebase {
  // -----------------------------------------------------------------------------

  /// NativeFirebase SINGLETON

  // --------------------
  _NativeFirebase.singleton();
  static final _NativeFirebase _singleton = _NativeFirebase.singleton();
  static _NativeFirebase get instance => _singleton;
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  ///
  static Future<void> initialize({
    @required FirebaseOptions options,
    @required String appName,
    String persistentStoragePath,
  }) async {

    assert(options.appId != null, 'options.appId is null');
    assert(options.apiKey != null, 'options.apiKey is null');
    assert(options.projectId != null, 'options.projectId is null');
    assert(options.messagingSenderId != null, 'options.messagingSenderId is null');
    assert(options.authDomain != null, 'options.authDomain is null');
    assert(options.databaseURL != null, 'options.databaseURL is null');
    assert(options.measurementId != null, 'options.measurementId is null');
    assert(options.storageBucket != null, 'options.storageBucket is null');

    /// AUTH
    final fd.FirebaseAuth _auth = await _NativeFirebase.instance._initializeAuthing(
        apiKey: options.apiKey,
    );

    /// FIRE
    _NativeFirebase.instance._initializeFire(
      projectID: options.projectId,
      firebaseAuth: _auth,
    );

    /// APP
    final f_d.FirebaseApp _app = await _NativeFirebase.instance._initializeApp(
      options: options,
      persistentStoragePath: persistentStoragePath,
      appName: appName,
    );

    /// REAL
    _NativeFirebase.instance._initializeReal(
      databaseURL: options.databaseURL,
      app: _app,
    );

    /// STORAGE
    await _NativeFirebase.instance._initializeStorage(
      app: _app,
      persistentStoragePath: persistentStoragePath,
    );

  }
  // -----------------------------------------------------------------------------

  /// APP

  // --------------------
  /// FIREBASE APP SINGLETON
  f_d.FirebaseApp _app;
  f_d.FirebaseApp get app => _app;
  /// NOT USED
  // static f_d.FirebaseApp getApp() => _NativeFirebase.instance.app;
  // --------------------
  Future<f_d.FirebaseApp> _initializeApp({
    @required String persistentStoragePath,
    @required FirebaseOptions options,
    @required String appName,
  }) async {

    f_d.FirebaseDart.setup(storagePath: persistentStoragePath);

    final f_d.FirebaseApp app = await f_d.Firebase.initializeApp(
      name: appName,
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

    _app = app;

    return app;
  }
  // -----------------------------------------------------------------------------

  /// AUTH

  // --------------------
  /// FIREBASE AUTH INSTANCE SINGLETON
  fd.FirebaseAuth _auth;
  fd.FirebaseAuth get auth => _auth;
  static fd.FirebaseAuth getAuth() => _NativeFirebase.instance.auth;
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<fd.FirebaseAuth> _initializeAuthing({
    @required String apiKey,
    // @required String projectID,
  }) async {

    final fd.FirebaseAuth firebaseAuth = fd.FirebaseAuth(
        apiKey,
        fd.VolatileStore(), // HiveStore
        );

    _auth = firebaseAuth;

    blog('=> Native Firebase Auth has been initialized');

    return firebaseAuth;
  }
  // -----------------------------------------------------------------------------

  /// FIRE

  // --------------------
  /// FIREBASE FIRESTORE INSTANCE SINGLETON
  fd.Firestore _fire;
  fd.Firestore get fire => _fire;
  static fd.Firestore getFire() => _NativeFirebase.instance.fire;
  // --------------------
  /// TESTED : WORKS PERFECT
  fd.Firestore _initializeFire({
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

    _fire = _store;
    blog('=> Native Firebase Firestore has been initialized');

    return _store;
  }
  // -----------------------------------------------------------------------------

  /// REAL

  // --------------------
  /// FIREBASE REALTIME DATABASE INSTANCE SINGLETON
  f_d.FirebaseDatabase _real;
  f_d.FirebaseDatabase get real => _real;
  static f_d.FirebaseDatabase getReal() => _NativeFirebase.instance.real;
  // --------------------
  /// TASK : TEST ME
  f_d.FirebaseDatabase _initializeReal({
    @required f_d.FirebaseApp app,
    @required String databaseURL,
  }){

    final f_d.FirebaseDatabase _db = f_d.FirebaseDatabase(
      app: app,
      databaseURL: databaseURL,
    );

    _real = _db;

    return _db;
  }
  // -----------------------------------------------------------------------------

  /// STORAGE

  // --------------------
  /// FIREBASE STORAGE INSTANCE SINGLETON
  f_d.FirebaseStorage _storage;
  f_d.FirebaseStorage get storage => _storage;
  static f_d.FirebaseStorage getStorage() => _NativeFirebase.instance.storage;
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<f_d.FirebaseStorage> _initializeStorage({
    @required f_d.FirebaseApp app,
    @required String persistentStoragePath,
  }) async {

    final f_d.FirebaseStorage storage = f_d.FirebaseStorage.instanceFor(
      app: app,
      // bucket: ,
    );

    _storage = storage;

    blog('=> Native Firebase Storage has been initialized');

    return storage;
  }
  // -----------------------------------------------------------------------------
}
