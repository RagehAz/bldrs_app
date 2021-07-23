import 'package:bldrs/controllers/drafters/object_checkers.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/screens/h_0_flyer_screen.dart';
import 'package:flutter/material.dart';
import 'route_names.dart';
import 'package:page_transition/page_transition.dart';

class Nav{
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

    PageTransitionType _transition = transitionType == null ? PageTransitionType.bottomToTop : transitionType;

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
  static goToRoute(BuildContext context, String routezName, {dynamic arguments}){
    Navigator.of(context).pushNamed(routezName, arguments: arguments);
  }
// -----------------------------------------------------------------------------
  static void openFlyerOldWay(BuildContext context, String flyerID){
    Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 750),
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
  void openFlyer(BuildContext context, dynamic tinyFlyerOrID){

    if (ObjectChecker.objectIsString(tinyFlyerOrID) == true){

      goToRoute(context, Routez.FlyerScreen, arguments: tinyFlyerOrID);
    } else {

      goToNewScreen(context, FlyerScreen(tinyFlyer: tinyFlyerOrID,));

    }

    // print('open flyer navigator recieved $flyerID');
    //
    // Navigator.of(context).pushNamed(
    //   Routez.FlyerScreen,
    //   arguments: flyerID,
    // );
  }
// -----------------------------------------------------------------------------
  static Future<void> goBack(BuildContext context, {argument}) async {
    // you can send whatever you want in Navigator.pop(context,whatever you want to pass)
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
    var _result = await Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => screen));
    return _result;
  }
// -----------------------------------------------------------------------------
  static Future<dynamic> removeRouteBelow(BuildContext context, Widget screen) async {
    var _result = Navigator.removeRouteBelow(context, MaterialPageRoute(builder: (BuildContext context) => screen));
    return _result;
  }
// -----------------------------------------------------------------------------
  static void pushNamedAndRemoveAllBelow(BuildContext context, String goToRoute){
    Navigator.of(context)
        .pushNamedAndRemoveUntil(goToRoute, (Route<dynamic> route) => false);
  }
// -----------------------------------------------------------------------------
}