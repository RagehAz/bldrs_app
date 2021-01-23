import 'package:bldrs/ambassadors/services/auth.dart';
import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/xxx_LABORATORY/camera_and_location/test_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'models/user_model.dart';
import 'providers/combined_models/cobz_provider.dart';
import 'providers/combined_models/coflyer_provider.dart';
import 'view_brains/localization/demo_localization.dart';
import 'view_brains/router/route_names.dart';
import 'view_brains/router/router.dart';
import 'package:provider/provider.dart';
import 'views/widgets/pro_flyer/flyer_screen.dart';
import 'xxx_LABORATORY/ask/questions_provider.dart';

main() => runApp(BldrsApp());

class BldrsApp extends StatefulWidget {

  static void setLocale(BuildContext context, Locale locale) {
    _BldrsAppState state = context.findAncestorStateOfType<_BldrsAppState>();
    state.setLocale(locale);
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
    Locale('ru', 'RU'),
    Locale('it', 'IT'),
    Locale('tr', 'TR'),
    Locale('zh', 'CN'),
  ];

  List<LocalizationsDelegate> _localizationDelegates = [
    DemoLocalization.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
// ---------------------------------------------------------------------------
  void setLocale(Locale locale) {
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
  void initializeFlutterFire() async {
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
  }
// ---------------------------------------------------------------------------
  @override
  void initState() {
    initializeFlutterFire();
    print("successfully initialized FlutterFire");
    super.initState();
  }
// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (_locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
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
            create: (ctx) => GreatPlaces(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => CoBzProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => CoFlyersProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => QuestionsProvider(),
          ),
          // ChangeNotiFierProvider(create: (ctx)=> )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          debugShowMaterialGrid: false,
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
          },
        ),
      );
    }
  }
}
