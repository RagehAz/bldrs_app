import 'dart:async';
import 'package:bldrs/b_views/a_starters/a_logo_screen/a_static_logo_screen.dart';
import 'package:bldrs/b_views/a_starters/a_logo_screen/b_animated_logo_screen.dart';
import 'package:bldrs/b_views/a_starters/b_home_screen/a_home_screen.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/a_flyer_screen.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/general_provider.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/search_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/firestore.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
import 'package:bldrs/e_back_end/f_cloud/dynamic_links.dart';
import 'package:bldrs/f_helpers/drafters/sounder.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm_starter.dart';
import 'package:bldrs/f_helpers/router/routing.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

Future<void> main() async {
  /// -----------------------------------------------------------------------------
  /*
    /// TASK : In optimization : study this : https://pub.dev/packages/keframe
  // debugPrintMarkNeedsPaintStacks = false;
  // debugProfilePaintsEnabled = false;
  // debugProfileBuildsEnabled = false;
  // debugRepaintTextRainbowEnabled = false;
  // debugPaintLayerBordersEnabled = false;
  // debugRepaintRainbowEnabled = false;
  // debugPrintLayouts = true;
  */
  // --------------------
  /// insures awaiting async methods below to finish then continue
  WidgetsFlutterBinding.ensureInitialized();
  // --------------------
  await Firebase.initializeApp();
  // --------------------
  await FCMStarter.preInitializeNotifications();
  /// --------------------
  runApp(const BldrsApp());
  /// -----------------------------------------------------------------------------
}

class BldrsApp extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BldrsApp({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  static void setLocale(BuildContext context, Locale locale) {
    final _BldrsAppState state = context.findAncestorStateOfType<_BldrsAppState>();
    state._setLocale(locale);
  }
  /// --------------------------------------------------------------------------
  @override
  _BldrsAppState createState() => _BldrsAppState();
/// --------------------------------------------------------------------------
}

class _BldrsAppState extends State<BldrsApp> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<String> _fireError = ValueNotifier<String>(null); /// tamam disposed
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
  // --------------------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'EditProfileScreen',);
    }
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading().then((_) async {

        /// LOCALE
        await Localizer.initializeLocale(_locale);

        /// FIREBASE
        await Fire.initializeFirestore(
          context: context,
          fireError: _fireError,
        );

        /// NOTIFICATIONS
        await FCMStarter.initializeNotifications(context);

        /// DYNAMIC LINKS
        await DynamicLinks.initializeDynamicLinks(context);

        /// END
        await _triggerLoading();

      });
    }

    _isInit = false;
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _locale.dispose();
    _fireError.dispose();

    // Sembast.dispose(); async function,, and no need to close sembast I guess
    Sounder.dispose();
    FCM.dispose();

    super.dispose();
  }
  // -----------------------------------------------------------------------------
  final ValueNotifier<Locale> _locale = ValueNotifier<Locale>(null); /// tamam disposed
  // --------------------
  void _setLocale(Locale locale) {
    _locale.value = locale;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (_locale == null || _fireError.value != null) {
      return ValueListenableBuilder<bool>(
          valueListenable: _loading,
          builder: (_, bool loading, Widget child) {
            return ValueListenableBuilder<String>(
                valueListenable: _fireError,
                builder: (_, String error, Widget child) {
                  return const AnimatedLogoScreen();
                });
          });
    }

    else {
      return MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<PhraseProvider>(
            create: (BuildContext ctx) => PhraseProvider(),
          ),
          ChangeNotifierProvider<UiProvider>(
            create: (BuildContext ctx) => UiProvider(),
          ),
          ChangeNotifierProvider<UsersProvider>(
            create: (BuildContext ctx) => UsersProvider(),
          ),
          ChangeNotifierProvider<GeneralProvider>(
            create: (BuildContext ctx) => GeneralProvider(),
          ),
          ChangeNotifierProvider<NotesProvider>(
            create: (BuildContext ctx) => NotesProvider(),
          ),
          ChangeNotifierProvider<UsersProvider>(
            create: (BuildContext ctx) => UsersProvider(),
          ),
          ChangeNotifierProvider<ZoneProvider>(
            create: (BuildContext ctx) => ZoneProvider(),
          ),
          ChangeNotifierProvider<BzzProvider>(
            create: (BuildContext ctx) => BzzProvider(),
          ),
          ChangeNotifierProvider<FlyersProvider>(
            create: (BuildContext ctx) => FlyersProvider(),
          ),
          ChangeNotifierProvider<ChainsProvider>(
            create: (BuildContext ctx) => ChainsProvider(),
          ),
          ChangeNotifierProvider<SearchProvider>(
            create: (BuildContext ctx) => SearchProvider(),
          ),
          // ChangeNotifierProvider<QuestionsProvider>(
          //   create: (BuildContext ctx) => QuestionsProvider(),
          // ),
        ],
        child: ValueListenableBuilder<Locale>(
          valueListenable: _locale,
          builder: (BuildContext ctx, Locale value, Widget child) {
            return MaterialApp(

              /// DEBUG
              debugShowCheckedModeBanner: false,
              // debugShowMaterialGrid: false,
              // showPerformanceOverlay: false,
              // checkerboardRasterCacheImages: false,

              /// THEME
              title: 'Bldrs.net',
              theme:
              ThemeData(
                canvasColor: Colorz.nothing,
                textSelectionTheme: const TextSelectionThemeData(
                  selectionHandleColor: Colorz.yellow255,
                  selectionColor: Colorz.white50,
                ),
              ),

              /// LOCALE
              locale: _locale.value,
              supportedLocales: Localizer.getSupportedLocales(),
              localizationsDelegates: Localizer.getLocalizationDelegates(),
              localeResolutionCallback: Localizer.localeResolutionCallback,

              /// ROUTES
              onGenerateRoute: Routing.allRoutes,
              initialRoute: Routing.staticLogoScreen,
              routes: <String, Widget Function(BuildContext)>{

                /// STARTERS
                Routing.staticLogoScreen: (BuildContext ctx) => const StaticLogoScreen(key: ValueKey<String>('LogoScreen'),),
                Routing.home: (BuildContext ctx) => const HomeScreen(),

                Routing.flyerScreen: (BuildContext ctx) => const FlyerScreen(),
                // Routez.Starting: (ctx) => StartingScreen(),


              },
            );
          },
        ),
      );
    }

  }
  // -----------------------------------------------------------------------------
}
