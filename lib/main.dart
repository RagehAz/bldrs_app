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
import 'package:bldrs/e_back_end/e_fcm/z_noot_controller.dart';
import 'package:bldrs/e_back_end/i_app_check/app_check.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_providers.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/router/routing.dart';
import 'package:bldrs/firebase_options.dart';
import 'package:device_preview/device_preview.dart';
import 'package:fire/super_fire.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'bldrs_keys.dart';

Future<void> main() async {
  /// -----------------------------------------------------------------------------
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
  /// --------------------
  runApp(
    DevicePreview(
      /// ignore: avoid_redundant_argument_values
      enabled: false,
      builder: (context) => const BldrsAppStarter(),
    ),
  );
  /// -----------------------------------------------------------------------------
}

// ---------------------------------------------------------------------------

class BldrsAppStarter extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BldrsAppStarter({
    super.key
  });
  /// --------------------------------------------------------------------------
  static void setLocale(BuildContext context, Locale? locale) {
    if (locale == null) {
      return;
    }
    final _BldrsAppStarterState? state = context.findAncestorStateOfType<_BldrsAppStarterState>();
    state?._setLocale(locale);
  }
  /// --------------------------------------------------------------------------
  @override
  _BldrsAppStarterState createState() => _BldrsAppStarterState();
  /// --------------------------------------------------------------------------
}

class _BldrsAppStarterState extends State<BldrsAppStarter> {
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
    FlutterNativeSplash.remove();
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

        /// LOCALE
        await Localizer.initializeLocale(
          locale: _locale,
          mounted: mounted,
        );

        /// INITIALIZE NOOTS
        await FCMStarter.initializeNootsInBldrsAppStarter(
          channelModel: ChannelModel.bldrsChannel,
        );
        /// NOOT LISTENERS
        _initializeNootListeners();

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
    _locale.dispose();

    // Sembast.dispose(); async function,, and no need to close sembast I guess
    Sounder.dispose();
    _closeNootListeners();
    FCM.disposeAwesomeNoots();

    super.dispose();
  }
  // -----------------------------------------------------------------------------

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
  // -----------------------------------------------------------------------------

  /// LOCALE

  // --------------------
  final ValueNotifier<Locale?> _locale = ValueNotifier<Locale?>(null);
  // --------------------
  void _setLocale(Locale locale) {

    setNotifier(
        notifier: _locale,
        mounted: mounted,
        value: locale
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

      return BldrsProviders(
        child: ValueListenableBuilder<Locale?>(
          valueListenable: _locale,
          builder: (BuildContext ctx, Locale? value, Widget? child) {
            return MaterialApp(
              /// KEYS
              // key: ,
              // scaffoldMessengerKey: ,
              // restorationScopeId: ,

              // useInheritedMediaQuery: true,


              /// DUNNO
              // actions: ,
              // builder: (BuildContext context, Widget widget) {
              //
              //   ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
              //
              //     // blogFlutterErrorDetails(errorDetails);
              //
              //     final String _text = TextMod.removeTextBeforeLastSpecialCharacter(errorDetails.exception.toString(), ':');
              //
              //     return Center(
              //       child: Container(
              //         // width: double.infinity,
              //         // height: double.infinity,
              //         color: Colorz.red255,
              //         child: ListView(
              //           children: <Widget>[
              //
              //             const BldrsImage(
              //               width: 40,
              //               height: 40,
              //               pic: Iconz.dvGouran,
              //               iconColor: Colorz.black255,
              //             ),
              //
              //             BldrsText(
              //               verse: Verse(
              //                 id: _text,
              //                 translate: false,
              //                 casing: Casing.upperCase,
              //               ),
              //               maxLines: 20,
              //               color: Colorz.black255,
              //               margin: 20,
              //               weight: VerseWeight.black,
              //               italic: true,
              //               labelColor: Colorz.black50,
              //             ),
              //
              //           ],
              //         ),
              //       ),
              //     );
              //   };
              //
              //   return widget;
              //   },
              builder: DevicePreview.appBuilder,

              // home: ,
              // useInheritedMediaQuery: ,
              // shortcuts: ,
              scrollBehavior: AppScrollBehavior(),

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
              locale: value,
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
            );
          },
        ),
      );

  }
  // -----------------------------------------------------------------------------
}

// ---------------------------------------------------------------------------
