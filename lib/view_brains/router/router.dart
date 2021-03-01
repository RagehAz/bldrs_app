import 'package:bldrs/views/screens/s00_user_checker_widget.dart';
import 'package:bldrs/views/screens/s12_saved_flyers_screen.dart';
import 'package:bldrs/views/screens/s13_news_screen.dart';
import 'package:bldrs/views/screens/s14_more_screen.dart';
import 'package:bldrs/views/screens/s15_profile_screen.dart';
import 'package:bldrs/views/screens/s41_my_bz_screen.dart';
import 'package:bldrs/views/screens/s42_edit_bz_screen.dart';
import 'package:bldrs/views/screens/s51_flyer_screen.dart';
import 'package:bldrs/views/screens/s40_create_bz_screen.dart';
import 'package:bldrs/views/screens/s50_flyer_maker_screen.dart';
import 'package:bldrs/views/screens/s00_splash_screen.dart';
import 'package:bldrs/views/screens/s01_starting_screen.dart';
import 'package:bldrs/views/screens/s10_home_screen.dart';
import 'package:bldrs/views/screens/s20_search_screen.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x01_access_denied_screen.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/xxx_obelisk.dart';
import 'package:flutter/material.dart';
import 'route_names.dart';

class Routerer {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    switch (settings.name) {

// ---------------------------------------------------------------------------
    /// s00
      case Routez.UserChecker:
        return MaterialPageRoute(builder: (_) => UserChecker());
// ---------------------------------------------------------------------------
    /// s00
      case Routez.Splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
// ---------------------------------------------------------------------------
    /// s01
    /// (s02 signin page, s03 register page) are pages insides StartingScreen();
      case Routez.Starting:
        return MaterialPageRoute(builder: (_) => StartingScreen());
// ---------------------------------------------------------------------------
    /// s10
      case Routez.Home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
// ---------------------------------------------------------------------------
    /// s12
      case Routez.SavedFlyers:
        return MaterialPageRoute(builder: (_) => SavedFlyersScreen());
// ---------------------------------------------------------------------------
    /// s13
      case Routez.News:
        return MaterialPageRoute(builder: (_) => NewsScreen());
// ---------------------------------------------------------------------------
    /// s14
      case Routez.More:
        return MaterialPageRoute(builder: (_) => MoreScreen());
// ---------------------------------------------------------------------------
    /// s15
      case Routez.Profile:
        return MaterialPageRoute(builder: (_) => UserProfileScreen());
// ---------------------------------------------------------------------------
//     /// s16
//       case Routez.EditProfile:
//         return MaterialPageRoute(builder: (_) => EditProfileScreen(user: superUserID()));
// ---------------------------------------------------------------------------
    /// s20
      case Routez.Search:
        return MaterialPageRoute(builder: (_) => SearchScreen());
// ---------------------------------------------------------------------------
    /// s40
      case Routez.CreateBz:
        return MaterialPageRoute(builder: (_) => CreateBzScreen());
// ---------------------------------------------------------------------------
    /// s41
      case Routez.MyBz:
        return MaterialPageRoute(builder: (_) => MyBzScreen());
// ---------------------------------------------------------------------------
    /// s42
      case Routez.EditBz:
        return MaterialPageRoute(builder: (_) => EditBzScreen());
// ---------------------------------------------------------------------------
    /// s50
      case Routez.FlyerMaker:
        return MaterialPageRoute(builder: (_) => FlyerMakerScreen());
// ---------------------------------------------------------------------------
    ///  s51
      case Routez.FlyerScreen:
        return MaterialPageRoute(builder: (_) => FlyerScreen());
// ---------------------------------------------------------------------------

    // --- XXX GENERAL SCREENS
    ///  xxx
      case Routez.Obelisk:
        return MaterialPageRoute(builder: (_) => ObeliskScreen());

// ---------------------------------------------------------------------------

    }

    return MaterialPageRoute(builder: (_) => AccessDeniedScreen());
  }
}
