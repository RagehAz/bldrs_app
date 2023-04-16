part of super_fire;

class NativeFirebaseInitializer {
  // -----------------------------------------------------------------------------

  const NativeFirebaseInitializer();

  // -----------------------------------------------------------------------------
  ///
  static Future<void> initialize({
    @required FirebaseOptions options,
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
    final fd.FirebaseAuth _auth = await NativeAuthing.initializeNativeAuth(
        apiKey: options.apiKey,
    );

    /// FIRE
    await NativeFire.initializeNativeFireWithAuth(
      projectID: options.projectId,
      firebaseAuth: _auth,
    );

    /// STORAGE
    await NativeStorage.initializeNativeStorage(
      options: options,
      persistentStoragePath: persistentStoragePath,
    );

  }
  // -----------------------------------------------------------------------------
}
