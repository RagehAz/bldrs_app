import 'dart:async';

import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/c_protocols/app_initialization_protocols/sub/b_app_state_initializer.dart';
import 'package:bldrs/c_protocols/app_initialization_protocols/sub/c_user_initializer.dart';
import 'package:bldrs/c_protocols/app_initialization_protocols/sub/e_ui_initializer.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/router/a_route_name.dart';
import 'package:bldrs/f_helpers/router/b_static_router.dart';
import 'package:bldrs/f_helpers/router/c_dynamic_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart';

/// => TAMAM
class Initializer {
  // -----------------------------------------------------------------------------

  const Initializer();

  // -----------------------------------------------------------------------------

  /// MAIN APP INITIALIZER


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
        _canLoadApp = await UiInitializer.initializeClock(mounted: mounted);

        if (_canLoadApp == true){

          /// LOADING
          UiInitializer.setLoadingVerse(getWord('phid_thankYouForWaiting'));

            /// USER MODEL
            _canLoadApp = await UserInitializer.initializeUser();

            if (_canLoadApp == true){

              UiInitializer.setLoadingVerse(getWord('phid_loading'));

              // await Future.wait(<Future>[
              //
              //   /// UI - ICONS - PHRASES
              //   UiInitializer.initializeIconsAndPhrases(),
              //
              // ]);

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
