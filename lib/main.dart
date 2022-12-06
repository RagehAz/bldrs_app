import 'dart:async';

import 'package:bldrs/b_views/a_starters/a_logo_screen/a_static_logo_screen.dart';
import 'package:bldrs/b_views/a_starters/a_logo_screen/b_animated_logo_screen.dart';
import 'package:bldrs/b_views/a_starters/b_home_screen/a_home_screen.dart';
import 'package:bldrs/b_views/z_components/images/super_image/a_super_image.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/general_provider.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/search_provider.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/flyer_protocols/provider/flyers_provider.dart';
import 'package:bldrs/c_protocols/note_protocols/provider/notes_provider.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/provider/zone_provider.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm_starter.dart';
import 'package:bldrs/e_back_end/e_fcm/z_noot_controller.dart';
import 'package:bldrs/e_back_end/f_cloud/dynamic_links.dart';
import 'package:bldrs/e_back_end/i_app_check/app_check.dart';
import 'package:bldrs/f_helpers/drafters/sounder.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/router/routing.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
/*

malak2817

28 17 90 3030
http://mhiptv.com:8888

  MAKKAR TALK

  - it would be nice if you would like to contribute in Bldrs
      - contribution form
        - as ambassador
        - as investor
        - as fund raiser
        -

  siliconValleyBank.com

  accountantsOnAir.com

  dalware

 */
Future<void> main() async {
  /// -----------------------------------------------------------------------------
  /*
    /// PLAN : In optimization : study this : https://pub.dev/packages/keframe
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
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );
  // --------------------
  await FCMStarter.preInitializeNootsInMainFunction();
  // --------------------
  await AppCheck.preInitialize();
  /// --------------------
  runApp(const BldrsAppStarter());
  /// -----------------------------------------------------------------------------
}

class BldrsAppStarter extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BldrsAppStarter({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  static void setLocale(BuildContext context, Locale locale) {
    final _BldrsAppStarterState state = context.findAncestorStateOfType<_BldrsAppStarterState>();
    state._setLocale(locale);
  }
  /// --------------------------------------------------------------------------
  @override
  _BldrsAppStarterState createState() => _BldrsAppStarterState();
  /// --------------------------------------------------------------------------
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  /// --------------------------------------------------------------------------
}

class _BldrsAppStarterState extends State<BldrsAppStarter> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<String> _fireError = ValueNotifier<String>(null);
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
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
      _triggerLoading(setTo: true).then((_) async {

        /// LOCALE
        await Localizer.initializeLocale(_locale);

        /// FIREBASE
        await Fire.initializeFirestore(
          fireError: _fireError,
        );

        /// INITIALIZE NOOTS
        await FCMStarter.initializeNootsInBldrsAppStarter();
        /// NOOT LISTENERS
        _initializeNootListeners();

        /// DYNAMIC LINKS
        await DynamicLinks.initializeDynamicLinks(context);

        /// END
        await _triggerLoading(setTo: false);

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
    _closeNootListeners();
    FCM.disposeAwesomeNoots();

    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// NOOT STREAMS

  // --------------------
  StreamSubscription _action;
  StreamSubscription _created;
  StreamSubscription _dismissed;
  StreamSubscription _displayed;
  // --------------------
  void _initializeNootListeners(){
    _action = NootListener.listenToNootActionStream();
    _created = NootListener.listenToNootCreatedStream();
    // _dismissed = NootListener.listenToNootDismissedStream(); Unhandled Exception: Bad state: Stream has already been listened to.
    _displayed = NootListener.listenToNootDisplayedStream();
  }
  // --------------------
  void _closeNootListeners(){
    _action.cancel();
    _created.cancel();
    _dismissed.cancel();
    _displayed.cancel();
  }
  // -----------------------------------------------------------------------------

  /// LOCALE

  // --------------------
  final ValueNotifier<Locale> _locale = ValueNotifier<Locale>(null);
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
              /// KEYS
              // key: ,
              // scaffoldMessengerKey: ,
              // restorationScopeId: ,

              /// DUNNO
              // actions: ,
              builder: (BuildContext context, Widget widget) {

                ErrorWidget.builder = (FlutterErrorDetails errorDetails) {

                  // blogFlutterErrorDetails(errorDetails);

                  final String _text = TextMod.removeTextBeforeLastSpecialCharacter(errorDetails.exception.toString(), ':');

                  return Center(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colorz.red255,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          const SuperImage(
                            width: 40,
                            height: 40,
                            pic: Iconz.dvGouran,
                            iconColor: Colorz.black255,
                          ),

                          SuperVerse(
                            verse: Verse(
                              text: _text,
                              translate: false,
                              casing: Casing.upperCase,
                            ),
                            maxLines: 20,
                            color: Colorz.black255,
                            margin: 20,
                            weight: VerseWeight.black,
                            italic: true,
                            size: 4,
                            labelColor: Colorz.black50,
                          ),

                        ],
                      ),
                    ),
                  );
                };

                return widget;
                },

              // home: ,
              // useInheritedMediaQuery: ,
              // shortcuts: ,
              // scrollBehavior: ,

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
              locale: _locale.value,
              supportedLocales: Localizer.getSupportedLocales(),
              localizationsDelegates: Localizer.getLocalizationDelegates(),
              localeResolutionCallback: Localizer.localeResolutionCallback,
              // localeListResolutionCallback: ,

              /// ROUTES
              // navigatorObservers: [],
              // onGenerateInitialRoutes: ,
              // onUnknownRoute: ,
              navigatorKey: BldrsAppStarter.navigatorKey,
              onGenerateRoute: Routing.allRoutes,
              initialRoute: Routing.staticLogoScreen,
              routes: <String, Widget Function(BuildContext)>{

                /// STARTERS
                Routing.staticLogoScreen: (BuildContext ctx) => const StaticLogoScreen(key: ValueKey<String>('LogoScreen'),),
                Routing.home: (BuildContext ctx) => const HomeScreen(),

                // Routing.flyerScreen: (BuildContext ctx) => const FlyerPreviewScreen(),
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
