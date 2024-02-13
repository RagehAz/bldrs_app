// ignore_for_file: non_constant_identifier_names
part of bldrs_routing;

class Routing {
  // -----------------------------------------------------------------------------

  const Routing();

  // -----------------------------------------------------------------------------

  /// ROUTER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Route<dynamic> router(RouteSettings settings) {

    final String? _path = RoutePather.getPathFromRouteSettingsName(settings.name);
    final String? _arg = RoutePather.getArgFromRouteSettingsName(settings.name);

    final Route<dynamic>? _deep = _goDeep(settings);
    if (_deep != null){
      return _deep;
    }

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
  /// TASk : VALIDATE ME
  static Route<dynamic>? _goDeep(RouteSettings settings){

    final String? _path = RoutePather.getPathFromRouteSettingsName(settings.name);
    final String? _arg = RoutePather.getArgFromRouteSettingsName(settings.name);

    blog('router : _path : $_path');
    blog('router : _arg : $_arg');
    blog('router : settings : $settings');

    if (
    TextCheck.stringStartsExactlyWith(
        text: _path,
        startsWith: '/redirect',
    ) == true
    ){

      /// key=value&key2=value2&;
      final Uri _uri = Uri.parse('bldrs://deep${settings.name}');
      final String? _args = _uri.queryParameters.toString();


      return Nav.transitFade(
        screen: RedirectScreen(
          path: _path,
          arg: _args,
        ),
        settings: settings,
      );
    }

    else {
      return null;
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
  ///
  static Future<void> goTo({
    required String? route,
    String? arg,
  }) async  {

    if (TextCheck.isEmpty(route) == false){

      final bool _isBid = TextCheck.stringStartsExactlyWith(text: route, startsWith: 'bid');
      final bool _isScreen = ScreenName.checkIsScreen(routeName: route);
      final bool _isKeywordPath = TextCheck.stringStartsExactlyWith(text: route, startsWith: 'phid');

      if (_isBid == true){
        await _MirageNav.goTo(bid: route!, bzID: arg);
      }
      else if (_isKeywordPath == true){
        await _MirageNav.goToKeyword(phid: Pathing.getLastPathNode(route)!);
      }
      else if (_isScreen == true){
        await _goToScreen(routeName: route, arg: arg);
      }

    }

  }
  // --------------------
  static Future<void> _goToScreen({
    required String? routeName,
    required String? arg,
  }) async {
    Future<void>? _goTo;

    final String? _path = RoutePather.getPathFromRouteSettingsName(routeName);

    final String? _pathArguments = RoutePather.getArgFromRouteSettingsName(routeName);
    final String? _args = arg ?? _pathArguments;

    final BuildContext? _context = getMainContext();

    if (_context != null && _path != null){

      switch (_path){
      // --------------------
      /// staticLogoScreen
        case ScreenName.logo:
          _goTo = Nav.pushNamedAndRemoveAllBelow(
            context: _context,
            goToRoute: ScreenName.logo,
          ); break;
      // --------------------
      /// home
        case ScreenName.home:
          _goTo = Nav.pushNamedAndRemoveAllBelow(
            context: _context,
            goToRoute: ScreenName.home,
          ); break;
      // ------------------------------------------------------------
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
          _goTo = Nav.goToRoute(_context, ScreenName.logo); break;
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
      await goTo(route: ScreenName.home);
    }

    else {
      await Nav.goBack(
        context: getMainContext(),
      );
    }

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
  static Future<void> restartToAfterHomeRoute({
    required String? routeName,
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

      await Routing.goTo(route: ScreenName.logo);

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> autoNavigateToAfterHomeRoute({
    required bool mounted,
  }) async {

    if (mounted == true){

      final RouteSettings? _afterHomeRoute = UiProvider.proGetAfterHomeRoute(
        context: getMainContext(),
        listen: false,
      );

      // blog('autoNavigateFromHomeScreen : _afterHomeRoute : ${_afterHomeRoute?.name} : arg : ${_afterHomeRoute?.arguments}');

      if (_afterHomeRoute != null){

        /// CLEAR AFTER HOME ROUTE
        UiProvider.proClearAfterHomeRoute(
          notify: true,
        );

        final String? _args = _afterHomeRoute.arguments as String?;

        await Routing.goTo(
          route: _afterHomeRoute.name,
          arg: _args,
        );

      }

    }

  }
  // -----------------------------------------------------------------------------
}

/*
THE REDIRECTOR
adb shell 'am start -a android.intent.action.VIEW -c android.intent.category.BROWSABLE -d "bldrs://deep/redirect"' net.bldrs.app

---

adb shell 'am start -a android.intent.action.VIEW -c android.intent.category.BROWSABLE -d "bldrs://deep/redirect
?key=e&key2=value2"' net.bldrs.app

Nour Magdi
7:35 AM
https://developers.facebook.com/tools/explorer/427786221866015/?method=GET&path=me%2Faccounts&version=v19.0
You
7:37 AM
17841447816479749
Hover over a message to pin it
keep
You
9:08 AM
https://www.instagram.com/lumiereegypt
You
9:34 AM
17841447816479749?fields=business_discovery.username(modulorstudio_eg)
You
9:36 AM
17841447816479749?fields=profile_picture_url,ig_id,followers_count,name,website,media
Nour Magdi
9:40 AM
business_discovery.username(modulorstudio_eg) {
profile_picture_url,
ig_id,
followers_count,
name,
website,
media
}
Nour Magdi
10:19 AM
adb shell 'am start -a android.intent.action.VIEW \
-c android.intent.category.BROWSABLE \
-d "bldrs://deep/redirect"' \
net.bldrs.app
Nour Magdi
10:20 AM
adb shell 'am start -a android.intent.action.VIEW -c android.intent.category.BROWSABLE -d "bldrs://deep/redirect"' net.bldrs.app
You
11:17 AM
"bldrs://deep/redirect
?key=e&key2=value2"

-------

 */
