import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/xxx_LABORATORY/camera_and_location/test_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'controllers/localization/demo_localization.dart';
import 'controllers/localization/localization_constants.dart';
import 'controllers/router/route_names.dart';
import 'controllers/router/router.dart';
import 'firestore/auth/auth.dart';
import 'models/user_model.dart';
import 'providers/flyers_provider.dart';
import 'package:provider/provider.dart';
import 'views/screens/s51_flyer_screen.dart';
import 'views/widgets/loading/loading.dart';
import 'xxx_LABORATORY/ask/questions_provider.dart';

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
  List<Locale> _supportedLocales = [
    Locale('en', 'US'),
    Locale('ar', 'EG'),
    Locale('es', 'ES'),
    Locale('fr', 'FR'),
    Locale('zh', 'CN'),
    Locale('de', 'DE'),
    Locale('it', 'IT'),
  ];
  List<LocalizationsDelegate> _localizationDelegates = [
    DemoLocalization.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
// ---------------------------------------------------------------------------
  void _setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
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
  void initState() {
    _initializeFlutterFire();
    print("successfully initialized FlutterFire");
    super.initState();
  }
// ---------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING') : print('LOADING COMPLETE');
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
    } else {
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
              value: AuthService().userStream,
          ),
          ChangeNotifierProvider(
            create: (ctx) => FlyersProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => CountryProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => GreatPlaces(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => QuestionsProvider(),
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
            // Routez.InPyramids: (ctx) => InPyramidsScreen(),
          },
        ),
      );
    }
  }
}
