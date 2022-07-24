import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/x_screens/g_bz/a_bz_profile/a_my_bz_screen.dart';
import 'package:bldrs/b_views/x_screens/x_flyer/a_flyer_screen.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/f_helpers/drafters/text_directionerz.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/route_names.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Nav {

  Nav();

// -----------------------------------------------------------------------------

/// GOING FORWARD

// -------------------------------------
/// TESTED : WORKS PERFECT
static PageTransition<dynamic> slideToScreen(Widget screen, RouteSettings settings) {
  return PageTransition<dynamic>(
    child: screen,
    type: PageTransitionType.bottomToTop,
    // duration: Ratioz.durationFading200,
    // reverseDuration: Ratioz.durationFading200,
    curve: Curves.fastOutSlowIn,
    settings: settings,
  );
}
// -------------------------------------
/// TESTED : WORKS PERFECT
  static PageTransition<dynamic> fadeToScreen(Widget screen, RouteSettings settings) {
  return PageTransition<dynamic>(
    child: screen,
    type: PageTransitionType.fade,
    duration: Ratioz.duration150ms,
    reverseDuration: Ratioz.duration150ms,
    curve: Curves.fastOutSlowIn,
    settings: settings,
  );
}
// -------------------------------------
/// TESTED : WORKS PERFECT
  static Future<dynamic> goToNewScreen({
  @required BuildContext context,
  @required Widget screen,
  PageTransitionType transitionType = PageTransitionType.bottomToTop,
}) async {

  final dynamic _result = await Navigator.push(
    context,
    PageTransition<dynamic>(
      type: transitionType,
      child: screen,
      // duration: Ratioz.durationFading200,
      // reverseDuration: Ratioz.durationFading200,
      curve: Curves.fastOutSlowIn,
      alignment: Alignment.bottomCenter,
    ),
  );

  return _result;
}
// -------------------------------------
/// TESTED : WORKS PERFECT
  static Future<void> goToRoute(BuildContext context, String routezName, {dynamic arguments}) async {
  await Navigator.of(context).pushNamed(routezName, arguments: arguments);
}
// -------------------------------------
/// TESTED : WORKS PERFECT
  static Future<dynamic> replaceScreen({
  @required BuildContext context,
  @required Widget screen,
  PageTransitionType transitionType = PageTransitionType.bottomToTop,
}) async {

  final dynamic _result = await Navigator.pushReplacement(
      context,
      PageTransition<dynamic>(
        type: transitionType,
        child: screen,
        // duration: Ratioz.duration750ms,
        // reverseDuration: Ratioz.duration750ms,
        curve: Curves.fastOutSlowIn,
        alignment: Alignment.bottomCenter,
      )
  );

  return _result;
}
// -------------------------------------
  static Future<void> pushNamedAndRemoveAllBelow({
  @required BuildContext context,
  @required String goToRoute,
}) async {

  await Navigator.of(context).pushNamedAndRemoveUntil(goToRoute, (Route<dynamic> route) => false);

}
// -------------------------------------
  static Future<void> pushAndRemoveUntil({
  @required BuildContext context,
  @required Widget screen,
}) async {

  await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute<dynamic>(
        builder: (_) => screen,
      ),
          (Route<dynamic> route) => route.isFirst);
}
// -----------------------------------------------------------------------------

/// FLYER NAVIGATORS

// -------------------------------------
  static Future<void> openFlyerOldWay(BuildContext context, String flyerID) async {
  await Navigator.of(context).push(PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 750),
    pageBuilder: (_, __, ___) {
      return Hero(
        tag: flyerID, // galleryCoFlyers[index].flyer.flyerID,
        child: const Material(
          type: MaterialType.transparency,
          child: FlyerScreen(
              // flyerID: flyerID, // galleryCoFlyers[index].flyer.flyerID,
              ),
        ),
      );
    },
  ));
}
// -------------------------------------
  static Future<void> openFlyer({
  @required BuildContext context,
  String flyerID,
  FlyerModel flyer,
  bool isSponsored = false,
}) async {

  /// A - by  flyer
  if (flyer != null) {

    await goToNewScreen(
        context: context,
        screen: FlyerScreen(
          flyerModel: flyer,
          flyerID: flyerID,
          isSponsored: isSponsored,
        )
    );

  }

  /// A - by flyerID
  else if (flyerID != null) {
    await goToRoute(context, Routez.flyerScreen, arguments: flyerID);
  }

  // /// A - nothing give
  // else {
  //   // do nothing
  // }
}
// -----------------------------------------------------------------------------

/// GOING BACK

// -------------------------------------
/// TESTED : WORKS PERFECT
  static void goBack(BuildContext context, {dynamic passedData}) {
  Navigator.pop(context, passedData);
}
// -------------------------------------
/// TESTED : WORKS PERFECT
  static Future<void> closeApp(BuildContext context) async {
  await SystemNavigator.pop();
}
// -------------------------------------
  static void goBackToLogoScreen(BuildContext context) {
  // var _navResult = Navigator.popUntil(context,
  //     ModalRoute.withName(Routez.UserChecker)
  // );

  Navigator.popUntil(context, ModalRoute.withName(Routez.logoScreen));
}
// -------------------------------------
  static void goBackUntil(BuildContext context, String routeName) {

  Navigator.popUntil(context, ModalRoute.withName(routeName));
}
// -------------------------------------
  static void goBackToHomeScreen(BuildContext context) {
  blog('goBackToHomeScreen : popUntil Routez.home');
  Navigator.popUntil(context, ModalRoute.withName(Routez.home));
}
// -----------------------------------------------------------------------------

/// I DONT KNO ABOUT THIS SHIT

// -------------------------------------
  static Future<void> removeRouteBelow(BuildContext context, Widget screen) async {
  Navigator.removeRouteBelow(context, MaterialPageRoute<dynamic>(builder: (BuildContext context) => screen));
}
// -----------------------------------------------------------------------------

/// TRANSITION

// -------------------------------------
  static PageTransitionType superHorizontalTransition(BuildContext context) {
  final PageTransitionType _transition =
  appIsLeftToRight(context) == true ?
  PageTransitionType.rightToLeftWithFade
      :
  PageTransitionType.leftToRightWithFade;
  return _transition;
// -----------------------------------------------------------------------------
}
// -------------------------------------
  static Future<void> goToMyBzScreen({
    @required BuildContext context,
    @required String bzID,
    @required bool replaceCurrentScreen,
  }) async {

    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);

    final BzModel _bzModel = await _bzzProvider.fetchBzByID(
      context: context,
      bzID: bzID,
    );

    _bzzProvider.setActiveBz(
      bzModel: _bzModel,
      notify: true,
    );

    if (replaceCurrentScreen == true){
      await Nav.replaceScreen(
          context: context,
          screen: const MyBzScreen()
      );
    }

    else {
      await Nav.goToNewScreen(
          context: context,
          screen: const MyBzScreen()
      );
    }


  }
// -------------------------------------
  static Future<void> goRebootToInitNewBzScreen({
    @required BuildContext context,
    @required String bzID,
  }) async {

    await Nav.pushNamedAndRemoveAllBelow(
      context: context,
      goToRoute: Routez.logoScreen, // Routez.home
    );

    await Nav.goToMyBzScreen( /// TASK : THIS BITCH IS NOT ROUTING TO BZ SCREEN
      context: context,
      bzID: bzID,
      replaceCurrentScreen: true,
    );

  }
// -------------------------------------
}
