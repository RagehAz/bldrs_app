import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bldrs/b_views/a_starters/a_logo_screen/a_static_logo_screen.dart';
import 'package:bldrs/b_views/a_starters/b_home_screen/a_home_screen.dart';
import 'package:bldrs/b_views/b_auth/a_auth_screen/a_auth_screen.dart';
import 'package:bldrs/b_views/c_main_search/a_main_search_screen/a_main_search_screen.dart';
import 'package:bldrs/b_views/e_saves/a_saved_flyers_screen/a_saved_flyers_screen.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/a_flyer_screen.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/b_views/a_starters/a_logo_screen/b_animated_logo_screen.dart';
import 'package:bldrs/x_dashboard/a_dashboard_home/b_dashboard_home_screen/a_dashboard_home_screen.dart';
import 'package:bldrs/x_dashboard/notes_creator/x_lab/d_noot_route_to_screen.dart';
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
  static const String myBz = '/MyBzScreen';
  static const String editBz = '/EditBzScreen';
  // --------------------
  static const String flyerEditor = '/FlyerEditorScreen';
  static const String flyerScreen = '/FlyerFullScreen';
  // --------------------
  static const String ragehDashBoard = '/RagehDashBoardScreen';
  static const String obelisk = '/ObeliskScreen';
  static const String dynamicLinkTest = '/DynamicLinkTest';
  // -----------------------------------------------------------------------------

  /// ROUTER

  // --------------------
  static Route<dynamic> allRoutes(RouteSettings settings) {

    switch (settings.name) {
    // --------------------------
    /// STATIC LOGO SCREEN
      case '/notification-page':
        final ReceivedAction receivedAction = settings.arguments as ReceivedAction;
        return Nav.fadeToScreen(NoteRouteToScreen(
          receivedAction: receivedAction,
        ), settings);
        break;
    // --------------------------
    /// STATIC LOGO SCREEN
      case Routing.staticLogoScreen:
        return Nav.fadeToScreen(const StaticLogoScreen(), settings);
        break;
    // --------------------------
    /// ANIMATED LOGO SCREEN
      case Routing.animatedLogoScreen:
        return Nav.fadeToScreen(const AnimatedLogoScreen(), settings);
        break;
    // --------------------------
    /// AUTH SCREEN
      case Routing.auth:
        return Nav.fadeToScreen(const AuthScreen(), settings);
        break;
    // --------------------------
    /// HOME SCREEN
      case Routing.home:
        return Nav.fadeToScreen(const HomeScreen(), settings);
        break;
    // --------------------------
    /// s12
      case Routing.savedFlyers:
        return Nav.slideToScreen(const SavedFlyersScreen(), settings);
        break;
    // --------------------------
    /// s20
      case Routing.search:
        return Nav.fadeToScreen(const MainSearchScreen(), settings);
        break;
    // --------------------------
    ///  s51
      case Routing.flyerScreen:
        return Nav.slideToScreen(const FlyerScreen(), settings);
        break;
    // --------------------------
    ///  s51
      case Routing.ragehDashBoard:
        return Nav.fadeToScreen(const DashBoardHomeScreen(), settings);
        break;
    // --------------------------
    }
    return Nav.fadeToScreen(const AnimatedLogoScreen(), settings);
  }
// -----------------------------------------------------------------------------
}
