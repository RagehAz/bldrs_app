part of super_fire;

class NativeAuth{
  // -----------------------------------------------------------------------------

  /// NativeAuth SINGLETON

  // --------------------
  NativeAuth.singleton();
  static final NativeAuth _singleton = NativeAuth.singleton();
  static NativeAuth get instance => _singleton;
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// FIREBASE AUTH SINGLETON
  fd.FirebaseAuth _auth;
  fd.FirebaseAuth get auth => _auth;
  // --------------------
  /// TESTED : WORKS PERFECT
  fd.FirebaseAuth _initialize({
    @required String apiKey,
    // @required String projectID,
  }){

    final fd.FirebaseAuth firebaseAuth = fd.FirebaseAuth(
        apiKey,
        fd.VolatileStore(), // HiveStore
        );

    _auth = firebaseAuth;

    blog('=> Native Firebase Auth has been initialized');

    return firebaseAuth;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static fd.FirebaseAuth initializeNativeAuth({
    @required String apiKey,
  }){
    return NativeAuth.instance._initialize(
      apiKey: apiKey,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static fd.FirebaseAuth getFirebaseAuth() => NativeAuth.instance.auth;
  // -----------------------------------------------------------------------------

  /// SIGN IN

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AuthModel> signInByEmail({
    @required String email,
    @required String password,
    Function(String error) onError,
  }) async {
    AuthModel _output;

    if (email != null && password != null) {
      await tryAndCatch(
        invoker: 'NativeAuth.signInByEmail',
        functions: () async {
          final fd_u.User _user = await getFirebaseAuth().signIn(email, password);

          _output = AuthModel.getAuthModelFromFiredartUser(
            user: _user,
          );
        },
        onError: onError,
      );
    }

    return _output;
  }
  // -----------------------------------------------------------------------------
  ///
  static Future<void> signOut() async {}
  // -----------------------------------------------------------------------------

  /// GET ID

  // --------------------
  /// TESTED : WORKS PERFECT
  static String getUserID(){
    final fd.FirebaseAuth _auth = getFirebaseAuth();
    if (_auth?.isSignedIn == true){
      return _auth?.userId;
    }
    else {
      return null;
    }
  }
  // -----------------------------------------------------------------------------
}
