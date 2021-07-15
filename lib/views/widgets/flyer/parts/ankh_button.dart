import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:flutter/material.dart';

class AnkhButton extends StatefulWidget {
  final bool microMode;
  final bool bzPageIsOn;
  final bool slidingIsOn;
  final double flyerZoneWidth;
  final bool ankhIsOn;
  final Function tappingAnkh;

  AnkhButton({
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
  bool _ankhIsOn;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _ankhIsOn = widget.ankhIsOn;

    _ankhAniController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this
    );

    _ankhColorAni = ColorTween(begin: Colorz.White10, end: Colorz.Yellow80)
        .animate(_ankhAniController);

    _ankhAniController.addListener(() {
      // print(_ankhAniController.value);
      // print(_ankhColorAni.value);
    });

    _ankhAniController.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        setState(() {
          _ankhIsOn = true;
        });
      }
      if(status == AnimationStatus.dismissed){
        setState(() {
          _ankhIsOn = false;
        });
      }

    });

  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _ankhAniController.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    // final pro = Provider.of<CoFlyer>(context, listen: false);
    // bool ankhIsOn = pro.ankhIsOn;
    // String flyerID = pro.flyer.flyerID;
// -----------------------------------------------------------------------------
    double _footerBTMargins =
    (
        (_ankhIsOn == true && widget.microMode == true && widget.slidingIsOn == false) ?
        widget.flyerZoneWidth * 0.01// for micro flyer when AnkhIsOn
            :
        (_ankhIsOn == true) ?
        widget.flyerZoneWidth * 0.015 // for Normal flyer when AnkhIsOn
            :
        widget.flyerZoneWidth * 0.025 // for Normal flyer when !AnkhIsOn
    );
// -----------------------------------------------------------------------------
    double _flyerBottomCorners = widget.flyerZoneWidth * Ratioz.xxflyerBottomCorners;
    double _saveBTRadius = _flyerBottomCorners - _footerBTMargins;
    // String saveBTIcon = ankhIsOn == true ? Iconz.SaveOn : Iconz.SaveOff;
    // String saveBTVerse = ankhIsOn == true ? translate(context, 'Saved') :
    // translate(context, 'Save');
    // Color _saveBTColor = _ankhIsOn == true ? Colorz.YellowSmoke : Colorz.Nothing;
// -----------------------------------------------------------------------------
    // Color flyerShadowColor = ankhIsOn == true ? Colorz.BlackBlack : Colorz.BlackBlack;
// -----------------------------------------------------------------------------
    return
      Positioned(
        left: Wordz.textDirection(context) == 'ltr' ? null : 0,
        right: Wordz.textDirection(context) == 'ltr' ? 0 : null,
        bottom: 0,
        child:
        AnimatedBuilder(
          animation: _ankhAniController,
          builder: (BuildContext context, _){
            return
              Stack(
                alignment: Alignment.center,
                children: <Widget>[

                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: _saveBTRadius * 2,
                    height: _saveBTRadius * 2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.ankhIsOn == true ? Colorz.Yellow80 : Colorz.Nothing,//_ankhColorAni.value,
                    ),
                  ),
                  (widget.microMode == true && widget.ankhIsOn == false) || widget.bzPageIsOn == true ? Container():
                  DreamBox(
                      icon: widget.ankhIsOn == true ? Iconz.SaveOn : Iconz.SaveOff, // saveBTIcon,
                      iconSizeFactor: 0.8,
                      width: _saveBTRadius*2,
                      height: _saveBTRadius*2,
                      corners: _saveBTRadius,
                      margins: EdgeInsets.all(_footerBTMargins),
                      color: Colorz.Nothing,
                      onTap: (){
                        widget.tappingAnkh();
                        // _ankhIsOn == false ? _ankhAniController.forward() :
                        // _ankhAniController.reverse();
                      }
                      ),

                ],
              );
            },
        ),
      );
  }
}
