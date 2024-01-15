import 'dart:async';

import 'package:basics/helpers/checks/device_checker.dart';
import 'package:basics/helpers/checks/errorize.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/mediator/sounder/sounder.dart';
import 'package:bldrs/a_models/e_notes/c_channel_model.dart';
import 'package:bldrs/b_views/a_starters/b_home_screen/x_initialization_controllers.dart';
import 'package:bldrs/bldrs_keys.dart';
import 'package:bldrs/c_protocols/app_initialization_protocols/e_ui_initializer.dart';
import 'package:bldrs/c_protocols/app_initialization_protocols/sub/a_initializer.dart';
import 'package:bldrs/c_protocols/auth_protocols/auth_protocols.dart';
import 'package:bldrs/c_protocols/main_providers/home_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/note_protocols/provider/notes_provider.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm_starter.dart';
import 'package:bldrs/e_back_end/f_cloud/dynamic_links.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
import 'package:bldrs/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class BldrsEngine {
  // --------------------------------------------------------------------------

  const BldrsEngine();

  // --------------------------------------------------------------------------

  /// MAIN

  // --------------------
  ///
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
  // --------------------------------------------------------------------------

  /// APP STARTER

  // --------------------
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
  static Future<void> appStartInit() async {

    /// WINDOWS ADMIN AUTH
    if (DeviceChecker.deviceIsWindows() == true){
      await AuthProtocols.signInAsRage7(context: getMainContext());
    }

    /// INITIALIZE NOOTS
    await FCMStarter.initializeNootsInBldrsAppStarter(
      channelModel: ChannelModel.bldrsChannel,
    );

  }
  // --------------------
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

  }
  // --------------------
  static Future<void> homeInit({
    required bool mounted,
  }) async {

    /// CLOSE KEYBOARD
    unawaited(Keyboard.closeKeyboard());

    final bool _loadApp = await Initializer.logoScreenInitialize(
      context: getMainContext(),
      mounted: mounted,
    );

    if (mounted == true && _loadApp == true){

      await initializeHomeScreen();

      await NotesProvider.proInitializeNoteStreams(mounted: mounted);

      if (mounted){
        await BldrsNav.autoNavigateFromHomeScreen();
      }

      /// DYNAMIC LINKS
      await DynamicLinks.initDynamicLinks();

      await UiInitializer.initializeOnBoarding();

    }

  }
  // --------------------
  static void homeDispose(){
    blog('disposing home screen');
    HomeProvider.proDisposeTabBarController();
    UiProvider.disposeKeyword();
    HomeProvider.proDisposeHomeGrid();
    NotesProvider.disposeNoteStreams();
  }
  // --------------------------------------------------------------------------
}
