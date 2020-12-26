import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/drafters/shadowers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FlyerZone extends StatelessWidget {
  final double flyerSizeFactor;
  final Function tappingFlyerZone;
  final List<Widget> stackWidgets;

  FlyerZone({
    @required this.flyerSizeFactor,
    @required this.tappingFlyerZone,
    this.stackWidgets,
  });

  @override
  Widget build(BuildContext context) {

    // ----------------------------------------------------------------------
    double screenWidth = superScreenWidth(context);
    double screenWithoutSafeAreaHeight = superScreenHeightWithoutSafeArea(context);
    // ----------------------------------------------------------------------
    double flyerZoneWidth = superFlyerZoneWidth(flyerSizeFactor, screenWidth);
    double flyerZoneHeight = flyerSizeFactor == 1 ?
    screenWithoutSafeAreaHeight : flyerZoneWidth * Ratioz.xxflyerZoneHeight;
    double flyerTopCorners = flyerZoneWidth * Ratioz.xxflyerTopCorners;
    double flyerBottomCorners = flyerZoneWidth * Ratioz.xxflyerBottomCorners;
    // ----------------------------------------------------------------------
    // void printingShit(){
    //   print('follow');
    // }
    // ----------------------------------------------------------------------
    // bool _barHidden = (bzPageIsOn == true) || (slidingIsOn = false) ?  true : false;
    // ----------------------------------------------------------------------
    // int slideIndex = widget.currentSlideIndex;
    // bool ankhIsOn = true;//flyerData.flyerAnkhIsOn;

    // bool microMode = flyerZoneWidth < screenWidth * 0.4 ? true : false;

    // double footerBTMargins =
    // ((ankhIsOn == true && (microMode == true && slidingIsOn == false)) ? flyerZoneWidth * 0.01: // for micro flyer when AnkhIsOn
    // (ankhIsOn == true) ? flyerZoneWidth * 0.015 : // for Normal flyer when AnkhIsOn
    // flyerZoneWidth * 0.025); // for Normal flyer when !AnkhIsOn
    // double saveBTRadius = flyerBottomCorners - footerBTMargins;
    // Color footerBTColor = Colorz.GreySmoke;
    // String saveBTIcon = ankhIsOn == true ? Iconz.SaveOn : Iconz.SaveOff;
    // String saveBTVerse = ankhIsOn == true ? getTranslated(context, 'Saved') :
    // getTranslated(context, 'Save');
    // Color saveBTColor = ankhIsOn == true ? Colorz.YellowSmoke : Colorz.Nothing;

    Color flyerShadowColor = Colorz.BlackBlack;
    // ----------------------------------------------------------------------

    // print ('slidingIsOn value =$slidingIsOn');

    BorderRadius flyerBorders = superBorderRadius(context, flyerTopCorners, flyerBottomCorners, flyerBottomCorners, flyerTopCorners);

    return GestureDetector(
      onTap: tappingFlyerZone,
      child: Center(
        child: Container(
          width: flyerZoneWidth,
          height: flyerZoneHeight,
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
              borderRadius: flyerBorders,
              gradient: RadialGradient(
                colors: [Colorz.WhiteAir, Colorz.Nothing],
                stops: [0, 0.3],
                center: Alignment.center,
                radius:  0.18,
              ),
              boxShadow: [
                CustomBoxShadow(
                    color: flyerShadowColor,
                    blurRadius: flyerZoneWidth * 0.055,
                    blurStyle: BlurStyle.outer),
              ]
          ),
          child: ClipRRect(
            borderRadius: flyerBorders,

            child: Stack(
              alignment: Alignment.topCenter,
              children: stackWidgets,
            ),
          ),
        ),
      ),
    );
  }
}

