import 'package:bldrs/controllers/localization/demo_localization.dart';
import 'package:bldrs/controllers/localization/localization_constants.dart';
import 'package:bldrs/controllers/router/route_names.dart';
import 'package:bldrs/controllers/router/router.dart';
import 'package:bldrs/firestore/user_ops.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/screens/s00_user_checker_widget.dart';
import 'package:bldrs/views/screens/s10_home_screen.dart';
import 'package:bldrs/views/screens/s51_flyer_screen.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:bldrs/xxx_LABORATORY/camera_and_location/test_provider.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/dynamic_links_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(BldrsApp());
}

// main() => runApp(BldrsApp());

class BldrsApp extends StatefulWidget {

  static void setLocale(BuildContext context, Locale locale) {
    _BldrsAppState state = context.findAncestorStateOfType<_BldrsAppState>();
    state._setLocale(locale);
  }

  @override
  _BldrsAppState createState() => _BldrsAppState();
}

class _BldrsAppState extends State<BldrsApp> {
  Locale _locale;
  List<Locale> _supportedLocales = <Locale>[
    Locale('en', 'US'),
    Locale('ar', 'EG'),
    Locale('es', 'ES'),
    Locale('fr', 'FR'),
    Locale('zh', 'CN'),
    Locale('de', 'DE'),
    Locale('it', 'IT'),
  ];
  List<LocalizationsDelegate> _localizationDelegates = <LocalizationsDelegate>[
    DemoLocalization.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
// ---------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// ---------------------------------------------------------------------------
  @override
  void initState() {
    _initializeFlutterFire();
    print("successfully initialized FlutterFire");
    super.initState();
  }
// ---------------------------------------------------------------------------
  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }
// ---------------------------------------------------------------------------
  void _setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
// ---------------------------------------------------------------------------
  bool _initialized = false;
  bool _error = false;
// ---------------------------------------------------------------------------
  // Define an async function to initialize FlutterFire
  void _initializeFlutterFire() async {
    _triggerLoading();
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      print(e.message);
      setState(() {
        _error = true;
      });
    }
    _triggerLoading();
  }
// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    print({'building Bldrs with _locale : $_locale'});

    if (_locale == null) {
      return Container(
        child: Center(
          child: Loading(loading: _loading,),
        ),
      );
    }

    else {
      // Show error message if initialization failed
      if (_error) {
        print("Error has occured");
      }

      // Show a loader until FlutterFire is initialized
      if (!_initialized) {
        print("Firebase Coudn't be initialized");
      }

      return MultiProvider(
        providers: [
          StreamProvider<UserModel>.value(
              value: UserOps().streamInitialUser(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => CountryProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => FlyersProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => GreatPlaces(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          debugShowMaterialGrid: false,
          showPerformanceOverlay: false,
          title: 'Bldrs.net',

          // theme:
          // ThemeData(
          //   primarySwatch: MaterialColor(),
          //   accentColor: Colorz.BlackBlack,
          // ),
          locale: _locale,
          supportedLocales: _supportedLocales,
          localizationsDelegates: _localizationDelegates,
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            for (var locale in supportedLocales) {
              if (locale.languageCode == deviceLocale.languageCode &&
                  locale.countryCode == deviceLocale.countryCode) {
                return deviceLocale;
              }
            }
            return supportedLocales.first;
          },
          onGenerateRoute: Routerer.allRoutes,
          initialRoute: Routez.UserChecker,
          routes: {
            Routez.FlyerScreen: (ctx) => FlyerScreen(),
            Routez.DynamicLinkTest: (ctx) => DynamicLinkTest(),
            // Routez.Starting: (ctx) => StartingScreen(),
            Routez.UserChecker: (ctx) => UserChecker(),
            Routez.Home: (ctx) => HomeScreen(),
            // Routez.InPyramids: (ctx) => InPyramidsScreen(),
          },
        ),
      );
    }
  }
}
