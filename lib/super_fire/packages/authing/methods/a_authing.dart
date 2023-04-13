part of super_fire;
/// => TAMAM
class Authing {
  // -----------------------------------------------------------------------------

  /// AuthFireOps SINGLETON

  // --------------------
  Authing.singleton();
  static final Authing _singleton = Authing.singleton();
  static Authing get instance => _singleton;
  // -----------------------------------------------------------------------------

  /// FIREBASE AUTH

  // --------------------
  /// FIREBASE AUTH SINGLETON
  FirebaseAuth _auth;
  FirebaseAuth get auth => _auth ??= FirebaseAuth.instance;
  static FirebaseAuth getFirebaseAuth() => Authing.instance.auth;
  // -----------------------------------------------------------------------------

  /// INITIALIZE SOCIAL AUTHING

  // --------------------
  /// TESTED : WORKS PERFECT
  static void initializeSocialAuthing({
    @required SocialKeys socialKeys,
  }) {

    if (socialKeys != null) {
      fireUI.FirebaseUIAuth.configureProviders([
        if (socialKeys.supportEmail == true) fireUI.EmailAuthProvider(),
        if (socialKeys.googleClientID != null)
          GoogleProvider(
            clientId: socialKeys.googleClientID,
            // redirectUri: ,
            // scopes: ,
            // iOSPreferPlist: ,
          ),
        if (socialKeys.facebookAppID != null)
          FacebookProvider(
            clientId: socialKeys.facebookAppID,
            // redirectUri: '',
          ),
        if (socialKeys.supportApple == true)
          AppleProvider(
              // scopes: ,
              ),
      ]);
    }

  }
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

        final UserCredential _userCredential = await getFirebaseAuth().signInAnonymously();

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
            final GoogleSignIn _instance = GoogleAuthing.getGoogleSignInInstance();
            await _instance.disconnect();
            await _instance.signOut();
          }
        }

        /// FACEBOOK SIGN OUT
        else if (signInMethod == SignInMethod.facebook) {
          await FacebookAuthing.getFacebookAuthInstance().logOut();
        }

        /// FIREBASE SIGN OUT
        await Authing.getFirebaseAuth().signOut();
      },
    );

    return _success;
  }
  // -----------------------------------------------------------------------------

  /// READ AUTH

  // --------------------
  /// TESTED : WORKS PERFECT
  static User getFirebaseUser() {
    return getFirebaseAuth()?.currentUser;
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
        functions: () => getFirebaseAuth().currentUser?.delete(),
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
  static String getUserImageURLFromUserCredential(UserCredential cred){
    String _output;

    if (cred != null){

      final SignInMethod signInMethod = Authing.getCurrentSignInMethod();

      if (signInMethod == SignInMethod.google){
        _output = cred.user?.photoURL;
      }
      else if (signInMethod == SignInMethod.facebook){
        _output = FacebookAuthing.getUserFacebookImageURLFromUserCredential(cred);
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
    return _getSignInMethodFromUser(user: Authing.getFirebaseUser());
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static SignInMethod _getSignInMethodFromUser({
    @required User user,
  }){
    SignInMethod _output;

    if (user != null){

      final List<UserInfo> providerData = user.providerData;

      if (Mapper.checkCanLoopList(providerData) == true){
        final UserInfo _info = providerData.first;
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
