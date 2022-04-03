// tu sei il #crepuscolo_sul_mare contessa

import 'dart:async';
import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/x_screens/a_starters/a_0_logo_screen.dart';
import 'package:bldrs/b_views/x_screens/a_starters/a_1_home_screen.dart';
import 'package:bldrs/b_views/x_screens/i_flyer/h_0_flyer_screen.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/general_provider.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/noti_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/search_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/methods/dynamic_links.dart';
import 'package:bldrs/e_db/fire/ops/user_ops.dart' as UserFireOps;
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/notifications/local_notification_service.dart' as LocalNotificationService;
import 'package:bldrs/f_helpers/notifications/noti_ops.dart' as NotiOps;
import 'package:bldrs/f_helpers/router/route_names.dart';
import 'package:bldrs/f_helpers/router/router.dart' as Routerer;
import 'package:bldrs/xxx_lab/ask/question/questions_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

Future<void> main() async {
  /// TASK : In optimization : study this : https://pub.dev/packages/keframe
  // debugPrintMarkNeedsPaintStacks = false;
  // debugProfilePaintsEnabled = false;
  // debugProfileBuildsEnabled = false;
  // debugRepaintTextRainbowEnabled = false;
  // debugPaintLayerBordersEnabled = false;
  // debugRepaintRainbowEnabled = false;
  // debugPrintLayouts = true;

  /// insures awaiting async methods below to finish then continue
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await NotiOps.preInitializeNoti();

  runApp(const BldrsApp());
}

class BldrsApp extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BldrsApp({Key key}) : super(key: key);

  /// --------------------------------------------------------------------------
  static void setLocale(BuildContext context, Locale locale) {
    final _BldrsAppState state =
        context.findAncestorStateOfType<_BldrsAppState>();
    state._setLocale(locale);
  }

  /// --------------------------------------------------------------------------
  @override
  _BldrsAppState createState() => _BldrsAppState();
}

class _BldrsAppState extends State<BldrsApp> {
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false);
// -----------------------------------
  Future<void> _triggerLoading() async {
    _loading.value = !_loading.value;

    if (_loading.value == true) {
      blog('LOADING --------------------------------------');
    } else {
      blog('LOADING COMPLETE -----------------------------');
    }
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading().then((_) async {

        /// LOCALE
        await _initializeLocale();

        /// FIREBASE
        await _initializeFlutterFire();

        /// NOTIFICATIONS
        await LocalNotificationService.initialize(context);
        await NotiOps.initializeNoti();

        /// DYNAMIC LINKS
        await DynamicLinksApi().initializeDynamicLinks(context);

        /// END
        await _triggerLoading();
      });
    }

    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _loading.dispose();
    _locale.dispose();
    _fireError.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  Locale _localeResolutionCallback(
      Locale deviceLocale, Iterable<Locale> supportedLocales) {
    return Localizer.localeResolutionCallback(
        deviceLocale: deviceLocale, supportedLocales: supportedLocales);
  }

// -----------------------------------------------------------------------------
  final ValueNotifier<Locale> _locale = ValueNotifier<Locale>(null);
// -----------------------------------
  Future<void> _initializeLocale() async {
    final Locale _gotLocale = await Localizer.getLocaleFromSharedPref();
    _setLocale(_gotLocale);
  }

// -----------------------------------
  void _setLocale(Locale locale) {
    _locale.value = locale;
  }

// -----------------------------------------------------------------------------
  final ValueNotifier<String> _fireError = ValueNotifier(null);
// -----------------------------------
  Future<void> _initializeFlutterFire() async {
    await tryAndCatch(
        context: context,
        functions: () async {
          final FirebaseApp _firebaseApp = await Firebase.initializeApp();

          blog('_firebaseApp.name : ${_firebaseApp.name}');
          blog('_firebaseApp.isAutomaticDataCollectionEnabled : ${_firebaseApp.isAutomaticDataCollectionEnabled}');
          blog('_firebaseApp.options :-');
          blogMap(_firebaseApp.options.asMap);
        },
        onError: (String error) {
          _fireError.value = error;
        });
  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    blog('building Bldrs with _locale : $_locale');

    if (_locale == null || _fireError.value != null) {

      return ValueListenableBuilder<bool>(
          valueListenable: _loading,
          builder: (_, bool loading, Widget child) {
            return ValueListenableBuilder<String>(
                valueListenable: _fireError,
                builder: (_, String error, Widget child) {
                  return const LogoScreen(
                    // loading: loading,
                    // error: error,
                  );
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
          StreamProvider<UserModel>.value(
            value: UserFireOps.streamInitialUser(),
            initialData: UserModel.initializeUserModelStreamFromUser(),
          ),
          ChangeNotifierProvider<GeneralProvider>(
            create: (BuildContext ctx) => GeneralProvider(),
          ),
          ChangeNotifierProvider<NotiProvider>(
            create: (BuildContext ctx) => NotiProvider(),
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
          ChangeNotifierProvider<QuestionsProvider>(
            create: (BuildContext ctx) => QuestionsProvider(),
          ),
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
              // theme:
              // ThemeData(
              //   primarySwatch: MaterialColor(),
              //   accentColor: Colorz.BlackBlack,
              // ),

              /// LOCALE
              locale: _locale.value,
              supportedLocales: Localizer.getSupportedLocales(),
              localizationsDelegates: Localizer.getLocalizationDelegates(),
              localeResolutionCallback: _localeResolutionCallback,

              /// ROUTES
              onGenerateRoute: Routerer.allRoutes,
              initialRoute: Routez.logoScreen,
              routes: <String, Widget Function(BuildContext)>{

                /// STARTERS
                Routez.logoScreen: (BuildContext ctx) => const LogoScreen(key: ValueKey<String>('LogoScreen'),),
                Routez.home: (BuildContext ctx) => const HomeScreen(),

                Routez.flyerScreen: (BuildContext ctx) => const FlyerScreen(),
                // Routez.Starting: (ctx) => StartingScreen(),
                // Routez.InPyramids: (ctx) => InPyramidsScreen(),

              },
            );
          },
        ),
      );
    }
  }
}
