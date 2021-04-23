import 'package:bldrs/controllers/drafters/file_formatters.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class BTMain extends StatelessWidget {
  final String buttonVerse;
  final dynamic buttonIcon;
  final Color buttonColor;
  final Color splashColor;
  final bool buttonVerseShadow;
  final dynamic function;
  final bool stretched;
  final double iconSizeFactor;
  final Color verseColor;
  final VerseWeight verseWeight;
  final Color iconColor;

  BTMain({
    @required this.buttonVerse,
    @required this.buttonIcon,
    @required this.buttonColor,
    @required this.splashColor,
    this.buttonVerseShadow = true,
    @required this.function,
    @required this.stretched,

    this.iconSizeFactor = 0.75,
    this.verseColor = Colorz.White,
    this.verseWeight = VerseWeight.bold,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {

    double _screenHeight = Scale.superScreenHeight(context);
    double _screenWidth = Scale.superScreenWidth(context);

    double _buttonCorner = _screenHeight * Ratioz.rrButtonCorner;
    double _buttonZoneHeight = _screenHeight * 0.08;
    double _buttonZonePaddings = _screenHeight * 0.01;

    double _buttonWidth = stretched == true ?
    _screenWidth
        :
    _screenHeight * 22 * 0.017;

    double _buttonHeight = _buttonZoneHeight * 0.85;

    // BUTTON FOOTPRINT
    return Container(
      width: _screenWidth,
      height: _buttonZoneHeight,
      // color: Colorz.Yellow,
      alignment: Alignment.center,
      // padding: EdgeInsets.all(_buttonZonePaddings),

      // BUTTON ITSELF
      child: Container(
        width: _buttonWidth,
        height: _buttonHeight,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_buttonCorner),
            boxShadow: <BoxShadow>[
              CustomBoxShadow(
                  color: Colorz.BlackBlack,
                  offset: new Offset(0, 0),
                  blurRadius: _buttonZoneHeight * 0.09,
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
            borderRadius: BorderRadius.circular(_buttonCorner),
          ),
          disabledColor: Colorz.GreySmoke,
          padding: EdgeInsets.all(0),

          // --- BUTTON CONTENTS
          child: Stack(
            alignment: Alignment.center,
            children: [

              // --- BUTTON HIGHLIGHT
              Container(
                width: _buttonWidth * 0.9,
                height: _buttonHeight * 0.22,
                decoration: BoxDecoration(
                  // color: Colorz.White,
                  borderRadius: BorderRadius.circular(_buttonCorner-(_buttonHeight-(_buttonHeight * 0.22))),
                  boxShadow: [CustomBoxShadow(
                    color: Colorz.WhiteZircon,
                    offset: new Offset(0, _buttonHeight * -0.23),
                    blurRadius: _buttonHeight * 0.18 ,
                    blurStyle: BlurStyle.normal
                  ),]
                ),
              ),

              // --- BUTTON GRADIENT
              Container(
                height: _buttonHeight,
                width: _buttonWidth,
                decoration: BoxDecoration(
                    // color: Colorz.Grey,
                    borderRadius: BorderRadius.circular(_buttonCorner),
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
                      children: <Widget>[
                        // --- ONLY THE BUTTON VERSE HERE
                        Padding(
                          padding: EdgeInsets.all(_buttonZonePaddings),
                          child: SuperVerse(
                            verse: buttonVerse,
                            color: verseColor,
                            italic: false,
                            weight: verseWeight,
                            centered: true,
                            shadow: buttonVerseShadow,
                            designMode: false,
                            size: 2,
                          ),
                        ),
                      ],
                    )
                  :
                  // --- WHEN BUTTON HAS AN ICON
                  Padding(
                    padding: EdgeInsets.only(left: _buttonZonePaddings, right: _buttonZonePaddings),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[

                          // --- OLD BUTTON ICON
                          Flexible(
                            flex: 1,
                            child: new Container(
                              // color: Colorz.BloodTest,
                              width: _buttonZoneHeight * 0.4,
                              height: _buttonZoneHeight * 0.4,
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(_buttonZoneHeight * 0.1),
                              // padding: EdgeInsets.all(_buttonHeight * 0),
                              child:
                                  buttonIcon.runtimeType != String ? buttonIcon :
                                  ObjectChecker.fileExtensionOf(buttonIcon) == 'jpg' || ObjectChecker.fileExtensionOf(buttonIcon) == 'jpeg' || ObjectChecker.fileExtensionOf(buttonIcon) == 'png' ?
                                  Container(
                                    width: _buttonZoneHeight * 0.4,
                                    height: _buttonZoneHeight * 0.4,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage(buttonIcon), fit: BoxFit.cover, ),
                                    ),
                                  ) :
                              WebsafeSvg.asset(buttonIcon, fit: BoxFit.fill, color: iconColor),
                            ),
                          ),

                          // --- BUTTON VERSE
                          Expanded(
                            flex: 4,
                            child: new Padding(
                              padding: EdgeInsets.symmetric(horizontal : _buttonZonePaddings),
                              child: SuperVerse(
                                verse: buttonVerse,
                                color: verseColor,
                                italic: false,
                                weight: verseWeight,
                                centered: false,
                                shadow: buttonVerseShadow,
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
