import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:flutter/material.dart';

class AnkhButton extends StatelessWidget {
  // final String flyerID;
  final bool microMode;
  final bool bzPageIsOn;
  final bool slidingIsOn;
  final double flyerZoneWidth;
  final bool ankhIsOn;
  final Function tappingAnkh;

  AnkhButton({
    // @required this.flyerID,
    @required this.microMode,
    @required this.bzPageIsOn,
    @required this.flyerZoneWidth,
    @required this.slidingIsOn,
    @required this.ankhIsOn,
    @required this.tappingAnkh,
});
  @override
  Widget build(BuildContext context) {
    // ----------------------------------------------------------------------------
    // final pro = Provider.of<CoFlyer>(context, listen: false);
    // bool ankhIsOn = pro.ankhIsOn;
    // String flyerID = pro.flyer.flyerID;
    // ----------------------------------------------------------------------------
    double footerBTMargins =
    (
        (ankhIsOn == true && microMode == true && slidingIsOn == false) ?
        flyerZoneWidth * 0.01// for micro flyer when AnkhIsOn
            :
        (ankhIsOn == true) ?
        flyerZoneWidth * 0.015 // for Normal flyer when AnkhIsOn
            :
        flyerZoneWidth * 0.025 // for Normal flyer when !AnkhIsOn
    );
    // ----------------------------------------------------------------------------
    double flyerBottomCorners = flyerZoneWidth * Ratioz.xxflyerBottomCorners;
    double saveBTRadius = flyerBottomCorners - footerBTMargins;
    // String saveBTIcon = ankhIsOn == true ? Iconz.SaveOn : Iconz.SaveOff;
    // String saveBTVerse = ankhIsOn == true ? getTranslated(context, 'Saved') :
    // getTranslated(context, 'Save');
    Color saveBTColor = ankhIsOn == true ? Colorz.YellowSmoke : Colorz.Nothing;
    // ----------------------------------------------------------------------------
    // Color flyerShadowColor = ankhIsOn == true ? Colorz.BlackBlack : Colorz.BlackBlack;
    // ----------------------------------------------------------------------------
    return
      Positioned(
        left: getTranslated(context, 'Text_Direction') == 'ltr' ? null : 0,
        right: getTranslated(context, 'Text_Direction') == 'ltr' ? 0 : null,
        bottom: 0,
        child:
        (microMode == true && ankhIsOn == false) || bzPageIsOn == true ? Container():
        DreamBox(
          icon: ankhIsOn == true ? Iconz.SaveOn : Iconz.SaveOff, // saveBTIcon,
          iconSizeFactor: 0.8,
          width: saveBTRadius*2,
          height: saveBTRadius*2,
          corners: saveBTRadius,
          boxMargins: EdgeInsets.all(footerBTMargins),
          color: saveBTColor,
          boxFunction: tappingAnkh,
        ),
    );
  }
}
