import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/strings/text_mod.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/legalizer/legalizer.dart';
import 'package:bldrs/a_models/f_flyer/sub/review_model.dart';
import 'package:bldrs/a_models/x_ui/tabs/bz_tabber.dart';
import 'package:bldrs/a_models/x_ui/tabs/user_tabber.dart';
import 'package:bldrs/b_views/a_starters/a_logo_screen/a_static_logo_screen.dart';
import 'package:bldrs/b_views/a_starters/a_logo_screen/b_animated_logo_screen.dart';
import 'package:bldrs/b_views/a_starters/b_home_screen/a_home_screen.dart';
import 'package:bldrs/b_views/a_starters/c_error_screen/delete_my_data_screen.dart';
import 'package:bldrs/b_views/a_starters/c_error_screen/no_page_found.dart';
import 'package:bldrs/b_views/a_starters/c_error_screen/under_construction_screen.dart';
import 'package:bldrs/b_views/b_auth/a_auth_screen.dart';
import 'package:bldrs/b_views/c_main_search/super_search_screen.dart';
import 'package:bldrs/b_views/d_user/a_user_profile_screen/user_profile_screen.dart';
import 'package:bldrs/b_views/d_user/e_user_preview_screen/user_preview_screen.dart';
import 'package:bldrs/b_views/e_saves/a_saved_flyers_screen/a_saved_flyers_screen.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/a_my_bz_screen.dart';
import 'package:bldrs/b_views/f_bz/f_bz_preview_screen/a_bz_preview_screen.dart';
import 'package:bldrs/b_views/h_app_settings/a_app_settings_screen/a_app_settings_screen.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/a_flyer_screen.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/obelisk/obelisk.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/router/a_route_name.dart';
import 'package:bldrs/w_web_module/banner_screen.dart';
import 'package:flutter/material.dart';

class StaticRouter {
  // -----------------------------------------------------------------------------

  const StaticRouter();

  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT : ROUTES_LIST
  static Route<dynamic> router(RouteSettings settings) {

    /// https://www.bldrs.net/#/screenName:someID
    final String? _path = TextMod.removeTextAfterLastSpecialCharacter(
      text: settings.name,
      specialCharacter: ':',
    );

    final String? _arg = TextMod.removeTextBeforeFirstSpecialCharacter(
        text: settings.name,
        specialCharacter: ':',
    );

    blog('settings.name : ${settings.name}');
    blog('StaticRouter : router : _path : $_path : _arg : $_arg');

    final BuildContext context = getMainContext();
    final bool appIsLTR = UiProvider.checkAppIsLeftToRight();
    final bool _menuEnAnimatesLTR = !Obelisk.isWideScreenObelisk(context);

    switch (_path) {
      // ------------------------------------------------------------

      /// LOADING

      // --------------------
      /// staticLogoScreen
      case RouteName.staticLogo:
        return Nav.transitFade(
            screen: const StaticLogoScreen(),
            settings: settings,
        );
      // --------------------
      /// animatedLogoScreen
      case RouteName.animatedLogo:
        return Nav.transitFade(
            screen: const AnimatedLogoScreen(),
            settings: settings,
        );
      // ------------------------------------------------------------

      /// MAIN

      // --------------------
      /// home
      case RouteName.home:
        return Nav.transitFade(
            screen: const HomeScreen(),
            settings: settings,
        );
      // --------------------
      /// auth
      case RouteName.auth:
        return Nav.transit(
          screen: const AuthScreen(),
          settings: settings,
          pageTransitionType: PageTransitionType.bottomToTop,
        );
      // --------------------
      /// search
      case RouteName.search:
        return Nav.transitSuperHorizontal(
          screen: const SuperSearchScreen(),
          settings: settings,
          enAnimatesLTR: false,
          appIsLTR: appIsLTR,
        );
      // --------------------
      /// appSettings
      case RouteName.appSettings:
        return Nav.transit(
          screen: const AppSettingsScreen(),
          settings: settings,
          pageTransitionType: PageTransitionType.bottomToTop,
        );
      // ------------------------------------------------------------

      /// PROFILE

      // --------------------
      /// myUserProfile
      case RouteName.myUserProfile:
        return Nav.transitSuperHorizontal(
          screen: const UserProfileScreen(
            // userTab: UserTab.profile, // default
          ),
          settings: settings,
          enAnimatesLTR: _menuEnAnimatesLTR,
          appIsLTR: appIsLTR,
        );
      // --------------------
      /// myUserNotes
      case RouteName.myUserNotes:
        return Nav.transitSuperHorizontal(
          screen: const UserProfileScreen(
            userTab: UserTab.notifications,
          ),
          settings: settings,
          enAnimatesLTR: _menuEnAnimatesLTR,
          appIsLTR: appIsLTR,
        );
      // --------------------
      /// myUserFollowing
      case RouteName.myUserFollowing:
        return Nav.transitSuperHorizontal(
          screen: const UserProfileScreen(
            userTab: UserTab.following,
          ),
          settings: settings,
          enAnimatesLTR: _menuEnAnimatesLTR,
          appIsLTR: appIsLTR,
        );
      // --------------------
      /// myUserSettings
      case RouteName.myUserSettings:
        return Nav.transitSuperHorizontal(
          screen: const UserProfileScreen(
            userTab: UserTab.settings,
          ),
          settings: settings,
          enAnimatesLTR: _menuEnAnimatesLTR,
          appIsLTR: appIsLTR,
        );
      // --------------------
      /// savedFlyers
      case RouteName.savedFlyers:
        return Nav.transitSuperHorizontal(
          screen: const SavedFlyersScreen(),
          settings: settings,
          enAnimatesLTR: _menuEnAnimatesLTR,
          appIsLTR: appIsLTR,
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
      /// myBzAboutPage : HANDLED MANUALLY BY [goToMyBzScreen]
      case RouteName.myBzAboutPage:
        return Nav.transitSuperHorizontal(
          screen: const MyBzScreen(
            initialTab: BzTab.about,
          ),
          settings: settings,
          enAnimatesLTR: _menuEnAnimatesLTR,
          appIsLTR: appIsLTR,
        );
      // --------------------
      /// myBzFlyersPage : HANDLED MANUALLY BY [goToMyBzScreen]
      case RouteName.myBzFlyersPage:
        return Nav.transitSuperHorizontal(
          screen: const MyBzScreen(
            // initialTab: BzTab.flyers, // DEFAULT
          ),
          settings: settings,
          enAnimatesLTR: _menuEnAnimatesLTR,
          appIsLTR: appIsLTR,
        );
      // --------------------
      /// myBzTeamPage : HANDLED MANUALLY BY [goToMyBzScreen]
      case RouteName.myBzTeamPage:
        return Nav.transitSuperHorizontal(
          screen: const MyBzScreen(
            initialTab: BzTab.team,
          ),
          settings: settings,
          enAnimatesLTR: _menuEnAnimatesLTR,
          appIsLTR: appIsLTR,
        );
      // --------------------
      /// myBzNotesPage : HANDLED MANUALLY BY [goToMyBzScreen]
      case RouteName.myBzNotesPage:
        return Nav.transitSuperHorizontal(
          screen: const MyBzScreen(
            initialTab: BzTab.notes,
          ),
          settings: settings,
          enAnimatesLTR: _menuEnAnimatesLTR,
          appIsLTR: appIsLTR,
        );
      // --------------------
      /// myBzSettingsPage : HANDLED MANUALLY BY [goToMyBzScreen]
      case RouteName.myBzSettingsPage:
        return Nav.transitSuperHorizontal(
          screen: const MyBzScreen(
            initialTab: BzTab.settings,
          ),
          settings: settings,
          enAnimatesLTR: _menuEnAnimatesLTR,
          appIsLTR: appIsLTR,
        );
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
        return Nav.transitSuperHorizontal(
          screen: UserPreviewScreen(
            userID: _arg,
          ),
          settings: settings,
          enAnimatesLTR: _menuEnAnimatesLTR,
          appIsLTR: appIsLTR,
        );
      // --------------------
      /// bzPreview
      case RouteName.bzPreview:
        return Nav.transitSuperHorizontal(
          screen: BzPreviewScreen(
            bzID: _arg,
          ),
          settings: settings,
          enAnimatesLTR: _menuEnAnimatesLTR,
          appIsLTR: appIsLTR,
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
        return Nav.transit(
          screen: FlyerPreviewScreen(
            flyerID: ReviewModel.getFlyerIDFromLinkPart(
              linkPart: _arg,
            ),
            reviewID: ReviewModel.getReviewIDFromLinkPart(
              linkPart: _arg,
            ),
          ),
          settings: settings,
          pageTransitionType: PageTransitionType.bottomToTop,
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
        return Nav.transitFade(
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
}
