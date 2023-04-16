part of super_fire;

class NativeAuthing{
  // -----------------------------------------------------------------------------

  const NativeAuthing();

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

        final fd_u.User _user =  await NativeFirebase.getFirebaseAuth()
            .signInAnonymously();

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

          final fd_u.User _user = await NativeFirebase.getFirebaseAuth().signIn(email,
              password);

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
    final fd.FirebaseAuth _auth = NativeFirebase.getFirebaseAuth();
    if (_auth?.isSignedIn == true){
      return _auth?.userId;
    }
    else {
      return null;
    }
  }
  // -----------------------------------------------------------------------------
}
