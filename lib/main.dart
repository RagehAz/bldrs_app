import 'dart:async';

import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/animators/app_scroll_behavior.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:bldrs/f_helpers/router/z_new_static_router.dart';
import 'package:bldrs/c_protocols/app_initialization_protocols/bldrs_engine.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_providers.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------

Future<void> main() => BldrsEngine.mainIgnition();

// ---------------------------------------------------------------------------

class BldrsAppStarter extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BldrsAppStarter({
    super.key
  });
  /// --------------------------------------------------------------------------
  static void setLocale(BuildContext? context, Locale? locale) {

    if (locale != null){
      /// let's see if this works
      context?.findAncestorStateOfType<_BldrsAppStarterState>()?._setLocale(locale);
    }

  }
  /// --------------------------------------------------------------------------
  @override
  _BldrsAppStarterState createState() => _BldrsAppStarterState();
  /// --------------------------------------------------------------------------
}

class _BldrsAppStarterState extends State<BldrsAppStarter> with WidgetsBindingObserver {
  // -----------------------------------------------------------------------------
  @override
  void initState() {

    BldrsEngine.appStartPreInit(
      observer: this,
    );

    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        await BldrsEngine.appStartInit();

      });
    }

    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {

    BldrsEngine.appStartDispose(
      observer: this,
    );

    super.dispose();
  }
  // --------------------
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    BldrsEngine.appLifeCycleListener(state);
    super.didChangeAppLifecycleState(state);
  }
  // -----------------------------------------------------------------------------

  /// LOCALE

  // --------------------
  Locale? _locale;
  // --------------------
  void _setLocale(Locale? locale) {

    if (mounted == true && locale != null){
      setState(() {
        _locale = locale;
      });
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return BldrsProviders(
      child: MaterialApp(
        /// KEYS
        // key: ,
        // scaffoldMessengerKey: ,
        // restorationScopeId: ,
        // useInheritedMediaQuery: true,

        /// DUNNO
        // actions: ,

        builder: DevicePreview.appBuilder,

        // home: ,
        // useInheritedMediaQuery: ,
        // shortcuts: ,
        scrollBehavior: const AppScrollBehavior(),

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
        locale: _locale,
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
        onGenerateRoute: NewStaticRouter.router,
        // initialRoute: RouteName.staticLogo,
        // routes: Routing.routesMap,
      ),
    );

  }
  // -----------------------------------------------------------------------------
}

// ---------------------------------------------------------------------------
