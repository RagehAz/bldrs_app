import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/keyboarders.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/super_flyer.dart';
import 'package:bldrs/views/widgets/flyer/editor/editorPanel.dart';
import 'package:flutter/material.dart';

class FlyerZoneBox extends StatelessWidget {
  final SuperFlyer superFlyer;
  final double flyerZoneWidth;
  final Function onFlyerZoneTap;
  final List<Widget> stackWidgets;
  final Function onFlyerZoneLongPress;
  final BzModel editorBzModel;

  FlyerZoneBox({
    @required this.superFlyer,
    @required this.flyerZoneWidth, // NEVER DELETE THIS
    @required this.onFlyerZoneTap,
    this.stackWidgets,
    this.onFlyerZoneLongPress,
    this.editorBzModel,
  });

  @override
  Widget build(BuildContext context) {

// -----------------------------------------------------------------------------
    double _screenWithoutSafeAreaHeight = Scale.superScreenHeightWithoutSafeArea(context);
// -----------------------------------------------------------------------------
    double _flyerZoneWidth = flyerZoneWidth;
    double _flyerZoneFactor = Scale.superFlyerSizeFactorByWidth(context, superFlyer.flyerZoneWidth);
    double _flyerZoneHeight = _flyerZoneFactor == 1 ?
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

    BorderRadius _flyerBorders = Borderers.superBorderOnly(
        context: context,
        enTopLeft: _flyerTopCorners,
        enBottomLeft: _flyerBottomCorners,
        enBottomRight: _flyerBottomCorners,
        enTopRight: _flyerTopCorners
    );

    double _screenWidth = Scale.superScreenWidth(context);
    double _panelWidth =
        editorBzModel == null ? 0 :
        _screenWidth - _flyerZoneWidth - (Ratioz.appBarMargin * 3);

    return GestureDetector(
      onTap: (){
        onFlyerZoneTap();
        Keyboarders.minimizeKeyboardOnTapOutSide(context);
      },
      onLongPress: onFlyerZoneLongPress,
      child: Container(
        width: _flyerZoneWidth + _panelWidth + Ratioz.appBarMargin,
        height: _flyerZoneHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            /// EditorPanel
            if (editorBzModel != null)
            EditorPanel(
              superFlyer: superFlyer,
              panelWidth: _panelWidth,
              bzModel: editorBzModel,
              flyerZoneWidth: _flyerZoneWidth,
            ),

            if (editorBzModel != null)
            SizedBox(
              width: Ratioz.appBarMargin,
            ),

            /// flyer zone
            Container(
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

          ],
        ),
      ),
    );
  }
}

