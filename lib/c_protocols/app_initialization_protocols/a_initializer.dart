import 'dart:async';

import 'package:bldrs/c_protocols/app_initialization_protocols/b_app_state_initailizer.dart';
import 'package:bldrs/c_protocols/app_initialization_protocols/c_user_initializer.dart';
import 'package:bldrs/c_protocols/app_initialization_protocols/e_ui_initializer.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/theme/words.dart';
import 'package:flutter/cupertino.dart';

class Initializer {
  // -----------------------------------------------------------------------------

  const Initializer();

  // -----------------------------------------------------------------------------

  /// LOADING SCREEN INITIALIZER

  // --------------------
  /// TASK : TEST ME
  static Future<void> logoScreenInitialize({
    required BuildContext context,
  }) async {

    unawaited(UiInitializer.refreshLDB());

    /// LOADING
    UiInitializer.setLoadingVerse(Words.pleaseWait());

    /// APP LANGUAGE
    await UiInitializer.initializeAppLanguage();

    /// APP STATE
    bool _canLoadApp = await AppStateInitializer.initialize();

    /// LOADING
    UiInitializer.setLoadingVerse(Words.thisIsBabyApp());

    if (_canLoadApp == true){

      /// CLOCK
      _canLoadApp = await UiInitializer.initializeClock();

      if (_canLoadApp == true){

        /// LOADING
        UiInitializer.setLoadingVerse(Words.thankYouForWaiting());

        // await Future.wait([

          /// USER MODEL
          await UserInitializer.initializeUser();

          UiInitializer.setLoadingVerse(Words.loading());

          /// UI - ICONS - PHRASES
          await UiInitializer.initializeIconsAndPhrases();

        // ]);

        await UiInitializer.avoidMissingPhrasesOps();

      }

    }

    UiProvider.clearLoadingVerse();

  }
  // -----------------------------------------------------------------------------

}
