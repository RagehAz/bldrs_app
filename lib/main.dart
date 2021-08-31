import 'package:bldrs/controllers/localization/localizer.dart';
import 'package:bldrs/controllers/notifications/noti_channelz.dart';
import 'package:bldrs/controllers/router/route_names.dart';
import 'package:bldrs/controllers/router/router.dart';
import 'package:bldrs/firestore/user_ops.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/providers/zones/zone_provider.dart';
import 'package:bldrs/providers/flyers_and_bzz/flyers_provider.dart';
import 'package:bldrs/views/screens/a_0_user_checker_widget.dart';
import 'package:bldrs/views/screens/b_0_home_screen.dart';
import 'package:bldrs/views/screens/h_0_flyer_screen.dart';
import 'package:bldrs/views/widgets/ask/question/questions_provider.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:bldrs/xxx_LABORATORY/camera_and_location/test_provider.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/dynamic_links_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:bldrs/models/notification/noti_model.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() async {

  /// TASK : In optimization : study this : https://pub.dev/packages/keframe
  // debugPrintMarkNeedsPaintStacks = false;
  // debugProfilePaintsEnabled = false;
  // debugProfileBuildsEnabled = false;
  // debugRepaintTextRainbowEnabled = false;
  // debugPaintLayerBordersEnabled = false;
  // debugRepaintRainbowEnabled = false;

  /// insures awaiting async methods below to finish then continue
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  AwesomeNotifications _awesomeNotification = AwesomeNotifications();


  _awesomeNotification.initialize(
    'resource://drawable/res_flat_logo',
    <NotificationChannel>[
      NotiChannelz.basicNotificationChannel(),
      NotiChannelz.scheduledNotificationChannel(),
    ],
  );


  runApp(BldrsApp());

}


// AndroidNotificationChannel channel;
// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // if (!kIsWeb) {
  //   channel = const AndroidNotificationChannel(
  //     'high_importance_channel', // id
  //     'High Importance Notifications', // title
  //     'This channel is used for important notifications.', // description
  //     importance: Importance.high,
  //   );
  //
  //   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //
  //   /// Create an Android Notification Channel.
  //   ///
  //   /// We use this channel in the `AndroidManifest.xml` file to override the
  //   /// default FCM channel to enable heads up notifications.
  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //       AndroidFlutterLocalNotificationsPlugin>()
  //       ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  // }
    print('Handling a background message ${message.messageId}');
}

class BldrsApp extends StatefulWidget {

  static void setLocale(BuildContext context, Locale locale) {
    _BldrsAppState state = context.findAncestorStateOfType<_BldrsAppState>();
    state._setLocale(locale);
  }

  @override
  _BldrsAppState createState() => _BldrsAppState();
}

class _BldrsAppState extends State<BldrsApp> {
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
    super.initState();
    _initializeFlutterFire();
    _initializeNotifications();
  }
// ---------------------------------------------------------------------------
  @override
  void didChangeDependencies() {
    Localizer.getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }
// ---------------------------------------------------------------------------
  Locale _locale;
  List<Locale> _supportedLocales = Localizer.getSupportedLocales();
  List<LocalizationsDelegate> _localizationDelegates = Localizer.getLocalizationDelegates();
  void _setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
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
  final fbm = FirebaseMessaging.instance;
  void _initializeNotifications(){

    fbm.requestPermission(
      criticalAlert: true,
      carPlay: true,
      announcement: true,
      sound: true,
      provisional: true,
      badge: true,
      alert: true,

    );

    /// when app running in foreground
    FirebaseMessaging.onMessage.listen((event) {
      Map<String, dynamic> msgMap = event.data;

      receiveAndActUponNoti(msgMap: msgMap, notiType: NotiType.onMessage);

    });

    /// when launching the app
    FirebaseMessaging.onMessageOpenedApp.listen((event) {

      // RemoteNotification remoteNotification = event.notification;
      // String category = event.category;
      // String collapseKey = event.collapseKey;
      // bool contentAvailable = event.contentAvailable;
      // String from = event.from;
      // String messageId = event.messageId;
      // String messageType = event.messageType;
      // bool mutableContent = event.mutableContent;
      // String senderId = event.senderId;
      // DateTime sentTime = event.sentTime;
      // String threadId = event.threadId;
      // int ttl = event.ttl;

      Map<String, dynamic> msgMap = event.data;
      receiveAndActUponNoti(msgMap: msgMap, notiType: NotiType.onLaunch);
    });

    /// when app running in background and notification tapped while having
    /// msg['data']['click_action'] == 'FLUTTER_NOTIFICATION_CLICK';
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


    // fbm.getToken();
    fbm.subscribeToTopic('flyers');

  }
// -----------------------------------------------------------------------------
//   NotiModel _noti;
  bool _notiIsOn = false;
  void _setNoti(NotiModel noti){

    if (noti != null){
      setState(() {
        // _noti = noti;
        _notiIsOn = true;
      });
    }

  }
// -----------------------------------------------------------------------------
void receiveAndActUponNoti({dynamic msgMap, NotiType notiType}){
  print('receiveAndActUponNoti : notiType : $notiType');

  NotiModel _noti;

  tryAndCatch(
    context: context,
    onError: (error) => print(error),
    methodName: 'receiveAndActUponNoti',
    functions: (){
      _noti = NotiModel.decipherNotiModel(msgMap);
    },
  );

  _setNoti(_noti);
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
              value: UserOps().streamInitialUser(),
            initialData: UserModel(),
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
          ChangeNotifierProvider(
            create: (ctx) => QuestionsProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          debugShowMaterialGrid: false,
          showPerformanceOverlay: false,
          checkerboardRasterCacheImages: false,

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
            Routez.Home: (ctx) => HomeScreen(notiIsOn: _notiIsOn,),
            // Routez.InPyramids: (ctx) => InPyramidsScreen(),
          },
        ),
      );
    }
  }
}
