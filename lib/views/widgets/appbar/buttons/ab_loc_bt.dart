import 'package:bldrs/view_brains/drafters/shadowers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

import 'bt_localizer.dart';

class ABLocalizerBT extends StatelessWidget {
  final Function buttonTap;
  final bool buttonOn;
  final String buttonIcon;
  final String buttonVerse;

  ABLocalizerBT({
    @required this.buttonVerse,
    @required this.buttonTap,
    @required this.buttonOn,
    @required this.buttonIcon,
});

  @override
  Widget build(BuildContext context) {

    double buttonHeight = 40;
    double buttonWidth = double.infinity;
    double iconPaddings = 5;



    return Expanded(
      child: GestureDetector(
        onTap: buttonTap,
        child: Container(
          height: buttonHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(Ratioz.ddAppBarButtonCorner)),
            color: buttonOn == true ? Colorz.Yellow : Colorz.WhiteGlass,
            boxShadow: [
              CustomBoxShadow(
              color: Colorz.BlackSmoke,
              offset: new Offset(0, 0),
              blurRadius: buttonHeight * 0.3,
              blurStyle: BlurStyle.outer
              ),
            ]
          ),
          child: Stack(
            children: [

              // --- HIGHLIGHT
              Container(
                width: buttonWidth * 0.9,
                height: buttonHeight * 0.22,
                decoration: BoxDecoration(
                  // color: Colorz.White,
                    borderRadius: BorderRadius.circular(Ratioz.ddAppBarButtonCorner * 0.9),
                    boxShadow: [
                      CustomBoxShadow(
                          color: Colorz.WhiteZircon,
                          offset: new Offset(0, buttonHeight * -0.08),
                          blurRadius: buttonHeight * 0.18,
                          blurStyle: BlurStyle.normal),
                    ]),
              ),

              // --- GRADIENT bitch
              Container(
                height: buttonHeight,
                width: double.infinity,
                decoration: BoxDecoration(
                  // color: Colorz.Grey,
                  borderRadius:
                  BorderRadius.circular(Ratioz.ddAppBarButtonCorner),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colorz.BlackAir, Colorz.BlackPlastic],
                      stops: [0.1, 1]),
                ),
              ),

              // --- BUTTON COMPONENTS

              Row(
                mainAxisAlignment: buttonIcon == '' ? MainAxisAlignment.center : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  // --- BUTTON ICON
                  buttonIcon == '' ?
                  Container()
                      :
                      Stack(
                        children: <Widget>[
                          // LocalizerButton(buttonFlag: Iconz.DvDonaldDuck,
                          // ),

                          buttonOn == true ? Container() :
                          LocalizerButton(
                            // buttonFlag: 'Black',
                          ),
                        ],
                      ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(right: iconPaddings, left: iconPaddings),
                      child: SuperVerse(
                        verse: buttonVerse,
                        color: buttonOn == true ? Colorz.White : Colorz.WhiteSmoke,
                        italic: false,
                        weight: VerseWeight.bold,
                        centered: true,
                        shadow: true,
                        designMode: false,
                        size: 2,
                      ),
                    ),
                  ),
                ],
              )

                  // :
                  // // --- WHEN BUTTON HAS AN ICON
                  // Padding(
                  //   padding: EdgeInsets.only(left: iconPaddings, right: iconPaddings),
                  //   child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         // --- BUTTON ICON
                  //         new Container(
                  //           // color: Colorz.BloodTest,
                  //           width: buttonZoneHeight * 0.4,
                  //           height: buttonZoneHeight * 0.4,
                  //           alignment: Alignment.center,
                  //           margin: EdgeInsets.all(buttonZoneHeight * 0.1),
                  //           // padding: EdgeInsets.all(buttonHeight * 0),
                  //           child:
                  //               buttonIcon.runtimeType != String ?
                  //                   buttonIcon :
                  //           WebsafeSvg.asset(buttonIcon, fit: BoxFit.fill,),
                  //         ),
                  //
                  //         // --- BUTTON VERSE
                  //         new Padding(
                  //           padding: EdgeInsets.all(iconPaddings),
                  //           child: SuperVerse(
                  //             verse: buttonVerse,
                  //             color: Colorz.White,
                  //             italic: false,
                  //             weight: 'bold',
                  //             centered: false,
                  //             shadow: true,
                  //             designMode: false,
                  //             size: 2,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  // )


              // --- END --- END--- END--- END--- END--- END--- END--- END--- END

            ],
          ),
        ),
      ),
    );
  }
}
