import 'dart:async';

import 'package:basics/helpers/checks/device_checker.dart';
import 'package:basics/helpers/checks/errorize.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/mediator/sounder/sounder.dart';
import 'package:bldrs/a_models/e_notes/c_channel_model.dart';
import 'package:bldrs/b_views/a_starters/b_home_screen/x_initialization_controllers.dart';
import 'package:bldrs/bldrs_keys.dart';
import 'package:bldrs/c_protocols/app_initialization_protocols/sub/b_app_state_initializer.dart';
import 'package:bldrs/c_protocols/app_initialization_protocols/sub/c_user_initializer.dart';
import 'package:bldrs/c_protocols/app_initialization_protocols/sub/e_ui_initializer.dart';
import 'package:bldrs/c_protocols/auth_protocols/auth_protocols.dart';
import 'package:bldrs/c_protocols/main_providers/home_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/note_protocols/provider/notes_provider.dart';
import 'package:bldrs/e_back_end/e_fcm/background_msg_handler.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm_starter.dart';
import 'package:bldrs/e_back_end/f_cloud/dynamic_links.dart';
import 'package:bldrs/e_back_end/i_app_check/app_check.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
import 'package:bldrs/firebase_options.dart';
import 'package:bldrs/main.dart';
import 'package:fire/super_fire.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

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

    /// WINDOWS ADMIN AUTH
    if (DeviceChecker.deviceIsWindows() == true){
      await AuthProtocols.signInAsRage7(context: getMainContext());
    }

    /// REFRESH LDB
    unawaited(UiInitializer.refreshLDB());

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

  }
  // --------------------
  ///
  static Future<void> homeInit({
    required BuildContext context,
    required bool mounted,
  }) async {

    await UiInitializer.initializeAppLanguage(
      context: context,
      mounted: mounted,
    );

    /// APP STATE
    await AppStateInitializer.initialize();

    /// CLOSE KEYBOARD
    unawaited(Keyboard.closeKeyboard());

    /// UI - ICONS - PHRASES
    unawaited(UiInitializer.initializeIconsAndPhrases());

    unawaited(
        /// APP LANGUAGE
        UiInitializer.initializeClock(mounted: mounted)
        .then(
                /// AUTO NAV
                (value) => BldrsNav.autoNavigateFromHomeScreen(mounted: mounted)
        ).then(
                /// DYNAMIC LINKS
                (value) => DynamicLinks.initDynamicLinks(mounted: mounted)
        ).then(
                /// ON BOARDING
                (value) => UiInitializer.initializeOnBoarding(mounted: mounted)
        )
    );

    /// USER
    await UserInitializer.initializeUser();
    /// NOTIFICATIONS
    await NotesProvider.proInitializeNoteStreams(mounted: mounted);

    await checkIfUserIsMissingFields();

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void homeDispose(){
    HomeProvider.proDisposeTabBarController();
    UiProvider.disposeKeyword();
    HomeProvider.proDisposeHomeGrid();
    NotesProvider.disposeNoteStreams();
    HomeProvider.proDisposeMirages();
  }
  // --------------------------------------------------------------------------
}
