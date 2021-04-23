import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class ShareBT extends StatelessWidget {
  final double flyerZoneWidth;
  final double buttonRadius;
  final double buttonMargins;
  final dynamic buttonColor;
  final String buttonIcon;
  final String buttonVerse;
  final Function tappingButton;

  ShareBT({
    @required this.flyerZoneWidth,
    @required this.buttonVerse,
    @required this.buttonIcon,
    @required this.buttonColor,
    @required this.buttonRadius,
    @required this.buttonMargins,
    @required this.tappingButton,
  });

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    // --- ICON & VERSE --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ICON & VERSE
    double iconWidth = buttonRadius * 1.3;
    double iconHeight = iconWidth;
    dynamic iconTestBoxColor = Colorz.Nothing;
    dynamic verseColor =
    buttonColor == Colorz.Yellow ? Colorz.BlackBlack :
        Colorz.White;

    double btOvalSizeFactor = 0.8; // as a ratio of button sizes

    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        left: buttonMargins,
        top: buttonMargins,
        right: buttonMargins,
        bottom: buttonMargins,
      ),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: <BoxShadow>[
            CustomBoxShadow(
                color:
                buttonVerse == Wordz.saved(context) ? Colorz.Yellow:Colorz.BlackPlastic,
                offset: new Offset(0, buttonMargins * -0.12),
                blurRadius: buttonMargins * 0.99,
                blurStyle: BlurStyle.outer),
            CustomBoxShadow(
                color: Colorz.WhiteGlass,
                offset: new Offset(0, buttonMargins * -0.12),
                blurRadius: buttonMargins * 0.99,
                blurStyle: BlurStyle.outer),

          ]
      ),

      // --- BUTTON CIRCLE
      child: GestureDetector(
        onTap: tappingButton,

        child: CircleAvatar(
          radius: buttonRadius,
          backgroundColor: buttonColor,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[

              buttonVerse == Wordz.saved(context) ? Container () :

              // --- BUTTON OVAL HIGHLIGHT
              Container(
                width: 2 * buttonRadius * btOvalSizeFactor,
                height: 1.4 * buttonRadius* btOvalSizeFactor,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.elliptical(buttonRadius * btOvalSizeFactor, buttonRadius * 0.7 * btOvalSizeFactor)),
                  color: Colorz.Nothing,
                  boxShadow: [CustomBoxShadow(
                    color: Colorz.WhiteSmoke,
                    offset: new Offset(0, buttonRadius * -0.3),
                    blurRadius: buttonRadius * 0.4 ,
                    blurStyle: BlurStyle.normal
                  ),]
                ),
              ),

              // --- BUTTON GRADIENT
              Container(
                width: buttonRadius * 2,
                height: buttonRadius * 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colorz.Nothing, Colorz.BlackZircon],
                      stops: [0.3,1]
                  ),

                ),
              ),

              // --- ANKH GOLDEN BACKGROUND
              buttonVerse == Wordz.saved(context) ?
              Container(
                width: 0.8 * buttonRadius * btOvalSizeFactor,
                height: 0.8 * buttonRadius* btOvalSizeFactor,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.elliptical(buttonRadius * btOvalSizeFactor, buttonRadius * btOvalSizeFactor)),
                  color: Colorz.BlackNothing,
                  boxShadow: [CustomBoxShadow(
                    color: Colorz.Yellow,
                    offset: new Offset(0, buttonRadius * 0),
                    blurRadius: buttonRadius * 0.4 ,
                    blurStyle: BlurStyle.normal
                  ),]
                ),
              )
                  : Container(),

              // -- BUTTON COMPONENTS : ICON & VERSE
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  // --- BUTTON ICON
                  Container(
                    width: iconWidth,
                    height: iconHeight,
                    padding: buttonIcon == Iconz.Share ?
                    EdgeInsets.all(iconWidth * 0.075) : EdgeInsets.all(0),
                    color: iconTestBoxColor, // for designing
                    child: WebsafeSvg.asset(
                      buttonIcon,
                    ),
                  ),

                  if (
                  Scale.superFlyerMiniMode(context, flyerZoneWidth) ||
                      buttonVerse == Wordz.saved(context)
                  )
                  // --- BUTTON VERSE
                  SuperVerse(
                    verse: buttonVerse,
                    color: verseColor,
                    centered: true,
                    size: 1,
                    weight: VerseWeight.bold,
                    shadow: false,
                    italic: false,
                    designMode: false,
                    scaleFactor: flyerZoneWidth/screenWidth,
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
