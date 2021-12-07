import 'package:bldrs/controllers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart' as Wordz;
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/pages_parts/slides_page_parts/footer_parts/footer_button.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/pages_parts/slides_page_parts/footer_parts/slide_counters.dart';
import 'package:flutter/material.dart';

class FlyerFooter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerFooter({
    @required this.flyerBoxWidth,
    @required this.shares,
    @required this.views,
    @required this.saves,
    @required this.onShareTap,
    @required this.onCountersTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final int shares;
  final int views;
  final int saves;
  final Function onShareTap;
  final Function onCountersTap;
  /// --------------------------------------------------------------------------
  static double boxCorners(double flyerBoxWidth){
    return flyerBoxWidth * Ratioz.xxflyerBottomCorners;
  }
// -----------------------------------------------------------------------------
  static double boxHeight({BuildContext context, double flyerBoxWidth}){
    final double _footerBTMargins = buttonMargin(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
      buttonIsOn: null,
    );

    final double _footerBTRadius = buttonRadius(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );

    final double _flyerFooterHeight = (2 * _footerBTMargins) + (2 * _footerBTRadius);

    return _flyerFooterHeight;
  }
// -----------------------------------------------------------------------------
  static double buttonMargin({@required BuildContext context, @required double flyerBoxWidth, @required bool buttonIsOn}){

    final bool _tinyMode = FlyerBox.isTinyMode(context, flyerBoxWidth);

    bool _buttonIsOn;
    if (buttonIsOn == null){
      _buttonIsOn = false;
    }
    else {
      _buttonIsOn = buttonIsOn;
    }

    final double _footerBTMargins =

        (_buttonIsOn == true && _tinyMode == true) ? //&& widget.slidingIsOn == false
        flyerBoxWidth * 0.01// for tiny flyer when Button is on
            :
        (_buttonIsOn == true) ?
        flyerBoxWidth * 0.015 // for big flyer when button is on
            :
        flyerBoxWidth * 0.025; // for big flyer when button is off

    return _footerBTMargins;
  }
// -----------------------------------------------------------------------------
  static double buttonRadius({BuildContext context, double flyerBoxWidth, bool buttonIsOn}){
    final double _flyerBottomCorners = boxCorners(flyerBoxWidth);
    final double _footerBTMargins = buttonMargin(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
      buttonIsOn: buttonIsOn,
    );

    final double _footerBTRadius = _flyerBottomCorners - _footerBTMargins;
    return _footerBTRadius;
  }
// -----------------------------------------------------------------------------
  static double buttonSize({BuildContext context, double flyerBoxWidth, bool buttonIsOn}){
    final double _footerBTRadius = buttonRadius(context: context, flyerBoxWidth: flyerBoxWidth, buttonIsOn: buttonIsOn);
    return _footerBTRadius * 2;
  }
// -----------------------------------------------------------------------------
  static Color buttonColor({bool buttonIsOn}){
    const Color _onColor = Colorz.yellow80;
    const Color _offColor = Colorz.nothing;

    final Color _color = buttonIsOn ? _onColor : _offColor;

    return _color;
  }
// -----------------------------------------------------------------------------
  static Widget boxShadow({BuildContext context, double flyerBoxWidth}){

    final double _flyerBottomCorners = boxCorners(flyerBoxWidth);
    final double _footerHeight = boxHeight(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );

    return
      Container(
        width: flyerBoxWidth,
        height: _footerHeight,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(_flyerBottomCorners),
              bottomRight: Radius.circular(_flyerBottomCorners),
            ),
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colorz.black0,
                  Colorz.black125,
                  Colorz.black230
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
    final bool _tinyMode = FlyerBox.isTinyMode(context, flyerBoxWidth);
// -----------------------------------------------------------------------------
    /// SHARE & SAVE BUTTONS

    // double _footerBTRadius = buttonRadius(context: context, flyerBoxWidth: flyerBoxWidth, buttonIsOn: false,);

    // dynamic _footerBTColor = Colorz.Grey80;
    // String _shareBTIcon = Iconz.Share;
    final String _shareBTVerse = Wordz.send(context);
    // String saveBTIcon = ankhOn == true ? Iconz.SaveOn : Iconz.SaveOff;
    // String saveBTVerse = ankhOn == true ? translate(context, 'Saved') :
    // Wordz.save(context);
    // dynamic saveBTColor = ankhOn == true ? Colorz.SkyDarkBlue : footerBTColor;
// -----------------------------------------------------------------------------
    /// FLYER FOOTER CONTAINER
    final double _flyerFooterHeight = boxHeight(context: context, flyerBoxWidth: flyerBoxWidth);

    /// FLYER FOOTER
    return Align(
      alignment: Alignment.bottomCenter,

      /// --- FLYER FOOTER BOX
      child: SizedBox(
        width: flyerBoxWidth,
        height: _flyerFooterHeight,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[

            /// BOTTOM SHADOW
            boxShadow(context: context, flyerBoxWidth: flyerBoxWidth,),

            /// SHARE BUTTON
            if (!_tinyMode)
              Positioned(
                right: Aligners.rightPositionInLeftAlignmentEn(context, 0),
                left: Aligners.leftPositionInLeftAlignmentEn(context, 0),
                bottom: 0,
                child: FooterButton(
                  icon: Iconz.share, /// TASK : let share icon point outwards the flyer pointing to outside the phone
                  flyerBoxWidth: flyerBoxWidth,
                  onTap: onShareTap,
                  verse: _shareBTVerse,
                ),
              ),

            /// FLYER COUNTERS
            if(!_tinyMode && saves != null && shares != null && views != null)
              SlideCounters(
                saves: saves,
                shares: shares,
                views: views,
                flyerBoxWidth: flyerBoxWidth,
                onCountersTap: onCountersTap,
              ),

          ],
        ),
      ),

    );
  }
}
