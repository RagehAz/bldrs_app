import 'package:bldrs/views/widgets/auth/user_checker.dart';
import 'package:bldrs/views/widgets/pro_flyer/flyer_screen.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/aa03_signup_screen.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x10_pro_flyer_page_view.dart';
import 'package:bldrs/views/screens/s01_wrapper.dart';
import 'package:bldrs/views/screens/s02_starting_screen.dart';
import 'package:bldrs/views/screens/s03_user_type_screen.dart';
import 'package:bldrs/views/screens/s04_localizer_screen.dart';
import 'package:bldrs/views/screens/s11_home_screen.dart';
import 'package:bldrs/views/screens/s13_in_pyramids_screen.dart';
import 'package:bldrs/views/screens/s21_search_screen.dart';
import 'package:bldrs/views/screens/s41_add_bz.dart';
import 'package:bldrs/views/screens/s44_bz_card_review.dart';
import 'package:bldrs/views/screens/sss_bz_complete_profile_screen.dart';
import 'package:bldrs/views/screens/sss_flyer_maker.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x01_access_denied_screen.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x02_rageh_dash_board.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x03_font_test_screen.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x05_Hero_test.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x06_swiper_layout.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x06_single_collection_screen.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x07_chat_screen.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x08_earth_screen.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x09_id_screen.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x11_pro_flyer_grid_view.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/xxx_obelisk.dart';
import 'package:flutter/material.dart';
import 'route_names.dart';

class Routerer {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    switch (settings.name) {

      // --- 000 STARTING SCREENS
    // 010
      case Routez.UserChecker:
        return MaterialPageRoute(builder: (_) => UserChecker());
      // 010
      case Routez.Splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      // 020
      case Routez.Starting:
        return MaterialPageRoute(builder: (_) => StartingScreen());
      // 021
      case Routez.Localizer:
        return MaterialPageRoute(builder: (_) => LocalizerScreen());
      // 030
      case Routez.ChooseUserType:
        return MaterialPageRoute(builder: (_) => ChooseUserTypeScreen());
      // 040
      case Routez.BzCompleteProfile:
        return MaterialPageRoute(builder: (_) => BzCompleteProfileScreen());

      // --- 100 MAIN SCREENS
      // 110
      case Routez.Home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      // 120
      case Routez.FlyerScreen:
        return MaterialPageRoute(builder: (_) => FlyerScreen());
      // 130
      case Routez.InPyramids:
        return MaterialPageRoute(builder: (_) => InPyramidsScreen());
      // 140
      case Routez.FlyerMaker:
        return MaterialPageRoute(builder: (_) => FlyerMakerScreen());

      // --- 200 SEARCH SCREENS
      // 210
      case Routez.Search:
        return MaterialPageRoute(builder: (_) => SearchScreen());

      // --- 300 PROFILE SCREENS
      // // 320
      // case Routez.Profile:
      //   return MaterialPageRoute(builder: (_) => ProfileScreen());
      // 330
      case Routez.SingleCollection:
        return MaterialPageRoute(builder: (_) => SingleCollectionScreen());


        // BzSignUpScreen
      // --- 400 BUSINESS SIGNUP SCREENS
    // 410
      case Routez.AddBz:
        return MaterialPageRoute(builder: (_) => AddBzScreen());

      // // 420
      // case Routez.AddBzLogo:
      //   return MaterialPageRoute(builder: (_) => AddBzLogoScreen());

      // 430
      // case Routez.AddBzDetails:
      //   return MaterialPageRoute(builder: (_) => AddBzDetailsScreen());

      // 440
      case Routez.BzCardReview:
        return MaterialPageRoute(builder: (_) => BzCardReviewScreen());


      // --- XXX DASHBOARD
      // x01
      case Routez.AccessDenied:
        return MaterialPageRoute(builder: (_) => AccessDeniedScreen());
      // x02
      case Routez.RagehDashBoard:
        return MaterialPageRoute(builder: (_) => RagehDashBoardScreen());
      // x03
      case Routez.FontTest:
        return MaterialPageRoute(builder: (_) => FontTestScreen());
      // x04
      // case Routez.FlyersTest:
      //   return MaterialPageRoute(builder: (_) => FlyersTestScreen());
      case Routez.HeroTest:
        return MaterialPageRoute(builder: (_) => HeroTestScreen());
      // xxx
      case Routez.Obelisk:
        return MaterialPageRoute(builder: (_) => ObeliskScreen());

      // --- ZEBALA
      case Routez.SignUp:
        return MaterialPageRoute(builder: (_) => SignUpScreen());

      // case Routez.SignIn:
      //   return MaterialPageRoute(builder: (_) => SignInScreen());

      case Routez.MainLayout:
        return MaterialPageRoute(builder: (_) => SwiperLayout());

      case Routez.ChatScreen:
        return MaterialPageRoute(builder: (_) => ChatScreen());

      case Routez.IDScreen:
        return MaterialPageRoute(builder: (_) => IDscreen());

      case Routez.EarthScreen:
        return MaterialPageRoute(builder: (_) => EarthScreen());

      case Routez.ProFlyersPageView:
        return MaterialPageRoute(builder: (_) => ProFlyersPageView());


      case Routez.ProFlyersGridView:
        return MaterialPageRoute(builder: (_) => ProFlyersGridView());
    }

    return MaterialPageRoute(builder: (_) => AccessDeniedScreen());
  }
}
