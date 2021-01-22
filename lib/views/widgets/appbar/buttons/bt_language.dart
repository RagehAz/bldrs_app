import 'package:bldrs/view_brains/drafters/shadowers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';


class BTLocalizerLanguage extends StatelessWidget {
  final Function buttonTap;
  final bool buttonON;

  BTLocalizerLanguage({@required this.buttonON, @required this.buttonTap});

  @override
  Widget build(BuildContext context) {
    double buttonsHeight = 40;
    double buttonWidth = double.infinity;

    return buttonON == true
        ?
        // --- BT LANGUAGE SWITCHED ON
        Expanded(
            child: Container(
              height: buttonsHeight,
              alignment: Alignment.center,
              // padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(Ratioz.ddAppBarButtonCorner)),
                  color: Colorz.Yellow,
                  boxShadow: [
                    CustomBoxShadow(
                        color: Colorz.BlackSmoke,
                        offset: new Offset(0, 0),
                        blurRadius: buttonsHeight * 0.3,
                        blurStyle: BlurStyle.outer),
                  ]),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // --- HIGHLIGHT
                  Container(
                    width: buttonWidth * 0.9,
                    height: buttonsHeight * 0.22,
                    decoration: BoxDecoration(
                        // color: Colorz.White,
                        borderRadius: BorderRadius.circular(
                            Ratioz.ddAppBarButtonCorner -
                                (buttonsHeight - (buttonsHeight * 0.22))),
                        boxShadow: [
                          CustomBoxShadow(
                              color: Colorz.WhiteZircon,
                              offset: new Offset(0, buttonsHeight * -0.1),
                              blurRadius: buttonsHeight * 0.18,
                              blurStyle: BlurStyle.normal),
                        ]),
                  ),

                  // --- GRADIENT bitch
                  Container(
                    height: buttonsHeight,
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

                  SuperVerse(
                    verse: Wordz.language(context),
                    color: Colorz.White,
                    designMode: false,
                    centered: true,
                    size: 2,
                    weight: VerseWeight.bold,
                    shadow: true,
                    italic: false,
                  ),
                ],
              ),
            ),
          )
        :
        // --- BT LANGUAGE SWITCHED OFF
        Expanded(
            child: GestureDetector(
              onTap: buttonTap,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // --- HIGHLIGHT
                  Container(
                    width: buttonWidth * 0.9,
                    height: buttonsHeight * 0.22,
                    decoration: BoxDecoration(
                        // color: Colorz.White,
                        borderRadius: BorderRadius.circular(
                            Ratioz.ddAppBarButtonCorner -
                                (buttonsHeight - (buttonsHeight * 0.22))),
                        boxShadow: [
                          CustomBoxShadow(
                              color: Colorz.WhiteZircon,
                              offset: new Offset(0, buttonsHeight * -0.1),
                              blurRadius: buttonsHeight * 0.18,
                              blurStyle: BlurStyle.normal),
                        ]),
                  ),

                  // --- GRADIENT bitch
                  Container(
                    height: buttonsHeight,
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

                  SuperVerse(
                    verse: Wordz.language(context),
                    color: Colorz.Grey,
                    designMode: false,
                    centered: true,
                    size: 2,
                    weight: VerseWeight.bold,
                    shadow: true,
                    italic: false,
                  ),
                ],
              ),
            ),
          );
  }
}
