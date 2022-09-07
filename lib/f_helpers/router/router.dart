import 'package:bldrs/b_views/a_starters/a_logo_screen/a_static_logo_screen.dart';
import 'package:bldrs/b_views/a_starters/b_home_screen/a_home_screen.dart';
import 'package:bldrs/b_views/b_auth/a_auth_screen/a_auth_screen.dart';
import 'package:bldrs/b_views/c_main_search/a_main_search_screen/a_main_search_screen.dart';
import 'package:bldrs/b_views/e_saves/a_saved_flyers_screen/a_saved_flyers_screen.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/a_flyer_screen.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/router/route_names.dart';
import 'package:bldrs/b_views/a_starters/a_logo_screen/b_animated_logo_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> allRoutes(RouteSettings settings) {

  switch (settings.name) {

  // --------------------------
  /// STATIC LOGO SCREEN
    case Routez.staticLogoScreen:
      return Nav.fadeToScreen(const StaticLogoScreen(), settings);
      break;
  // --------------------------
  /// ANIMATED LOGO SCREEN
    case Routez.animatedLogoScreen:
      return Nav.fadeToScreen(const AnimatedLogoScreen(), settings);
      break;
  // --------------------------
  /// AUTH SCREEN
    case Routez.auth:
      return Nav.fadeToScreen(const AuthScreen(), settings);
      break;
  // --------------------------
  /// HOME SCREEN
    case Routez.home:
      return Nav.fadeToScreen(const HomeScreen(), settings);
      break;
  // --------------------------
  /// s12
    case Routez.savedFlyers:
      return Nav.slideToScreen(const SavedFlyersScreen(), settings);
      break;
  // --------------------------
  /// s20
    case Routez.search:
      return Nav.fadeToScreen(const MainSearchScreen(), settings);
      break;
  // --------------------------
  ///  s51
    case Routez.flyerScreen:
      return Nav.slideToScreen(const FlyerScreen(), settings);
      break;
  // --------------------------
  }
  return Nav.fadeToScreen(const AnimatedLogoScreen(), settings);
}
