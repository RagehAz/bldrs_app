// ignore_for_file: non_constant_identifier_names
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
      case ScreenName.logo:
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
      case ScreenName.userPreview: return _transitSuperHorizontal(
        settings: settings,
        screen: UserPreviewScreen(userID: _arg,),
      );
    // --------------------
    /// bzPreview
      case ScreenName.bzPreview: return _transitSuperHorizontal(
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
        return _transitSuperHorizontal(
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
        return _transitSuperHorizontal(
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
  /// TESTED : WORKS PERFECT
  static PageTransition<dynamic> _transitSuperHorizontal({
    required Widget screen,
    bool enAnimatesLTR = true,
    RouteSettings? settings,
  }) {
    return Nav.transitSuperHorizontal(
      screen: screen,
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      enAnimatesLTR:enAnimatesLTR ,
      settings: settings,
    );
  }
  // -----------------------------------------------------------------------------

  /// GO TO

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
        case ScreenName.logo:
          _goTo = _pushLogoRouteAndRemoveAllBelow(); break;
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
          _goTo = _pushHomeRouteAndRemoveAllBelow(); break;
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
          _goTo = _jumpToUserPreviewScreen(
            userID: _args,
          ); break;
      // --------------------
      /// bzPreview
        case ScreenName.bzPreview:
          _goTo = _jumpToBzPreviewScreen(
            bzID: _args,
          ); break;
      // --------------------
      /// flyerPreview
        case ScreenName.flyerPreview:
          _goTo = _jumpToFlyerPreviewScreen(
            flyerID: _args,
          ); break;
      // --------------------
      /// flyerReviews
        case ScreenName.flyerReviews:
          _goTo = _jumpToFlyerReviewScreen(
            flyerID_reviewID: _args,
          ); break;
      // ------------------------------------------------------------

      /// WEB

      // --------------------
      /// underConstruction
        case ScreenName.underConstruction:
          _goTo = Nav.goToRoute(_context, ScreenName.underConstruction); break;
      // --------------------
      /// banner
        case ScreenName.banner:
          _goTo = Nav.goToRoute(_context, ScreenName.banner); break;
      // --------------------
      /// privacy
        case ScreenName.privacy:
          _goTo = _pushPrivacyScreen(); break;
      // --------------------
      /// terms
        case ScreenName.terms:
          _goTo = _pushTermsScreen(); break;
      // --------------------
      /// deleteMyData
        case ScreenName.deleteMyData:
          _goTo = Nav.goToRoute(_context, ScreenName.deleteMyData); break;
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

  /// WEB SCREENS

  // --------------------
  /// privacy
  static Future<void> _pushPrivacyScreen() async {

    if (kIsWeb == true){
      await Nav.goToRoute(getMainContext(), ScreenName.privacy);
    }
    else {
      await Launcher.launchURL(Standards.privacyPolicyURL);
    }

  }
  // --------------------
  /// terms
  static Future<void> _pushTermsScreen() async {

    if (kIsWeb == true){
      await Nav.goToRoute(getMainContext(), ScreenName.terms);
    }
    else {
      await Launcher.launchURL(Standards.termsAndRegulationsURL);
    }

  }
  // -----------------------------------------------------------------------------

  /// BACK

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> backFromHomeScreen() async {

    final BuildContext context = getMainContext();

    final bool _flyerIsOpen = !UiProvider.proGetLayoutIsVisible(
      context: context,
      listen: false,
    );

    /// CLOSE FLYER
    if (_flyerIsOpen == true){

      final ZGridController? _controller = HomeProvider.proGetHomeZGridController(
        context: context,
        listen: false,
      );

      await zoomOutFlyer(
        context: context,
        mounted: true,
        controller: _controller,
      );

    }

    /// CLOSE APP
    else {

      // final String? _currentPhid = ChainsProvider.proGetHomeWallPhid(
      //     context: context,
      //     listen: false,
      // );
      //
      // /// WHILE WALL HAS PHID
      // if (_currentPhid != null){
      //
      //     final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
      //     await _chainsProvider.changeHomeWallFlyerType(
      //       notify: true,
      //       flyerType: null,
      //       phid: null,
      //     );
      //
      // }
      //
      // else {

      if (kIsWeb == false){

        final bool _result = await Dialogs.goBackDialog(
          titleVerse: const Verse(
            id: 'phid_exit_app_?',
            translate: true,
          ),
          bodyVerse: const Verse(
            id: 'phid_exit_app_notice',
            translate: true,
          ),
          confirmButtonVerse: const Verse(
            id: 'phid_exit',
            translate: true,
          ),
        );

        if (_result == true) {

          await BldrsCenterDialog.closeCenterDialog();

          await Future.delayed(
            const Duration(milliseconds: 500),
                () async {
              await Nav.closeApp();
            },
          );

        }

      }

      // }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> backFromPreviewScreen() async {

    if (kIsWeb == true){
      await _pushHomeRouteAndRemoveAllBelow();
    }

    else {
      await Nav.goBack(
        context: getMainContext(),
      );
    }

  }
  // -----------------------------------------------------------------------------

  /// RESTARTING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _pushLogoRouteAndRemoveAllBelow() async {

    await Nav.pushNamedAndRemoveAllBelow(
      context: getMainContext(),
      goToRoute: ScreenName.logo,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _pushHomeRouteAndRemoveAllBelow() async {

    await Nav.pushNamedAndRemoveAllBelow(
      goToRoute: ScreenName.home,
      context: getMainContext(),
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> restartAndRoute({
    String? route,
    dynamic arguments,
  }) async {

    if (route != null) {
      UiProvider.proSetAfterHomeRoute(
        routeName: route,
        arguments: arguments,
        notify: true,
      );
    }

    await _pushLogoRouteAndRemoveAllBelow();

  }
  // ------------------------------------------------------------

  /// JUMPERS

  // --------------------
  /// userPreview
  static Future<void> _jumpToUserPreviewScreen({
    required String? userID,
  }) async {

    if (userID != null){

      // await Nav.goToNewScreen(
      //   context: getMainContext(),
      //   screen: UserPreviewScreen(
      //     userID: userID,
      //   ),
      // );

      final String _route = '${ScreenName.userPreview}:$userID';
      await Nav.goToRoute(getMainContext(), _route);

    }

  }
  // --------------------
  /// bzPreview
  static Future<void> _jumpToBzPreviewScreen({
    required String? bzID,
  }) async {

    if (bzID != null){

      // await Nav.goToNewScreen(
      //   context: getMainContext(),
      //   screen: BzPreviewScreen(
      //     bzID: bzID,
      //   ),
      // );

      final String _route = '${ScreenName.bzPreview}:$bzID';
      await Nav.goToRoute(getMainContext(), _route);

    }

  }
  // --------------------
  /// flyerPreview
  static Future<void> _jumpToFlyerPreviewScreen({
    required String? flyerID,
  }) async {

    if (flyerID != null){

      // await Nav.goToNewScreen(
      //   context: getMainContext(),
      //   screen: FlyerPreviewScreen(
      //     flyerID: flyerID,
      //     // reviewID: ,
      //     // bzModel: _bzModel,
      //   ),
      // );

      final String _route = '${ScreenName.flyerPreview}:$flyerID';
      await Nav.goToRoute(getMainContext(), _route);

    }

  }
  // --------------------
  /// flyerReviews
  static Future<void> _jumpToFlyerReviewScreen({
    required String? flyerID_reviewID,
  }) async {

    /// TASK : DO JUMP TO REVIEW THING
    /*

    In this method [NoteEvent.sendFlyerReceivedNewReviewByMe]

    The trigger to come here was :-

    TriggerModel(
        name: Routing.flyerReviews,
        argument: ChainPathConverter.combinePathNodes([
          reviewModel.flyerID, // index 0
          reviewModel.id, // index 1
        ]),

     */

    if (flyerID_reviewID != null){

      // final String? _flyerID = ReviewModel.getFlyerIDFromLinkPart(
      //     linkPart: flyerID_reviewID,
      // );
      // final String? _reviewID = ReviewModel.getReviewIDFromLinkPart(
      //     linkPart: flyerID_reviewID,
      // );
      //
      // if (_flyerID != null && _reviewID != null){
      //
      //   await Nav.goToNewScreen(
      //     context: getMainContext(),
      //     screen: FlyerPreviewScreen(
      //       flyerID: _flyerID,
      //       reviewID: _reviewID,
      //     ),
      //   );
      //
      // }

      final String _route = '${ScreenName.flyerReviews}:$flyerID_reviewID';
      blog('jumpToFlyerReviewScreen : _route : $_route');
      await Nav.goToRoute(getMainContext(), _route);

    }

  }
  // -----------------------------------------------------------------------------

  /// AUTO NAV

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> autoNav({
    required String? routeName,
    required bool startFromHome,
    required bool mounted,
    String? arguments,
  }) async {

    if (TextCheck.isEmpty(routeName) == false){

      if (mainNavKey.currentContext == null){
        await Future.delayed(const Duration(seconds: 3));
      }

      UiProvider.proSetAfterHomeRoute(
          routeName: routeName,
          arguments: arguments,
          notify: true
      );

      if (startFromHome == true){
        await ScreenRouter.goTo(routeSettingsName: ScreenName.home, args: null);
      }

      else {
        await autoNavigateFromHomeScreen(mounted: mounted);
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> autoNavigateFromHomeScreen({
    required bool mounted,
  }) async {

    if (mounted == true){

      final RouteSettings? _afterHomeRoute = UiProvider.proGetAfterHomeRoute(
        context: getMainContext(),
        listen: false,
      );

      blog('autoNavigateFromHomeScreen : _afterHomeRoute : ${_afterHomeRoute?.name} : arg : ${_afterHomeRoute?.arguments}');

      if (_afterHomeRoute != null){

        /// CLEAR AFTER HOME ROUTE
        UiProvider.proClearAfterHomeRoute(
          notify: true,
        );

        final String? _args = _afterHomeRoute.arguments as String?;

        await ScreenRouter.goTo(
          routeSettingsName: _afterHomeRoute.name,
          args: _args,
        );

      }

    }

  }
  // -----------------------------------------------------------------------------
}
