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
  bool ankhIsOn;
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
  AnimationController _ankhAniController;
  Animation _ankhColorAni;

  @override
  void initState() {
    super.initState();

    _ankhAniController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this
    );

    _ankhColorAni = ColorTween(begin: Colorz.WhiteAir, end: Colorz.YellowSmoke)
        .animate(_ankhAniController);

    _ankhAniController.addListener(() {
      print(_ankhAniController.value);
      print(_ankhColorAni.value);
    });

    _ankhAniController.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        setState(() {
          widget.ankhIsOn = true;
        });
      }
      if(status == AnimationStatus.dismissed){
        setState(() {
          widget.ankhIsOn = false;
        });
      }

    });

  }

  @override
  void dispose() {
    _ankhAniController.dispose();
    super.dispose();
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
    // String saveBTVerse = ankhIsOn == true ? translate(context, 'Saved') :
    // translate(context, 'Save');
    Color saveBTColor = widget.ankhIsOn == true ? Colorz.YellowSmoke : Colorz.Nothing;
    // ----------------------------------------------------------------------------
    // Color flyerShadowColor = ankhIsOn == true ? Colorz.BlackBlack : Colorz.BlackBlack;
    // ----------------------------------------------------------------------------
    return
      AnimatedBuilder(
        animation: _ankhAniController,
        builder: (BuildContext context, _) =>
            Positioned(
              left: translate(context, 'Text_Direction') == 'ltr' ? null : 0,
              right: translate(context, 'Text_Direction') == 'ltr' ? 0 : null,
              bottom: 0,
              child:
              Stack(
                alignment: Alignment.center,
                children: <Widget>[

                  AnimatedContainer(
                    duration: Duration(milliseconds: 1000),
                    width: saveBTRadius*2,
                    height: saveBTRadius*2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.ankhIsOn == true ? Colorz.YellowSmoke : Colorz.Nothing,//_ankhColorAni.value,
                    ),
                  ),

                  (widget.microMode == true && widget.ankhIsOn == false) || widget.bzPageIsOn == true ? Container():
                  DreamBox(
                      icon: widget.ankhIsOn == true ? Iconz.SaveOn : Iconz.SaveOff, // saveBTIcon,
                      iconSizeFactor: 0.8,
                      width: saveBTRadius*2,
                      height: saveBTRadius*2,
                      corners: saveBTRadius,
                      boxMargins: EdgeInsets.all(footerBTMargins),
                      color: Colorz.Nothing,
                      boxFunction: (){
                        widget.tappingAnkh();
                        widget.ankhIsOn == false ? _ankhAniController.forward() :
                        _ankhAniController.reverse();
                      }
                  ),

                ],
              ),
            ),
      );
  }
}
