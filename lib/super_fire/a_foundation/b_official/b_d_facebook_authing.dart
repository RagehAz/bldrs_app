part of super_fire;

/*


/// FACEBOOK DEVELOPER DASHBOARD URL
https://developers.facebook.com/apps/?show_reminder=true

/// SETUP ON ANDROID

1 - open new app facebook developer account
2 - start doing Android
3 - skip download the facebook SDK
4 - assure u r using mavenCentral() under buildscript and allprojects in android/build.gradle
5 - put [ implementation 'com.facebook.android:facebook-android-sdk:latest.release' ] in
dependencies in  android/app/build.gradle,, ref : TalkToHumanity // USED_FOR_FACEBOOK_AUTH
6 - add package name com.example.example and com.example.example.MainActivity in fc dashboard
sequence
7 - get your key hashes and put in in dashboard sequence
  7a - download opensssl 64 from https://code.google.com/archive/p/openssl-for-windows/downloads
  7b - extract openssl in C:\Users\rageh\openssl
  7c - get android debugkey
    7c1 - cd android "from project terminal" to run below line
    7c2 - run this : D:\projects\bldrs\talktohumanity\android> .\gradlew signingreport
    7c3 - make sure that C:\Users\rageh\.android\debug.keystore is correct path for debugKeystore
  7d - run the below command in command prompt cmd
    7d1 - keytool -exportcert -alias androiddebugkey -keystore "C:\Users\rageh\.android\debug.keystore" | "C:\Users\rageh\openssl\bin\openssl" sha1 -binary | "C:\Users\rageh\openssl\bin\openssl" base64
    7d2 - enter keystore password : 'same as my windows pin'
  7e - add the generated key Hash to 'Release Key Hashes' in facebook dashboard sequence
8 - and set single sign on to "yes" in facebook dashboard sequence
9 - create strings.xml in .../android/app/src/main/res/values/strings.xml
  9a - see TalkToHumanity for reference.
  9b - get AppID from facebookDev-dashboard-Settings-Basic
  9c - get facebook_client_token from facebookDev-dashboard-Settings-Advanced-Security-Client Token

10 - modify android/app/src/main/AndroidManifest.xml
  10a - add xmlns:tools="http://schemas.android.com/tools" line 3,, see TalkToHumanity
  10b - assure there are <uses-permission android:name="android.permission.INTERNET" /> line
  10c - add this line under the "uses-permission" <uses-permission android:name="com.google.android.gms.permission.AD_ID" tools:node="remove"/>
  10d - copy the last 16 lines in TalkToHumanity as is
11 - add flutter_facebook_auth package in pubspec.yaml
12 - add facebook sign-in method in authentication in firebase
  12a - get App ID & App secret from facebookDev-dashboard-Settings-Basic

 */

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
          await OfficialAuthing.getFirebaseAuth().signInWithCredential(_facebookAuthCredential);

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
