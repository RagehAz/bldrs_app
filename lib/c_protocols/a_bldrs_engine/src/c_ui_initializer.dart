part of bldrs_engine;

/// => TAMAM
class UiInitializer {
  // -----------------------------------------------------------------------------

  const UiInitializer();

  // -----------------------------------------------------------------------------

  /// LOADING VERSE

  // --------------------
  /// TESTED : WORKS PERFECT
  static void setLoadingVerse(String? text){
    UiProvider.proSetLoadingVerse(verse: Verse.plain(text));
  }
  // -----------------------------------------------------------------------------

  /// APP LANGUAGE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> initializeAppLanguage({
    required BuildContext context,
    required bool mounted,
  }) async {

    String? _lang = await Localizer.readLDBLangCode();

    _lang ??= await Dialogs.languageDialog();
    _lang ??= 'en';

    if (mounted == true){
      await Localizer.changeAppLanguage(
        code: _lang,
        context: context,
      );
    }

  }
  // -----------------------------------------------------------------------------

  /// CLOCK

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> initializeClock({
    required bool mounted,
}) async {
    bool _good = true;

    const bool doTheClockCheck = false;

    if (mounted == true && doTheClockCheck == true){

        /// CHECK DEVICE CLOCK
        bool _deviceTimeIsCorrect = await BldrsTimers.checkDeviceTimeIsCorrect(
          context: getMainContext(),
          showIncorrectTimeDialog: true,
          canThrowError: true,
        );

        /// OVERRIDE : FOR WEB AND WINDOWS
        if (
            _deviceTimeIsCorrect == true ||
            kIsWeb == true ||
            DeviceChecker.deviceIsWindows() == true
        ){
          _good = true;
        }
        else {

          await Future.delayed(const Duration(seconds: 5));

          _deviceTimeIsCorrect = await BldrsTimers.checkDeviceTimeIsCorrect(
            context: getMainContext(),
            showIncorrectTimeDialog: false,
            canThrowError: false,
          );

          if (_deviceTimeIsCorrect == true){
            _good = true;
          }

          else {
            await Routing.goTo(route: ScreenName.logo);
            _good = false;
          }

        }

    }

    return _good;
  }
  // -----------------------------------------------------------------------------

  /// SCREEN DIM - ICONS - PHRASES

  // --------------------
  // /// TESTED : WORKS PERFECT
  // static Future<void> initializeIconsAndPhrases() async {
  //
  //
  //
  //
  //
  //
  //   await Future.wait([
  //
  //     GeneralProvider.proGetSetLocalAssetsPaths(notify: true),
  //
  //     PhraseProtocols.generateCountriesPhrases(),
  //
  //   ]);
  //
  // }
  // -----------------------------------------------------------------------------

  /// LDB REFRESH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> refreshLDB() async {

    await _monitorRefreshLDBThing();

    final bool _shouldRefresh = await LDBOps.checkShouldRefreshLDB(
      refreshDurationInMinutes: Standards.ldbWipeIntervalInMinutes,
    );

    if (_shouldRefresh == true){

      await Future.wait(<Future>[

        Director.wipeAllDirectoriesAndCaches(),

        LDBDoc.wipeOutLDBDocs(
          /// MAIN
          flyers: true, /// flyers are updated frequently
          bzz: true, /// bzz might be updated frequently
          notes: false, // I do not think we need to refresh notes everyday
          media: true, /// pics of logos - users - flyers might change over time
          pdfs: false, // i do not think that fetched pdfs are changed frequently by authors,
          superFiles: true,
          /// USER
          users: true, // users might change their profile info
          authModel: false, // need my authModel to prevent re-auth everyday
          accounts: false, // keep accounts until user decides to not "remember me trigger"
          searches: false,
          /// CHAIN
          bldrsChains: false, // keep the chains man, if chains updated - appState protocols handles this
          pickers: false, // same as chains
          /// ZONES
          countries: true, // countries include staging info, so lets refresh that daily
          cities: false, // cities do not change often
          staging: true, // staging info changes frequently
          census: true, // might need faster refresh aslan
          /// PHRASES
          allKeywordsPhrasesInAllLangs: false,
          keywords: false,
          zonePhids: true,// yes should be refreshed frequently to listen to new flyers
          countriesPhrases: false,
          /// EDITORS
          userEditor: false, // keep this for user to find later anytime
          bzEditor: false, // keep this as well
          authorEditor: false, // keep
          flyerMaker: false, // keep
          reviewEditor: false, // keep
          /// SETTINGS
          theLastWipe: false, // no need to wipe
          appState: true,
          langCode: false, // no need to wipe
          // langMaps: false, // no need to wipe
          onboarding: false,
          /// DASHBOARD
          gta: false, // this is for dashboard
          webpages: false, // this is for dashboard
          noteCampaigns: false, // dashboard
          /// COUNTERS
          bzzCounters: true, // this stays for 10 minutes anyways
          flyersCounters: true, // this stays for 10 minutes anyways
          usersCounters: true, // this stays for 10 minutes anyways
        ),

      ]);



    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _monitorRefreshLDBThing() async {

    if (kDebugMode == true){

      final List<Map<String, dynamic>> _maps = await LDBOps.readMaps(
        ids: ['theLastWipeMap'],
        docName: 'theLastWipeMap',
        primaryKey: 'id',
      );

      // ignore: unused_local_variable
      bool _shouldRefresh = false;
      double? _diff;
      DateTime? _lastWipe;

      if (Lister.checkCanLoop(_maps) == true){

        _lastWipe = Timers.decipherTime(
          time: _maps.first['time'],
          fromJSON: true,
        );

        _diff = Timers.calculateTimeDifferenceInMinutes(
          from: _lastWipe,
          to: DateTime.now(),
        ).toDouble();

        _diff = Numeric.modulus(_diff);

        /// ONLY WHEN NOT EXCEEDED THE TIME SHOULD NOT REFRESH
        if (_diff != null && _diff < Standards.ldbWipeIntervalInMinutes){
          _shouldRefresh = false;
        }
        else {
          _shouldRefresh = true;
        }

      }

      // blog('checkShouldRefreshLDB : $_shouldRefresh');

//       blog('''
// _diff Minutes
//
// Last Wipe : $_lastWipe
//
// ($_diff) < (${Standards.ldbWipeIntervalInMinutes}) >  = (${Numeric.isLesserThan(number: Standards.ldbWipeIntervalInMinutes, isLesserThan: _diff)}))
//             ''');

    }

  }
  // -----------------------------------------------------------------------------

  /// ONBOARDING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> initializeOnBoarding({
    required bool mounted,
  }) async {

    if (mounted == true){

      final bool autoOnBoardingIsActive = await OnBoardingScreen.autoOnBoardingIsActive();

        if (autoOnBoardingIsActive == true){

          await OnBoardingScreen.goToOnboardingScreen(
            showDontShowAgainButton: true,
          );

        }

    }

  }
  // -----------------------------------------------------------------------------
}
