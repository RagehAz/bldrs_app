import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/screens/s51_flyer_screen.dart';
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
        duration: Ratioz.slidingAndFadingDuration,
        reverseDuration: Ratioz.slidingAndFadingDuration,
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
        duration: Ratioz.fadingDuration,
        reverseDuration: Ratioz.fadingDuration,
        curve: Curves.fastOutSlowIn,
        settings: settings,
      );
  }
// -----------------------------------------------------------------------------
  static Future<dynamic> goToNewScreen (BuildContext context, Widget screen) async {
    dynamic _result = await Navigator.push(context,
      PageTransition(
          type: PageTransitionType.scale,
          child: screen,
          duration: Ratioz.slidingAndFadingDuration,
          reverseDuration: Ratioz.slidingAndFadingDuration,
          curve: Curves.fastOutSlowIn,
          alignment: Alignment.bottomCenter,
      ),
    );

  return _result;
  }
// -----------------------------------------------------------------------------
  static goToRoute(BuildContext context, String routezName){
    Navigator.pushNamed(context, routezName);
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
  void openFlyer(BuildContext context, String flyerID){

    print('open flyer navigator recieved $flyerID');

    Navigator.of(context).pushNamed(
      Routez.FlyerScreen,
      arguments: flyerID,
    );
  }
// -----------------------------------------------------------------------------
  static goBack(BuildContext context, {argument}){
    // you can send whatever you want in Navigator.pop(context,whatever you want to pass)
    Navigator.pop(context, argument);
  }
// -----------------------------------------------------------------------------

}