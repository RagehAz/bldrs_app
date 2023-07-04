import 'package:bldrs/b_views/a_starters/a_logo_screen/a_static_logo_screen.dart';
import 'package:bldrs/b_views/a_starters/b_home_screen/a_home_screen.dart';
import 'package:bldrs/b_views/b_auth/a_auth_screen/a_auth_screen.dart';
import 'package:bldrs/b_views/c_main_search/super_search_screen.dart';
import 'package:bldrs/b_views/e_saves/a_saved_flyers_screen/a_saved_flyers_screen.dart';
import 'package:bldrs/b_views/h_app_settings/a_app_settings_screen/a_app_settings_screen.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/b_views/a_starters/a_logo_screen/b_animated_logo_screen.dart';
import 'package:flutter/material.dart';

class Routing {
  // -----------------------------------------------------------------------------

  const Routing();

  // -----------------------------------------------------------------------------

  /// ROUTE NAMES

  // --------------------
  static const String staticLogoScreen = '/';
  static const String animatedLogoScreen = '/animatedLogoScreen';
  // --------------------
  static const String home = '/HomeScreen';
  /// (s02 signin page, s03 register page) are pages insides StartingScreen();
  static const String auth = '/AuthScreen';
  static const String savedFlyers = '/SavedFlyersScreen';
  static const String news = '/NewsScreen';
  static const String more = '/MoreScreen';
  static const String profile = '/UserProfileScreen';
  static const String profileEditor = '/ProfileEditorScreen';
  // --------------------
  static const String search = '/SearchScreen';
  // --------------------
  static const String bzEditor = '/BzEditorScreen';
  static const String myBzFlyersPage = '/MyBzScreen';
  static const String myBzAboutPage = '/MyBzScreen/AboutPage';
  static const String myBzNotesPage = '/MyBzScreen/NotesPage';
  static const String myBzTeamPage = '/MyBzScreen/TeamPage';
  static const String editBz = '/EditBzScreen';
  // --------------------
  static const String flyerEditor = '/FlyerEditorScreen';
  static const String flyerScreen = '/FlyerFullScreen'; /// TASK : WHO ARE YOU ?
  // --------------------
  static const String obelisk = '/ObeliskScreen';
  static const String dynamicLinkTest = '/DynamicLinkTest';
  // --------------------
  static const String userPreview = '/userPreview';
  static const String bzPreview = '/bzPreview';
  static const String countryPreview = '/countryPreview';
  static const String flyerPreview = '/flyerPreview';
  static const String flyerReviews = '/flyerPreview/flyerReviews';
  static const String bldrsPreview = '/bldrsPreview';
  // --------------------
  static const String myUserScreen = '/myUserScreen';
  static const String myUserNotesPage = '/myUserNotesPage';
  // --------------------
  static const String appSettings = '/appSettings';
  // --------------------
  static const String dashboard = '/dashboard';
  // -----------------------------------------------------------------------------

  /// ROUTER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Route<dynamic> allRoutes(RouteSettings settings) {

    switch (settings.name) {
    // --------------------------
    /*
    /// NOTIFICATION PAGE
      case '/notification-page':
        final ReceivedAction receivedAction = settings.arguments as ReceivedAction;
        return Nav.fadeToScreen(NoteRouteToScreen(
          receivedAction: receivedAction,
        ), settings);
        break;
     */
    // --------------------------
    /// STATIC LOGO SCREEN
      case Routing.staticLogoScreen:
        return Nav.fadeToScreen(const StaticLogoScreen(), settings);
    // --------------------------
    /// ANIMATED LOGO SCREEN
      case Routing.animatedLogoScreen:
        return Nav.fadeToScreen(const AnimatedLogoScreen(), settings);
    // --------------------------
    /// AUTH SCREEN
      case Routing.auth:
        return Nav.fadeToScreen(const AuthScreen(), settings);
    // --------------------------
    /// HOME SCREEN
      case Routing.home:
        return Nav.fadeToScreen(const HomeScreen(), settings);
    // --------------------------
    /// s12
      case Routing.savedFlyers:
        return Nav.slideToScreen(const SavedFlyersScreen(), settings);
    // --------------------------
    /// s20
      case Routing.search:
        return Nav.fadeToScreen(const SuperSearchScreen(), settings);
    // --------------------------
      case Routing.appSettings:
        return Nav.fadeToScreen(const AppSettingsScreen(), settings);
    // --------------------------
    /*
    ///  s51
      case Routing.flyerScreen:
        return Nav.slideToScreen(const FlyerPreviewScreen(), settings);
        break;
     */
    // --------------------------
    }
    return Nav.fadeToScreen(const AnimatedLogoScreen(), settings);
  }
  // -----------------------------------------------------------------------------
}
