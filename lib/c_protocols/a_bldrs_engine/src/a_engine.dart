part of bldrs_engine;
/// => TAMAM
class BldrsEngine {
  // --------------------------------------------------------------------------

  const BldrsEngine();

  // --------------------------------------------------------------------------

  /// MAIN

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> mainIgnition() async {
    // -----------------------------------------------------------------------------
    /// PLAN : In optimization : study this : https://pub.dev/packages/keframe
    // --------------------
    const bool useSentryOnDebug = false;
    const bool _runSentry = useSentryOnDebug == true ? true : !kDebugMode;
    // --------------------
    if (_runSentry == true){
      await Sentrize.initializeApp(
        app: const BldrsAppStarter(),
        dns: BldrsKeys.sentryDSN,
        functions: (WidgetsBinding binding) async {
          // --------------------
          await initializeBldrs(binding);
          // --------------------
        },
      );
    }
    // --------------------
    else {
      // --------------------
      final WidgetsBinding _binding = WidgetsFlutterBinding.ensureInitialized();
      await initializeBldrs(_binding);
      // --------------------
      runApp(const BldrsAppStarter());
      // --------------------
      /// DEVICE PREVIEW
      /*
    // runApp(
    //   DevicePreview(
    //     /// ignore: avoid_redundant_argument_values
    //     enabled: false,
    //     builder: (context) => const BldrsAppStarter(),
    //   ),
    // );
    */
      // --------------------
    }
    // -----------------------------------------------------------------------------
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> initializeBldrs(WidgetsBinding binding) async {
    // --------------------
    final bool _isSmartPhone = DeviceChecker.deviceIsSmartPhone();
    // --------------------
    if (kIsWeb == false) {
      FlutterNativeSplash.preserve(widgetsBinding: binding);
    }
    // --------------------
    await FirebaseInitializer.initialize(
      useOfficialPackages: !DeviceChecker.deviceIsWindows(),
      socialKeys: BldrsKeys.socialKeys,
      options: DefaultFirebaseOptions.currentPlatform!,
      realForceOnlyAuthenticated: true,
      // nativePersistentStoragePath: ,
    );
    // --------------------
    if (_isSmartPhone == true){
      FirebaseMessaging.onBackgroundMessage(bldrsAppOnBackgroundMessageHandler);
    }
    // --------------------
    await Future.wait(<Future>[

      /// FCM
      if (_isSmartPhone == true)
        FCMStarter.preInitializeNootsInMainFunction(
          channelModel: ChannelModel.bldrsChannel,
        ),

      /// APP CHECK
      AppCheck.preInitialize(),

      /// GOOGLE ADS
      // GoogleAds.initialize(),

    ]);
    // --------------------
  }
  // --------------------------------------------------------------------------

  /// APP STARTER

  // --------------------
  /// TESTED : WORKS PERFECT
  static void appStartPreInit({
    required WidgetsBindingObserver observer,
  }){
    /// NOTE : No providers can be initialized here

    blog('XXX === >>> APP START');

    /// NATIVE SPLASH SCREEN
    if (kIsWeb == false){
      FlutterNativeSplash.remove();
    }

    /// WIDGET BINDING OBSERVER
    WidgetsBinding.instance.addObserver(observer);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> appStartInit() async {

    // /// REFRESH LDB
    // unawaited(UiInitializer.refreshLDB());

    /// INITIALIZE NOOTS
    await FCMStarter.initializeNootsInBldrsAppStarter(
      channelModel: ChannelModel.bldrsChannel,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void appStartDispose({
    required WidgetsBindingObserver observer,
  }){
    // Sembast.dispose(); async function,, and no need to close sembast I guess
    // _closeNootListeners();
    Sounder.dispose();
    FCM.disposeAwesomeNoots();
    WidgetsBinding.instance.removeObserver(observer);
    superLocale.dispose();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void appLifeCycleListener(AppLifecycleState state){

    if (state == AppLifecycleState.resumed) {
      blog('XXX === >>> RESUMED');
    }
    else if (state == AppLifecycleState.inactive) {
      blog('XXX === >>> INACTIVE');
    }
    else if (state == AppLifecycleState.paused) {
      blog('XXX === >>> PAUSED');
    }
    else if (state == AppLifecycleState.detached) {
      blog('XXX === >>> DETACHED');
    }

  }
  // --------------------------------------------------------------------------

  /// LOGO

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> logoScreenRouting({
    required bool mounted,
  }) async {

    // final String url = window.location.toString();
    // final String? _routeSettingsName = RoutePather.getRouteSettingsNameFromFullPath(url);
    // blog('logoScreenRouting : url : $url');
    // blog('logoScreenRouting : kIsWeb : $kIsWeb');
    // blog('logoScreenRouting : path : ${RoutePather.getPathFromWindowURL(url)}');
    // blog('logoScreenRouting : routeSettingsName : $_routeSettingsName');
    // blog('logoScreenRouting : path2 : ${RoutePather.getPathFromRouteSettingsName(_routeSettingsName)}');
    // blog('logoScreenRouting : args : ${RoutePather.getArgFromRouteSettingsName(_routeSettingsName)}');

    if (mounted == true){

      /// MOBILE - WINDOWS
      if (kIsWeb == false){
        await Routing.goTo(route: ScreenName.home);
      }

      /// WEB : WHERE THERE IS A URL
      else {

        final String _url = window.location.toString();

        final String? _path = RoutePather.getPathFromWindowURL(_url);

        /// LANDED ON LOGO SCREENS OR ON HOME SCREEN
        if (_path == ScreenName.logo || _path == ScreenName.home){
          await Routing.goTo(route: ScreenName.home);
        }

        else {

          final String? _routeSettingsName = RoutePather.getRouteSettingsNameFromFullPath(_url);

          await Routing.restartToAfterHomeRoute(
            routeName: RoutePather.getPathFromRouteSettingsName(_routeSettingsName),
            arguments: RoutePather.getArgFromRouteSettingsName(_routeSettingsName),
          );

        }

      }

    }

  }
  // --------------------------------------------------------------------------

  /// HOME

  // --------------------
  /// TESTED : WORKS PERFECT
  static void homePreInit({
    required TickerProvider vsync,
  }){

    /// TAB BAR CONTROLLER
    HomeProvider.proInitializeTabBarController(
      context: getMainContext(),
      vsync: vsync,
    );

    /// KEYBOARD
    UiProvider.proInitializeKeyboard();

    /// HOME GRID
    HomeProvider.proInitializeHomeGrid(
      vsync: vsync,
      mounted: true,
    );

    /// MIRAGES
    HomeProvider.proInitializeMirages();

    /// LAYOUT IS VISIBLE
    UiProvider.proSetLayoutIsVisible(
      setTo: true,
      notify: true,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> homeInit({
    required BuildContext context,
    required bool mounted,
  }) async {

    /// CLOSE KEYBOARD
    unawaited(Keyboard.closeKeyboard());

    /// APP LANGUAGE
    await UiInitializer.initializeAppLanguage(
      context: context,
      mounted: mounted,
    );

    /// COUNTRIES PHRASES
    unawaited(CountriesPhrasesProtocols.generateCountriesPhrases());
    // /// KEYWORDS PHRASES
    // unawaited(KeywordsPhrasesProtocols.fetchAll(
    //     langCode: Localizer.getCurrentLangCode(),
    // ));

    unawaited(
                        /// APP STATE
                        _AppStateInitializer.initialize()
                        /// ON BOARDING
      .then((value) =>  UiInitializer.initializeOnBoarding(mounted: mounted))
                        /// AUTO NAV
      .then((value) =>  Routing.autoNavigateToAfterHomeRoute(mounted: mounted))
                        /// DYNAMIC LINKS
      .then((value) =>  DynamicLinks.initDynamicLinks(mounted: mounted))
                        /// APP LANGUAGE
      .then((value) =>  UiInitializer.initializeClock(mounted: mounted))
    );


    /// USER
    await UserInitializer.initialize();

    /// LET THE ZONE INITIALLY BE THE PLANET
    await ZoneProvider.proSetCurrentZone(
        zone: null, // UsersProvider.proGetUserZone(context: context, listen: false),
    );

    /// BZ STREAMS
    HomeProvider.proInitializeMyBzzStreams();

    /// NOTIFICATIONS
    await NotesProvider.proInitializeNoteStreams(mounted: mounted);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void homeDispose(){
    HomeProvider.proDisposeTabBarController();
    UiProvider.disposeKeyword();
    HomeProvider.proDisposeHomeGrid();
    NotesProvider.disposeNoteStreams();
    HomeProvider.proDisposeMirages();
    HomeProvider.proDisposeMyBzzStreams();
  }
  // --------------------------------------------------------------------------
}
