part of super_fire;

class NativeFireInitializer {
  // -----------------------------------------------------------------------------

  const NativeFireInitializer();

  // -----------------------------------------------------------------------------
  ///
  static void initializeNativeFirebaseServices({
    @required String apiKey,
    @required String projectID,
  }) {

    assert(apiKey != null, 'you forgot to add apiKey');
    assert(projectID != null, 'you forgot to add projectID');

    final fd.FirebaseAuth _auth = NativeAuth.initializeNativeAuth(
        apiKey: apiKey,
    );

    NativeFire.initializeNativeFireWithAuth(
      projectID: projectID,
      firebaseAuth: _auth,
    );

  }
  // -----------------------------------------------------------------------------
}
