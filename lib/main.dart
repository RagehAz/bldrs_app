import 'dart:async';

import 'package:basics/animators/helpers/app_scroll_behavior.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/checks/device_checker.dart';
import 'package:basics/helpers/classes/checks/errorize.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/mediator/sounder/sounder.dart';
import 'package:bldrs/a_models/e_notes/c_channel_model.dart';
import 'package:bldrs/c_protocols/app_initialization_protocols/a_initializer.dart';
import 'package:bldrs/c_protocols/auth_protocols/auth_protocols.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm_starter.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_providers.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/router/b_static_router.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'bldrs_keys.dart';

// ---------------------------------------------------------------------------

Future<void> main() async {
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
          await Initializer.initializeBldrs(binding);
          // --------------------
        },
    );
  }
  // --------------------
  else {
    // --------------------
    final WidgetsBinding _binding = WidgetsFlutterBinding.ensureInitialized();
    await Initializer.initializeBldrs(_binding);
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

// ---------------------------------------------------------------------------

class BldrsAppStarter extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BldrsAppStarter({
    super.key
  });
  /// --------------------------------------------------------------------------
  static void setLocale(BuildContext? context, Locale? locale) {

    if (locale != null){
      final _BldrsAppStarterState? state = context?.findAncestorStateOfType<_BldrsAppStarterState>();
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
        onGenerateRoute: StaticRouter.router,
        // initialRoute: RouteName.staticLogo,
        // routes: Routing.routesMap,
      ),
    );

  }
  // -----------------------------------------------------------------------------
}

// ---------------------------------------------------------------------------
