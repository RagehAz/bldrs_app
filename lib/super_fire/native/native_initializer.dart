part of super_fire;

class NativeFireInitializer {
  // -----------------------------------------------------------------------------

  const NativeFireInitializer();

  // -----------------------------------------------------------------------------
  ///
  static Future<void> initializeNativeFirebaseServices({
    @required String apiKey,
    @required String projectID,
    @required String appID,
    @required String authDomain,
    @required String messagingSenderId,
    @required String databaseURL,
    @required String measurementId,
    @required String storageBucket,
    String persistentStoragePath,
  }) async {

    assert(apiKey != null, 'you forgot to add apiKey');
    assert(projectID != null, 'you forgot to add projectID');

    /// AUTH
    final fd.FirebaseAuth _auth = await NativeAuth.initializeNativeAuth(
        apiKey: apiKey,
    );

    /// FIRE
    await NativeFire.initializeNativeFireWithAuth(
      projectID: projectID,
      firebaseAuth: _auth,
    );

    /// STORAGE
    await NativeStorage.initializeNativeStorage(
      apiKey: apiKey,
      appID: appID,
      projectID: projectID,
      authDomain: authDomain,
      persistentStoragePath: persistentStoragePath,
      messagingSenderId: messagingSenderId,
      storageBucket: storageBucket,
      databaseURL: databaseURL,
      measurementId: measurementId,
    );

  }
  // -----------------------------------------------------------------------------
}
