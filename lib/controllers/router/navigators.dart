import 'package:bldrs/controllers/drafters/text_directionerz.dart';
import 'package:bldrs/controllers/router/route_names.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/views/screens/i_flyer/h_0_flyer_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

// -----------------------------------------------------------------------------
  PageTransition<dynamic> slideToScreen(Widget screen, RouteSettings settings){
    return
      PageTransition<dynamic>(
        child: screen,
        type: PageTransitionType.bottomToTop,
        duration: Ratioz.durationFading200,
        reverseDuration: Ratioz.durationFading200,
        curve: Curves.fastOutSlowIn,
        settings: settings,
      );
  }
// -----------------------------------------------------------------------------
  PageTransition<dynamic> fadeToScreen(Widget screen, RouteSettings settings){
    return
      PageTransition<dynamic>(
        child: screen,
        type: PageTransitionType.fade,
        duration: Ratioz.duration150ms,
        reverseDuration: Ratioz.duration150ms,
        curve: Curves.fastOutSlowIn,
        settings: settings,
      );
  }
// -----------------------------------------------------------------------------
  Future<dynamic> goToNewScreen (BuildContext context, Widget screen, {PageTransitionType transitionType}) async {

    final PageTransitionType _transition = transitionType ?? PageTransitionType.bottomToTop;

    final dynamic _result = await Navigator.push(context,
      PageTransition<dynamic>(
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
  Future<void> goToRoute(BuildContext context, String routezName, {dynamic arguments}) async {
    await Navigator.of(context).pushNamed(routezName, arguments: arguments);
  }
// -----------------------------------------------------------------------------
  Future<void> openFlyerOldWay(BuildContext context, String flyerID) async {
    await Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 750),
          pageBuilder: (_,__,___){
            return Hero(
              tag: flyerID, // galleryCoFlyers[index].flyer.flyerID,
              child: const Material(
                type: MaterialType.transparency,
                child: const FlyerScreen(
                  // flyerID: flyerID, // galleryCoFlyers[index].flyer.flyerID,
                ),
              ),
            );
          },
        )
    );
  }
// -----------------------------------------------------------------------------
  Future<void> openFlyer({BuildContext context, String flyerID, FlyerModel flyer}) async {

    /// A - by tinyFlyer
    if (flyer != null){
      await goToNewScreen(context, new FlyerScreen(flyerModel: flyer, flyerID: flyerID,));
    }

    /// A - by flyerID
    else if (flyerID != null){
      await goToRoute(context, Routez.flyerScreen, arguments: flyerID);
    }

    // /// A - nothing give
    // else {
    //   // do nothing
    // }

  }
// -----------------------------------------------------------------------------
  void goBack(BuildContext context, {dynamic argument}) {
    /// you can send whatever you want in Navigator.pop(context,whatever you want to pass)
    Navigator.pop(context, argument);
    // await null;
  }
// -----------------------------------------------------------------------------
  goBackToUserChecker(BuildContext context){

    // var _navResult = Navigator.popUntil(context,
    //     ModalRoute.withName(Routez.UserChecker)
    // );

    Navigator.popUntil(context,
        ModalRoute.withName(Routez.userChecker)
    );

  }
// -----------------------------------------------------------------------------
  goBackUntil(BuildContext context, String routez){

    // var _navResult = Navigator.popUntil(context,
    //     ModalRoute.withName(Routez.UserChecker)
    // );

    Navigator.popUntil(context, ModalRoute.withName(routez)
    );

  }
// -----------------------------------------------------------------------------
  goBackToHomeScreen(BuildContext context){

    Navigator.popUntil(context,
        ModalRoute.withName(Routez.home)
    );

  }
// -----------------------------------------------------------------------------
  Future<dynamic> replaceScreen(BuildContext context, Widget screen) async {
    final dynamic _result = await Navigator.pushReplacement(context, MaterialPageRoute<dynamic>(builder: (BuildContext context) => screen));
    return _result;
  }
// -----------------------------------------------------------------------------
  Future<void> removeRouteBelow(BuildContext context, Widget screen) async {
    Navigator.removeRouteBelow(context, MaterialPageRoute<dynamic>(builder: (BuildContext context) => screen));
  }
// -----------------------------------------------------------------------------
  Future<void> pushNamedAndRemoveAllBelow(BuildContext context, String goToRoute) async {
    await Navigator.of(context)
        .pushNamedAndRemoveUntil(goToRoute, (Route<dynamic> route) => false);
  }
// -----------------------------------------------------------------------------
  Future<void> pushAndRemoveUntil({@required BuildContext context, @required Widget screen}) async {

    await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<dynamic>(
            builder: (_) => screen,
        ),
            (Route<dynamic> route) => route.isFirst
    );
  }
// -----------------------------------------------------------------------------
  PageTransitionType superHorizontalTransition(BuildContext context){

    final PageTransitionType _transition = appIsLeftToRight(context) == true ? PageTransitionType.rightToLeftWithFade : PageTransitionType.leftToRightWithFade;
    return _transition;

  }
