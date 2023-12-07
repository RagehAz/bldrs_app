import 'dart:async';

import 'package:basics/helpers/classes/checks/device_checker.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/a_models/e_notes/c_channel_model.dart';
import 'package:bldrs/bldrs_keys.dart';
import 'package:bldrs/c_protocols/app_initialization_protocols/b_app_state_initializer.dart';
import 'package:bldrs/c_protocols/app_initialization_protocols/c_user_initializer.dart';
import 'package:bldrs/c_protocols/app_initialization_protocols/e_ui_initializer.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/e_back_end/e_fcm/background_msg_handler.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm_starter.dart';
import 'package:bldrs/e_back_end/i_app_check/app_check.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/router/a_route_name.dart';
import 'package:bldrs/f_helpers/router/b_static_router.dart';
import 'package:bldrs/f_helpers/router/c_dynamic_router.dart';
import 'package:bldrs/firebase_options.dart';
import 'package:fire/super_fire.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:universal_html/html.dart';

/// => TAMAM
class Initializer {
  // -----------------------------------------------------------------------------

  const Initializer();

  // -----------------------------------------------------------------------------

  /// MAIN APP INITIALIZER

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
  // -----------------------------------------------------------------------------

  /// LOADING SCREEN INITIALIZER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> logoScreenInitialize({
    required BuildContext context,
    required bool mounted,
    bool? skipAppStateCheck,
  }) async {
    bool _canLoadApp = false;

      unawaited(UiInitializer.refreshLDB());

      /// LOADING
      UiInitializer.setLoadingVerse(getWord('phid_please_wait'));

      /// APP LANGUAGE
      await UiInitializer.initializeAppLanguage(
        context: context,
        mounted: mounted,
      );

      /// APP STATE
      _canLoadApp = skipAppStateCheck ?? await AppStateInitializer.initialize();

      /// LOADING
      UiInitializer.setLoadingVerse(getWord('phid_thisIsBabyApp'));

      if (_canLoadApp == true){

        /// CLOCK
        _canLoadApp = await UiInitializer.initializeClock();


        if (_canLoadApp == true){

          /// LOADING
          UiInitializer.setLoadingVerse(getWord('phid_thankYouForWaiting'));

            /// USER MODEL
            _canLoadApp = await UserInitializer.initializeUser();

            if (_canLoadApp == true){

              UiInitializer.setLoadingVerse(getWord('phid_loading'));

              await Future.wait(<Future>[

                /// UI - ICONS - PHRASES
                UiInitializer.initializeIconsAndPhrases(),

                /// ALL CURRENCIES
                ZoneProvider.proInitializeAllCurrencies(),

              ]);

            }

        }

        else {

        }

      }

      UiProvider.clearLoadingVerse();

    return _canLoadApp;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> routeAfterLoaded({
    // required BuildContext context,
    required bool mounted,
  }) async {

    if (mounted == true){

      /// WEB : WHERE THERE IS A URL
      if (kIsWeb == true){
        await _webUrlLandingSwitcherLogic();
      }

      /// MOBILE - WINDOWS
      else {
        await Nav.pushNamedAndRemoveAllBelow(
          context: getMainContext(),
          goToRoute: RouteName.home,
        );
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _webUrlLandingSwitcherLogic() async {

    if (kIsWeb == true){

      final String _url = window.location.toString();

      final String? _path = StaticRouter.getPathFromWindowURL(_url);

      /// LANDED ON LOGO SCREENS
      if (
          _path == RouteName.animatedLogo ||
          _path == RouteName.staticLogo
      ){
        await Nav.pushNamedAndRemoveAllBelow(
          context: getMainContext(),
          goToRoute: RouteName.home,
        );
      }

      /// LANDED ON HOME SCREEN
      else if (_path == RouteName.home){
        // do nothing
      }

      /// LANDED ON ANY OTHER SCREEN
      else {

        final BuildContext context = getMainContext();

        /// SO WHEN USER GEOS TO A URL, WE PUSH HOME AND THEN PUSH THE URL AS A WORK AROUND
        /// TO REPLACING THE ROUTE BELOW BECAUSE WE FAILED TO DO THAT
        unawaited(Nav.pushNamedAndRemoveAllBelow(
          context: context,
          goToRoute: RouteName.home,
        ));

        await DynamicRouter.goTo(
          routeSettingsName: StaticRouter.getRouteSettingsNameFromFullPath(_url),
          args: null,
        );

      }

    }

  }
  // -----------------------------------------------------------------------------
}
