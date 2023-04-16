part of super_fire;

/// => TAMAM
class OfficialAuthing {
  // -----------------------------------------------------------------------------

  const OfficialAuthing();

  // -----------------------------------------------------------------------------

  /// CREATE ANONYMOUS AUTH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AuthModel> anonymousSignin({
    Function(String error) onError,
  }) async {
    AuthModel _output;

    await tryAndCatch(
      invoker: 'anonymousSignin',
      onError: onError,
      functions: () async {

        final f_a.UserCredential _userCredential = await OfficialFirebase
            .getFirebaseAuth()
            .signInAnonymously();

        _output = AuthModel.getAuthModelFromUserCredential(
            cred: _userCredential,
        );

      },
    );

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// SIGN OUT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> signOut({
    Function(String error) onError,
  }) async {

    final bool _success = await tryCatchAndReturnBool(
      invoker: 'Authing.signOut',
      onError: onError,
      functions: () async {
        final SignInMethod signInMethod = getCurrentSignInMethod();

        /// GOOGLE SIGN OUT
        if (signInMethod == SignInMethod.google) {
          if (kIsWeb == false) {
            final GoogleSignIn _instance = OfficialGoogleAuthing.getGoogleSignInInstance();
            await _instance.disconnect();
            await _instance.signOut();
          }
        }

        /// FACEBOOK SIGN OUT
        else if (signInMethod == SignInMethod.facebook) {
          await OfficialFacebookAuthing.getFacebookAuthInstance().logOut();
        }

        /// FIREBASE SIGN OUT
        await OfficialFirebase.getFirebaseAuth().signOut();
      },
    );

    return _success;
  }
  // -----------------------------------------------------------------------------

  /// READ AUTH

  // --------------------
  /// TESTED : WORKS PERFECT
  static f_a.User getFirebaseUser() {
    return OfficialFirebase.getFirebaseAuth()?.currentUser;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getUserID() {
    return getFirebaseUser()?.uid;
  }
  // -----------------------------------------------------------------------------

  /// DELETE FIREBASE USER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> deleteFirebaseUser({
    @required String userID,
    Function(String error) onError,
  }) async {

    blog('deleting firebase user');
    // String _error;

    final bool _success = await tryCatchAndReturnBool(
        invoker: 'deleteFirebaseUser',
        functions: () => OfficialFirebase.getFirebaseAuth().currentUser?.delete(),
        onError: onError,
    );

    return _success;

    /*
      /// delete firebase user
  // Future<void> _deleteFirebaseUser({
  //   BuildContext context,
  //   String email,
  //   String password,
  // }) async {
  //
  //   try {
  //
  //     User user = _auth.currentUser;
  //
  //     AuthCredential credentials = EmailAuthProvider.credential(email: email, password: password);
  //
  //     blog(user);
  //
  //     UserCredential result = await user.reauthenticateWithCredential(credentials);
  //
  //     await result.user.delete();
  //
  //     return true;
  //
  //   } catch (error) {
  //
  //     blog(error.toString());
  //
  //     await superDialog(
  //       context: context,
  //       title: 'Could not delete account',
  //       body: error,
  //       boolDialog: false,
  //     );
  //
  //     return null;
  //   }
  // }
  // -----------------------------------------------------------------------------
     */
  }
  // -----------------------------------------------------------------------------

  /// USER IMAGE

  // --------------------
  /// TESTED : WORKS PERFECT
  static String getUserImageURLFromUserCredential(f_a.UserCredential cred){
    String _output;

    if (cred != null){

      final SignInMethod signInMethod = OfficialAuthing.getCurrentSignInMethod();

      if (signInMethod == SignInMethod.google){
        _output = cred.user?.photoURL;
      }
      else if (signInMethod == SignInMethod.facebook){
        _output = OfficialFacebookAuthing.getUserFacebookImageURLFromUserCredential(cred);
      }
      else if (signInMethod == SignInMethod.apple){
        /// TASK : DO ME
      }
      else {
        _output = cred.user?.photoURL;
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static SignInMethod getCurrentSignInMethod(){
    return _getSignInMethodFromUser(user: OfficialAuthing.getFirebaseUser());
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static SignInMethod _getSignInMethodFromUser({
    @required f_a.User user,
  }){
    SignInMethod _output;

    if (user != null){

      final List<f_a.UserInfo> providerData = user.providerData;

      if (Mapper.checkCanLoopList(providerData) == true){
        final f_a.UserInfo _info = providerData.first;
        final String providerID = _info?.providerId;
        _output = AuthModel.decipherSignInMethod(providerID);
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool userIsSignedIn() {
    return getFirebaseUser() != null;
  }
  // --------------------

}

/// => TAMAM
class OfficialEmailAuthing {
  // -----------------------------------------------------------------------------

  const OfficialEmailAuthing();

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

          final f_a.UserCredential _userCredential = await OfficialFirebase.getFirebaseAuth()
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

            final f_a.UserCredential _userCredential = await OfficialFirebase.getFirebaseAuth().createUserWithEmailAndPassword(
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
        await OfficialFirebase.getFirebaseAuth()?.signOut();
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

    f_a.UserCredential _credential;

    final bool _credentialsAreGood = await tryCatchAndReturnBool(
        functions: () async {

          final f_a.AuthCredential _authCredential = f_a.EmailAuthProvider.credential(
            email: email,
            password: password,
          );

          _credential = await OfficialFirebase.getFirebaseAuth().currentUser?.reauthenticateWithCredential(_authCredential);

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

    final f_a.FirebaseAuth _auth = OfficialFirebase.getFirebaseAuth();
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

/// => TAMAM
class OfficialGoogleAuthing {
  // --------------------
  OfficialGoogleAuthing.singleton();
  static final OfficialGoogleAuthing _singleton = OfficialGoogleAuthing.singleton();
  static OfficialGoogleAuthing get instance => _singleton;
  // -----------------------------------------------------------------------------

  /// GOOGLE SIGN IN SINGLETON

  // --------------------
  GoogleSignIn _googleSignIn;
  GoogleSignIn get googleSignIn => _googleSignIn ??= GoogleSignIn();
  static GoogleSignIn getGoogleSignInInstance() => OfficialGoogleAuthing.instance.googleSignIn;
  // -----------------------------------------------------------------------------

  /// GOOGLE AUTH PROVIDER SINGLETON

  // --------------------
  f_a.GoogleAuthProvider _googleAuthProvider;
  f_a.GoogleAuthProvider get googleAuthProvider => _googleAuthProvider ??=  f_a.GoogleAuthProvider();
  static f_a.GoogleAuthProvider getGoogleAuthProviderInstance() => OfficialGoogleAuthing.instance.googleAuthProvider;
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
        final f_a.GoogleAuthProvider _googleAuthProvider = getGoogleAuthProviderInstance();

        final f_a.FirebaseAuth _firebaseAuth = OfficialFirebase.getFirebaseAuth();

        /// get [user credential] from [auth provider]
        final f_a.UserCredential _userCredential = await _firebaseAuth.signInWithPopup(_googleAuthProvider);

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
              final f_a.AuthCredential _authCredential = f_a.GoogleAuthProvider.credential(
                accessToken: _googleSignInAuthentication.accessToken,
                idToken: _googleSignInAuthentication.idToken,
              );

              final f_a.FirebaseAuth _firebaseAuth = OfficialFirebase.getFirebaseAuth();

              /// C - get [user credential] from [auth credential]
              final f_a.UserCredential _userCredential = await _firebaseAuth.signInWithCredential(_authCredential);

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
    f_a.AuthCredential authCredential,
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

/// => TAMAM
class OfficialFacebookAuthing {
  // --------------------
  OfficialFacebookAuthing.singleton();
  static final OfficialFacebookAuthing _singleton = OfficialFacebookAuthing.singleton();
  static OfficialFacebookAuthing get instance => _singleton;
  // -----------------------------------------------------------------------------

  /// AUDIO PLAYER SINGLETON

  // --------------------
  FacebookAuth _facebookAuth;
  FacebookAuth get facebookAuth => _facebookAuth ??= FacebookAuth.instance;
  static FacebookAuth getFacebookAuthInstance() => OfficialFacebookAuthing.instance.facebookAuth;
  // -----------------------------------------------------------------------------

  /// FACEBOOK AUTHENTICATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AuthModel> signIn({
    Function(String error) onError,
  }) async {
    AuthModel _output;

    await tryAndCatch(
      invoker: 'signInByFacebook',
      onError: onError,
      functions: () async {

        final LoginResult _loginResult = await  getFacebookAuthInstance().login(
          // loginBehavior: ,
          // permissions: ['email'],
        );

        if (_loginResult?.accessToken != null) {

          final f_a.FacebookAuthCredential _facebookAuthCredential =
          f_a.FacebookAuthProvider.credential(_loginResult.accessToken.token);

          final f_a.UserCredential _userCredential =
          await OfficialFirebase.getFirebaseAuth().signInWithCredential(_facebookAuthCredential);

          _output = AuthModel.getAuthModelFromUserCredential(
            cred: _userCredential,
            addData: _createFacebookAuthDataMap(
              facebookAuthCredential: _facebookAuthCredential,
              loginResult: _loginResult,
            ),
          );

        }

      },
    );

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> _createFacebookAuthDataMap({
    @required LoginResult loginResult,
    @required f_a.FacebookAuthCredential facebookAuthCredential,
  }) {
    final Map<String, dynamic> _map = {
      'loginResult.status.name': loginResult?.status?.name,
      'loginResult.status.index': loginResult?.status?.index,
      'loginResult.accessToken.expires':
          Timers.cipherTime(time: loginResult?.accessToken?.expires, toJSON: false),
      'loginResult.accessToken.lastRefresh':
          Timers.cipherTime(time: loginResult?.accessToken?.lastRefresh, toJSON: true),
      'loginResult.accessToken.userId': loginResult?.accessToken?.userId,
      'loginResult.accessToken.token': loginResult?.accessToken?.token,
      'loginResult.accessToken.applicationId': loginResult?.accessToken?.applicationId,
      'loginResult.accessToken.graphDomain': loginResult?.accessToken?.graphDomain,
      'loginResult.accessToken.declinedPermissions': loginResult?.accessToken?.declinedPermissions,
      'loginResult.accessToken.grantedPermissions': loginResult?.accessToken?.grantedPermissions,
      'loginResult.accessToken.isExpired': loginResult?.accessToken?.isExpired,
      'loginResult.message': loginResult?.message,
      'facebookAuthCredential.idToken': facebookAuthCredential?.idToken,
      'facebookAuthCredential.rawNonce': facebookAuthCredential?.rawNonce,
      'facebookAuthCredential.secret': facebookAuthCredential?.secret,
      'facebookAuthCredential.token': facebookAuthCredential?.token,
      'facebookAuthCredential.accessToken': facebookAuthCredential?.accessToken,
      'facebookAuthCredential.providerId': facebookAuthCredential?.providerId,
      'facebookAuthCredential.signInMethod': facebookAuthCredential?.signInMethod,
    };

    return Mapper.cleanNullPairs(map: _map);
  }
  // -----------------------------------------------------------------------------

  /// FACEBOOK USER DATA

  // --------------------
  /// TESTED : WORKS PERFECT
  static String getUserFacebookImageURLFromUserCredential(f_a.UserCredential cred){
    String _output;

    if (cred != null){

      if (cred.additionalUserInfo?.providerId == 'facebook.com'){
        final Map<String, dynamic> profileMap = cred.additionalUserInfo?.profile;
        if (profileMap != null){
          final picture = profileMap['picture'];
          if (picture != null){
            final data = picture['data'];
            if (data != null){
              _output = data['url'];
            }
          }
        }
      }


    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}

/// => TAMAM
class OfficialAppleAuthing {
  // -----------------------------------------------------------------------------

  const OfficialAppleAuthing();

  // -----------------------------------------------------------------------------

  /// APPLE AUTHENTICATION

  // --------------------
  /// WORKS ON IOS DEVICE
  static Future<AuthModel> signInByApple({
    Function(String error) onError,
  }) async {
    AuthModel _output;

    await tryAndCatch(
      invoker: 'signInByApple',
      onError: onError,
      functions: () async {

        final AuthorizationCredentialAppleID credential = await SignInWithApple.getAppleIDCredential(
          scopes: <AppleIDAuthorizationScopes>[
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          // state: ,
          // nonce: ,
          // webAuthenticationOptions: ,
        );

        // AuthBlog.blogAppleCred(credential);

        _output = AuthModel.getAuthModelFromAppleCred(
          cred: credential,
        );

      },
    );

    return _output;
  }
  // -----------------------------------------------------------------------------
}
