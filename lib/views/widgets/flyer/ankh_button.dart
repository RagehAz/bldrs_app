import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:flutter/material.dart';

class AnkhButton extends StatefulWidget {
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
  _AnkhButtonState createState() => _AnkhButtonState();
}

class _AnkhButtonState extends State<AnkhButton> with SingleTickerProviderStateMixin{
  AnimationController _ankhAnimation;

  @override
  void initState() {
    // _ankhAnimation = AnimationController(
    //   duration: Duration(seconds: 1),
    //   vsync:
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ----------------------------------------------------------------------------
    // final pro = Provider.of<CoFlyer>(context, listen: false);
    // bool ankhIsOn = pro.ankhIsOn;
    // String flyerID = pro.flyer.flyerID;
    // ----------------------------------------------------------------------------
    double footerBTMargins =
    (
        (widget.ankhIsOn == true && widget.microMode == true && widget.slidingIsOn == false) ?
        widget.flyerZoneWidth * 0.01// for micro flyer when AnkhIsOn
            :
        (widget.ankhIsOn == true) ?
        widget.flyerZoneWidth * 0.015 // for Normal flyer when AnkhIsOn
            :
        widget.flyerZoneWidth * 0.025 // for Normal flyer when !AnkhIsOn
    );
    // ----------------------------------------------------------------------------
    double flyerBottomCorners = widget.flyerZoneWidth * Ratioz.xxflyerBottomCorners;
    double saveBTRadius = flyerBottomCorners - footerBTMargins;
    // String saveBTIcon = ankhIsOn == true ? Iconz.SaveOn : Iconz.SaveOff;
    // String saveBTVerse = ankhIsOn == true ? getTranslated(context, 'Saved') :
    // getTranslated(context, 'Save');
    Color saveBTColor = widget.ankhIsOn == true ? Colorz.YellowSmoke : Colorz.Nothing;
    // ----------------------------------------------------------------------------
    // Color flyerShadowColor = ankhIsOn == true ? Colorz.BlackBlack : Colorz.BlackBlack;
    // ----------------------------------------------------------------------------
    return
      Positioned(
        left: getTranslated(context, 'Text_Direction') == 'ltr' ? null : 0,
        right: getTranslated(context, 'Text_Direction') == 'ltr' ? 0 : null,
        bottom: 0,
        child:
        (widget.microMode == true && widget.ankhIsOn == false) || widget.bzPageIsOn == true ? Container():
        DreamBox(
          icon: widget.ankhIsOn == true ? Iconz.SaveOn : Iconz.SaveOff, // saveBTIcon,
          iconSizeFactor: 0.8,
          width: saveBTRadius*2,
          height: saveBTRadius*2,
          corners: saveBTRadius,
          boxMargins: EdgeInsets.all(footerBTMargins),
          color: saveBTColor,
          boxFunction: widget.tappingAnkh,
        ),
    );
  }
}
