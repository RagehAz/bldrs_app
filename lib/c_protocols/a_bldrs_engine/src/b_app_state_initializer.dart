part of bldrs_engine;

/// => TAMAM
class _AppStateInitializer {
  // -----------------------------------------------------------------------------

  const _AppStateInitializer();

  // -----------------------------------------------------------------------------

  /// APP STATE INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> initialize() async {

    const bool _isDebug = false; // kDebugMode

    bool _canLoadApp = _isDebug;

    /// GET GLOBAL STATE
    final AppStateModel? _globalState = await AppStateProtocols.fetchGlobalAppState();

    // blog('the _globalState : $_globalState');

    /// ON LOADING FAILED OP
    bool _continue = await _globalStateExistsOps(globalState: _globalState);

    if (_continue == true && _isDebug == false){

        /// APP IS ONLINE CHECKUP
        _continue = await _appIsOnlineCheckOps(globalState: _globalState!);
        if (_continue == true && _isDebug == false){

          final String _detectedVersion = await AppVersionBuilder.detectAppVersion();

          /// FORCE UPDATE APP OP
          _continue = await _forceUpdateCheckOps(
            globalState: _globalState,
            detectedVersion: _detectedVersion,
          );

          if (_continue == true && _isDebug == false){

            /// ENDORSE UPDATE APP OP
            _continue = await _endorseUpdateCheckOps(
              globalState: _globalState,
              detectedVersion: _detectedVersion,
            );

            if (_continue == true && _isDebug == false){

              unawaited(_superWipeLDBIfDecidedByRage7(
                globalState: _globalState,
              ));

              /// NOW WE CAN LOAD THE APP
              _canLoadApp = true;

            }

          }
        }

      }

    return _canLoadApp;
  }
  // -----------------------------------------------------------------------------

  /// CHECK OPS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> _globalStateExistsOps({
    required AppStateModel? globalState,
  }) async {
    bool _output = false;

    /// GLOBAL STATE IS GOOD
    if (globalState != null && globalState.appVersion != null) {
      _output = true;
    }

    /// INTERNET COULDN'T GET GLOBAL STATE
    else {

      await Dialogs.somethingWentWrongAppWillRestart();

      /// create_reboot_system_method
      await Routing.goTo(route: ScreenName.logo);

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> _appIsOnlineCheckOps({
    required AppStateModel globalState,
  }) async {
    bool _output = false;

    /// BLDRS IS ONLINE
    if (globalState.bldrsIsOnline == true){
      _output = true;
    }

    /// BLDRS IS UNDER CONSTRUCTION
    else {
      await Routing.goTo(route: ScreenName.underConstruction);
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> _forceUpdateCheckOps({
    required AppStateModel globalState,
    required String detectedVersion,
  }) async {
    bool _output = false;

    if (kIsWeb == true){
      _output = true;
    }

    else {

      final bool _mustUpdate = AppVersionBuilder.versionIsBigger(
        thisIsBigger: globalState.minVersion,
        thanThis: detectedVersion,
      );

      /// MUST UPDATE
      if (_mustUpdate == true){

        /// TEMPORARY UNTIL APP BECOMES MORE STABLE
        unawaited(LDBOps.deleteAllMapsAtOnce(docName: LDBDoc.accounts));

        await BldrsCenterDialog.showCenterDialog(
          titleVerse:  getVerse('phid_newUpdateAvailable'),
          bodyVerse: Verse.plain(
'''
${getWord('phid_pleaseUpdateToContinue')}
${getWord('phid_your_version')} : $detectedVersion
${getWord('phid_new_version')} : ${globalState.appVersion}
'''
        ),
        confirmButtonVerse: getVerse('phid_updateApp'),
        canExit: false,
        onOk: () async {

          await Launcher.launchBldrsAppLinkOnStore();

        }
        // boolDialog: false,

      );

      }

      /// CAN CONTINUE WITHOUT UPDATE
      else {
        _output = true;
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> _endorseUpdateCheckOps({
    required AppStateModel globalState,
    required String detectedVersion,
  }) async {
    bool _output = true;

    if (kIsWeb == true){
      _output = true;
    }

    else {

      final bool _mayUpdate = AppVersionBuilder.versionIsBigger(
        thisIsBigger: globalState.appVersion,
        thanThis: detectedVersion,
      );

      // blog('should show center dialog _mayUpdate : $_mayUpdate : ${globalState.appVersion} > $detectedVersion ?');

      /// MUST UPDATE
      if (_mayUpdate == true){

        await BldrsCenterDialog.showCenterDialog(
          titleVerse:  getVerse('phid_newUpdateAvailable'),
          bodyVerse: Verse.plain(
'''
${getWord('phid_pleaseUpdateToContinue')}
${getWord('phid_your_version')} : $detectedVersion
${getWord('phid_new_version')} : ${globalState.appVersion}
'''
          ),
          confirmButtonVerse: getVerse('phid_updateApp'),
          boolDialog: true,
          noVerse: getVerse('phid_skip'),
          onOk: () async {
            blog('wtf is this why no work');
            _output = false;
            await Launcher.launchBldrsAppLinkOnStore();
            },
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _superWipeLDBIfDecidedByRage7({
    required AppStateModel globalState,
  }) async {

    final Map<String, dynamic>? _localLDBVersionMap = await LDBOps.readMap(
      docName: 'ldbVersion',
      id: 'ldb',
      primaryKey: 'id',
    );

    final int? _localLDBVersion = _localLDBVersionMap?['ldbVersion'];

    if (globalState.ldbVersion != _localLDBVersion){

      await LDBDoc.onHardRebootSystem();

      await LDBOps.insertMap(
        docName: 'ldbVersion',
        primaryKey: 'id',
        input: {
          'id': 'ldb',
          'ldbVersion': globalState.ldbVersion,
        },
      );

    }

  }
  // -----------------------------------------------------------------------------
}
