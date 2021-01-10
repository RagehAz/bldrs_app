import 'package:bldrs/view_brains/drafters/shadowers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class BTMain extends StatelessWidget {
  final String buttonVerse;
  final dynamic buttonIcon;
  final dynamic buttonColor;
  final dynamic splashColor;
  final bool buttonVerseShadow;
  final dynamic function;
  final bool stretched;
  final double iconSizeFactor;

  BTMain({
    @required this.buttonVerse,
    @required this.buttonIcon,
    @required this.buttonColor,
    @required this.splashColor,
    @required this.buttonVerseShadow,
    @required this.function,
    @required this.stretched,
    this.iconSizeFactor = 0.75,
  });

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double buttonCorner = screenHeight * Ratioz.rrButtonCorner;
    double buttonZoneHeight = screenHeight * 0.08;
    double buttonZonePaddings = screenHeight * 0.01;

    double buttonWidth = stretched == true ?
    screenWidth
        :
    screenHeight * 22 * 0.017;

    double buttonHeight = buttonZoneHeight * 0.85;

    // BUTTON FOOTPRINT
    return Container(
      width: screenWidth,
      height: buttonZoneHeight,
      // color: Colorz.Yellow,
      alignment: Alignment.center,
      // padding: EdgeInsets.all(buttonZonePaddings),

      // BUTTON ITSELF
      child: Container(
        width: buttonWidth,
        height: buttonHeight,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(buttonCorner),
            boxShadow: [
              CustomBoxShadow(
                  color: Colorz.BlackBlack,
                  offset: new Offset(0, 0),
                  blurRadius: buttonZoneHeight * 0.09,
                  blurStyle: BlurStyle.outer),
            ]
        ),
        child: RaisedButton(
          onPressed: () {
            if (function.runtimeType != String)
            {function();}
            else {
              if (function == 'GoBackFucker')
              {Navigator.pop(context);}
              else {Navigator.pushNamed(context, function);}
}
          },
          splashColor: splashColor,
          elevation: 1,
          color: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonCorner),
          ),
          disabledColor: Colorz.GreySmoke,
          padding: EdgeInsets.all(0),

          // --- BUTTON CONTENTS
          child: Stack(
            alignment: Alignment.center,
            children: [

              // --- BUTTON HIGHLIGHT
              Container(
                width: buttonWidth * 0.9,
                height: buttonHeight * 0.22,
                decoration: BoxDecoration(
                  // color: Colorz.White,
                  borderRadius: BorderRadius.circular(buttonCorner-(buttonHeight-(buttonHeight * 0.22))),
                  boxShadow: [CustomBoxShadow(
                    color: Colorz.WhiteZircon,
                    offset: new Offset(0, buttonHeight * -0.23),
                    blurRadius: buttonHeight * 0.18 ,
                    blurStyle: BlurStyle.normal
                  ),]
                ),
              ),

              // --- BUTTON GRADIENT
              Container(
                height: buttonHeight,
                width: buttonWidth,
                decoration: BoxDecoration(
                    // color: Colorz.Grey,
                    borderRadius: BorderRadius.circular(buttonCorner),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colorz.BlackAir, Colorz.BlackPlastic],
                        stops: [0.1,1]
                    ),
                ),
              ),

              // --- BUTTON COMPONENTS
              buttonIcon == ''
                  ?
                  // --- WHEN BUTTON DOES NOT HAVE AN ICON
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // --- ONLY THE BUTTON VERSE HERE
                        Padding(
                          padding: EdgeInsets.all(buttonZonePaddings),
                          child: SuperVerse(
                            verse: buttonVerse,
                            color: Colorz.White,
                            italic: false,
                            weight: VerseWeight.bold,
                            centered: true,
                            shadow: true,
                            designMode: false,
                            size: 2,
                          ),
                        ),
                      ],
                    )
                  :
                  // --- WHEN BUTTON HAS AN ICON
                  Padding(
                    padding: EdgeInsets.only(left: buttonZonePaddings, right: buttonZonePaddings),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [

                          // --- OLD BUTTON ICON
                          Flexible(
                            flex: 1,
                            child: new Container(
                              // color: Colorz.BloodTest,
                              width: buttonZoneHeight * 0.4,
                              height: buttonZoneHeight * 0.4,
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(buttonZoneHeight * 0.1),
                              // padding: EdgeInsets.all(buttonHeight * 0),
                              child:
                                  buttonIcon.runtimeType != String ?
                                      buttonIcon :
                              WebsafeSvg.asset(buttonIcon, fit: BoxFit.fill,),
                            ),
                          ),

                          // --- BUTTON VERSE
                          Expanded(
                            flex: 4,
                            child: new Padding(
                              padding: EdgeInsets.symmetric(horizontal : buttonZonePaddings),
                              child: SuperVerse(
                                verse: buttonVerse,
                                color: Colorz.White,
                                italic: false,
                                weight: VerseWeight.bold,
                                centered: false,
                                shadow: true,
                                designMode: false,
                                size: 2,
                                maxLines: 2,

                              ),
                            ),
                          ),
                        ],
                      ),
                  )
            ],
          ),
        ),
      ),
    );
  }
}
