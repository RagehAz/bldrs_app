import 'dart:async';

import 'package:bldrs/c_protocols/app_initialization_protocols/b_app_state_initailizer.dart';
import 'package:bldrs/c_protocols/app_initialization_protocols/c_user_initializer.dart';
import 'package:bldrs/c_protocols/app_initialization_protocols/e_ui_initializer.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
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
  }) async {
    bool _canLoadApp = false;

    _report('start');

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

      _report('refreshLDB : started');

      /// LOADING
      UiInitializer.setLoadingVerse(getWord('pleaseWait'));

      /// APP LANGUAGE
      await UiInitializer.initializeAppLanguage();

      _report('refreshLDB : app land ${Localizer.getCurrentLangCode()}');

      /// APP STATE
      _canLoadApp = await AppStateInitializer.initialize();

      _report('refreshLDB : after app state can continue : $_canLoadApp');

      /// LOADING
      UiInitializer.setLoadingVerse(getWord('phid_thisIsBabyApp'));

      if (_canLoadApp == true){

        /// CLOCK
        _canLoadApp = await UiInitializer.initializeClock();

        _report('refreshLDB : after clock can continue : $_canLoadApp');

        if (_canLoadApp == true){

          /// LOADING
          UiInitializer.setLoadingVerse(getWord('phid_thankYouForWaiting'));

            /// USER MODEL
            _canLoadApp = await UserInitializer.initializeUser();

            _report('refreshLDB : after user can continue : $_canLoadApp');

            if (_canLoadApp == true){

              UiInitializer.setLoadingVerse(getWord('loading')!);

              /// UI - ICONS - PHRASES
              await UiInitializer.initializeIconsAndPhrases();

              _report('refreshLDB : done with phrases');

            }

        }

      }

      UiProvider.clearLoadingVerse();

    // }


    return _canLoadApp;
  }
  // -----------------------------------------------------------------------------
  static void _report(String text){
    // blog('  --> logoScreenInitialize : $text');
  }
  // -----------------------------------------------------------------------------
}
