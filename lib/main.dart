import 'dart:async';

import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/animators/app_scroll_behavior.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:bldrs/c_protocols/a_bldrs_engine/bldrs_engine.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_providers.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------

Future<void> main() => BldrsEngine.mainIgnition();

// ---------------------------------------------------------------------------

final ValueNotifier<Locale?> superLocale = ValueNotifier(null);

class BldrsAppStarter extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BldrsAppStarter({
    super.key
  });
  /// --------------------------------------------------------------------------
  static void setLocale(BuildContext? context, Locale? locale) {
    superLocale.value = null;
    superLocale.value = locale;
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
  @override
  Widget build(BuildContext context) {

    return BldrsProviders(
      child: ValueListenableBuilder(
        valueListenable: superLocale,
        builder: (_, Locale? locale, Widget? child) {

          return MaterialApp(
            /// KEYS
            // key: ,
            // scaffoldMessengerKey: ,
            // restorationScopeId: ,
            // useInheritedMediaQuery: true,

            /// DUNNO
            // actions: ,

            // builder: DevicePreview.appBuilder,

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
            locale: locale,
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
            onGenerateRoute: Routing.router,
            // initialRoute: RouteName.staticLogo,
            // routes: Routing.routesMap,
          );
        }
      ),
    );

  }
  // -----------------------------------------------------------------------------
}

// ---------------------------------------------------------------------------

// class RestartWidget extends StatefulWidget {
//
//   const RestartWidget({
//     required this.child,
//   });
//
//   final Widget child;
//
//   static void restartApp(BuildContext context) {
//     context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
//   }
//
//   @override
//   _RestartWidgetState createState() => _RestartWidgetState();
// }
//
// class _RestartWidgetState extends State<RestartWidget> {
//   Key key = UniqueKey();
//
//   void restartApp() {
//     setState(() {
//       key = UniqueKey();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return KeyedSubtree(
//       key: key,
//       child: widget.child,
//     );
//   }
//
// }
