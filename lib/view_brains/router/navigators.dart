import 'package:bldrs/views/screens/s50_flyer_screen.dart';
import 'package:flutter/material.dart';
import 'route_names.dart';
// === === === === === === === === === === === === === === === === === === ===
goToNewScreen (BuildContext context, Widget screen){
Navigator.of(context).push(MaterialPageRoute(builder: (_){return screen;},),);
  }
// === === === === === === === === === === === === === === === === === === ===
goToRoute(BuildContext context, String routezName){
    Navigator.pushNamed(context, routezName);
  }
// === === === === === === === === === === === === === === === === === === ===
void openFlyerOldWay(BuildContext context, String flyerID){
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
  Navigator.of(context).pushNamed(
    Routez.FlyerScreen,
    arguments: flyerID,
  );
}
// === === === === === === === === === === === === === === === === === === ===
goBack(BuildContext context){
  Navigator.pop(context);
}