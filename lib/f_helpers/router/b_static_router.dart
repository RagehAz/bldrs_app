import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/legalizer/legalizer.dart';
import 'package:bldrs/a_models/f_flyer/sub/review_model.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/c_user_pages/b_my_saves_page/saved_flyers_screen.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/e_app_settings_page/app_settings_page.dart';
import 'package:bldrs/b_screens/b_user_screens/d_user_preview_screen/user_preview_screen.dart';
import 'package:bldrs/b_screens/c_error_screen/delete_my_data_screen.dart';
import 'package:bldrs/b_screens/c_error_screen/no_page_found.dart';
import 'package:bldrs/b_screens/c_error_screen/under_construction_screen.dart';
import 'package:bldrs/b_screens/x_banner_screen/banner_screen.dart';
import 'package:bldrs/b_views/c_main_search/super_search_screen.dart';
import 'package:bldrs/b_views/f_bz/f_bz_preview_screen/a_bz_preview_screen.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/a_flyer_preview_screen.dart';
import 'package:bldrs/f_helpers/router/a_route_name.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
import 'package:flutter/material.dart';

class StaticRouter {
  // -----------------------------------------------------------------------------

  const StaticRouter();

  // -----------------------------------------------------------------------------

  /// ROUTER

  // --------------------
  /// TESTED : WORKS PERFECT : ROUTES_LIST
  static Route<dynamic> router(RouteSettings settings) {

    final String? _path = getPathFromRouteSettingsName(settings.name);

    final String? _arg = getArgFromRouteSettingsName(settings.name);

    switch (_path) {
      // ------------------------------------------------------------

      /// LOADING

      // --------------------
      // /// staticLogoScreen
      // case RouteName.staticLogo:
      //   return Nav.transitFade(
      //       screen: const StaticLogoScreen(),
      //       settings: settings,
      //   );
      // // --------------------
      // /// animatedLogoScreen
      // case RouteName.animatedLogo:
      //   return Nav.transitFade(
      //       screen: const AnimatedLogoScreen(),
      //       settings: settings,
      //   );
      // ------------------------------------------------------------

      /// MAIN

      // --------------------
      // /// home
      // case RouteName.home:
      //   return Nav.transitFade(
      //       screen: const HomeScreen(),
      //       settings: settings,
      //   );
      // --------------------
      // /// auth
      // case RouteName.auth:
      //   return BldrsNav.transitSuperHorizontal(
      //     screen: const AuthScreen(),
      //     settings: settings,
      //   );
      // --------------------
      /// search
      case RouteName.search:
        return BldrsNav.transitSuperHorizontal(
          screen: const SuperSearchScreen(),
          settings: settings,
        );
      // --------------------
      /// appSettings
      case RouteName.appSettings:
        return BldrsNav.transitSuperHorizontal(
          screen: const AppSettingsPage(),
          settings: settings,
        );
      // ------------------------------------------------------------

      /// PROFILE

      // --------------------
      // /// myUserProfile
      // case RouteName.myUserProfile:
      //   return BldrsNav.transitSuperHorizontal(
      //     settings: settings,
      //     screen: const UserProfileScreen(
      //       // userTab: UserTab.profile, // default
      //     ),
      //   );
      // --------------------
      // /// myUserNotes
      // case RouteName.myUserNotes:
      //   return BldrsNav.transitSuperHorizontal(
      //     settings: settings,
      //     screen: const UserProfileScreen(
      //       userTab: UserTab.notifications,
      //     ),
      //   );
      // --------------------
      // /// myUserFollowing
      // case RouteName.myUserFollowing:
      //   return BldrsNav.transitSuperHorizontal(
      //     settings: settings,
      //     screen: const UserProfileScreen(
      //       userTab: UserTab.following,
      //     ),
      //   );
      // --------------------
      // /// myUserSettings
      // case RouteName.myUserSettings:
      //   return BldrsNav.transitSuperHorizontal(
      //     screen: const UserProfileScreen(
      //       userTab: UserTab.settings,
      //     ),
      //     settings: settings,
      //   );
      // --------------------
      /// savedFlyers
      case RouteName.savedFlyers:
        return BldrsNav.transitSuperHorizontal(
          screen: const SavedFlyersScreen(),
          settings: settings,
        );
      // --------------------
      /// profileEditor
      /*
        HANDLED MANUALLY BY
        [onEditProfileTap]
        [_goToUserEditorForFirstTime]
        [_controlMissingFieldsCase]
      */
      // ------------------------------------------------------------

      /// MY BZ

      // --------------------
      // /// myBzAboutPage : HANDLED MANUALLY BY [goToMyBzScreen]
      // case RouteName.myBzAboutPage:
      //   return BldrsNav.transitSuperHorizontal(
      //     settings: settings,
      //     screen: const MyBzScreen(
      //       initialTab: BzTab.about,
      //     ),
      //   );
      // --------------------
      // /// myBzFlyersPage : HANDLED MANUALLY BY [goToMyBzScreen]
      // case RouteName.myBzFlyersPage:
      //   return BldrsNav.transitSuperHorizontal(
      //     settings: settings,
      //     screen: const MyBzScreen(
      //       // initialTab: BzTab.flyers, // DEFAULT
      //     ),
      //   );
      // --------------------
      // /// myBzTeamPage : HANDLED MANUALLY BY [goToMyBzScreen]
      // case RouteName.myBzTeamPage:
      //   return BldrsNav.transitSuperHorizontal(
      //     settings: settings,
      //     screen: const MyBzScreen(
      //       initialTab: BzTab.team,
      //     ),
      //   );
      // --------------------
      // /// myBzNotesPage : HANDLED MANUALLY BY [goToMyBzScreen]
      // case RouteName.myBzNotesPage:
      //   return BldrsNav.transitSuperHorizontal(
      //     settings: settings,
      //     screen: const MyBzScreen(
      //       initialTab: BzTab.notes,
      //     ),
      //   );
      // --------------------
      // /// myBzSettingsPage : HANDLED MANUALLY BY [goToMyBzScreen]
      // case RouteName.myBzSettingsPage:
      //   return BldrsNav.transitSuperHorizontal(
      //     settings: settings,
      //     screen: const MyBzScreen(
      //       initialTab: BzTab.settings,
      //     ),
      //   );
      // --------------------
      /// bzEditor
      /*
        HANDLED MANUALLY BY
        [onEditBzButtonTap]
        [onCreateNewBzTap]
      */
      // --------------------
      /// flyerEditor
      /*
        HANDLED MANUALLY BY
        [_onEditFlyerButtonTap]
        [goToFlyerMaker]
      */
      // ------------------------------------------------------------

      /// PREVIEWS

      // --------------------
      /// userPreview
      case RouteName.userPreview:
        return BldrsNav.transitSuperHorizontal(
          settings: settings,
          screen: UserPreviewScreen(
            userID: _arg,
          ),
        );
      // --------------------
      /// bzPreview
      case RouteName.bzPreview:
        return BldrsNav.transitSuperHorizontal(
          settings: settings,
          screen: BzPreviewScreen(
            bzID: _arg,
          ),
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
      // --------------------
      /// countryPreview
      /* LATER */
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

      /// DASHBOARD

      // --------------------
      /// handled in dashboard app
      // ------------------------------------------------------------

      /// NOTHING

      // --------------------
      default:
        return Nav.transitFade(
            screen: const NoPageFoundScreen(),
            settings: settings,
        );
      // ------------------------------------------------------------
    }

  }
  // -----------------------------------------------------------------------------

  /// PATHS - ARGS - EXTRACTORS

  // --------------------
  /// BRIEFING
  /*
  .......................
  TEMPLATE :
  https://www.bldrs.net/#/screenName/pageName:someID
  PATH :
  /screenName/pageName
  ARG :
  someID
  DOMAIN :
  https://www.bldrs.net/
  FULL PATH :
  https://www.bldrs.net/#/screenName/pageName:someID
  ROUTE SETTINGS NAME :
  /screenName/pageName:someID
  .......................
  DEBUG DOMAIN :
  http://localhost:62861/
  RELEASE DOMAIN :
  https://www.bldrs.net/
  .......................
  DEBUG EXAMPLES
  http://localhost:60214/#/home
  http://localhost:60214/#/privacy
  http://localhost:60214/#/flyerPreview:0Vyr4hWSwdbH1EsbOC4P
  .......................
  RELEASE EXAMPLES
  https://www.bldrs.net/
  https://www.bldrs.net/#/home
  https://www.bldrs.net/#/flyerPreview:0Vyr4hWSwdbH1EsbOC4P
  .......................
  */
  // -----------------------------------------------------------------------------

  /// FROM ROUTE SETTINGS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getPathFromRouteSettingsName(String? settingsName){

    return TextMod.removeTextAfterLastSpecialCharacter(
      text: settingsName,
      specialCharacter: ':',
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getArgFromRouteSettingsName(String? settingsName){
    return TextMod.removeTextBeforeFirstSpecialCharacter(
      text: settingsName,
      specialCharacter: ':',
    );
  }
  // -----------------------------------------------------------------------------

  /// FROM WINDOW URL

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getPathFromWindowURL(String? fullPath){
    final String? settingsName = getRouteSettingsNameFromFullPath(fullPath);
    return getPathFromRouteSettingsName(settingsName);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getArgFromWindowURL(String? fullPath){
    final String? settingsName = getRouteSettingsNameFromFullPath(fullPath);
    return getArgFromRouteSettingsName(settingsName);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getRouteSettingsNameFromFullPath(String? fullPath){
    String? _routeSettingsName;
    // .......................
    // DEBUG EXAMPLES
    // http://localhost:50356/#/home
    // http://localhost:50356/#/privacy
    // http://localhost:50356/#/flyerPreview:0Vyr4hWSwdbH1EsbOC4P
    // .......................
    // RELEASE EXAMPLES
    // https://www.bldrs.net/
    // https://www.bldrs.net/#/home
    // https://www.bldrs.net/#/flyerPreview:0Vyr4hWSwdbH1EsbOC4P
    // .......................

    if (fullPath != null){

      _routeSettingsName = _removeExtraSlashAtTheEndIfExisted(fullPath);

      for (int i = 0; i < 4; i ++){

        final String _was = _routeSettingsName!;

        final String? _is = TextMod.removeTextBeforeFirstSpecialCharacter(
          text: _routeSettingsName,
          specialCharacter: '/',
        );

        blog('$i was : $_was : is : $_is : equals : ${_was == _is}');

        /// NOT CHANGED ( had no more slashes )
        if (_is == _was){
          _routeSettingsName = '';
          break;
        }

        /// SHRUNK ( had slash )
        else {
          _routeSettingsName = _is;
        }

      }

      _routeSettingsName = '/$_routeSettingsName';

    }

    return _routeSettingsName;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String _removeExtraSlashAtTheEndIfExisted(String fullPath){
    String _output = fullPath;

    if (TextCheck.isEmpty(fullPath) == false){

      final String _lastChar = fullPath[fullPath.length-1];

      if (_lastChar == '/'){
        _output = TextMod.removeNumberOfCharactersFromEndOfAString(
            string: fullPath,
            numberOfCharacters: 1,
        )!;
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
