import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/footer_parts/footer_button.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/footer_parts/slide_counters.dart';
import 'package:flutter/material.dart';

class FlyerFooter extends StatelessWidget {
  final double flyerZoneWidth;
  final int shares;
  final int views;
  final int saves;
  final Function onShareTap;
  final Function onCountersTap;

  FlyerFooter({
    @required this.flyerZoneWidth,
    @required this.shares,
    @required this.views,
    @required this.saves,
    @required this.onShareTap,
    @required this.onCountersTap,
  });
// -----------------------------------------------------------------------------
  static double boxCorners(double flyerZoneWidth){
    return flyerZoneWidth * Ratioz.xxflyerBottomCorners;
  }
// -----------------------------------------------------------------------------
  static double boxHeight({BuildContext context, double flyerZoneWidth}){
    double _footerBTMargins = buttonMargin(
      context: context,
      flyerZoneWidth: flyerZoneWidth,
      buttonIsOn: null,
    );

    double _footerBTRadius = buttonRadius(
      context: context,
      flyerZoneWidth: flyerZoneWidth,
      buttonIsOn: null,
    );

    double _flyerFooterHeight = (2 * _footerBTMargins) + (2 * _footerBTRadius);

    return _flyerFooterHeight;
  }
// -----------------------------------------------------------------------------
  static double buttonMargin({BuildContext context, double flyerZoneWidth, bool buttonIsOn}){

    bool _microMode = Scale.superFlyerMicroMode(context, flyerZoneWidth);
    bool _buttonIsOn = buttonIsOn == null ? false : buttonIsOn;

    double _footerBTMargins =

        (_buttonIsOn == true && _microMode == true) ? //&& widget.slidingIsOn == false
        flyerZoneWidth * 0.01// for micro flyer when Button is on
            :
        (_buttonIsOn == true) ?
        flyerZoneWidth * 0.015 // for Normal flyer when button is on
            :
        flyerZoneWidth * 0.025; // for Normal flyer when button is off

    return _footerBTMargins;
  }
// -----------------------------------------------------------------------------
  static double buttonRadius({BuildContext context, double flyerZoneWidth, bool buttonIsOn}){
    double _flyerBottomCorners = boxCorners(flyerZoneWidth);
    double _footerBTMargins = buttonMargin(
      context: context,
      flyerZoneWidth: flyerZoneWidth,
      buttonIsOn: buttonIsOn,
    );

    double _footerBTRadius = _flyerBottomCorners - _footerBTMargins;
    return _footerBTRadius;
  }
// -----------------------------------------------------------------------------
  static double buttonSize({BuildContext context, double flyerZoneWidth, bool buttonIsOn}){
    double _footerBTRadius = buttonRadius(context: context, flyerZoneWidth: flyerZoneWidth, buttonIsOn: buttonIsOn);
    return _footerBTRadius * 2;
  }
// -----------------------------------------------------------------------------
  static Color buttonColor({bool buttonIsOn}){
    Color _onColor = Colorz.Yellow80;
    Color _offColor = Colorz.Nothing;

    Color _color = buttonIsOn ? _onColor : _offColor;

    return _color;
  }
// -----------------------------------------------------------------------------
  static Widget boxShadow({BuildContext context, double flyerZoneWidth}){

    double _flyerBottomCorners = boxCorners(flyerZoneWidth);
    double _footerHeight = boxHeight(
      context: context,
      flyerZoneWidth: flyerZoneWidth,
    );

    return
      Container(
        width: flyerZoneWidth,
        height: _footerHeight,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(_flyerBottomCorners),
              bottomRight: Radius.circular(_flyerBottomCorners),
            ),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colorz.Black0,
                  Colorz.Black125,
                  Colorz.Black230
                ],
                stops: <double>[0.35, 0.85, 1]
            ),
        ),
      );
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    bool _microMode = Scale.superFlyerMicroMode(context, flyerZoneWidth) ;
// -----------------------------------------------------------------------------
    /// SHARE & SAVE BUTTONS

    double _footerBTRadius = buttonRadius(context: context, flyerZoneWidth: flyerZoneWidth, buttonIsOn: false,);

    dynamic _footerBTColor = Colorz.Grey80;
    String _shareBTIcon = Iconz.Share;
    String _shareBTVerse = Wordz.send(context);
    // String saveBTIcon = ankhOn == true ? Iconz.SaveOn : Iconz.SaveOff;
    // String saveBTVerse = ankhOn == true ? translate(context, 'Saved') :
    // Wordz.save(context);
    // dynamic saveBTColor = ankhOn == true ? Colorz.SkyDarkBlue : footerBTColor;
// -----------------------------------------------------------------------------
    /// FLYER FOOTER CONTAINER
    double _flyerFooterHeight = boxHeight(context: context, flyerZoneWidth: flyerZoneWidth);

    // --- FLYER FOOTER
    return Align(
      alignment: Alignment.bottomCenter,
      // --- FLYER FOOTER BOX
      child: Container(
        width: flyerZoneWidth,
        height: _flyerFooterHeight,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[

            /// BOTTOM SHADOW
            boxShadow(context: context, flyerZoneWidth: flyerZoneWidth,),

            /// SHARE BUTTON
            if (!_microMode)
              Positioned(
                right: Aligners.rightPositionInLeftAlignmentEn(context, 0),
                left: Aligners.leftPositionInLeftAlignmentEn(context, 0),
                bottom: 0,
                child: FooterButton(
                  icon: Iconz.Share, /// TASK : let share icon point outwards the flyer pointing to outside the phone
                  flyerZoneWidth: flyerZoneWidth,
                  isOn: false,
                  onTap: onShareTap,
                  verse: _shareBTVerse,
                ),
              ),

            /// FLYER COUNTERS
            if(!_microMode)
              SlideCounters(
                saves: saves,
                shares: shares,
                views: views,
                flyerZoneWidth: flyerZoneWidth,
                onCountersTap: onCountersTap,
              ),

          ],
        ),
      ),
    );
  }
}

