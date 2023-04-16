part of super_fire;

class NativeAuthing{
  // -----------------------------------------------------------------------------

  /// NativeAuth SINGLETON

  // --------------------
  NativeAuthing.singleton();
  static final NativeAuthing _singleton = NativeAuthing.singleton();
  static NativeAuthing get instance => _singleton;
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// FIREBASE AUTH SINGLETON
  fd.FirebaseAuth _auth;
  fd.FirebaseAuth get auth => _auth;
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<fd.FirebaseAuth> _initialize({
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<fd.FirebaseAuth> initializeNativeAuth({
    @required String apiKey,
  }) async {
    final fd.FirebaseAuth auth = await NativeAuthing.instance._initialize(
      apiKey: apiKey,
    );

    return auth;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static fd.FirebaseAuth getFirebaseAuth() => NativeAuthing.instance.auth;
  // -----------------------------------------------------------------------------

  /// ANONYMOUS AUTH

  // --------------------
  /// TASK : TEST ME
  static Future<AuthModel> anonymousSignin({
    Function(String error) onError,
  }) async {
    AuthModel _output;

    await tryAndCatch(
      invoker: 'anonymousSignin',
      onError: onError,
      functions: () async {

        final fd_u.User _user =  await getFirebaseAuth().signInAnonymously();

        _output = AuthModel.getAuthModelFromFiredartUser(
          user: _user,
        );

      },
    );

    return _output;
  }
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
