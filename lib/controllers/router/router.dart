import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/router/route_names.dart';
import 'package:bldrs/views/screens/a_0_user_checker_widget.dart';
import 'package:bldrs/views/screens/e_0_saved_flyers_screen.dart';
import 'package:bldrs/views/screens/g_1_notifications_screen.dart';
import 'package:bldrs/views/screens/h_0_flyer_screen.dart';
import 'package:bldrs/views/screens/a_2_starting_screen.dart';
import 'package:bldrs/views/screens/c_0_search_screen.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/dynamic_links_test.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/xxx_obelisk.dart';
import 'package:flutter/material.dart';

class Routerer {
  static Route<dynamic> allRoutes(RouteSettings settings) {

    /// TASK : check passing arguments inside Routerer
    // final _arg = settings.arguments;

    switch (settings.name) {

// -----------------------------------------------------------------------------
    /// ccc
      case Routez.DynamicLinkTest:
        return Nav.fadeToScreen(DynamicLinkTest(), settings); break;
// -----------------------------------------------------------------------------
    /// s00
      case Routez.UserChecker:
        return Nav.fadeToScreen(UserChecker(), settings); break;
// -----------------------------------------------------------------------------
    /// s01
    /// (s02 signin page, s03 register page) are pages insides StartingScreen();
      case Routez.Starting:
        return Nav.fadeToScreen(StartingScreen(), settings); break;
// -----------------------------------------------------------------------------
//     /// s10
//       case Routez.Home:
//         return Nav.fadeToScreen(HomeScreen(), settings); break;
// -----------------------------------------------------------------------------
    /// s12
      case Routez.SavedFlyers:
        return Nav.slideToScreen(SavedFlyersScreen(), settings); break;
// -----------------------------------------------------------------------------
    /// s13
      case Routez.News:
        return Nav.slideToScreen(NotificationsScreen(), settings); break;
// -----------------------------------------------------------------------------
//     /// s14
//       case Routez.More:
//         return MaterialPageRoute(builder: (_) => MoreScreen());
// -----------------------------------------------------------------------------
//     /// s15
//       case Routez.Profile:
//         return Nav.slideToScreen(UserProfileScreen(), settings); break;
// -----------------------------------------------------------------------------
//     /// s16
//       case Routez.EditProfile:
//         return MaterialPageRoute(builder: (_) => EditProfileScreen(user: superUserID()));
// -----------------------------------------------------------------------------
    /// s20
      case Routez.Search:
        return Nav.fadeToScreen(SearchScreen(), settings); break;
// -----------------------------------------------------------------------------
//     /// s40
//       case Routez.BzEditor:
//         return MaterialPageRoute(builder: (_) => BzEditorScreen());
// -----------------------------------------------------------------------------
//     /// s41
//       case Routez.MyBz:
//         return MaterialPageRoute(builder: (_) => MyBzScreen());
// -----------------------------------------------------------------------------
//     /// s42
//       case Routez.EditBz:
//         return MaterialPageRoute(builder: (_) => EditBzScreen());
// -----------------------------------------------------------------------------
//     /// s50
//       case Routez.FlyerEditor:
//         return MaterialPageRoute(builder: (_) => FlyerEditorScreen());
// -----------------------------------------------------------------------------
    ///  s51
      case Routez.FlyerScreen:
        return Nav.slideToScreen(FlyerScreen(), settings); break;
// -----------------------------------------------------------------------------

    // --- XXX GENERAL SCREENS
    ///  xxx
      case Routez.Obelisk:
        return Nav.slideToScreen(ObeliskScreen(), settings); break;

// -----------------------------------------------------------------------------

    }
    return Nav.fadeToScreen(UserChecker(), settings);
  }
}
