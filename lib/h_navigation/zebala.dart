
// // --------------------
// /// underConstruction
// static Future<void> pushBldrsUnderConstructionRoute() async {
// await Nav.goToRoute(getMainContext(), ScreenName.underConstruction);
// // await Nav.goToNewScreen(context: getMainContext(), screen: const BldrsUnderConstructionScreen());
// }

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

/*
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
 */
