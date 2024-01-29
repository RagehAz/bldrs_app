part of bldrs_routing;
// ignore_for_file: non_constant_identifier_names

/// => TAMAM
class BldrsNav {
  // -----------------------------------------------------------------------------

  const BldrsNav();

  // -----------------------------------------------------------------------------

  /// PUSH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<dynamic> goToNewScreen({
    required Widget screen,
    PageTransitionType? pageTransitionType,
    Duration duration = const Duration(milliseconds: 300),
  }){
    return Nav.goToNewScreen(
      context: getMainContext(),
      screen: screen,
      pageTransitionType: pageTransitionType,
      duration: duration,
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
    );
  }
  // -----------------------------------------------------------------------------

  /// BACK

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> backFromHomeScreen({
    required BuildContext context,
  }) async {

      final bool _flyerIsOpen = !UiProvider.proGetLayoutIsVisible(
          context: getMainContext(),
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
      await pushHomeRouteAndRemoveAllBelow();
    }

    else {
      await Nav.goBack(
          context: getMainContext(),
      );
    }

  }
  // -----------------------------------------------------------------------------

  /// LOADING

  // --------------------
  /// staticLogoScreen - animatedLogoScreen
  static Future<void> pushLogoRouteAndRemoveAllBelow({
    required bool animatedLogoScreen,
  }) async {


    if (animatedLogoScreen){
      await Nav.pushNamedAndRemoveAllBelow(
        context: getMainContext(),
        goToRoute: ScreenName.home,
      );
    }
    else {

      /// we already remove this layer in
      // Navigator.popUntil(context, ModalRoute.withName(Routing.logoScreen));

      await Nav.pushNamedAndRemoveAllBelow(
        context: getMainContext(),
        goToRoute: ScreenName.home,
      );
    }

  }
  // -----------------------------------------------------------------------------

  /// MAIN

  // --------------------
  /// home
  static Future<void> pushHomeRouteAndRemoveAllBelow() async {

    await Nav.pushNamedAndRemoveAllBelow(
      goToRoute: ScreenName.home,
      context: getMainContext(),
    );

  }
  // --------------------
  // /// auth
  // static Future<void> pushAuthRoute() async {
  //
  //   await Nav.goToRoute(getMainContext(), RouteName.auth);
  //
  // }
  // --------------------
  /// search
  // static Future<void> pushSearchRoute() async {
  //   await Nav.goToRoute(getMainContext(), RouteName.search);
  // }
  // --------------------
  /// appSettings
  // static Future<void> pushAppSettingsRoute() async {
  //   await Nav.goToRoute(getMainContext(), RouteName.appSettings);
  // }
  // -----------------------------------------------------------------------------

  /// PROFILE

  // --------------------
  /// user : profile - notifications - following - settings
  static Future<void> pushMyUserScreen(
  //     {
  //   UserTab userTab = UserTab.profile,
  // }
  ) async {

    // String? _path;
    //
    // switch (userTab){
    //   case UserTab.profile:         _path = RouteName.myUserProfile; break;
    //   case UserTab.notifications:   _path = RouteName.myUserNotes; break;
    //   case UserTab.saves:           _path = RouteName.savedFlyers; break;
    //   case UserTab.following:       _path = RouteName.myUserFollowing; break;
    //   case UserTab.settings:        _path = RouteName.myUserSettings; break;
    // }
    //
    // await Nav.goToRoute(getMainContext(), _path);

    // await Nav.goToNewScreen(
    //   context: getMainContext(),
    //   screen: UserProfileScreen(
    //     userTab: userTab,
    //   ),
    // );

  }
  // --------------------
  /// savedFlyers
  // static Future<void> pushSavedFlyersRoute() async {
  //   await Nav.goToRoute(getMainContext(), RouteName.savedFlyers);
  // }
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
  // /// myBzAboutPage - myBzFlyersPage - myBzTeamPage - myBzNotesPage
  // static Future<void> goToMyBzScreen({
  //   required String? bzID,
  //   required bool replaceCurrentScreen,
  //   BzTab initialTab = BzTab.flyers,
  // }) async {
  //
  //   final BzModel? _bzModel = await BzProtocols.fetchBz(
  //     bzID: bzID,
  //   );
  //
  //   HomeProvider.proSetActiveBzModel(
  //     context: getMainContext(),
  //     bzModel: _bzModel,
  //     notify: true,
  //   );
  //
  //   if (replaceCurrentScreen == true){
  //     await Nav.replaceScreen(
  //         context: getMainContext(),
  //         screen: MyBzScreen(
  //           initialTab: initialTab,
  //         )
  //     );
  //   }
  //
  //   else {
  //     blog('GOING TO BZ SCREEN AHOO');
  //     await BldrsNav.goToNewScreen(
  //         screen: MyBzScreen(
  //           initialTab: initialTab,
  //         )
  //     );
  //   }
  //
  // }
  // --------------------
  ///DEPRECATED
  /*
  /// REBOOT TO INIT NEW BZ SCREEN
  static Future<void> goRebootToInitNewBzScreenx({
    required BzModel? bzModel,
  }) async {

    if (bzModel != null){

      await onGoToAuthorEditorScreen(
        bzModel: bzModel,
        authorModel: AuthorModel.getAuthorFromBzByAuthorID(
          bz: bzModel,
          authorID: Authing.getUserID(),
        ),
        navAfterDone: false,
      );

      await BldrsNav.restartAndRoute(
        route: RouteName.myBzAboutPage,
        arguments: bzModel.id,
        goToAnimatedLogoScreen: true,
      );

    }

  }
   */
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
  static Future<void> jumpToUserPreviewScreen({
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
  static Future<void> jumpToBzPreviewScreen({
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
  static Future<void> jumpToFlyerPreviewScreen({
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
  static Future<void> jumpToFlyerReviewScreen({
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
  // --------------------
  /// countryPreview
  /*
  static Future<void> jumpToCountryPreviewScreen({
    required BuildContext context,
    required String countryID,
  }) async {

    if (countryID != null){

      final CountryModel _countryModel = await ZoneProtocols.fetchCountry(
          countryID: countryID,
      );

      if (_countryModel != null){

        blog('should go to Country preview screen');

        // await Nav.goToNewScreen(
        //   context: context,
        //   screen: CountryPreviewScreen(),
        // );

      }

    }

  }
   */
  // ------------------------------------------------------------

  /// WEB

  // --------------------
  /// underConstruction
  static Future<void> pushBldrsUnderConstructionRoute() async {
    await Nav.goToRoute(getMainContext(), ScreenName.underConstruction);
    // await Nav.goToNewScreen(context: getMainContext(), screen: const BldrsUnderConstructionScreen());
  }
  // --------------------
  /// banner
  static Future<void> pushBannerRoute() async {
    await Nav.goToRoute(getMainContext(), ScreenName.banner);
  }
  // --------------------
  /// privacy
  static Future<void> pushPrivacyScreen() async {

    if (kIsWeb == true){
      await Nav.goToRoute(getMainContext(), ScreenName.privacy);
    }
    else {
      await Launcher.launchURL(Standards.privacyPolicyURL);
    }

  }
  // --------------------
  /// terms
  static Future<void> pushTermsScreen() async {

    if (kIsWeb == true){
      await Nav.goToRoute(getMainContext(), ScreenName.terms);
    }
    else {
      await Launcher.launchURL(Standards.termsAndRegulationsURL);
    }

  }
  // --------------------
  /// deleteMyData
  static Future<void> pushDeleteMyDataScreen() async {

    await Nav.goToRoute(getMainContext(), ScreenName.deleteMyData);

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
        await pushHomeRouteAndRemoveAllBelow();
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> restartAndRoute({
    String? route,
    dynamic arguments,
    bool goToAnimatedLogoScreen = false,
  }) async {

    if (route != null) {
      UiProvider.proSetAfterHomeRoute(
        routeName: route,
        arguments: arguments,
        notify: true,
      );
    }

    await BldrsNav.pushLogoRouteAndRemoveAllBelow(
      animatedLogoScreen: goToAnimatedLogoScreen,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkNootTapStartsFromHome(String? routeName){

    switch (routeName){
      /// --------------------
      // case Routing.staticLogoScreen     : return true; break;
      // case Routing.animatedLogoScreen   : return true; break;
      /// --------------------
      // case Routing.home                 : return true; break;
      // case Routing.auth                 : return true; break;
      // case RouteName.search               : return true;
      // case RouteName.appSettings          : return true;
      /// --------------------
      // case RouteName.myUserProfile              : return true;
      // case Routing.savedFlyers          : return true; break;
      // case Routing.profileEditor        : return true;
      /// --------------------
      // case RouteName.myUserNotes      : return true;
      /// --------------------
      // case Routing.bzEditor             : return true;
      // case Routing.flyerEditor          : return true;
      /// --------------------
      // case RouteName.myBzAboutPage       : return true;
      // case RouteName.myBzFlyersPage       : return true;
      // case RouteName.myBzTeamPage         : return true;
      // case RouteName.myBzNotesPage        : return true;
      /// --------------------
      case ScreenName.userPreview          : return false;
      case ScreenName.bzPreview            : return false;
      case ScreenName.flyerPreview         : return false;
      case ScreenName.flyerReviews         : return false;
      // case RouteName.countryPreview       : return false;
      /// --------------------
      default: return true;
    }

  }
  // -----------------------------------------------------------------------------

  /// IMAGE FULL SCREEN

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goToImageFullScreenByBytes({
    required Uint8List bytes,
    required Dimensions dims,
    required String title,
  }) async {

    await BldrsNav.goToNewScreen(
        screen: SlideFullScreen(
          image: bytes,
          imageSize: dims,
          filter: ImageFilterModel.noFilter(),
          title: Verse.plain(title),
        ),
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goToImageFullScreenByPath({
    required String? path,
    required String? title,
  }) async {

    final PicModel? _pic = await PicProtocols.fetchPic(path);

    await BldrsNav.goToNewScreen(
        screen: SlideFullScreen(
          image: _pic?.bytes,
          imageSize: Dimensions(
            width: _pic?.meta?.width,
            height: _pic?.meta?.height,
          ),
          filter: ImageFilterModel.noFilter(),
          title: Verse.plain(title),
        ),
    );

  }
  // -----------------------------------------------------------------------------

  /// TRANSITION

  // --------------------
  /// TESTED : WORKS PERFECT
  static PageTransition<dynamic> transitSuperHorizontal({
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
  // --------------------

}
