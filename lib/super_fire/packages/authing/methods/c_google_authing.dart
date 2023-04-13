part of super_fire;

/*

FOR WEB INTEGRATION

- add the following line to ./web/index.html

<meta name="google-signin-client_id" content="YOUR_GOOGLE_SIGN_IN_OAUTH_CLIENT_ID.apps.googleusercontent.com">


 */

/// => TAMAM
class GoogleAuthing {
  // --------------------
  GoogleAuthing.singleton();
  static final GoogleAuthing _singleton = GoogleAuthing.singleton();
  static GoogleAuthing get instance => _singleton;
  // -----------------------------------------------------------------------------

  /// GOOGLE SIGN IN SINGLETON

  // --------------------
  GoogleSignIn _googleSignIn;
  GoogleSignIn get googleSignIn => _googleSignIn ??= GoogleSignIn();
  static GoogleSignIn getGoogleSignInInstance() => GoogleAuthing.instance.googleSignIn;
  // -----------------------------------------------------------------------------

  /// GOOGLE AUTH PROVIDER SINGLETON

  // --------------------
  GoogleAuthProvider _googleAuthProvider;
  GoogleAuthProvider get googleAuthProvider => _googleAuthProvider ??=  GoogleAuthProvider();
  static GoogleAuthProvider getGoogleAuthProviderInstance() => GoogleAuthing.instance.googleAuthProvider;
  // -----------------------------------------------------------------------------

  /// SCOPED SIGN IN

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AuthClient> scopedSignIn({
    List<String> scopes,
    // String clientID,
  }) async {
    AuthClient client;

    final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: scopes,
      // clientId: clientID,
      // forceCodeForRefreshToken: ,
      // hostedDomain: ,
      // serverClientId: ,
      // signInOption: ,
    );

    await tryAndCatch(
      invoker: 'googleSignIn',
        functions: () async {

          await _googleSignIn.signIn();

          client = await _googleSignIn.authenticatedClient();

        },
    );

    return client;
  }
  // -----------------------------------------------------------------------------

  /// EMAIL SIGN IN

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AuthModel> emailSignIn({
    Function(String error) onError,
  }) async {
    AuthModel _output;

    await getGoogleSignInInstance().signOut();

    if (kIsWeb == true) {
      _output = await _webGoogleAuth(onError: onError,);
    }

    else {
      _output = await _appGoogleAuth(onError: onError,);
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AuthModel> _webGoogleAuth({
    Function(String error) onError,
  }) async {
    AuthModel _output;

    await tryAndCatch(
      invoker: 'webGoogleAuth',
        onError: onError,
        functions: () async {

        /// get [auth provider]
        final GoogleAuthProvider _googleAuthProvider = getGoogleAuthProviderInstance();

        final FirebaseAuth _firebaseAuth = Authing.getFirebaseAuth();

        /// get [user credential] from [auth provider]
        final UserCredential _userCredential = await _firebaseAuth.signInWithPopup(_googleAuthProvider);

        _output = AuthModel.getAuthModelFromUserCredential(
          cred: _userCredential,
        );

      },
    );

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AuthModel> _appGoogleAuth({
    Function(String error) onError,
  }) async {
    AuthModel _output;

    await tryAndCatch(
      invoker: '_appGoogleAuth',
      onError: onError,
      functions: () async {

        /// get [google sign in account]
        final GoogleSignInAccount _googleSignInAccount = await getGoogleSignInInstance().signIn();

        if (_googleSignInAccount != null) {

              /// get [google sign in auth] from [google sign in account]
              final GoogleSignInAuthentication _googleSignInAuthentication = await
              _googleSignInAccount.authentication;

              /// get [auth credential] from [google sign in auth]
              final AuthCredential _authCredential = GoogleAuthProvider.credential(
                accessToken: _googleSignInAuthentication.accessToken,
                idToken: _googleSignInAuthentication.idToken,
              );

              final FirebaseAuth _firebaseAuth = Authing.getFirebaseAuth();

              /// C - get [user credential] from [auth credential]
              final UserCredential _userCredential = await _firebaseAuth.signInWithCredential(_authCredential);

              _output = AuthModel.getAuthModelFromUserCredential(
                cred: _userCredential,
                addData: _createGoogleAuthDataMap(
                  googleSignInAuthentication: _googleSignInAuthentication,
                  authCredential: _authCredential,
                ),
              );

            }

      },
    );

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> _createGoogleAuthDataMap({
    GoogleSignInAuthentication googleSignInAuthentication,
    AuthCredential authCredential,
  }){

    final Map<String, dynamic> _map = {
      'googleSignInAuthentication.accessToken': googleSignInAuthentication?.accessToken,
      'googleSignInAuthentication.idToken': googleSignInAuthentication?.idToken,
      'authCredential.signInMethod' : authCredential?.signInMethod,
      'authCredential.providerId' : authCredential?.providerId,
      'authCredential.accessToken' : authCredential?.accessToken,
      'authCredential.token' : authCredential?.token,
    };

    return Mapper.cleanNullPairs(map: _map);
  }
  // -----------------------------------------------------------------------------
}
