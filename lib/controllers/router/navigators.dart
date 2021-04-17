import 'package:bldrs/views/screens/s51_flyer_screen.dart';
import 'package:flutter/material.dart';
import 'route_names.dart';

class Nav{
// === === === === === === === === === === === === === === === === === === ===
  static goToNewScreen (BuildContext context, Widget screen){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){return screen;},),);
  }
// === === === === === === === === === === === === === === === === === === ===
  static goToRoute(BuildContext context, String routezName){
    Navigator.pushNamed(context, routezName);
  }
// === === === === === === === === === === === === === === === === === === ===
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
// === === === === === === === === === === === === === === === === === === ===
  void openFlyer(BuildContext context, String flyerID){

    print('open flyer navigator recieved $flyerID');

    Navigator.of(context).pushNamed(
      Routez.FlyerScreen,
      arguments: flyerID,
    );
  }
// === === === === === === === === === === === === === === === === === === ===
  static goBack(BuildContext context, {argument}){
    // you can send whatever you want in Navigator.pop(context,whatever you want to pass)
    Navigator.pop(context, argument);
  }
// === === === === === === === === === === === === === === === === === === ===

}