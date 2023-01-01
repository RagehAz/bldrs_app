import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum AuthType {
  emailSignIn,
  emailRegister,
  facebook,
  google,
  apple,
}

@immutable
class AuthModel {
  /// --------------------------------------------------------------------------
  const AuthModel({
    this.userModel,
    this.firstTimer,
    this.authSucceeds,
    this.authError,
    /// UserCredential
    this.profile,
    this.isNewUser,
    this.userCredentialProviderId,
    this.username,
    /// AuthCredential
    this.authCredentialProviderId,
    this.authCredentialToken,
    this.signInMethod,
    /// FirebaseAuth.currentUser
    this.email,
    this.displayName,
    this.emailVerified,
    this.isAnonymous,
    this.phoneNumber,
    this.photoURL,
    this.refreshToken,
    this.tenantId,
    this.uid,
    this.providerData,
    /// FirebaseAuth.currentUser.metadata
    this.creationTime,
    this.lastSignInTime,
    /// facebookLoginResult
    this.facebookLoginResultMessage,
    this.facebookLoginResultToken,
    /// facebookLoginResult.status
    this.facebookLoginResultStatusIndex,
    this.facebookLoginResultStatusName,
    /// facebookLoginResult.accessToken
    this.facebookLoginResultAppId,
    this.facebookLoginResultDeclinedPermission,
    this.facebookLoginResultExpires,
    this.facebookLoginResultGrantedPermission,
    this.facebookLoginResultGraphDomain,
    this.facebookLoginResultIsExpired,
    this.facebookLoginResultLastRefresh,
    this.facebookLoginResultUserID,
    /// facebookAuthCredential
    this.facebookAuthCredentialAccessToken,
    this.facebookAuthCredentialRawNonce,
    this.facebookAuthCredentialSecret,
    this.facebookAuthCredentialToken,
    this.facebookAuthCredentialSignInMethod,
    this.facebookAuthCredentialProviderId,
    this.facebookAuthCredentialIdToken,
    /// googleAuthProvider
    this.googleAuthProviderParameters,
    this.googleAuthProviderScopes,
    this.googleAuthProviderProviderId,
    /// googleSignIn
    this.googleSignInScopes,
    this.googleSignInClientId,
    this.googleSignInHostedDomain,
    /// googleSignIn.signInOption
    this.googleSignInSignInOptionIndex,
    this.googleSignInSignInOptionName,
    /// googleSignIn.currentUser
    this.googleSignInDisplayName,
    this.googleSignInEmail,
    this.googleSignInId,
    this.googleSignInPhotoUrl,
    this.googleSignInServerAuthCode,
    // @required this.googleSignInAuthentication,
    // @required this.googleSignInAuthHeaders,
    /// googleSignInAccount
    this.googleSignInAccountServerAuthCode,
    this.googleSignInAccountPhotoUrl,
    this.googleSignInAccountId,
    this.googleSignInAccountEmail,
    this.googleSignInAccountDisplayName,
    // this.googleSignInAccountAuthHeaders,
    // this.googleSignInAccountAuthentication,
    /// googleSignInAuthentication
    this.googleSignInAuthenticationIdToken,
    this.googleSignInAuthenticationAccessToken,

  });
  /// --------------------------------------------------------------------------
  final UserModel userModel;
  final bool firstTimer;
  final bool authSucceeds;
  final String authError;
  /// UserCredential
  final Map<String, dynamic> profile;
  final bool isNewUser;
  final String userCredentialProviderId;
  final String username;
  /// AuthCredential
  final String authCredentialProviderId;
  final int authCredentialToken;
  final String signInMethod;
  /// FirebaseAuth.currentUser
  final String email;
  final String displayName;
  final bool emailVerified;
  final bool isAnonymous;
  final String phoneNumber;
  final String photoURL;
  final String refreshToken;
  final String tenantId;
  final String uid;
  final List<UserInfo> providerData;
  /// FirebaseAuth.currentUser.metadata
  final DateTime creationTime;
  final DateTime lastSignInTime;
  /// facebookLoginResult
  final String facebookLoginResultMessage;
  /// facebookLoginResult.status
  final int facebookLoginResultStatusIndex;
  final String facebookLoginResultStatusName;
  /// facebookLoginResult.accessToken
  final String facebookLoginResultToken;
  final String facebookLoginResultAppId;
  final List<String> facebookLoginResultDeclinedPermission;
  final DateTime facebookLoginResultExpires;
  final List<String> facebookLoginResultGrantedPermission;
  final String facebookLoginResultGraphDomain;
  final bool facebookLoginResultIsExpired;
  final DateTime facebookLoginResultLastRefresh;
  final String facebookLoginResultUserID;
  /// facebookAuthCredential
  final String facebookAuthCredentialAccessToken;
  final String facebookAuthCredentialRawNonce;
  final String facebookAuthCredentialSecret;
  final int facebookAuthCredentialToken;
  final String facebookAuthCredentialSignInMethod;
  final String facebookAuthCredentialProviderId;
  final String facebookAuthCredentialIdToken;
  /// googleAuthProvider
  final Map<dynamic, dynamic> googleAuthProviderParameters;
  final List<String> googleAuthProviderScopes;
  final String googleAuthProviderProviderId;
  /// googleSignIn
  final List<String> googleSignInScopes;
  final String googleSignInClientId;
  final String googleSignInHostedDomain;
  /// googleSignIn.signInOption
  final int googleSignInSignInOptionIndex;
  final String googleSignInSignInOptionName;
  /// googleSignIn.currentUser
  final String googleSignInDisplayName;
  final String googleSignInEmail;
  final String googleSignInId;
  final String googleSignInPhotoUrl;
  final String googleSignInServerAuthCode;
  // final String googleSignInAuthentication;
  // final Map<String, String> googleSignInAuthHeaders;
  /// googleSignInAccount
  final String googleSignInAccountServerAuthCode;
  final String googleSignInAccountPhotoUrl;
  final String googleSignInAccountId;
  final String googleSignInAccountEmail;
  final String googleSignInAccountDisplayName;
  // final String googleSignInAccountAuthHeaders;
  // final String googleSignInAccountAuthentication;
  /// googleSignInAuthentication
  final String googleSignInAuthenticationIdToken;
  final String googleSignInAuthenticationAccessToken;
  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static AuthModel create({
    UserModel userModel,
    bool firstTimer,
    bool authSucceeds,
    String authError,
    UserCredential userCredential,
    AuthCredential authCredential,
    // LoginResult facebookLoginResult,
    FacebookAuthCredential facebookAuthCredential,
    GoogleAuthProvider googleAuthProvider,
    GoogleSignIn googleSignIn,
    GoogleSignInAccount googleSignInAccount,
    GoogleSignInAuthentication googleSignInAuthentication,
  }){

    // temp panadol until we re-do facebook auth
    const dynamic facebookLoginResult = null;

    return AuthModel(
      userModel: userModel,
      firstTimer: firstTimer,
      authSucceeds: authSucceeds,
      authError: authError,
      /// UserCredential
      profile: userCredential?.additionalUserInfo?.profile,
      isNewUser: userCredential?.additionalUserInfo?.isNewUser,
      userCredentialProviderId: userCredential?.additionalUserInfo?.providerId,
      username: userCredential?.additionalUserInfo?.username,
      /// UserCredential.user
      email: userCredential?.user?.email,
      displayName: userCredential?.user?.displayName,
      emailVerified: userCredential?.user?.emailVerified,
      isAnonymous: userCredential?.user?.isAnonymous,
      phoneNumber: userCredential?.user?.phoneNumber,
      photoURL: userCredential?.user?.photoURL,
      refreshToken: userCredential?.user?.refreshToken,
      tenantId: userCredential?.user?.tenantId,
      uid: userCredential?.user?.uid,
      providerData: userCredential?.user?.providerData,
      /// UserCredential.user.metadata
      creationTime: userCredential?.user?.metadata?.creationTime,
      lastSignInTime: userCredential?.user?.metadata?.lastSignInTime,
      /// AuthCredential
      authCredentialProviderId: authCredential?.providerId,
      authCredentialToken: authCredential?.token,
      signInMethod: authCredential?.signInMethod,
      /// facebookLoginResult
      facebookLoginResultMessage: facebookLoginResult?.message,
      /// facebookLoginResult.status
      facebookLoginResultStatusIndex: facebookLoginResult?.status?.index,
      facebookLoginResultStatusName: facebookLoginResult?.status?.name,
      /// facebookLoginResult.accessToken
      facebookLoginResultToken: facebookLoginResult?.accessToken?.token,
      facebookLoginResultAppId: facebookLoginResult?.accessToken?.applicationId,
      facebookLoginResultDeclinedPermission: facebookLoginResult?.accessToken?.declinedPermissions,
      facebookLoginResultExpires: facebookLoginResult?.accessToken?.expires,
      facebookLoginResultGrantedPermission: facebookLoginResult?.accessToken?.grantedPermissions,
      facebookLoginResultGraphDomain: facebookLoginResult?.accessToken?.graphDomain,
      facebookLoginResultIsExpired: facebookLoginResult?.accessToken?.isExpired,
      facebookLoginResultLastRefresh: facebookLoginResult?.accessToken?.lastRefresh,
      facebookLoginResultUserID: facebookLoginResult?.accessToken?.userId,
      /// facebookAuthCredential
      facebookAuthCredentialAccessToken: facebookAuthCredential?.accessToken,
      facebookAuthCredentialRawNonce: facebookAuthCredential?.rawNonce,
      facebookAuthCredentialSecret: facebookAuthCredential?.secret,
      facebookAuthCredentialToken: facebookAuthCredential?.token,
      facebookAuthCredentialSignInMethod: facebookAuthCredential?.signInMethod,
      facebookAuthCredentialProviderId: facebookAuthCredential?.providerId,
      facebookAuthCredentialIdToken: facebookAuthCredential?.idToken,
      /// googleAuthProvider
      googleAuthProviderParameters: googleAuthProvider?.parameters,
      googleAuthProviderScopes: googleAuthProvider?.scopes,
      googleAuthProviderProviderId: googleAuthProvider?.providerId,
      /// googleSignIn
      googleSignInScopes: googleSignIn?.scopes,
      googleSignInClientId: googleSignIn?.clientId,
      googleSignInHostedDomain: googleSignIn?.hostedDomain,
      /// googleSignIn.signInOption
      googleSignInSignInOptionIndex: googleSignIn?.signInOption?.index,
      googleSignInSignInOptionName: googleSignIn?.signInOption?.name,
      /// googleSignIn.currentUser
      googleSignInDisplayName: googleSignIn?.currentUser?.displayName,
      googleSignInEmail: googleSignIn?.currentUser?.email,
      googleSignInId: googleSignIn?.currentUser?.id,
      googleSignInPhotoUrl: googleSignIn?.currentUser?.photoUrl,
      googleSignInServerAuthCode: googleSignIn?.currentUser?.serverAuthCode,
      // googleSignInAuthHeaders: googleSignIn.currentUser.authHeaders,
      // googleSignInAuthentication: googleSignIn.currentUser.authentication,
      /// googleSignInAccount
      googleSignInAccountServerAuthCode: googleSignInAccount?.serverAuthCode,
      googleSignInAccountPhotoUrl: googleSignInAccount?.photoUrl,
      googleSignInAccountId: googleSignInAccount?.id,
      googleSignInAccountEmail: googleSignInAccount?.email,
      googleSignInAccountDisplayName: googleSignInAccount?.displayName,
      // googleSignInAccountAuthHeaders: googleSignInAccount.authHeaders,
      // googleSignInAccountAuthentication: googleSignInAccount.authentication,
      /// googleSignInAuthentication
      googleSignInAuthenticationIdToken: googleSignInAuthentication?.idToken,
      googleSignInAuthenticationAccessToken: googleSignInAuthentication?.accessToken,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  AuthModel copyWith({
    UserModel userModel,
    bool firstTimer,
    bool authSucceeds,
    String authError,
    Map<String, dynamic> profile,
    bool isNewUser,
    String userCredentialProviderId,
    String username,
    User userCredentialUser,
    String authCredentialProviderId,
    int authCredentialToken,
    String signInMethod,
    String email,
    String displayName,
    bool emailVerified,
    bool isAnonymous,
    String phoneNumber,
    String photoURL,
    String refreshToken,
    String tenantId,
    String uid,
    List<UserInfo> providerData,
    DateTime creationTime,
    DateTime lastSignInTime,
    String facebookLoginResultMessage,
    int facebookLoginResultStatusIndex,
    String facebookLoginResultStatusName,
    String facebookLoginResultToken,
    String facebookLoginResultAppId,
    List<String> facebookLoginResultDeclinedPermission,
    DateTime facebookLoginResultExpires,
    List<String> facebookLoginResultGrantedPermission,
    String facebookLoginResultGraphDomain,
    bool facebookLoginResultIsExpired,
    DateTime facebookLoginResultLastRefresh,
    String facebookLoginResultUserID,
    String facebookAuthCredentialAccessToken,
    String facebookAuthCredentialRawNonce,
    String facebookAuthCredentialSecret,
    int facebookAuthCredentialToken,
    String facebookAuthCredentialSignInMethod,
    String facebookAuthCredentialProviderId,
    String facebookAuthCredentialIdToken,
    Map<dynamic, dynamic> googleAuthProviderParameters,
    List<String> googleAuthProviderScopes,
    String googleAuthProviderProviderId,
    List<String> googleSignInScopes,
    String googleSignInClientId,
    String googleSignInHostedDomain,
    int googleSignInSignInOptionIndex,
    String googleSignInSignInOptionName,
    String googleSignInDisplayName,
    String googleSignInEmail,
    String googleSignInId,
    String googleSignInPhotoUrl,
    String googleSignInServerAuthCode,
    String googleSignInAccountServerAuthCode,
    String googleSignInAccountPhotoUrl,
    String googleSignInAccountId,
    String googleSignInAccountEmail,
    String googleSignInAccountDisplayName,
    String googleSignInAuthenticationIdToken,
    String googleSignInAuthenticationAccessToken,
  }){

    return AuthModel(
      userModel: userModel ?? this.userModel,
      firstTimer: firstTimer ?? this.firstTimer,
      authSucceeds: authSucceeds ?? this.authSucceeds,
      authError: authError ?? this.authError,
      profile: profile ?? this.profile,
      isNewUser: isNewUser ?? this.isNewUser,
      userCredentialProviderId: userCredentialProviderId ?? this.userCredentialProviderId,
      username: username ?? this.username,
      authCredentialProviderId: authCredentialProviderId ?? this.authCredentialProviderId,
      authCredentialToken: authCredentialToken ?? this.authCredentialToken,
      signInMethod: signInMethod ?? this.signInMethod,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      emailVerified: emailVerified ?? this.emailVerified,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoURL: photoURL ?? this.photoURL,
      refreshToken: refreshToken ?? this.refreshToken,
      tenantId: tenantId ?? this.tenantId,
      uid: uid ?? this.uid,
      providerData: providerData ?? this.providerData,
      creationTime: creationTime ?? this.creationTime,
      lastSignInTime: lastSignInTime ?? this.lastSignInTime,
      facebookLoginResultMessage: facebookLoginResultMessage ?? this.facebookLoginResultMessage,
      facebookLoginResultToken: facebookLoginResultToken ?? this.facebookLoginResultToken,
      facebookLoginResultStatusIndex: facebookLoginResultStatusIndex ?? this.facebookLoginResultStatusIndex,
      facebookLoginResultStatusName: facebookLoginResultStatusName ?? this.facebookLoginResultStatusName,
      facebookLoginResultAppId: facebookLoginResultAppId ?? this.facebookLoginResultAppId,
      facebookLoginResultDeclinedPermission: facebookLoginResultDeclinedPermission ?? this.facebookLoginResultDeclinedPermission,
      facebookLoginResultExpires: facebookLoginResultExpires ?? this.facebookLoginResultExpires,
      facebookLoginResultGrantedPermission: facebookLoginResultGrantedPermission ?? this.facebookLoginResultGrantedPermission,
      facebookLoginResultGraphDomain: facebookLoginResultGraphDomain ?? this.facebookLoginResultGraphDomain,
      facebookLoginResultIsExpired: facebookLoginResultIsExpired ?? this.facebookLoginResultIsExpired,
      facebookLoginResultLastRefresh: facebookLoginResultLastRefresh ?? this.facebookLoginResultLastRefresh,
      facebookLoginResultUserID: facebookLoginResultUserID ?? this.facebookLoginResultUserID,
      facebookAuthCredentialAccessToken: facebookAuthCredentialAccessToken ?? this.facebookAuthCredentialAccessToken,
      facebookAuthCredentialRawNonce: facebookAuthCredentialRawNonce ?? this.facebookAuthCredentialRawNonce,
      facebookAuthCredentialSecret: facebookAuthCredentialSecret ?? this.facebookAuthCredentialSecret,
      facebookAuthCredentialToken: facebookAuthCredentialToken ?? this.facebookAuthCredentialToken,
      facebookAuthCredentialSignInMethod: facebookAuthCredentialSignInMethod ?? this.facebookAuthCredentialSignInMethod,
      facebookAuthCredentialProviderId: facebookAuthCredentialProviderId ?? this.facebookAuthCredentialProviderId,
      facebookAuthCredentialIdToken: facebookAuthCredentialIdToken ?? this.facebookAuthCredentialIdToken,
      googleAuthProviderParameters: googleAuthProviderParameters ?? this.googleAuthProviderParameters,
      googleAuthProviderScopes: googleAuthProviderScopes ?? this.googleAuthProviderScopes,
      googleAuthProviderProviderId: googleAuthProviderProviderId ?? this.googleAuthProviderProviderId,
      googleSignInScopes: googleSignInScopes ?? this.googleSignInScopes,
      googleSignInClientId: googleSignInClientId ?? this.googleSignInClientId,
      googleSignInHostedDomain: googleSignInHostedDomain ?? this.googleSignInHostedDomain,
      googleSignInSignInOptionIndex: googleSignInSignInOptionIndex ?? this.googleSignInSignInOptionIndex,
      googleSignInSignInOptionName: googleSignInSignInOptionName ?? this.googleSignInSignInOptionName,
      googleSignInDisplayName: googleSignInDisplayName ?? this.googleSignInDisplayName,
      googleSignInEmail: googleSignInEmail ?? this.googleSignInEmail,
      googleSignInId: googleSignInId ?? this.googleSignInId,
      googleSignInPhotoUrl: googleSignInPhotoUrl ?? this.googleSignInPhotoUrl,
      googleSignInServerAuthCode: googleSignInServerAuthCode ?? this.googleSignInServerAuthCode,
      googleSignInAccountServerAuthCode: googleSignInAccountServerAuthCode ?? this.googleSignInAccountServerAuthCode,
      googleSignInAccountPhotoUrl: googleSignInAccountPhotoUrl ?? this.googleSignInAccountPhotoUrl,
      googleSignInAccountId: googleSignInAccountId ?? this.googleSignInAccountId,
      googleSignInAccountEmail: googleSignInAccountEmail ?? this.googleSignInAccountEmail,
      googleSignInAccountDisplayName: googleSignInAccountDisplayName ?? this.googleSignInAccountDisplayName,
      googleSignInAuthenticationIdToken: googleSignInAuthenticationIdToken ?? this.googleSignInAuthenticationIdToken,
      googleSignInAuthenticationAccessToken: googleSignInAuthenticationAccessToken ?? this.googleSignInAuthenticationAccessToken,
    );

  }
  // -----------------------------------------------------------------------------

  /// CYPHER

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap({
    @required bool toJSON,
  }){
    return {
      'userModel': userModel.toMap(toJSON: toJSON),
      'firstTimer': firstTimer,
      'authSucceeds': authSucceeds,
      'authError': authError,
      /// UserCredential
      'profile': profile,
      'isNewUser': isNewUser,
      'userCredentialProviderId': userCredentialProviderId,
      'username': username,
      /// AuthCredential
      'authCredentialProviderId': authCredentialProviderId,
      'authCredentialToken': authCredentialToken,
      'signInMethod': signInMethod,
      /// FirebaseAuth.currentUser
      'email': email,
      'displayName': displayName,
      'emailVerified': emailVerified,
      'isAnonymous': isAnonymous,
      'phoneNumber': phoneNumber,
      'photoURL': photoURL,
      'refreshToken': refreshToken,
      'tenantId': tenantId,
      'uid': uid,
      'providerData': cipherUserInfos(providerData),
      /// FirebaseAuth.currentUser.metadata
      'creationTime': Timers.cipherTime(time: creationTime, toJSON: toJSON),
      'lastSignInTime': Timers.cipherTime(time: lastSignInTime, toJSON: toJSON),
      /// facebookLoginResult
      'facebookLoginResultMessage': facebookLoginResultMessage,
      /// facebookLoginResult.status
      'facebookLoginResultStatusIndex': facebookLoginResultStatusIndex,
      'facebookLoginResultStatusName': facebookLoginResultStatusName,
      /// facebookLoginResult.accessToken
      'facebookLoginResultToken': facebookLoginResultToken,
      'facebookLoginResultAppId': facebookLoginResultAppId,
      'facebookLoginResultDeclinedPermission': facebookLoginResultDeclinedPermission,
      'facebookLoginResultExpires': Timers.cipherTime(time: facebookLoginResultExpires, toJSON: toJSON),
      'facebookLoginResultGrantedPermission': facebookLoginResultGrantedPermission,
      'facebookLoginResultGraphDomain' : facebookLoginResultGraphDomain,
      'facebookLoginResultIsExpired':  facebookLoginResultIsExpired,
      'facebookLoginResultLastRefresh': Timers.cipherTime(time: facebookLoginResultLastRefresh, toJSON: toJSON),
      'facebookLoginResultUserID' : facebookLoginResultUserID,
      /// facebookAuthCredential
      'facebookAuthCredentialAccessToken' : facebookAuthCredentialAccessToken,
      'facebookAuthCredentialRawNonce' : facebookAuthCredentialRawNonce,
      'facebookAuthCredentialSecret' : facebookAuthCredentialSecret,
      'facebookAuthCredentialToken' : facebookAuthCredentialToken,
      'facebookAuthCredentialSignInMethod' : facebookAuthCredentialSignInMethod,
      'facebookAuthCredentialProviderId' : facebookAuthCredentialProviderId,
      'facebookAuthCredentialIdToken' : facebookAuthCredentialIdToken,
      /// googleAuthProvider
      'googleAuthProviderParameters' : googleAuthProviderParameters,
      'googleAuthProviderScopes' : googleAuthProviderScopes,
      'googleAuthProviderProviderId' : googleAuthProviderProviderId,
      /// googleSignIn
      'googleSignInScopes' : googleSignInScopes,
      'googleSignInClientId' : googleSignInClientId,
      'googleSignInHostedDomain' : googleSignInHostedDomain,
      /// googleSignIn.signInOption
      'googleSignInSignInOptionIndex' : googleSignInSignInOptionIndex,
      'googleSignInSignInOptionName' : googleSignInSignInOptionName,
      /// googleSignIn.currentUser
      'googleSignInDisplayName' : googleSignInDisplayName,
      'googleSignInEmail' : googleSignInEmail,
      'googleSignInId' : googleSignInId,
      'googleSignInPhotoUrl' : googleSignInPhotoUrl,
      'googleSignInServerAuthCode' : googleSignInServerAuthCode,
      // googleSignInAuthentication;
      // googleSignInAuthHeaders;
      /// googleSignInAccount
      'googleSignInAccountServerAuthCode' : googleSignInAccountServerAuthCode,
      'googleSignInAccountPhotoUrl' : googleSignInAccountPhotoUrl,
      'googleSignInAccountId' : googleSignInAccountId,
      'googleSignInAccountEmail' : googleSignInAccountEmail,
      'googleSignInAccountDisplayName' : googleSignInAccountDisplayName,
      // googleSignInAccountAuthHeaders;
      // final String googleSignInAccountAuthentication;
      /// googleSignInAuthentication
      'googleSignInAuthenticationIdToken' : googleSignInAuthenticationIdToken,
      'googleSignInAuthenticationAccessToken' : googleSignInAuthenticationAccessToken,

    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static AuthModel decipherAuthModel({
    @required Map<String, dynamic> map,
    @required bool fromJSON,
  }){

    AuthModel _model;

    if (map != null){

      _model = AuthModel(
        userModel: UserModel.decipherUser(
          map: map['userModel'],
          fromJSON: fromJSON,
        ),
        firstTimer: map['firstTimer'],
        authSucceeds: map['authSucceeds'],
        authError: map['authError'],
        /// UserCredential
        profile: map['profile'],
        isNewUser: map['isNewUser'],
        userCredentialProviderId: map['userCredentialProviderId'],
        username: map['username'],
        /// AuthCredential
        authCredentialProviderId: map['authCredentialProviderId'],
        authCredentialToken: map['authCredentialToken'],
        signInMethod: map['signInMethod'],
        /// FirebaseAuth.currentUser
        email: map['email'],
        displayName: map['displayName'],
        emailVerified: map['emailVerified'],
        isAnonymous: map['isAnonymous'],
        phoneNumber: map['phoneNumber'],
        photoURL: map['photoURL'],
        refreshToken: map['refreshToken'],
        tenantId: map['tenantId'],
        uid: map['uid'],
        providerData: decipherUserInfos(map['providerData']),
        /// FirebaseAuth.currentUser.metadata
        creationTime: Timers.decipherTime(time: map['creationTime'], fromJSON: fromJSON),
        lastSignInTime: Timers.decipherTime(time: map['lastSignInTime'], fromJSON: fromJSON),
        /// facebookLoginResult
        facebookLoginResultMessage: map['facebookLoginResultMessage'],
        /// facebookLoginResult.status
        facebookLoginResultStatusIndex: map['facebookLoginResultStatusIndex'],
        facebookLoginResultStatusName: map['facebookLoginResultStatusName'],
        /// facebookLoginResult.accessToken
        facebookLoginResultToken: map['facebookLoginResultToken'],
        facebookLoginResultAppId: map['facebookLoginResultAppId'],
        facebookLoginResultDeclinedPermission: Stringer.getStringsFromDynamics(dynamics: map['facebookLoginResultDeclinedPermission']),
        facebookLoginResultExpires: Timers.decipherTime(time: map['facebookLoginResultExpires'], fromJSON: fromJSON),
        facebookLoginResultGrantedPermission: Stringer.getStringsFromDynamics(dynamics: map['facebookLoginResultGrantedPermission']),
        facebookLoginResultGraphDomain: map['facebookLoginResultGraphDomain'],
        facebookLoginResultIsExpired: map['facebookLoginResultIsExpired'],
        facebookLoginResultLastRefresh : Timers.decipherTime(time: map['facebookLoginResultLastRefresh'], fromJSON: fromJSON),
        facebookLoginResultUserID: map['facebookLoginResultUserID'],
        /// facebookAuthCredential
        facebookAuthCredentialAccessToken: map['facebookAuthCredentialAccessToken'],
        facebookAuthCredentialRawNonce: map['facebookAuthCredentialRawNonce'],
        facebookAuthCredentialSecret: map['facebookAuthCredentialSecret'],
        facebookAuthCredentialToken: map['facebookAuthCredentialToken'],
        facebookAuthCredentialSignInMethod: map['facebookAuthCredentialSignInMethod'],
        facebookAuthCredentialProviderId: map['facebookAuthCredentialProviderId'],
        facebookAuthCredentialIdToken: map['facebookAuthCredentialIdToken'],
        /// googleAuthProvider
        googleAuthProviderParameters: map['googleAuthProviderParameters'],
        googleAuthProviderScopes: Stringer.getStringsFromDynamics(dynamics: map['googleAuthProviderScopes']),
        googleAuthProviderProviderId: map['googleAuthProviderProviderId'],
        /// googleSignIn
        googleSignInScopes: Stringer.getStringsFromDynamics(dynamics: map['googleSignInScopes']),
        googleSignInClientId: map['googleSignInClientId'],
        googleSignInHostedDomain: map['googleSignInHostedDomain'],
        /// googleSignIn.signInOption
        googleSignInSignInOptionIndex: map['googleSignInSignInOptionIndex'],
        googleSignInSignInOptionName: map['googleSignInSignInOptionName'],
        /// googleSignIn.currentUser
        googleSignInDisplayName: map['googleSignInDisplayName'],
        googleSignInEmail: map['googleSignInEmail'],
        googleSignInId: map['googleSignInId'],
        googleSignInPhotoUrl: map['googleSignInPhotoUrl'],
        googleSignInServerAuthCode: map['googleSignInServerAuthCode'],
        // final String googleSignInAuthentication;
        // final Map<String, String> googleSignInAuthHeaders;
        /// googleSignInAccount
        googleSignInAccountServerAuthCode: map['googleSignInAccountServerAuthCode'],
        googleSignInAccountPhotoUrl: map['googleSignInAccountPhotoUrl'],
        googleSignInAccountId: map['googleSignInAccountId'],
        googleSignInAccountEmail: map['googleSignInAccountEmail'],
        googleSignInAccountDisplayName: map['googleSignInAccountDisplayName'],
        // final String googleSignInAccountAuthHeaders;
        // final String googleSignInAccountAuthentication;
        /// googleSignInAuthentication
        googleSignInAuthenticationIdToken: map['googleSignInAuthenticationIdToken'],
        googleSignInAuthenticationAccessToken: map['googleSignInAuthenticationAccessToken'],
      );

    }

    return _model;
  }
  // --------------------
  /// CYPHER AUTH BY
  // --------------------
  static AuthType decipherAuthBy(String authBy) {
    switch (authBy) {
      case 'emailRegister':     return AuthType.emailRegister;    break;
      case 'emailSignIn':       return AuthType.emailSignIn;      break;
      case 'facebook':          return AuthType.facebook;         break;
      case 'apple':             return AuthType.apple;            break;
      case 'google':            return AuthType.google;           break;
      default: return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String cipherAuthBy(AuthType authBy) {
    switch (authBy) {
      case AuthType.emailRegister:    return 'emailRegister';     break;
      case AuthType.emailSignIn:      return 'emailSignIn';       break;
      case AuthType.facebook:         return 'facebook';          break;
      case AuthType.apple:            return 'apple';             break;
      case AuthType.google:           return 'google';            break;
      default: return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// CYPHER USER INFO

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, String>> cipherUserInfos(List<UserInfo> userInfos){

    List<Map<String, String>> _maps;

    if (Mapper.checkCanLoopList(userInfos) == true){

      _maps = <Map<String, String>>[];

      for (final UserInfo info in userInfos){
        final Map<String, dynamic> _infoMap = cipherUserInfo(info);
        _maps.add(_infoMap);
      }

    }

    return _maps;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, String> cipherUserInfo(UserInfo userInfo){
    Map<String, String> _map;

    // blog('cipherUserInfo : blog : ${userInfo?.toString()}');

    if (userInfo != null){

      _map = {
        'displayName': userInfo.displayName,
        'email': userInfo.email,
        'uid' : userInfo.uid,
        'photoURL': userInfo.photoURL,
        'phoneNumber' :userInfo.phoneNumber,
        'providerId' : userInfo?.providerId,
      };
    }

    return _map;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<UserInfo> decipherUserInfos(dynamic maps){

    List<UserInfo> _userInfos;

    if (Mapper.checkCanLoopList(maps) == true){

      _userInfos = <UserInfo>[];

      final List<Map<String, String>> _maps = _fixTheImmutableMapsThing(maps);

      for (final Map<String, String> _map in _maps){

        final UserInfo _userInfo = decipherUserInfo(_map);
        _userInfos.add(_userInfo);

      }

    }

    return _userInfos;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static UserInfo decipherUserInfo(Map<String, String> map){
    UserInfo _userInfo;

    if (map != null){
      _userInfo = UserInfo(map);
    }

    return _userInfo;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, String>> _fixTheImmutableMapsThing(dynamic maps){

    // blog('1 _fixTheImmutableMapsThing : maps type is : ${maps.runtimeType}');
    final List<dynamic> _list = maps;
    // blog('2 _fixTheImmutableMapsThing : _list type is : ${_list.runtimeType}');

    final List<Map<String, String>> _output = <Map<String, String>>[];

    if (Mapper.checkCanLoopList(_list) == true){
      for (final dynamic object in _list){

        final Map<String, String> _stringStringMap = Mapper.getStringStringMapFromImmutableMapStringObject(object);

        // blog('5 _fixTheImmutableMapsThing : _stringStringMap type is : ${_stringStringMap.runtimeType}');

        _output.add(_stringStringMap);

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogAuthModel({String invoker = 'AUTH MODEL'}){

    blog('BLOGGING AUTH MODEL   : $invoker -------------------------------------------------------');
    userModel?.blogUserModel(invoker: 'blogAuthModel');
    blog('bool                  : firstTimer : $firstTimer');
    blog('bool                  : authSucceeds : $authSucceeds');
    blog('String                : authError : $authError');
    blog('Map<String, dynamic>  : profile :');
    Mapper.blogMap(profile);
    blog('bool                  : isNewUser : $isNewUser');
    blog('String                : userCredentialProviderId : $userCredentialProviderId');
    blog('String                : username : $username');
    blog('String                : authCredentialProviderId : $authCredentialProviderId');
    blog('int                   : authCredentialToken : $authCredentialToken');
    blog('String                : signInMethod : $signInMethod');
    blog('String                : email : $email');
    blog('String                : displayName : $displayName');
    blog('bool                  : emailVerified : $emailVerified');
    blog('bool                  : isAnonymous : $isAnonymous');
    blog('String                : phoneNumber : $phoneNumber');
    blog('String                : photoURL : $photoURL');
    blog('String                : refreshToken : $refreshToken');
    blog('String                : tenantId : $tenantId');
    blog('String                : uid : $uid');
    blog('List<UserInfo>        : providerData :');
    Mapper.blogMaps(cipherUserInfos(providerData));
    blog('DateTime              : creationTime : $creationTime');
    blog('DateTime              : lastSignInTime : $lastSignInTime');
    blog('String                : facebookLoginResultMessage : $facebookLoginResultMessage');
    blog('int                   : facebookLoginResultStatusIndex : $facebookLoginResultStatusIndex');
    blog('String                : facebookLoginResultStatusName : $facebookLoginResultStatusName');
    blog('String                : facebookLoginResultToken : $facebookLoginResultToken');
    blog('String                : facebookLoginResultAppId : $facebookLoginResultAppId');
    blog('List<String>          : facebookLoginResultDeclinedPermission : $facebookLoginResultDeclinedPermission');
    blog('DateTime              : facebookLoginResultExpires : $facebookLoginResultExpires');
    blog('List<String>          : facebookLoginResultGrantedPermission : $facebookLoginResultGrantedPermission');
    blog('String                : facebookLoginResultGraphDomain : $facebookLoginResultGraphDomain');
    blog('bool                  : facebookLoginResultIsExpired : $facebookLoginResultIsExpired');
    blog('DateTime              : facebookLoginResultLastRefresh : $facebookLoginResultLastRefresh');
    blog('String                : facebookLoginResultUserID : $facebookLoginResultUserID');
    blog('String                : facebookAuthCredentialAccessToken : $facebookAuthCredentialAccessToken');
    blog('String                : facebookAuthCredentialRawNonce : $facebookAuthCredentialRawNonce');
    blog('String                : facebookAuthCredentialSecret : $facebookAuthCredentialSecret');
    blog('int                   : facebookAuthCredentialToken : $facebookAuthCredentialToken');
    blog('String                : facebookAuthCredentialSignInMethod : $facebookAuthCredentialSignInMethod');
    blog('String                : facebookAuthCredentialProviderId : $facebookAuthCredentialProviderId');
    blog('String                : facebookAuthCredentialIdToken : $facebookAuthCredentialIdToken');
    blog('Map<dynamic, dynamic> : googleAuthProviderParameters :');
    Mapper.blogMap(googleAuthProviderParameters);
    blog('List<String>          : googleAuthProviderScopes : $googleAuthProviderScopes');
    blog('String                : googleAuthProviderProviderId : $googleAuthProviderProviderId');
    blog('List<String>          : googleSignInScopes : $googleSignInScopes');
    blog('String                : googleSignInClientId : $googleSignInClientId');
    blog('String                : googleSignInHostedDomain : $googleSignInHostedDomain');
    blog('int                   : googleSignInSignInOptionIndex : $googleSignInSignInOptionIndex');
    blog('String                : googleSignInSignInOptionName : $googleSignInSignInOptionName');
    blog('String                : googleSignInDisplayName : $googleSignInDisplayName');
    blog('String                : googleSignInEmail : $googleSignInEmail');
    blog('String                : googleSignInId : $googleSignInId');
    blog('String                : googleSignInPhotoUrl : $googleSignInPhotoUrl');
    blog('String                : googleSignInServerAuthCode : $googleSignInServerAuthCode');
    blog('String                : googleSignInAccountServerAuthCode : $googleSignInAccountServerAuthCode');
    blog('String                : googleSignInAccountPhotoUrl : $googleSignInAccountPhotoUrl');
    blog('String                : googleSignInAccountId : $googleSignInAccountId');
    blog('String                : googleSignInAccountEmail : $googleSignInAccountEmail');
    blog('String                : googleSignInAccountDisplayName : $googleSignInAccountDisplayName');
    blog('String                : googleSignInAuthenticationIdToken : $googleSignInAuthenticationIdToken');
    blog('String                : googleSignInAuthenticationAccessToken : $googleSignInAuthenticationAccessToken');
    blog('BLOGGING AUTH MODEL   : $invoker -------------------------------------------------------');
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool userIsSignedIn() {
    bool _userIsSignedIn = false;

    if (AuthFireOps.superFirebaseUser() == null) {
      _userIsSignedIn = false;
    } else {
      _userIsSignedIn = true;
    }

    // blog('_userIsSignedIn() = $_userIsSignedIn');

    return _userIsSignedIn;
  }
  // -----------------------------------------------------------------------------

  /// TESTING

  // --------------------
  /// TESTED : WORKS PERFECT
  static AuthModel testModel(BuildContext context){

    final AuthModel _model = AuthModel(
      userModel : UserModel.dummyUserModel(context),
      firstTimer : true,
      authSucceeds : true,
      authError : 'error',
      profile : const {'profileKey' : 'profile value'},
      isNewUser : true,
      userCredentialProviderId : 'user Credential Provider Id',
      username : 'user name',
      authCredentialProviderId : 'auth Credential Provider Id',
      authCredentialToken : 123456789,
      signInMethod : 'sign In Method',
      email : 'e mail',
      displayName : 'display Name',
      emailVerified : true,
      isAnonymous : true,
      phoneNumber : 'phone Number',
      photoURL : 'photo URL',
      refreshToken : 'refresh Token',
      tenantId : 'tenant Id',
      uid : 'u id',
      providerData : <UserInfo>[
        UserInfo(
          <String, String>{
            'displayName': 'display Name',
            'email': 'e mail',
            'providerId' : 'xxxxxx',
            'uid' : 'u id',
            'photoURL': 'photo URL',
            'phoneNumber' : 'phone Number',
          },
        ),
      ],
      creationTime : Timers.createDate(year: 1, month: 1, day: 1),
      lastSignInTime : Timers.createDate(year: 2, month: 2, day: 2),
      facebookLoginResultMessage : 'facebook Login Result Message',
      facebookLoginResultToken : 'facebook Login Result Token',
      facebookLoginResultStatusIndex : 1000,
      facebookLoginResultStatusName : 'facebook Login Result Status Name',
      facebookLoginResultAppId : 'facebook Login Result App Id',
      facebookLoginResultDeclinedPermission : const <String>['facebook', 'Login', 'Result', 'Declined', 'Permission',],
      facebookLoginResultExpires : Timers.createDate(year: 3, month: 3, day: 3),
      facebookLoginResultGrantedPermission : const <String>['facebook', 'Login', 'Result', 'Granted', 'Permission'],
      facebookLoginResultGraphDomain : 'facebook Login Result Graph Domain',
      facebookLoginResultIsExpired : true,
      facebookLoginResultLastRefresh : Timers.createDate(year: 4, month: 4, day: 4),
      facebookLoginResultUserID : 'facebook Login Result User ID',
      facebookAuthCredentialAccessToken : 'facebook Auth Credential Access Token',
      facebookAuthCredentialRawNonce : 'facebook Auth Credential Raw Nonce',
      facebookAuthCredentialSecret : 'facebook Auth Credential Secret',
      facebookAuthCredentialToken : 0,
      facebookAuthCredentialSignInMethod : 'facebook Auth Credential Sign In Method',
      facebookAuthCredentialProviderId : 'facebook Auth Credential Provider Id',
      facebookAuthCredentialIdToken : 'facebook Auth Credential Id Token',
      googleAuthProviderParameters : const {
        'param' : 'google Auth Provider Parameters',
      },
      googleAuthProviderScopes : const <String>['google', 'Auth', 'Provider', 'Scopes'],
      googleAuthProviderProviderId : 'googleAuthProviderProviderId',
      googleSignInScopes : const <String>['google', 'Sign', 'In', 'Scopes'],
      googleSignInClientId : 'google Sign In Client Id',
      googleSignInHostedDomain : 'google Sign In Hosted Domain',
      googleSignInSignInOptionIndex : 1,
      googleSignInSignInOptionName : 'google Sign In Sign In Option Name',
      googleSignInDisplayName : 'google Sign In Display Name',
      googleSignInEmail : 'google Sign In Email',
      googleSignInId : 'google Sign In Id',
      googleSignInPhotoUrl : 'google Sign In Photo Url',
      googleSignInServerAuthCode : 'google Sign In Server Auth Code',
      googleSignInAccountServerAuthCode : 'google Sign In Account Server Auth Code',
      googleSignInAccountPhotoUrl :'google Sign In Account Photo Url' ,
      googleSignInAccountId : 'google Sign In Account Id',
      googleSignInAccountEmail : 'google Sign In Account Email',
      googleSignInAccountDisplayName : 'google Sign In Account Display Name',
      googleSignInAuthenticationIdToken : 'google Sign In Authentication Id Token',
      googleSignInAuthenticationAccessToken : 'google Sign In Authentication Access Token',
    );

    return _model;

  }
  // -----------------------------------------------------------------------------
}
