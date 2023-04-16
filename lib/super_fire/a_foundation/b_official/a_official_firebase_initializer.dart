part of super_fire;

class OfficialFirebaseInitializer {
  // -----------------------------------------------------------------------------

  const OfficialFirebaseInitializer();

  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> initialize({
    @required FirebaseOptions options,
    @required SocialKeys socialKeys,
  }) async {

    if (DeviceChecker.deviceIsWindows() == false) {
      await tryAndCatch(
        functions: () async {

          /// IOS - ANDROID - WEB : NO WINDOWS SUPPORT
          await Firebase.initializeApp(
            options: options,
          );

          OfficialAuthing.initializeSocialAuthing(
            socialKeys: socialKeys,
          );

        },
      );
    }

  }
  // -----------------------------------------------------------------------------
}
