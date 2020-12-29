import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/xxx_LABORATORY/camera_and_location/test_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'providers/bz_provider.dart';
import 'providers/combined_models/cobz_provider.dart';
import 'providers/combined_models/coflyer_provider.dart';
import 'view_brains/localization/demo_localization.dart';
import 'view_brains/router/route_names.dart';
import 'view_brains/router/router.dart';
import 'package:provider/provider.dart';

import 'views/widgets/pro_flyer/flyer_screen.dart';
// import 'package:bldrs/providers/flyer_provider.dart';

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
  ];

  List<LocalizationsDelegate> _localizationDelegates = [
    DemoLocalization.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => GreatPlaces(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => CoBzProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => CoFlyersProvider(),
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
          initialRoute: Routez.Starting,
          routes: {
            Routez.FlyerScreen: (ctx) => FlyerScreen(),
          },
        ),
      );
    }
  }
}
