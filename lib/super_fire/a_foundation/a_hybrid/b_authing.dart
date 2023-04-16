part of super_fire;

///
class Authing {
  // -----------------------------------------------------------------------------

  const Authing();

  // -----------------------------------------------------------------------------

  /// USER ID

  // --------------------
  /// TASK : TEST ME
  static String getUserID() {

    if (FirebaseInitializer.isUsingOfficialPackages() == true) {
      return OfficialAuthing.getUserID();
    }

    else {
      return NativeAuthing.getUserID();
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

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      _output = await OfficialAuthing.anonymousSignin(
        onError: onError,
      );
    }
    else {
      _output = await NativeAuthing.anonymousSignin(
        onError: onError,
      );
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// SIGN OUT

  // --------------------
  /// TASK : TEST ME
  static Future<bool> signOut({
    Function(String error) onError,
  }) async {
    bool _success;

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      _success = await OfficialAuthing.signOut(
        onError: onError,
      );
    }

    else {
      _success = await NativeAuthing.signOut(
        onError: onError,
      );
    }

    return _success;
  }
  // -----------------------------------------------------------------------------

  /// DELETE USER

  // --------------------
  /// TASK : TEST ME
  static Future<bool> deleteUser({
    @required String userID,
    Function(String error) onError,
  }) async {
    bool _success;

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      _success = await OfficialAuthing.deleteUser(
        onError: onError,
      );
    }

    else {
      _success = await NativeAuthing.deleteUser(
        onError: onError,
      );
    }

    return _success;
  }
    // -----------------------------------------------------------------------------

  /// SIGN IN METHOD

  // --------------------
  /// TASK : TEST ME
  static bool userIsSignedIn() {

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      return OfficialAuthing.userIsSignedIn();
    }

    else {
      return NativeAuthing.userIsSignedIn();
    }

  }
  // --------------------
  /// TASK : TEST ME
  static SignInMethod getCurrentSignInMethod(){

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      return OfficialAuthing.getCurrentSignInMethod();
    }

    else {
      return NativeAuthing.getCurrentSignInMethod();
    }

  }
  // -----------------------------------------------------------------------------
}

///
class EmailAuthing {
  // -----------------------------------------------------------------------------

  const EmailAuthing();

  // -----------------------------------------------------------------------------

  /// SIGN IN

  // --------------------
  /// TASK : TEST ME
  static Future<AuthModel> signIn({
    @required String email,
    @required String password,
    Function(String error) onError,
  }) async {
    AuthModel _output;

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      _output = await OfficialEmailAuthing.signIn(
        email: email,
        password: password,
        onError: onError,
      );
    }

    else {
      _output = await NativeEmailAuthing.signIn(
        email: email,
        password: password,
        onError: onError,
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

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      _output = await OfficialEmailAuthing.register(
        email: email,
        password: password,
        onError: onError,
      );
    }

    else {
      _output = await NativeEmailAuthing.register(
        email: email,
        password: password,
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
    bool _output;

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      _output = await OfficialEmailAuthing.checkPasswordIsCorrect(
        password: password,
        email: email,
      );
    }

    else {
      _output = await NativeEmailAuthing.checkPasswordIsCorrect(
        password: password,
        email: email,
      );
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE EMAIL

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> updateUserEmail({
    @required String newEmail,
  }) async {
    bool _success = false;

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      _success = await OfficialEmailAuthing.updateUserEmail(
        newEmail: newEmail,
      );
    }

    else {
      _success = await NativeEmailAuthing.updateUserEmail(
        newEmail: newEmail,
      );
    }

    return _success;
  }
  // -----------------------------------------------------------------------------
}
