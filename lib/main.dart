import 'package:bldrs/controllers/localization/localizer.dart';
import 'package:bldrs/controllers/notifications/local_notification_service.dart';
import 'package:bldrs/controllers/notifications/noti_ops.dart';
import 'package:bldrs/controllers/router/route_names.dart';
import 'package:bldrs/controllers/router/router.dart';
import 'package:bldrs/db/fire/ops/user_ops.dart';
import 'package:bldrs/models/notification/noti_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/providers/bzz_provider.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/providers/general_provider.dart';
import 'package:bldrs/providers/keywords_provider.dart';
import 'package:bldrs/providers/ui_provider.dart';
import 'package:bldrs/providers/user_provider.dart';
import 'package:bldrs/providers/zone_provider.dart';
import 'package:bldrs/views/screens/a_starters/a_0_user_checker_widget.dart';
import 'package:bldrs/views/screens/b_landing/b_0_home_screen.dart';
import 'package:bldrs/views/screens/i_flyer/h_0_flyer_screen.dart';
import 'package:bldrs/views/widgets/general/loading/loading.dart';
import 'package:bldrs/xxx_LABORATORY/ask/question/questions_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';


void main() async {

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

  const BldrsApp({
    Key key
  }) : super(key: key);

  static void setLocale(BuildContext context, Locale locale) {
    _BldrsAppState state = context.findAncestorStateOfType<_BldrsAppState>();
    state._setLocale(locale);
  }

  @override
  _BldrsAppState createState() => _BldrsAppState();
}

class _BldrsAppState extends State<BldrsApp> {
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future <void> _triggerLoading({Function function}) async {

    if (function == null){
      setState(() {
        _loading = !_loading;
      });
    }

    else {
      setState(() {
        _loading = !_loading;
        function();
      });
    }

    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _initializeFlutterFire();
    LocalNotificationService.initialize(context);
    NotiOps.initializeNoti();
  }
// ---------------------------------------------------------------------------
  @override
  void didChangeDependencies() {
    Localizer.getLocale().then((locale) {

      // setState(() {
        this._locale.value = locale;
      // });

    });
    super.didChangeDependencies();
  }
// ---------------------------------------------------------------------------
  ValueNotifier<Locale> _locale = ValueNotifier(null);
  List<Locale> _supportedLocales = Localizer.getSupportedLocales();
  List<LocalizationsDelegate> _localizationDelegates = Localizer.getLocalizationDelegates();
  void _setLocale(Locale locale) {
    // setState(() {
      _locale.value = locale;
    // });
  }
// ---------------------------------------------------------------------------
  bool _initialized = false;
  bool _error = false;
  void _initializeFlutterFire() async {
    _triggerLoading();
    try {
      /// Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      /// Set `_error` state to true if Firebase initialization fails
      print(e.message);
      setState(() {
        _error = true;
      });
    }
    _triggerLoading();
  }
// ---------------------------------------------------------------------------
//   NotiModel _noti;
  bool _notiIsOn = false;
Future<void> receiveAndActUponNoti({dynamic msgMap, NotiType notiType}) async {
  print('receiveAndActUponNoti : notiType : $notiType');

  NotiModel _noti = await NotiOps.receiveAndActUponNoti(
    context: context,
    notiType: notiType,
    msgMap: msgMap,
  );

  if (_noti != null){
    setState(() {
      // _noti = noti;
      _notiIsOn = true;
    });
  }

}
// -----------------------------------------------------------------------------

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
      /// Show error message if initialization failed
      if (_error) {
        print("Error has occurred");
      }
      /// Show a loader until FlutterFire is initialized
      if (!_initialized) {
        print("Firebase Couldn't be initialized");
      }

      return MultiProvider(
        providers: [
          StreamProvider<UserModel>.value(
            value: UserFireOps.streamInitialUser(),
            initialData: UserModel.initializeUserModelStreamFromUser(),
          ),

          ChangeNotifierProvider(
            create: (BuildContext ctx) => UiProvider(),
          ),

          ChangeNotifierProvider(
            create: (BuildContext ctx) => GeneralProvider(),
          ),

          ChangeNotifierProvider(
            create: (BuildContext ctx) => UsersProvider(),
          ),

          ChangeNotifierProvider(
            create: (BuildContext ctx) => ZoneProvider(),
          ),

          ChangeNotifierProvider(
            create: (BuildContext ctx) => BzzProvider(),
          ),

          ChangeNotifierProvider(
            create: (BuildContext ctx) => FlyersProvider(),
          ),

          ChangeNotifierProvider(
            create: (BuildContext ctx) => KeywordsProvider(),
          ),


          ChangeNotifierProvider(
            create: (BuildContext ctx) => QuestionsProvider(),
          ),

        ],
        child: ValueListenableBuilder<Locale>(
          valueListenable: _locale,
          builder: (BuildContext ctx, Locale value, Widget child){

            return
              MaterialApp(
                debugShowCheckedModeBanner: false,
                debugShowMaterialGrid: false,
                showPerformanceOverlay: false,
                checkerboardOffscreenLayers: false,
                checkerboardRasterCacheImages: false,

                title: 'Bldrs.net',

                // theme:
                // ThemeData(
                //   primarySwatch: MaterialColor(),
                //   accentColor: Colorz.BlackBlack,
                // ),
                locale: _locale.value,
                supportedLocales: _supportedLocales,
                localizationsDelegates: _localizationDelegates,
                localeResolutionCallback: (Locale deviceLocale, Iterable<Locale> supportedLocales) {
                  for (Locale locale in supportedLocales) {
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
                  Routez.FlyerScreen: (BuildContext ctx) => const FlyerScreen(),
                  // Routez.Starting: (ctx) => StartingScreen(),
                  Routez.UserChecker: (BuildContext ctx) => UserChecker(key: const ValueKey<String>('userChecker'),),
                  Routez.Home: (BuildContext ctx) => HomeScreen(notiIsOn: _notiIsOn,),
                  // Routez.InPyramids: (ctx) => InPyramidsScreen(),
                },
              );

          },
        ),
      );
    }
  }
}
