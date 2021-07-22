import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/localization/localization_constants.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/footer.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/footer_button.dart';
import 'package:flutter/material.dart';

class AnkhButton extends StatefulWidget {
  final double flyerZoneWidth;
  final bool bzPageIsOn;
  final bool slidingIsOn;
  final bool ankhIsOn;
  final Function tappingAnkh;

  AnkhButton({
    @required this.flyerZoneWidth,
    @required this.bzPageIsOn,
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
  String _saveBTIcon;

  Color _onColor = Colorz.Yellow80;
  Color _offColor = Colorz.Nothing;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _ankhIsOn = widget.ankhIsOn;
    _saveBTIcon = _ankhIsOn == true ? Iconz.SaveOn : Iconz.SaveOff;

    _ankhAniController = AnimationController(
      duration: Ratioz.durationFading200,
      vsync: this
    );

    _ankhColorAni = _initialTween().animate(_ankhAniController);

    _ankhAniController.addListener(() {
      // print(_ankhAniController.value);
      // print(_ankhColorAni.value);
    });

    // _ankhAniController.addStatusListener((status) {
    //   if(status == AnimationStatus.completed){
    //     setState(() {
    //       _ankhIsOn = true;
    //     });
    //   }
    //   if(status == AnimationStatus.dismissed){
    //     setState(() {
    //       _ankhIsOn = false;
    //     });
    //   }
    //
    // });

  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _ankhAniController.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  ColorTween _initialTween(){
    ColorTween _tween;

    if(widget.ankhIsOn){
      _tween = ColorTween(begin: _onColor, end: _offColor);
    }

    else {
      _tween = ColorTween(begin: _offColor, end: _onColor);
    }

    return _tween;
  }
// -----------------------------------------------------------------------------
  Future<void> _onAnkhTap() async {
    widget.tappingAnkh();

    if (_ankhIsOn == true){

      setState(() {
        _ankhIsOn = false;
        _saveBTIcon = Iconz.SaveOff;
      });
      await _ankhAniController.reverse();

    }

    else {

      setState(() {
        _ankhIsOn = true;
        _saveBTIcon = Iconz.SaveOn;
      });
      await _ankhAniController.forward();

    }
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    // final pro = Provider.of<CoFlyer>(context, listen: false);
    // String flyerID = pro.flyer.flyerID;
// -----------------------------------------------------------------------------
    double _saveBTSize = FlyerFooter.buttonSize(
      context: context,
      flyerZoneWidth: widget.flyerZoneWidth,
      buttonIsOn: _ankhIsOn,
    ) ;


    String _saveBTVerse = widget.ankhIsOn == true ? translate(context, 'Saved') :
    translate(context, 'Save');
    Color _saveBTColor = _ankhIsOn == true ? Colorz.Yellow80 : Colorz.White10;
// -----------------------------------------------------------------------------
    // Color flyerShadowColor = ankhIsOn == true ? Colorz.BlackBlack : Colorz.BlackBlack;
// -----------------------------------------------------------------------------
    bool _microMode = Scale.superFlyerMicroMode(context, widget.flyerZoneWidth);

    return
      Positioned(
        right: Aligners.rightPositionInRightAlignmentEn(context, 0),
        left: Aligners.leftPositionInRightAlignmentEn(context, 0),
        bottom: 0,
        child:

          widget.bzPageIsOn ?
          Container()
              :

          _microMode == true && widget.ankhIsOn == true ?
          Container()
              :

          _microMode == false && widget.ankhIsOn == false ?
          FooterButton(
            icon: _saveBTIcon,
            flyerZoneWidth: widget.flyerZoneWidth,
            isOn: false,
            verse: _saveBTVerse,
            onTap: _onAnkhTap,
          )
              :

          _microMode == false && widget.ankhIsOn == true ?
          // (_microMode == true && widget.ankhIsOn == false) || widget.bzPageIsOn == true ? Container():
          FooterButton(
            icon: _saveBTIcon,
            flyerZoneWidth: widget.flyerZoneWidth,
            isOn: widget.ankhIsOn,
            verse: _saveBTVerse,
            onTap: _onAnkhTap,
          )
              :

          Container(),

        ///
        // AnimatedBuilder(
        //   animation: _ankhAniController,
        //   builder: (BuildContext context, _){
        //     return
        //       Stack(
        //         alignment: Alignment.center,
        //         children: <Widget>[
        //
        //           // AnimatedContainer(
        //           //   duration: const Duration(milliseconds: 50),
        //           //   width: _saveBTSize,
        //           //   height: _saveBTSize,
        //           //   decoration: BoxDecoration(
        //           //     shape: BoxShape.circle,
        //           //     color: _ankhColorAni.value,
        //           //   ),
        //           // ),
        //
        //           (widget.microMode == true && widget.ankhIsOn == false) || widget.bzPageIsOn == true ? Container():
        //           FooterButton(
        //               icon: _saveBTIcon,
        //               flyerZoneWidth: widget.flyerZoneWidth,
        //               isOn: widget.ankhIsOn,
        //               verse: _saveBTVerse,
        //               onTap: _onAnkhTap,
        //           ),
        //
        //         ],
        //       );
        //     },
        // ),
        ///
      );
  }
}
