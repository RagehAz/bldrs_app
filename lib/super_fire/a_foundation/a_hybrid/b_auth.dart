part of super_fire;

class Authing {
  // -----------------------------------------------------------------------------

  const Authing();

  // -----------------------------------------------------------------------------
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
}
