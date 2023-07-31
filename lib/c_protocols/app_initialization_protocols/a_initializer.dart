import 'dart:async';

import 'package:basics/helpers/classes/checks/device_checker.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/b_views/h_app_settings/a_app_settings_screen/a_app_settings_screen.dart';
import 'package:bldrs/c_protocols/app_initialization_protocols/b_app_state_initailizer.dart';
import 'package:bldrs/c_protocols/app_initialization_protocols/c_user_initializer.dart';
import 'package:bldrs/c_protocols/app_initialization_protocols/e_ui_initializer.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/theme/words.dart';
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
  }) async {
    bool _canLoadApp = false;

    _report('start');

    final bool _isConnected = await DeviceChecker.checkConnectivity();

    _report('_isConnected : $_isConnected');

    if (_isConnected == false){

      await Nav.goToNewScreen(context: context, screen: const AppSettingsScreen());

    }

    else {

      unawaited(UiInitializer.refreshLDB());

      _report('refreshLDB : started');

      /// LOADING
      UiInitializer.setLoadingVerse(Words.pleaseWait());

      /// APP LANGUAGE
      await UiInitializer.initializeAppLanguage();

      _report('refreshLDB : app land ${Words.languageCode()}');

      /// APP STATE
      _canLoadApp = await AppStateInitializer.initialize();

      _report('refreshLDB : after app state can continue : $_canLoadApp');

      /// LOADING
      UiInitializer.setLoadingVerse(Words.thisIsBabyApp());

      if (_canLoadApp == true){

        /// CLOCK
        _canLoadApp = await UiInitializer.initializeClock();

        _report('refreshLDB : after clock can continue : $_canLoadApp');

        if (_canLoadApp == true){

          /// LOADING
          UiInitializer.setLoadingVerse(Words.thankYouForWaiting());

            /// USER MODEL
            _canLoadApp = await UserInitializer.initializeUser();

            _report('refreshLDB : after user can continue : $_canLoadApp');

            if (_canLoadApp == true){

              UiInitializer.setLoadingVerse(Words.loading());

              /// UI - ICONS - PHRASES
              await UiInitializer.initializeIconsAndPhrases();

              _report('refreshLDB : done with phrases');

            }

        }

      }

      await UiInitializer.avoidMissingPhrasesOps();

      UiProvider.clearLoadingVerse();

    }


    return _canLoadApp;
  }
  // -----------------------------------------------------------------------------
  static void _report(String text){
    // blog('  --> logoScreenInitialize : $text');
  }
  // -----------------------------------------------------------------------------
}
