part of super_fire;

class FirebaseInitializer {
  // -----------------------------------------------------------------------------

  /// NativeAuth SINGLETON

  // --------------------
  FirebaseInitializer.singleton();
  static final FirebaseInitializer _singleton = FirebaseInitializer.singleton();
  static FirebaseInitializer get instance => _singleton;
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// use official firebase packages or Native dart implementation packages
  bool _usesOfficial = true;
  bool get usesOfficial => _usesOfficial;
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool isUsingOfficialPackages() => FirebaseInitializer.instance.usesOfficial;
  // -----------------------------------------------------------------------------
  /// TASK : TEST ME
  Future<void> _initialize({
    @required bool useOfficialPackages,
    @required FirebaseOptions options,
    @required SocialKeys socialKeys,
    @required String nativePersistentStoragePath,
    @required String appName,
  }) async {

    _usesOfficial = useOfficialPackages;

    /// OFFICIAL
    if (useOfficialPackages == true){
      await _OfficialFirebase.initialize(
        appName: appName,
        options: options,
        socialKeys: socialKeys,
      );
    }

    /// NATIVE
    else {
      await _NativeFirebase.initialize(
        appName: appName,
        options: options,
        persistentStoragePath: nativePersistentStoragePath,
      );
    }

  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> initialize({
    @required bool useOfficialPackages,
    @required FirebaseOptions options,
    @required SocialKeys socialKeys,
    String appName,
    String nativePersistentStoragePath,
  }) async {

    await FirebaseInitializer.instance._initialize(
      useOfficialPackages: useOfficialPackages,
      socialKeys: socialKeys,
      options: options,
      nativePersistentStoragePath: nativePersistentStoragePath,
      appName: appName,
    );

  }
  // -----------------------------------------------------------------------------
}
