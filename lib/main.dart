import 'dart:async';
import 'package:basics/animators/helpers/app_scroll_behavior.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/checks/device_checker.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/mediator/sounder/sounder.dart';
import 'package:bldrs/a_models/e_notes/c_channel_model.dart';
import 'package:bldrs/c_protocols/auth_protocols/auth_protocols.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/e_back_end/e_fcm/background_msg_handler.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm_starter.dart';
import 'package:bldrs/e_back_end/i_app_check/app_check.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_providers.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/router/routing.dart';
import 'package:bldrs/firebase_options.dart';
import 'package:device_preview/device_preview.dart';
import 'package:fire/super_fire.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'bldrs_keys.dart';

// ---------------------------------------------------------------------------

Future<void> main() async {
  // -----------------------------------------------------------------------------
  /*
    /// PLAN : In optimization : study this : https://pub.dev/packages/keframe
    // debugPrintMarkNeedsPaintStacks = false;
    // debugProfilePaintsEnabled = false;
    // debugProfileBuildsEnabled = false;
    // debugRepaintTextRainbowEnabled = false;
    // debugPaintLayerBordersEnabled = false;
    // debugRepaintRainbowEnabled = false;
    // debugPrintLayouts = true;
  */
  // --------------------
  /// insures awaiting async methods below to finish then continue
  final WidgetsBinding _binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: _binding);
  // --------------------
  await FirebaseInitializer.initialize(
    useOfficialPackages: !DeviceChecker.deviceIsWindows(),
    socialKeys: BldrsKeys.socialKeys,
    options: DefaultFirebaseOptions.currentPlatform!,
    // nativePersistentStoragePath: ,
  );
  // --------------------
  FirebaseMessaging.onBackgroundMessage(bldrsAppOnBackgroundMessageHandler);
  // --------------------
  await Future.wait(<Future>[

    /// FCM
    FCMStarter.preInitializeNootsInMainFunction(
      channelModel: ChannelModel.bldrsChannel,
    ),

    /// APP CHECK
    AppCheck.preInitialize(),

    // /// GOOGLE ADS
    // GoogleAds.initialize(),

  ]);
  // --------------------
  /*
  FlutterError.onError = (errorDetail){
    blog('XXX === >>> FlutterError : CRASH');
    FirebaseCrashlytics.instance.recordFlutterError(errorDetail);
  };
  PlatformDispatcher.instance.onError = (error, stack){
    blog('XXX === >>> PlatformDispatcher : CRASH');
    FirebaseCrashlytics.instance.recordError(error, stack,
      fatal: true,
      // information: ,
      // printDetails: ,
      // reason: ,
    );
    return true;
  };
   */
  // --------------------
  /// DEVICE PREVIEW
  // runApp(
  //   DevicePreview(
  //     /// ignore: avoid_redundant_argument_values
  //     enabled: false,
  //     builder: (context) => const BldrsAppStarter(),
  //   ),
  // );
  // --------------------
  /// SENTRY
  await sentryBldrs();
  /// -----------------------------------------------------------------------------
}

// ---------------------------------------------------------------------------

const bool useSentryOnDebug = false;

Future<void> sentryBldrs() async {

  const bool _runSentry = useSentryOnDebug == true ? true : !kDebugMode;

  if (_runSentry == true) {

    final pkg = await PackageInfo.fromPlatform();
    blog('XXX === >>> sentry is launching x');

    await SentryFlutter.init(
          (options) async {
            const String _thing = 'https://1c1d8068e888994cfeee26f0dfaafcd6@o4505718555213824.ingest.sentry.io/4505718558883840';
            // final release = AppPatcher.fullVersion;
            options.dsn = _thing; //AppConstants.sentryDsn;
            options.release = pkg.version;
            options.sendDefaultPii = true;
            options.environment = 'production';
            options.attachScreenshot = true;
            options.beforeSend = (SentryEvent? event,{Hint? hint}) async {
              blog('XXX === >>> CRASH');
              blog('crash event : culprit : ${event?.culprit} : message : ${event?.message}');
              return event;
            };
            },
      appRunner: () async {

            /// SENTRY CONFIGURATIONS
            Sentry.configureScope(
                  (scope) async {

                    late final BaseDeviceInfo deviceInfo;

                    if (DeviceChecker.deviceIsAndroid() == true) {
                      deviceInfo = await DeviceChecker.getDeviceInfoPlugin().androidInfo;
                    }
                    else if (DeviceChecker.deviceIsIOS() == true){
                      deviceInfo = await DeviceChecker.getDeviceInfoPlugin().iosInfo;
                    }
                    else if (kIsWeb == true){
                      deviceInfo = await DeviceChecker.getDeviceInfoPlugin().webBrowserInfo;
                    }
                    else if (DeviceChecker.deviceIsWindows() == true){
                      deviceInfo = await DeviceChecker.getDeviceInfoPlugin().windowsInfo;
                    }
                    else {

                    }

                    await scope.setContexts('device_info', deviceInfo.data);
                    final packageInfoAsMap = <String, String>{
                      'packageName': pkg.packageName,
                      'appName': pkg.appName,
                      'buildNumber': pkg.buildNumber,
                      'buildSignature': pkg.buildSignature,
                      'version': pkg.version,
                    };
                    await scope.setContexts('package_info', packageInfoAsMap);},
            );

            /// RUN
            return runApp(
              DefaultAssetBundle(
                bundle: SentryAssetBundle(),
                child: const SentryScreenshotWidget(
                  child: BldrsAppStarter(),
                ),
              ),
            );
            },
    );
  }

  else {
    runApp(const BldrsAppStarter());
  }

}

// ---------------------------------------------------------------------------

class BldrsAppStarter extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BldrsAppStarter({
    super.key
  });
  /// --------------------------------------------------------------------------
  static void setLocale(BuildContext context, Locale? locale) {

    if (locale != null){
      final _BldrsAppStarterState? state = context.findAncestorStateOfType<_BldrsAppStarterState>();
      state?._setLocale(locale);
    }

  }
  /// --------------------------------------------------------------------------
  @override
  _BldrsAppStarterState createState() => _BldrsAppStarterState();
  /// --------------------------------------------------------------------------
}

class _BldrsAppStarterState extends State<BldrsAppStarter> with WidgetsBindingObserver {
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    if (kIsWeb == false){
      FlutterNativeSplash.remove();
    }
    WidgetsBinding.instance.addObserver(this);
    blog('XXX === >>> APP START');
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      _triggerLoading(setTo: true).then((_) async {

        if (DeviceChecker.deviceIsWindows() == true){
          await AuthProtocols.signInAsRage7(context: context);
        }

        /// INITIALIZE NOOTS
        await FCMStarter.initializeNootsInBldrsAppStarter(
          channelModel: ChannelModel.bldrsChannel,
        );
        // /// NOOT LISTENERS
        // _initializeNootListeners();

        /// END
        await _triggerLoading(setTo: false);

      });
    }

    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    // Sembast.dispose(); async function,, and no need to close sembast I guess
    Sounder.dispose();
    // _closeNootListeners();
    FCM.disposeAwesomeNoots();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  // --------------------
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

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

    super.didChangeAppLifecycleState(state);
  }
  // -----------------------------------------------------------------------------
  /// DEPRECATED
  /*
  /// NOOT STREAMS

  // --------------------
  StreamSubscription? _action;
  StreamSubscription? _created;
  StreamSubscription? _dismissed;
  StreamSubscription? _displayed;
  // --------------------
  void _initializeNootListeners() {
    if (FCMStarter.canInitializeFCM() == true) {
      _action = NootListener.listenToNootActionStream();
      _created = NootListener.listenToNootCreatedStream();
      // _dismissed = NootListener.listenToNootDismissedStream(); Unhandled Exception: Bad state: Stream has already been listened to.
      _displayed = NootListener.listenToNootDisplayedStream();
    }
  }
  // --------------------
  void _closeNootListeners(){
    if (FCMStarter.canInitializeFCM() == true) {
      _action?.cancel();
      _created?.cancel();
      _dismissed?.cancel();
      _displayed?.cancel();
    }
  }
   */
  // -----------------------------------------------------------------------------

  /// LOCALE

  // --------------------
  Locale? _locale;
  // --------------------
  void _setLocale(Locale? locale) {

    if (mounted == true && locale != null){
      setState(() {
        _locale = locale;
      });
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return BldrsProviders(
      child: MaterialApp(
        /// KEYS
        // key: ,
        // scaffoldMessengerKey: ,
        // restorationScopeId: ,
        // useInheritedMediaQuery: true,

        /// DUNNO
        // actions: ,

        builder: DevicePreview.appBuilder,

        // home: ,
        // useInheritedMediaQuery: ,
        // shortcuts: ,
        scrollBehavior: const AppScrollBehavior(),

        /// DEBUG
        debugShowCheckedModeBanner: false,
        // debugShowMaterialGrid: false,
        // showPerformanceOverlay: false,
        // checkerboardRasterCacheImages: false,
        // showSemanticsDebugger: ,
        // checkerboardOffscreenLayers: ,

        /// THEME
        title: 'Bldrs.net',
        // onGenerateTitle: ,
        // color: ,
        // darkTheme: ,
        // highContrastDarkTheme: ,
        // highContrastTheme: ,
        // themeMode: ,
        theme: ThemeData(
          canvasColor: Colorz.nothing,
          textSelectionTheme: const TextSelectionThemeData(
            selectionHandleColor: Colorz.yellow255,
            selectionColor: Colorz.white50,
          ),
        ),

        /// LOCALE
        locale: _locale,
        supportedLocales: Localizer.getSupportedLocales(),
        localizationsDelegates: Localizer.getLocalizationDelegates(),
        localeResolutionCallback: Localizer.localeResolutionCallback,
        // localeListResolutionCallback: ,
        /// ROUTES
        // navigatorObservers: [],
        // onGenerateInitialRoutes: ,
        // onUnknownRoute: ,
        // home: ,
        navigatorKey: mainNavKey,
        // onGenerateRoute: Routing.allRoutes,
        initialRoute: Routing.staticLogoScreen,
        routes: Routing.routesMap,
      ),
    );

  }
  // -----------------------------------------------------------------------------
}

// ---------------------------------------------------------------------------
