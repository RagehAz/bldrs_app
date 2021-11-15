import 'package:bldrs/controllers/drafters/text_directionerz.dart';
import 'package:bldrs/controllers/router/route_names.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/views/screens/i_flyer/h_0_flyer_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

abstract class Nav{
// -----------------------------------------------------------------------------
  static PageTransition<dynamic> slideToScreen(Widget screen, RouteSettings settings){
    return
      PageTransition(
        child: screen,
        type: PageTransitionType.bottomToTop,
        duration: Ratioz.durationFading200,
        reverseDuration: Ratioz.durationFading200,
        curve: Curves.fastOutSlowIn,
        settings: settings,
      );
  }
// -----------------------------------------------------------------------------
  static PageTransition<dynamic> fadeToScreen(Widget screen, RouteSettings settings){
    return
      PageTransition(
        child: screen,
        type: PageTransitionType.fade,
        duration: Ratioz.duration150ms,
        reverseDuration: Ratioz.duration150ms,
        curve: Curves.fastOutSlowIn,
        settings: settings,
      );
  }
// -----------------------------------------------------------------------------
  static Future<dynamic> goToNewScreen (BuildContext context, Widget screen, {PageTransitionType transitionType}) async {

    final PageTransitionType _transition = transitionType == null ? PageTransitionType.bottomToTop : transitionType;

    dynamic _result = await Navigator.push(context,
      PageTransition(
          type: _transition,
          child: screen,
          duration: Ratioz.durationFading200,
          reverseDuration: Ratioz.durationFading200,
          curve: Curves.fastOutSlowIn,
          alignment: Alignment.bottomCenter,
      ),
    );

  return _result;
  }
// -----------------------------------------------------------------------------
  static Future<void> goToRoute(BuildContext context, String routezName, {dynamic arguments}) async {
    await Navigator.of(context).pushNamed(routezName, arguments: arguments);
  }
// -----------------------------------------------------------------------------
  static Future<void> openFlyerOldWay(BuildContext context, String flyerID) async {
    await Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 750),
          pageBuilder: (_,__,___){
            return Hero(
              tag: flyerID, // galleryCoFlyers[index].flyer.flyerID,
              child: Material(
                type: MaterialType.transparency,
                child: new FlyerScreen(
                  // flyerID: flyerID, // galleryCoFlyers[index].flyer.flyerID,
                ),
              ),
            );
          },
        )
    );
  }
// -----------------------------------------------------------------------------
  static Future<void> openFlyer({BuildContext context, String flyerID, FlyerModel flyer}) async {

    /// A - by tinyFlyer
    if (flyer != null){
      await goToNewScreen(context, new FlyerScreen(flyerModel: flyer, flyerID: flyerID,));
    }

    /// A - by flyerID
    else if (flyerID != null){
      await goToRoute(context, Routez.FlyerScreen, arguments: flyerID);
    }

    // /// A - nothing give
    // else {
    //   // do nothing
    // }

  }
// -----------------------------------------------------------------------------
  static Future<void> goBack(BuildContext context, {argument}) async {
    /// you can send whatever you want in Navigator.pop(context,whatever you want to pass)
    await Navigator.pop(context, argument);
  }
// -----------------------------------------------------------------------------
  static goBackToUserChecker(BuildContext context){

    // var _navResult = Navigator.popUntil(context,
    //     ModalRoute.withName(Routez.UserChecker)
    // );

    Navigator.popUntil(context,
        ModalRoute.withName(Routez.UserChecker)
    );

  }
// -----------------------------------------------------------------------------
  static goBackUntil(BuildContext context, String routez){

    // var _navResult = Navigator.popUntil(context,
    //     ModalRoute.withName(Routez.UserChecker)
    // );

    Navigator.popUntil(context, ModalRoute.withName(routez)
    );

  }
// -----------------------------------------------------------------------------
  static goBackToHomeScreen(BuildContext context){

    Navigator.popUntil(context,
        ModalRoute.withName(Routez.Home)
    );

  }
// -----------------------------------------------------------------------------
  static Future<dynamic> replaceScreen(BuildContext context, Widget screen) async {
    final dynamic _result = await Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => screen));
    return _result;
  }
// -----------------------------------------------------------------------------
  static Future<void> removeRouteBelow(BuildContext context, Widget screen) async {
    Navigator.removeRouteBelow(context, MaterialPageRoute(builder: (BuildContext context) => screen));
  }
// -----------------------------------------------------------------------------
  static Future<void> pushNamedAndRemoveAllBelow(BuildContext context, String goToRoute) async {
    await Navigator.of(context)
        .pushNamedAndRemoveUntil(goToRoute, (Route<dynamic> route) => false);
  }
// -----------------------------------------------------------------------------
  static Future<void> pushAndRemoveUntil({BuildContext context, Widget screen}) async {

    await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (_) => screen,
        ),
            (route) => route.isFirst
    );
  }
// -----------------------------------------------------------------------------
  static PageTransitionType superHorizontalTransition(BuildContext context){

    final PageTransitionType _transition = appIsLeftToRight(context) == true ? PageTransitionType.rightToLeftWithFade : PageTransitionType.leftToRightWithFade;
    return _transition;

  }
// -----------------------------------------------------------------------------
}