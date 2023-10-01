import 'dart:async';

import 'package:basics/helpers/classes/checks/device_checker.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:basics/helpers/classes/strings/text_mod.dart';
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
    FirebaseMessaging.onBackgroundMessage(bldrsAppOnBackgroundMessageHandler);
    // --------------------
    await Future.wait(<Future>[
      /// FCM
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
  }) async {
    bool _canLoadApp = false;

    // final bool _isConnected = await DeviceChecker.checkConnectivity();
    //
    // _report('_isConnected : $_isConnected');

    // if (_isConnected == false){
    //
    //   // await Nav.goToNewScreen(context: context, screen: const AppSettingsScreen());
    //
    // }
    //
    // else {

      unawaited(UiInitializer.refreshLDB());

      /// LOADING
      UiInitializer.setLoadingVerse(getWord('phid_please_wait'));

      /// APP LANGUAGE
      await UiInitializer.initializeAppLanguage(
        context: context,
        mounted: mounted,
      );

      /// APP STATE
      _canLoadApp = await AppStateInitializer.initialize();

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

      }

      UiProvider.clearLoadingVerse();

    // }

    return _canLoadApp;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> routeAfterLoaded({
    required BuildContext context,
    required bool mounted,
  }) async {

    if (mounted == true){

      /// WEB : WHERE THERE IS A URL
      if (kIsWeb == true){

        // https://www.bldrs.net
        // https://www.bldrs.net/#/route:arg

        final String _url = window.location.toString();

        // [//www.bldrs.net] or [arg]
        final String? _afterDots = TextMod.removeTextBeforeLastSpecialCharacter(
            text: _url,
            specialCharacter: ':',
        );
        final bool _includeBldrsNet = TextCheck.stringContainsSubString(
            string: _afterDots,
            subString: 'bldrs.net',
        );

        if (_includeBldrsNet == false && kDebugMode == false){
          // blog('shall not route after initialization in loading screen bro ---< ');
          // blog('_afterDots : $_afterDots : _includeBldrsNet : $_includeBldrsNet');
        }

        else {
          await Nav.pushNamedAndRemoveAllBelow(
            context: context,
            goToRoute: RouteName.home,
          );
        }

      }

      /// MOBILE - WINDOWS
      else {
        await Nav.pushNamedAndRemoveAllBelow(
          context: context,
          goToRoute: RouteName.home,
        );
      }

    }

  }
  /// -----------------------------------------------------------------------------
  // static void _report(String text){
    // blog('  --> logoScreenInitialize : $text');
  // }
  /// -----------------------------------------------------------------------------
}
