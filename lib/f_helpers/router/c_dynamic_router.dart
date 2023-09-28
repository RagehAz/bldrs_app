import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/strings/text_mod.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/a_models/x_ui/tabs/bz_tabber.dart';
import 'package:bldrs/a_models/x_ui/tabs/user_tabber.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/router/a_route_name.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
import 'package:flutter/material.dart';

class DynamicRouter {
  // -----------------------------------------------------------------------------

  const DynamicRouter();

  // -----------------------------------------------------------------------------

  /// TO ROUTE

  // --------------------
  /// ROUTES_LIST
  static Future<void> goTo({
    required String? route,
    String? arguments,
  }) async {
    Future<void>? _goTo;

    final String? _path = TextMod.removeTextAfterLastSpecialCharacter(
      text: route,
      specialCharacter: ':',
    );

    final String? _pathArg = TextMod.removeTextBeforeFirstSpecialCharacter(
      text: route,
      specialCharacter: ':',
    );

    final BuildContext? _context = getMainContext();

    if (_context != null && _path != null){

      switch (_path){
        // ------------------------------------------------------------

        /// LOADING

        // --------------------
        /// staticLogoScreen
        case RouteName.staticLogo:
          _goTo = BldrsNav.pushLogoRouteAndRemoveAllBelow(
            animatedLogoScreen: false,
          ); break;
        // --------------------
        /// animatedLogoScreen
        case RouteName.animatedLogo:
          _goTo = BldrsNav.pushLogoRouteAndRemoveAllBelow(
            animatedLogoScreen: true,
          ); break;
        // ------------------------------------------------------------

        /// MAIN

        // --------------------
        /// home
        case RouteName.home:
          _goTo = BldrsNav.pushHomeRouteAndRemoveAllBelow(); break;
        // --------------------
        /// auth
          case RouteName.auth:
            _goTo = BldrsNav.pushAuthRoute(); break;
        // --------------------
        /// search
          case RouteName.search:
            _goTo = BldrsNav.pushSearchRoute(); break;
        // --------------------
        /// appSettings
          case RouteName.appSettings:
            _goTo = BldrsNav.pushAppSettingsRoute(); break;
        // ------------------------------------------------------------

        /// PROFILE

        // --------------------
        /// myUserProfile
        case RouteName.myUserProfile:
          _goTo = BldrsNav.pushMyUserScreen(
              // userTab: UserTab.profile // default
          ); break;
        // --------------------
        /// myUserNotes
        case RouteName.myUserNotes:
          _goTo = BldrsNav.pushMyUserScreen(
              userTab: UserTab.notifications,
          ); break;
        // --------------------
        /// myUserFollowing
        case RouteName.myUserFollowing:
          _goTo = BldrsNav.pushMyUserScreen(
              userTab: UserTab.following,
          ); break;
        // --------------------
        /// myUserSettings
        case RouteName.myUserSettings:
          _goTo = BldrsNav.pushMyUserScreen(
              userTab: UserTab.settings,
          ); break;
        // --------------------
        /// savedFlyers
        case RouteName.savedFlyers:
          _goTo = BldrsNav.pushSavedFlyersRoute(); break;
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
        /// myBzAboutPage
        case RouteName.myBzAboutPage:
          _goTo = BldrsNav.goToMyBzScreen(
            bzID: arguments,
            replaceCurrentScreen: false,
            initialTab: BzTab.about,
          ); break;
        // --------------------
        /// myBzFlyersPage
        case RouteName.myBzFlyersPage:
          _goTo = BldrsNav.goToMyBzScreen(
            bzID: arguments,
            replaceCurrentScreen: false,
            // initialTab: BzTab.flyers, // default
          ); break;
        // --------------------
        /// myBzTeamPage
        case RouteName.myBzTeamPage:
          _goTo = BldrsNav.goToMyBzScreen(
            bzID: arguments,
            replaceCurrentScreen: false,
            initialTab: BzTab.team,
          ); break;
        // --------------------
        /// myBzNotesPage
        case RouteName.myBzNotesPage:
          _goTo = BldrsNav.goToMyBzScreen(
            bzID: arguments,
            replaceCurrentScreen: false,
            initialTab: BzTab.notes,
          ); break;
        // --------------------
        /// myBzSettingsPage
        case RouteName.myBzSettingsPage:
          _goTo = BldrsNav.goToMyBzScreen(
            bzID: arguments,
            replaceCurrentScreen: false,
            initialTab: BzTab.settings,
          ); break;
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
          _goTo = BldrsNav.jumpToUserPreviewScreen(
            userID: _pathArg,
          ); break;
        // --------------------
        /// bzPreview
        case RouteName.bzPreview:
          _goTo = BldrsNav.jumpToBzPreviewScreen(
            bzID: _pathArg,
          ); break;
        // --------------------
        /// flyerPreview
        case RouteName.flyerPreview:
          _goTo = BldrsNav.jumpToFlyerPreviewScreen(
            flyerID: _pathArg,
          ); break;
        // --------------------
        /// flyerReviews
        case RouteName.flyerReviews:
          _goTo = BldrsNav.jumpToFlyerReviewScreen(
            flyerID_reviewID: _pathArg,
          ); break;
        // --------------------
        /// countryPreview
        /*
         case Routing.countryPreview:
           return jumpToCountryPreviewScreen(
             context: context,
             countryID: _afterHomeRoute.arguments,
           ); break;
          */
        // ------------------------------------------------------------

        /// WEB

        // --------------------
        /// underConstruction
        case RouteName.underConstruction:
          _goTo = BldrsNav.pushBldrsUnderConstructionRoute(); break;
        // --------------------
        /// banner
        case RouteName.banner:
          _goTo = BldrsNav.pushBannerRoute(); break;
        // --------------------
        /// privacy
        case RouteName.privacy:
          _goTo = BldrsNav.pushPrivacyScreen(); break;
        // --------------------
        /// terms
        case RouteName.terms:
          _goTo = BldrsNav.pushTermsScreen(); break;
        // --------------------
        /// deleteMyData
        case RouteName.deleteMyData:
          _goTo = BldrsNav.pushDeleteMyDataScreen(); break;
        // ------------------------------------------------------------

        /// DASHBOARD

        // --------------------
        /// dashboard
        case RouteName.dashboard:
          _goTo = Nav.goToRoute(_context, RouteName.dashboard); break;
        // ------------------------------------------------------------

        /// NOTHING

        // --------------------
        default:
          _goTo = Nav.goToRoute(_context, 'nothing'); break;
        // ------------------------------------------------------------
      }
    }

    return _goTo;
  }
  // -----------------------------------------------------------------------------

  /// BLOG

  // --------------------
  static const bool canBlog = true;
  static int count = 0;
  static void blogGo(String text){
    if (canBlog == true){
      blog('SCREEN [$count] : $text');
      count++;
    }
  }
  // -----------------------------------------------------------------------------
}
