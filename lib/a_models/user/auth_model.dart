import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as FireAuthOps;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// -----------------------------------------------------------------------------
enum AuthBy {
  email,
  facebook,
  google,
  apple,
}
// -----------------------------------------------------------------------------
class AuthModel {
  /// --------------------------------------------------------------------------
  AuthModel({
    this.userModel,
    this.firstTimer,
    this.authError,
    this.userCredential,
    this.firebaseAuth,
    this.authSucceeds,
    this.facebookLoginResult,
    this.facebookAuthCredential,
    this.googleAuthProvider,
    this.googleSignIn,
    this.googleSignInAccount,
    this.googleSignInAuthentication,
    this.authCredential,
  });
  /// --------------------------------------------------------------------------
  UserModel userModel;
  bool firstTimer;
  bool authSucceeds;
  String authError;
  UserCredential userCredential;
  FirebaseAuth firebaseAuth;
  LoginResult facebookLoginResult;
  FacebookAuthCredential facebookAuthCredential;
  GoogleAuthProvider googleAuthProvider;
  GoogleSignIn googleSignIn;
  GoogleSignInAccount googleSignInAccount;
  GoogleSignInAuthentication googleSignInAuthentication;
  AuthCredential authCredential;
// -----------------------------------------------------------------------------
  static AuthBy decipherAuthBy(String authBy) {
    switch (authBy) {
      case 'email':     return AuthBy.email;    break;
      case 'facebook':  return AuthBy.facebook; break;
      case 'apple':     return AuthBy.apple;    break;
      case 'google':    return AuthBy.google;   break;
      default: return null;
    }
  }
// -----------------------------------------------------------------------------
  static String cipherAuthBy(AuthBy authBy) {
    switch (authBy) {
      case AuthBy.email:    return 'email';     break;
      case AuthBy.facebook: return 'facebook';  break;
      case AuthBy.apple:    return 'apple';     break;
      case AuthBy.google:   return 'google';    break;
      default: return null;
    }
  }
// -----------------------------------------------------------------------------
  static bool userIsSignedIn() {
    bool _userIsSignedIn = false;

    if (FireAuthOps.superFirebaseUser() == null) {
      _userIsSignedIn = false;
    } else {
      _userIsSignedIn = true;
    }

    // blog('_userIsSignedIn() = $_userIsSignedIn');

    return _userIsSignedIn;
  }
// -----------------------------------------------------------------------------
  void blogAuthModel({String methodName}){

    final String _methodName = methodName ?? 'AUTH MODEL';
    blog('================================================================');
    blog('BLOGGING : $_methodName');
    blog('..................................................');
    blog('firstTimer : $firstTimer');
    blog('authSucceeds : $authSucceeds');
    blog('authError : $authError');
    blog('..................................................');
    blog('firebaseUser.uid : ${userCredential?.user?.uid}');
    blog('firebaseUser.email : ${userCredential?.user?.email}');
    blog('firebaseUser.displayName : ${userCredential?.user?.displayName}');
    blog('firebaseUser.emailVerified : ${userCredential?.user?.emailVerified}');
    blog('firebaseUser.isAnonymous : ${userCredential?.user?.isAnonymous}');
    blog('firebaseUser.metadata.creationTime : ${userCredential?.user?.metadata?.creationTime}');
    blog('firebaseUser.metadata.lastSignInTime : ${userCredential?.user?.metadata?.lastSignInTime}');
    blog('firebaseUser.photoURL : ${userCredential?.user?.photoURL}');
    blog('firebaseUser.phoneNumber : ${userCredential?.user?.phoneNumber}');
    blog('firebaseUser.providerData : ${userCredential?.user?.providerData?.toString()}');
    blog('firebaseUser.refreshToken : ${userCredential?.user?.refreshToken}');
    blog('firebaseUser.tenantId : ${userCredential?.user?.tenantId}');
    blog('..................................................');
    blog('userCredential.additionalUserInfo.profile : ${userCredential?.additionalUserInfo?.profile}');
    blog('userCredential.additionalUserInfo.isNewUser : ${userCredential?.additionalUserInfo?.isNewUser}');
    blog('userCredential.additionalUserInfo.providerId : ${userCredential?.additionalUserInfo?.providerId}');
    blog('userCredential.additionalUserInfo.username : ${userCredential?.additionalUserInfo?.username}');
    blog('userCredential.credential.providerId : ${userCredential?.credential?.providerId}');
    blog('userCredential.credential.signInMethod : ${userCredential?.credential?.signInMethod}');
    blog('userCredential.credential.token : ${userCredential?.credential?.token}');
    blog('..................................................');
    blog('firebaseAuth.tenantId : ${firebaseAuth?.tenantId}');
    blog('firebaseAuth.app : ${firebaseAuth?.app}');
    blog('firebaseAuth.currentUser : ${firebaseAuth?.currentUser}');
    blog('firebaseAuth.languageCode : ${firebaseAuth?.languageCode}');
    blog('firebaseAuth.pluginConstants : ${firebaseAuth?.pluginConstants}');
    blog('..................................................');
    blog('facebookLoginResult.status.index : ${facebookLoginResult?.status?.index}');
    blog('facebookLoginResult.status.name : ${facebookLoginResult?.status?.name}');
    blog('facebookLoginResult.accessToken.token : ${facebookLoginResult?.accessToken?.token}');
    blog('facebookLoginResult.accessToken.applicationId : ${facebookLoginResult?.accessToken?.applicationId}');
    blog('facebookLoginResult.accessToken.declinedPermissions : ${facebookLoginResult?.accessToken?.declinedPermissions?.toString()}');
    blog('facebookLoginResult.accessToken.grantedPermissions : ${facebookLoginResult?.accessToken?.grantedPermissions?.toString()}');
    blog('facebookLoginResult.accessToken.expires : ${facebookLoginResult?.accessToken?.expires}');
    blog('facebookLoginResult.accessToken.graphDomain : ${facebookLoginResult?.accessToken?.graphDomain}');
    blog('facebookLoginResult.accessToken.isExpired : ${facebookLoginResult?.accessToken?.isExpired}');
    blog('facebookLoginResult.accessToken.lastRefresh : ${facebookLoginResult?.accessToken?.lastRefresh}');
    blog('facebookLoginResult.accessToken.userId : ${facebookLoginResult?.accessToken?.userId}');
    blog('facebookLoginResult.message : ${facebookLoginResult?.message}');
    blog('..................................................');
    blog('facebookAuthCredential.accessToken : ${facebookAuthCredential?.accessToken}');
    blog('facebookAuthCredential.idToken : ${facebookAuthCredential?.idToken}');
    blog('facebookAuthCredential.rawNonce : ${facebookAuthCredential?.rawNonce}');
    blog('facebookAuthCredential.secret : ${facebookAuthCredential?.secret}');
    blog('facebookAuthCredential.token : ${facebookAuthCredential?.token}');
    blog('facebookAuthCredential.signInMethod : ${facebookAuthCredential?.signInMethod}');
    blog('facebookAuthCredential.token : ${facebookAuthCredential?.token}');
    blog('facebookAuthCredential.providerId : ${facebookAuthCredential?.providerId}');
    blog('..................................................');
    blog('googleAuthProvider.parameters : ${googleAuthProvider?.parameters}');
    blog('googleAuthProvider.scopes : ${googleAuthProvider?.scopes?.toString()}');
    blog('googleAuthProvider.providerId : ${googleAuthProvider?.providerId}');
    blog('googleAuthProvider.providerId : ${googleAuthProvider?.providerId}');
    blog('..................................................');
    blog('googleAuthProvider.scopes : ${googleSignIn?.scopes.toString()}');
    blog('googleAuthProvider.currentUser.id : ${googleSignIn?.currentUser?.id}');
    blog('googleAuthProvider.currentUser.displayName : ${googleSignIn?.currentUser?.displayName}');
    blog('googleAuthProvider.currentUser.email : ${googleSignIn?.currentUser?.email}');
    blog('googleAuthProvider.currentUser.photoUrl : ${googleSignIn?.currentUser?.photoUrl}');
    blog('googleAuthProvider.currentUser.serverAuthCode : ${googleSignIn?.currentUser?.serverAuthCode}');
    blog('googleAuthProvider.clientId: ${googleSignIn?.clientId}');
    blog('googleAuthProvider.hostedDomain: ${googleSignIn?.hostedDomain}');
    blog('googleAuthProvider.hostedDomain.index: ${googleSignIn?.signInOption?.index}');
    blog('googleAuthProvider.hostedDomain.name: ${googleSignIn?.signInOption?.name}');
    blog('..................................................');
    blog('googleSignInAccount.serverAuthCode: ${googleSignInAccount?.serverAuthCode}');
    blog('googleSignInAccount.photoUrl: ${googleSignInAccount?.photoUrl}');
    blog('googleSignInAccount.email: ${googleSignInAccount?.email}');
    blog('googleSignInAccount.displayName: ${googleSignInAccount?.displayName}');
    blog('googleSignInAccount.id: ${googleSignInAccount?.id}');
    blog('..................................................');
    blog('googleSignInAuthentication.idToken: ${googleSignInAuthentication?.idToken}');
    blog('googleSignInAuthentication.accessToken: ${googleSignInAuthentication?.accessToken}');
    blog('..................................................');
    blog('authCredential.providerId: ${authCredential?.providerId}');
    blog('authCredential.token: ${authCredential?.token}');
    blog('authCredential.token: ${authCredential?.signInMethod}');
    blog('================================================================');

  }
// -----------------------------------------------------------------------------

}
