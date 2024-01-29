part of bldrs_routing;

class ScreenRouter {
  // -----------------------------------------------------------------------------

  const ScreenRouter();

  // -----------------------------------------------------------------------------

  /// ROUTER

  // --------------------
  /// TESTED : WORKS PERFECT : ROUTES_LIST
  static Route<dynamic> router(RouteSettings settings) {

    final String? _path = RoutePather.getPathFromRouteSettingsName(settings.name);

    final String? _arg = RoutePather.getArgFromRouteSettingsName(settings.name);

    switch (_path) {
    // ------------------------------------------------------------

    /// LOADING

    // --------------------
    /// staticLogoScreen
      case ScreenName.staticLogo:
        return Nav.transitFade(
          screen: const LogoScreen(),
          settings: settings,
        );
    // --------------------
    /// home
      case ScreenName.home: return Nav.transitFade(
        screen: const TheHomeScreen(),
        settings: settings,
      );
    // --------------------
    /// userPreview
      case ScreenName.userPreview: return BldrsNav.transitSuperHorizontal(
        settings: settings,
        screen: UserPreviewScreen(userID: _arg,),
      );
    // --------------------
    /// bzPreview
      case ScreenName.bzPreview: return BldrsNav.transitSuperHorizontal(
        settings: settings,
        screen: BzPreviewScreen(bzID: _arg,),
      );
    // --------------------
    /// flyerPreview
      case ScreenName.flyerPreview:
        return Nav.transit(
          screen: FlyerPreviewScreen(
            flyerID: _arg,
          ),
          settings: settings,
          pageTransitionType: PageTransitionType.bottomToTop,
        );
    // --------------------
    /// flyerReviews
      case ScreenName.flyerReviews:
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
      case ScreenName.underConstruction:
        return Nav.transitFade(
          screen: const BldrsUnderConstructionScreen(),
          settings: settings,
        );
    // --------------------
    /// banner
      case ScreenName.banner:
        return Nav.transitFade(
          screen: const BannerScreen(),
          settings: settings,
        );
    // --------------------
    /// privacy
      case ScreenName.privacy:
        return Nav.transitFade(
          screen: const PrivacyScreen(),
          settings: settings,
        );
    // --------------------
    /// terms
      case ScreenName.terms:
        return Nav.transitFade(
          screen: const TermsScreen(),
          settings: settings,
        );
    // --------------------
    /// deleteMyData
      case ScreenName.deleteMyData:
        return BldrsNav.transitSuperHorizontal(
          screen: const DeleteMyDataScreen(),
          settings: settings,
        );
    // ------------------------------------------------------------

    /// NOTHING

    // --------------------
      default:
        return Nav.transitFade(
          // screen: const NoPageFoundScreen(),
          screen: const TheHomeScreen(),
          settings: settings,
        );
    // ------------------------------------------------------------
    }

  }
  // --------------------
  /// ROUTES_LIST
  static Future<void> goTo({
    required String? routeSettingsName,
    required String? args,
  }) async  {
    Future<void>? _goTo;

    final String? _path = RoutePather.getPathFromRouteSettingsName(routeSettingsName);

    final String? _pathArguments = RoutePather.getArgFromRouteSettingsName(routeSettingsName);
    final String? _args = args ?? _pathArguments;

    final BuildContext? _context = getMainContext();

    if (_context != null && _path != null){

      switch (_path){
      // ------------------------------------------------------------

      /// LOADING

      // --------------------
      /// staticLogoScreen
        case ScreenName.staticLogo:
          _goTo = BldrsNav.pushLogoRouteAndRemoveAllBelow(
            animatedLogoScreen: false,
          ); break;
      // // --------------------
      // /// animatedLogoScreen
      // case RouteName.animatedLogo:
      //   _goTo = BldrsNav.pushLogoRouteAndRemoveAllBelow(
      //     animatedLogoScreen: true,
      //   ); break;
      // ------------------------------------------------------------

      /// MAIN

      // --------------------
      /// home
        case ScreenName.home:
          _goTo = BldrsNav.pushHomeRouteAndRemoveAllBelow(); break;
      // --------------------
      // /// auth
      //   case RouteName.auth:
      //     _goTo = BldrsNav.pushAuthRoute(); break;
      // --------------------
      // /// search
      //   case RouteName.search:
      //     _goTo = BldrsNav.pushSearchRoute(); break;
      // // --------------------
      /// GO_TO_APP_SETTINGS
      // /// appSettings
      //   case RouteName.appSettings:
      //     _goTo = BldrsNav.pushAppSettingsRoute(); break;
      // ------------------------------------------------------------

      /// PROFILE

      // --------------------
      /// myUserProfile
      // case RouteName.myUserProfile:
      //   _goTo = BldrsNav.pushMyUserScreen(
      //       // userTab: UserTab.profile // default
      //   ); break;
      // --------------------
      // /// myUserNotes
      // case RouteName.myUserNotes:
      //   _goTo = BldrsNav.pushMyUserScreen(
      //       userTab: UserTab.notifications,
      //   ); break;
      // // --------------------
      // /// myUserFollowing
      // case RouteName.myUserFollowing:
      //   _goTo = BldrsNav.pushMyUserScreen(
      //       userTab: UserTab.following,
      //   ); break;
      // // --------------------
      // /// myUserSettings
      // case RouteName.myUserSettings:
      //   _goTo = BldrsNav.pushMyUserScreen(
      //       userTab: UserTab.settings,
      //   ); break;
      // --------------------
      // /// savedFlyers
      // case RouteName.savedFlyers:
      //   _goTo = BldrsNav.pushSavedFlyersRoute(); break;
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
      // /// myBzAboutPage
      // case RouteName.myBzAboutPage:
      //   _goTo = BldrsNav.goToMyBzScreen(
      //     bzID: _args,
      //     replaceCurrentScreen: false,
      //     initialTab: BzTab.about,
      //   ); break;
      // --------------------
      // /// myBzFlyersPage
      // case RouteName.myBzFlyersPage:
      //   _goTo = BldrsNav.goToMyBzScreen(
      //     bzID: args,
      //     replaceCurrentScreen: false,
      //     // initialTab: BzTab.flyers, // default
      //   ); break;
      // --------------------
      // /// myBzTeamPage
      // case RouteName.myBzTeamPage:
      //   _goTo = BldrsNav.goToMyBzScreen(
      //     bzID: args,
      //     replaceCurrentScreen: false,
      //     initialTab: BzTab.team,
      //   ); break;
      // --------------------
      // /// myBzNotesPage
      // case RouteName.myBzNotesPage:
      //   _goTo = BldrsNav.goToMyBzScreen(
      //     bzID: args,
      //     replaceCurrentScreen: false,
      //     initialTab: BzTab.notes,
      //   ); break;
      // --------------------
      // /// myBzSettingsPage
      // case RouteName.myBzSettingsPage:
      //   _goTo = BldrsNav.goToMyBzScreen(
      //     bzID: _args,
      //     replaceCurrentScreen: false,
      //     initialTab: BzTab.settings,
      //   ); break;
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
        case ScreenName.userPreview:
          _goTo = BldrsNav.jumpToUserPreviewScreen(
            userID: _args,
          ); break;
      // --------------------
      /// bzPreview
        case ScreenName.bzPreview:
          _goTo = BldrsNav.jumpToBzPreviewScreen(
            bzID: _args,
          ); break;
      // --------------------
      /// flyerPreview
        case ScreenName.flyerPreview:
          _goTo = BldrsNav.jumpToFlyerPreviewScreen(
            flyerID: _args,
          ); break;
      // --------------------
      /// flyerReviews
        case ScreenName.flyerReviews:
          _goTo = BldrsNav.jumpToFlyerReviewScreen(
            flyerID_reviewID: _args,
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
        case ScreenName.underConstruction:
          _goTo = BldrsNav.pushBldrsUnderConstructionRoute(); break;
      // --------------------
      /// banner
        case ScreenName.banner:
          _goTo = BldrsNav.pushBannerRoute(); break;
      // --------------------
      /// privacy
        case ScreenName.privacy:
          _goTo = BldrsNav.pushPrivacyScreen(); break;
      // --------------------
      /// terms
        case ScreenName.terms:
          _goTo = BldrsNav.pushTermsScreen(); break;
      // --------------------
      /// deleteMyData
        case ScreenName.deleteMyData:
          _goTo = BldrsNav.pushDeleteMyDataScreen(); break;
      // ------------------------------------------------------------

      /// DASHBOARD

      // --------------------
      /// dashboard
        case ScreenName.dashboard:
          _goTo = Nav.goToRoute(_context, ScreenName.dashboard); break;
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
}
