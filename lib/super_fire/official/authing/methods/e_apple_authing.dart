part of super_fire;

/*

  CONFIGURATIONS

- IOS 13+
- add Apple as auth provider in firebase console
- add "Sign in with Apple" in xCode/Runner/Signing & Capabilities/+ Capability/Sign in with Apple
- make sure it is added under all - debug - release - profile

 */

/// => TAMAM
class AppleAuthing {
  // -----------------------------------------------------------------------------

  const AppleAuthing();

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
