
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
