import 'package:bldrs/b_views/x_screens/a_starters/a_1_home_screen.dart';
import 'package:bldrs/b_views/x_screens/b_auth/b_0_auth_screen.dart';
import 'package:bldrs/b_views/x_screens/c_search/c_0_search_screen.dart';
import 'package:bldrs/b_views/x_screens/e_saves/e_0_saved_flyers_screen.dart';
import 'package:bldrs/b_views/x_screens/i_flyer/h_0_flyer_screen.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/router/route_names.dart';
import 'package:bldrs/b_views/x_screens/a_starters/a_new_logo_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> allRoutes(RouteSettings settings) {

  switch (settings.name) {

  // --------------------------
  /// LOGO SCREEN
    case Routez.logoScreen:
      return Nav.fadeToScreen(const NewLogoScreen(), settings);
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
    case Routez.search:
      return Nav.fadeToScreen(const SearchScreen(), settings);
      break;
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
    case Routez.flyerScreen:
      return Nav.slideToScreen(const FlyerScreen(), settings);
      break;
// -----------------------------------------------------------------------------

  }
  return Nav.fadeToScreen(const NewLogoScreen(), settings);
}
