import 'dart:async';
import 'package:bldrs/c_protocols/app_initialization_protocols/b_app_state_initializer.dart';
import 'package:bldrs/c_protocols/app_initialization_protocols/c_user_initializer.dart';
import 'package:bldrs/c_protocols/app_initialization_protocols/e_ui_initializer.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/cupertino.dart';

/// => TAMAM
class Initializer {
  // -----------------------------------------------------------------------------

  const Initializer();

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
  /// -----------------------------------------------------------------------------
  // static void _report(String text){
    // blog('  --> logoScreenInitialize : $text');
  // }
  /// -----------------------------------------------------------------------------
}
