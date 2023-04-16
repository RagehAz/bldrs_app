part of super_fire;

///
class NativeAuthing{
  // -----------------------------------------------------------------------------

  const NativeAuthing();

  // -----------------------------------------------------------------------------

  /// USER ID

  // --------------------
  /// TESTED : WORKS PERFECT
  static String getUserID(){
    final fd.FirebaseAuth _auth = NativeFirebase.getAuth();
    if (_auth?.isSignedIn == true){
      return _auth?.userId;
    }
    else {
      return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// ANONYMOUS AUTH

  // --------------------
  /// TASK : TEST ME
  static Future<AuthModel> anonymousSignin({
    Function(String error) onError,
  }) async {
    AuthModel _output;

    await tryAndCatch(
      invoker: 'NativeAuthing.anonymousSignin',
      onError: onError,
      functions: () async {

        final fd_u.User _user =  await NativeFirebase.getAuth()
            .signInAnonymously();

        _output = AuthModel.getAuthModelFromFiredartUser(
          user: _user,
        );

      },
    );

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// SIGN OUT

  // --------------------
  /// TASK : TEST ME
  static Future<bool> signOut({
    Function(String error) onError,
  }) async {

    final bool _success = await tryCatchAndReturnBool(
      invoker: 'NativeAuthing.signOut',
      onError: onError,
      functions: () async {

        /// FIREBASE SIGN OUT
        NativeFirebase.getAuth().signOut();

      },
    );

    return _success;
  }
  // -----------------------------------------------------------------------------

  /// DELETE USER

  // --------------------
  /// TASK : TEST ME
  static Future<bool> deleteUser({
    Function(String error) onError,
  }) async {

    final bool _success = await tryCatchAndReturnBool(
        invoker: 'NativeAuthing.deleteFirebaseUser',
        functions: () => NativeFirebase.getAuth().deleteAccount(),
        onError: onError,
    );

    return _success;

  }
  // -----------------------------------------------------------------------------

  /// SIGN IN METHOD

  // --------------------
  /// TASK : TEST ME
  static bool userIsSignedIn() {
    return _getUser() != null;
  }
  // --------------------
  /// TASK : TEST ME
  static SignInMethod getCurrentSignInMethod(){

    if (userIsSignedIn() == true){
      return SignInMethod.nativeEmail;
    }
    else {
      return null;
    }

  }
  // -----------------------------------------------------------------------------

  /// USER

  // --------------------
  /// TASK : TEST ME
  static Future<fd_u.User> _getUser() async {
    final fd_u.User _user = await NativeFirebase.getAuth()?.getUser();
    return _user;
  }
  // -----------------------------------------------------------------------------
}

class NativeEmailAuthing {
  // -----------------------------------------------------------------------------

  const NativeEmailAuthing();

  // -----------------------------------------------------------------------------

  /// SIGN IN

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AuthModel> signIn({
    @required String email,
    @required String password,
    Function(String error) onError,
  }) async {
    AuthModel _output;

    if (email != null && password != null) {
      await tryAndCatch(
        invoker: 'NativeAuth.signInByEmail',
        onError: onError,
        functions: () async {

          final fd_u.User _user = await NativeFirebase.getAuth().signIn(
              email,
              password,
          );

          _output = AuthModel.getAuthModelFromFiredartUser(
            user: _user,
          );
        },
      );
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// REGISTER

  // --------------------
  /// TASK : TEST ME
  static Future<AuthModel> register({
    @required String email,
    @required String password,
    Function(String error) onError,
  }) async {
    AuthModel _output;

    if (
        TextCheck.isEmpty(email) == false
        &&
        TextCheck.isEmpty(password) == false
    ) {

      await tryAndCatch(
          invoker: 'NativeAuth.registerByEmail',
          functions: () async {

          final fd_u.User _user = await NativeFirebase.getAuth().signUp(
              email,
              password,
          );

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

  /// CHECKERS

  // --------------------
  /// TASK : TEST ME
  static Future<bool> checkPasswordIsCorrect({
    @required String password,
    @required String email,
  }) async {

   final AuthModel _authModel = await signIn(
      email: email,
      password: password,
    );

    return _authModel != null;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE EMAIL

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> updateUserEmail({
    @required String newEmail,
  }) async {
    blog('NativeAuth.updateUserEmail : updating user email is not supported');
    return false;
  }
  // -----------------------------------------------------------------------------
}
