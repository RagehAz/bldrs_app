part of super_fire;
/// => TAMAM
class EmailAuthing {
  // -----------------------------------------------------------------------------

  const EmailAuthing();

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

    if (
        TextCheck.isEmpty(email) == false
        &&
        TextCheck.isEmpty(password) == false
    ) {
      await tryAndCatch(
        invoker: 'signInByEmail',
        functions: () async {

          final UserCredential _userCredential = await Authing.getFirebaseAuth()
              .signInWithEmailAndPassword(
            email: email.trim(),
            password: password,
          );

          _output = AuthModel.getAuthModelFromUserCredential(
            cred: _userCredential,
          );

        },
        onError: onError,
      );
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// REGISTER

  // --------------------
  /// TESTED : WORKS PERFECT
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
          invoker: 'registerByEmail',
          functions: () async {

            final UserCredential _userCredential = await Authing.getFirebaseAuth().createUserWithEmailAndPassword(
              email: email.trim(),
              password: password,
            );

            _output = AuthModel.getAuthModelFromUserCredential(
                cred: _userCredential,
            );

          },
          onError: onError,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// SIGN OUT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> emailSignOut({
    Function(String error) onError,
  }) async {

    await tryAndCatch(
      invoker: 'emailSignOut',
      functions: () async {
        await Authing.getFirebaseAuth()?.signOut();
      },
      onError: onError,
    );

  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
    /// TESTED : WORKS PERFECT
  static Future<bool> checkPasswordIsCorrect({
    @required String password,
    @required String email,
  }) async {

    UserCredential _credential;

    final bool _credentialsAreGood = await tryCatchAndReturnBool(
        functions: () async {

          final AuthCredential _authCredential = EmailAuthProvider.credential(
            email: email,
            password: password,
          );

          _credential = await Authing.getFirebaseAuth().currentUser?.reauthenticateWithCredential(_authCredential);

        }
    );

    if (_credentialsAreGood == true && _credential != null){
      return true;
    }
    else {
      return false;
    }

  }
  // -----------------------------------------------------------------------------

  /// UPDATE EMAIL

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> updateUserEmail({
    @required String newEmail,
  }) async {
    blog('updateUserEmail : START');

    bool _success = false;

    final FirebaseAuth _auth = Authing.getFirebaseAuth();
    final String _oldEmail = _auth?.currentUser?.email;

    blog('updateUserEmail : new : $newEmail : old : $_oldEmail');

    if (_oldEmail != newEmail){

      _success = await tryCatchAndReturnBool(
        invoker: 'updateUserEmail',
        functions: () async {
          await _auth.currentUser.updateEmail(newEmail);
          blog('updateUserEmail : END');
        },
      );

    }

    return _success;
  }
  // -----------------------------------------------------------------------------
}
