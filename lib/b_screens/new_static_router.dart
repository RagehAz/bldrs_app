import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/legalizer/legalizer.dart';
import 'package:bldrs/a_models/f_flyer/sub/review_model.dart';
import 'package:bldrs/b_screens/a_home_screen/the_home_screen.dart';
import 'package:bldrs/b_views/a_starters/c_error_screen/delete_my_data_screen.dart';
import 'package:bldrs/b_views/a_starters/c_error_screen/under_construction_screen.dart';
import 'package:bldrs/b_views/a_starters/x_banner_screen/banner_screen.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/d_auth_page/a_auth_screen.dart';
import 'package:bldrs/b_screens/d_user_preview_screen/user_preview_screen.dart';
import 'package:bldrs/b_views/f_bz/f_bz_preview_screen/a_bz_preview_screen.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/a_flyer_preview_screen.dart';
import 'package:bldrs/f_helpers/router/a_route_name.dart';
import 'package:bldrs/f_helpers/router/b_static_router.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
import 'package:flutter/material.dart';

class NewStaticRouter {
  // -----------------------------------------------------------------------------

  const NewStaticRouter();

  // -----------------------------------------------------------------------------

  /// ROUTER

  // --------------------
  /// TESTED : WORKS PERFECT : ROUTES_LIST
  static Route<dynamic> router(RouteSettings settings) {

    final String? _path = StaticRouter.getPathFromRouteSettingsName(settings.name);

    final String? _arg = StaticRouter.getArgFromRouteSettingsName(settings.name);

    switch (_path) {
    // ------------------------------------------------------------
    /// home
      case '/': return Nav.transitFade(
          screen: const TheHomeScreen(),
          settings: settings,
      );
    // --------------------
    /// auth
      case RouteName.auth: return BldrsNav.transitSuperHorizontal(
          screen: const AuthScreen(),
          settings: settings
      );
    // --------------------
    /// userPreview
      case RouteName.userPreview: return BldrsNav.transitSuperHorizontal(
        settings: settings,
        screen: UserPreviewScreen(userID: _arg,),
      );
    // --------------------
    /// bzPreview
      case RouteName.bzPreview: return BldrsNav.transitSuperHorizontal(
        settings: settings,
        screen: BzPreviewScreen(bzID: _arg,),
      );
    // --------------------
    /// flyerPreview
      case RouteName.flyerPreview:
        return Nav.transit(
          screen: FlyerPreviewScreen(
            flyerID: _arg,
          ),
          settings: settings,
          pageTransitionType: PageTransitionType.bottomToTop,
        );
    // --------------------
    /// flyerReviews
      case RouteName.flyerReviews:
        return BldrsNav.transitSuperHorizontal(
          settings: settings,
          screen: FlyerPreviewScreen(
            flyerID: ReviewModel.getFlyerIDFromLinkPart(
              linkPart: _arg,
            ),
            reviewID: ReviewModel.getReviewIDFromLinkPart(
              linkPart: _arg,
            ),
          ),
        );
    // ------------------------------------------------------------

    /// WEB

    // --------------------
    /// underConstruction
      case RouteName.underConstruction:
        return Nav.transitFade(
          screen: const BldrsUnderConstructionScreen(),
          settings: settings,
        );
    // --------------------
    /// banner
      case RouteName.banner:
        return Nav.transitFade(
          screen: const BannerScreen(),
          settings: settings,
        );
    // --------------------
    /// privacy
      case RouteName.privacy:
        return Nav.transitFade(
          screen: const PrivacyScreen(),
          settings: settings,
        );
    // --------------------
    /// terms
      case RouteName.terms:
        return Nav.transitFade(
          screen: const TermsScreen(),
          settings: settings,
        );
    // --------------------
    /// deleteMyData
      case RouteName.deleteMyData:
        return BldrsNav.transitSuperHorizontal(
          screen: const DeleteMyDataScreen(),
          settings: settings,
        );
    // ------------------------------------------------------------
    //   case RouteName.staticLogo:return Nav.transitFade(screen: const StaticLogoScreen(), settings: settings,);
    //   case RouteName.animatedLogo:return Nav.transitFade(screen: const AnimatedLogoScreen(), settings: settings,);
    //   case RouteName.search:return BldrsNav.transitSuperHorizontal(screen: const SuperSearchScreen(), settings: settings);
    //   case RouteName.appSettings:return BldrsNav.transitSuperHorizontal(screen: const AppSettingsScreen(), settings: settings);
    //   case RouteName.myUserProfile:return BldrsNav.transitSuperHorizontal(settings: settings, screen: const UserProfileScreen());
    //   case RouteName.myUserNotes: return BldrsNav.transitSuperHorizontal(settings: settings, screen: const UserProfileScreen(userTab: UserTab.notifications,));
    //   case RouteName.myUserFollowing:return BldrsNav.transitSuperHorizontal(settings: settings, screen: const UserProfileScreen(userTab: UserTab.following,),);
    //   case RouteName.myUserSettings:return BldrsNav.transitSuperHorizontal(screen: const UserProfileScreen(userTab: UserTab.settings,), settings: settings);
    //   case RouteName.savedFlyers:return BldrsNav.transitSuperHorizontal(screen: const SavedFlyersScreen(), settings: settings);
    //   case RouteName.myBzAboutPage:return BldrsNav.transitSuperHorizontal(settings: settings, screen: const MyBzScreen(initialTab: BzTab.about,));
    //   case RouteName.myBzFlyersPage: return BldrsNav.transitSuperHorizontal(settings: settings, screen: const MyBzScreen(),);
    //   case RouteName.myBzTeamPage: return BldrsNav.transitSuperHorizontal(settings: settings, screen: const MyBzScreen(initialTab: BzTab.team,),);
    //   case RouteName.myBzNotesPage: return BldrsNav.transitSuperHorizontal(settings: settings, screen: const MyBzScreen(initialTab: BzTab.notes,));
    //   case RouteName.myBzSettingsPage: return BldrsNav.transitSuperHorizontal(settings: settings, screen: const MyBzScreen(initialTab: BzTab.settings,),);
    // ------------------------------------------------------------

    /// NOTHING

    // --------------------
      default:
        return Nav.transitFade(
          screen: const TheHomeScreen(),
          settings: settings,
        );
    // ------------------------------------------------------------
    }

  }
  // -----------------------------------------------------------------------------
}
