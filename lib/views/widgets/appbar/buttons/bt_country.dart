import 'package:bldrs/view_brains/drafters/shadowers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'bx_flagbox.dart';

class BTLocalizerCountry extends StatelessWidget {
  final Function buttonTap;
  final bool buttonON;
  final String buttonFlag;

  BTLocalizerCountry({
    @required this.buttonON,
    @required this.buttonTap,
    @required this.buttonFlag,
  });

  @override
  Widget build(BuildContext context) {
    double buttonsHeight = 40;
    double buttonWidth = double.infinity;

    return buttonON == true
        ?

        // --- BT COUNTRY SWITCHED ON
        Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: buttonsHeight,
                alignment: Alignment.center,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(Ratioz.ddAppBarButtonCorner)),
                    color: Colorz.White,
                    boxShadow: <CustomBoxShadow>[
                      CustomBoxShadow(
                          color: Colorz.BlackSmoke,
                          offset: new Offset(0, 0),
                          blurRadius: buttonsHeight * 0.3,
                          blurStyle: BlurStyle.outer),
                    ]),
                child: Stack(
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

                    // --- BUTTON CONTENTS
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          FlagBox(
                            flag: buttonFlag,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Container(
                              color: Colorz.Nothing,
                              alignment: Alignment.center,
                              child: SuperVerse(
                                verse: Wordz.country(context),
                                color: Colorz.White,
                                italic: false,
                                shadow: true,
                                weight: VerseWeight.bold,
                                size: 2,
                                centered: true,
                                designMode: false,
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
          )
        :
        // --- BT COUNTRY SWITCHED OFF
        Expanded(
            child: GestureDetector(
              onTap: buttonTap,
              child: Stack(
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

                    // --- GRADIENT BITCH
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

                    // --- BUTTON CONTENTS
                    Row(
                      children: [
                        // --- BUTTON FLAG ICON
                        Stack(
                          children: [
                            FlagBox(
                              flag: buttonFlag,
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colorz.BlackSmoke,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Ratioz.ddBoxCorner)),
                              ),
                            ),
                          ],
                        ),

                        // --- SPACING
                        SizedBox(
                          width: 5,
                        ),

                        // --- BUTTON VERSE
                        Expanded(
                          child: Container(
                            color: Colorz.Nothing,
                            alignment: Alignment.center,
                            child: SuperVerse(
                              verse: Wordz.country(context),
                              color: Colorz.Grey,
                              italic: false,
                              shadow: false,
                              weight: VerseWeight.bold,
                              size: 2,
                              centered: true,
                              designMode: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            ),
          );
  }
}
