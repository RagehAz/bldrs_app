import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/keyboarders.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FlyerZone extends StatelessWidget {
  final double flyerSizeFactor;
  final Function tappingFlyerZone;
  final List<Widget> stackWidgets;
  final Function onLongPress;

  FlyerZone({
    @required this.flyerSizeFactor,
    @required this.tappingFlyerZone,
    this.stackWidgets,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {

// -----------------------------------------------------------------------------
    double _screenWithoutSafeAreaHeight = Scale.superScreenHeightWithoutSafeArea(context);
// -----------------------------------------------------------------------------
    double _flyerZoneWidth = Scale.superFlyerZoneWidth(context, flyerSizeFactor);
    double _flyerZoneHeight = flyerSizeFactor == 1 ?
    _screenWithoutSafeAreaHeight : _flyerZoneWidth * Ratioz.xxflyerZoneHeight;
    double _flyerTopCorners = _flyerZoneWidth * Ratioz.xxflyerTopCorners;
    double _flyerBottomCorners = _flyerZoneWidth * Ratioz.xxflyerBottomCorners;
// -----------------------------------------------------------------------------
    // void printingShit(){
    //   print('follow');
    // }
// -----------------------------------------------------------------------------
    // bool _barHidden = (bzPageIsOn == true) || (slidingIsOn = false) ?  true : false;
// -----------------------------------------------------------------------------
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

// -----------------------------------------------------------------------------

    // print ('slidingIsOn value =$slidingIsOn');

    BorderRadius _flyerBorders = Borderers.superBorderRadius(
        context: context,
        enTopLeft: _flyerTopCorners,
        enBottomLeft: _flyerBottomCorners,
        enBottomRight: _flyerBottomCorners,
        enTopRight: _flyerTopCorners
    );

    return GestureDetector(
      onTap: (){
        tappingFlyerZone();
        minimizeKeyboardOnTapOutSide(context);
      },
      onLongPress: onLongPress,
      child: Center(
        child: Container(
          width: _flyerZoneWidth,
          height: _flyerZoneHeight,
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            color: Colorz.White20,
              borderRadius: _flyerBorders,
              boxShadow: Shadowz.flyerZoneShadow(_flyerZoneWidth),
          ),
          child: ClipRRect(
            borderRadius: _flyerBorders,

            child: Container(
              width: _flyerZoneWidth,
              height: _flyerZoneHeight,
              child: Stack(
                alignment: Alignment.topCenter,
                children: stackWidgets == null ? [] : stackWidgets,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

