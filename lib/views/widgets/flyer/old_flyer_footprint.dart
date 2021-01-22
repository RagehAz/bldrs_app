import 'package:bldrs/view_brains/drafters/shadowers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class FlyerFootPrint extends StatelessWidget {
  final double flyerSizeFactoria;

  FlyerFootPrint({
    @required this.flyerSizeFactoria,
  });

  @override
  Widget build(BuildContext context) {
    // ----------------------------------------------------------------------
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double safeAreaHeight = MediaQuery.of(context).padding.top;
    double screenWithoutSafeAreaHeight = screenHeight - safeAreaHeight;

    double flyerZoneWidth = screenWidth * flyerSizeFactoria;
    double flyerMargins = flyerZoneWidth * 0.019; // not sure
    double pyramidsSafeHeight = Ratioz.ddPyramidsHeight + 10;
    double flyerZoneHeight = flyerZoneWidth == MediaQuery.of(context).size.width
        ? screenWithoutSafeAreaHeight - pyramidsSafeHeight - flyerMargins
        : flyerZoneWidth * 1.74;
    double flyerTopCorners = flyerZoneWidth * Ratioz.xxflyerTopCorners;
    double flyerBottomCorners = flyerZoneWidth * Ratioz.xxflyerBottomCorners;
    // ----------------------------------------------------------------------
    bool miniMode = flyerZoneWidth < screenWidth * 0.75 ? true : false;
    // --- SHARE & SAVE BUTTONS --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- SHARE & SAVE BUTTONS
    double footerBTMargins = flyerZoneWidth * Ratioz.xxfooterBTMargins;
    // === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
    double maxWidthAvailable = double.infinity;
    // --- MAIN BOX --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- MAIN BOX
    double headerMainHeight = flyerZoneWidth * Ratioz.xxflyerHeaderMiniHeight;
    double headerMainWidth = maxWidthAvailable;
    double headerMainPadding = headerMainHeight * 0.0208;
    double headerMainCorners = flyerZoneWidth * Ratioz.xxflyerTopCorners;

    // --- OFFSET BOX --- --- --- --- --- --- --- --- --- ---  --- --- --- --- --- --- --- --- --- --- --- OFFSET BOX
    double headerOffsetHeight = headerMainHeight - (2 * headerMainPadding);
    double headerOffsetWidth = maxWidthAvailable;
    double headerOffsetCorner = headerMainCorners - headerMainPadding;

    // --- B.LOGO --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- B.LOGO
    String logoImage = Iconz.DvBlankPNG;
    double logoHeight = headerOffsetHeight;
    double logoWidth = headerOffsetHeight;
    double logoRoundCorners = headerOffsetCorner;
    double logoZeroCorner = miniMode == true ? headerOffsetCorner : 0;

    // === === === === === === === === === === === === === === === === === === === === === === === === === === === ===

    double footerBTRadius = flyerBottomCorners - footerBTMargins;

    // --- FLYER FOOTER CONTAINER--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- FLYER FOOTER
    double flyerFooterWidth = flyerZoneWidth ==
            MediaQuery.of(context).size.width
        ? (flyerZoneWidth - (flyerZoneWidth * Ratioz.xxfooterBTMargins * 1))
        : // * only 1 because it starts from bottom left of the flyer neglecting flyer's left margin from screen boarder kalb
        flyerZoneWidth;
    double flyerFooterHeight = (2 * footerBTMargins) + (2 * footerBTRadius);
    dynamic flyerFooterColor = Colorz.Nothing;

    // --- ICON & VERSE --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ICON & VERSE
    double iconWidth = footerBTRadius * 1.3;
    double iconHeight = iconWidth;
    dynamic iconTestBoxColor = Colorz.Nothing;
    double btOvalSizeFactor = 0.8; // as a ratio of button sizes
    dynamic flyerMainShadow = Colorz.BlackSmoke;

    return GestureDetector(
      onTap: () {
        print('meen ye-add flyer naaw ?');
      },
      child: Container(
        width: flyerZoneWidth,
        height: flyerZoneHeight,
        margin: EdgeInsets.only(
          left: flyerMargins,
          top: flyerMargins,
          right: flyerMargins,
          bottom: flyerMargins,
        ),
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
            color: Colorz.WhiteAir,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(flyerTopCorners),
              topRight: Radius.circular(flyerTopCorners),
              bottomLeft: Radius.circular(flyerBottomCorners),
              bottomRight: Radius.circular(flyerBottomCorners),
            ),
            boxShadow: [
              CustomBoxShadow(
                  color: flyerMainShadow,
                  offset: new Offset(0, 0),
                  blurRadius: flyerZoneWidth * 0.075,
                  blurStyle: BlurStyle.outer),
            ]),
        child: Stack(
          children: [
            // -- FLYER HEADER
            Stack(
              children: [
                // --- FLYER HEADER BLACK SHADOW
                Container(
                  height: headerMainHeight,
                  width: headerMainWidth,
                  padding: EdgeInsets.all(headerMainPadding),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(headerMainCorners),
                        topRight: Radius.circular(headerMainCorners),
                        bottomLeft: Radius.circular(headerMainCorners),
                        bottomRight: Radius.circular(headerMainCorners),
                      ),
                      boxShadow: [
                        CustomBoxShadow(
                            color: flyerMainShadow,
                            offset: new Offset(0, 0),
                            blurRadius: headerMainHeight * 0.25,
                            blurStyle: BlurStyle.outer),
                      ]),
                ),

                // --- FLYER HEADER COMPONENTS
                Container(
                  height: headerMainHeight,
                  width: headerMainWidth,
                  padding: EdgeInsets.all(headerMainPadding),
                  // alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(headerMainCorners),
                      topRight: Radius.circular(headerMainCorners),
                      bottomLeft: Radius.circular(headerMainCorners),
                      bottomRight: Radius.circular(headerMainCorners),
                    ),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colorz.Nothing, Colorz.WhiteGlass],
                        stops: [0.3, 1]),
                  ),

                  // --- OFFSET CONTAINER
                  child: Container(
                    height: headerOffsetHeight,
                    width: headerOffsetWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(headerOffsetCorner),
                        topRight: Radius.circular(headerOffsetCorner),
                        bottomLeft: Radius.circular(headerOffsetCorner),
                        bottomRight: Radius.circular(headerOffsetCorner),
                      ),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colorz.Nothing, Colorz.WhiteGlass],
                          stops: [0.65, 1]),
                    ),

                    // --- HEADER COMPONENTS
                    child: Row(
                      children: [
                        // --- B.Logo
                        Container(
                          height: logoHeight,
                          width: logoWidth,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(logoImage),
                                  fit: BoxFit.fill),
                              borderRadius:
                              Wordz.textDirection(context) ==
                                          'rtl'
                                      ? BorderRadius.only(
                                          topLeft:
                                              Radius.circular(logoRoundCorners),
                                          topRight:
                                              Radius.circular(logoRoundCorners),
                                          bottomLeft:
                                              Radius.circular(logoZeroCorner),
                                          bottomRight:
                                              Radius.circular(logoRoundCorners),
                                        )
                                      : BorderRadius.only(
                                          topLeft:
                                              Radius.circular(logoRoundCorners),
                                          topRight:
                                              Radius.circular(logoRoundCorners),
                                          bottomLeft:
                                              Radius.circular(logoRoundCorners),
                                          bottomRight:
                                              Radius.circular(logoZeroCorner),
                                        )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // -- FLYER SLIDES
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(flyerTopCorners),
                topRight: Radius.circular(flyerTopCorners),
                bottomLeft: Radius.circular(flyerBottomCorners),
                bottomRight: Radius.circular(flyerBottomCorners),
              ),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  // -- SLIDE
                  Container(
                    width: flyerZoneWidth,
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(flyerTopCorners),
                          topRight: Radius.circular(flyerTopCorners),
                          bottomLeft: Radius.circular(flyerBottomCorners),
                          bottomRight: Radius.circular(flyerBottomCorners),
                        ),
                        color: Colorz.WhiteGlass),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        // --- SHADOW UNDER PAGE HEADER & OVER PAGE PICTURE
                        Container(
                          width: screenWidth,
                          height: screenHeight * 0.4,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                Color.fromARGB(25, 0, 0, 0),
                                Colorz.Nothing
                              ],
                                  stops: [
                                0.45,
                                1
                              ])),
                        ),

                        // --- DUMMY SLIDE HEADLINE
                        Padding(
                          padding: EdgeInsets.only(top: flyerZoneWidth * 0.3),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: flyerZoneWidth * 0.9,
                                height: flyerZoneWidth * 0.1,
                                decoration: BoxDecoration(
                                    color: Colorz.WhiteGlass,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            logoRoundCorners * 0.6))),
                              ),
                              Container(
                                width: flyerZoneWidth * 0.5,
                                height: flyerZoneWidth * 0.1,
                                margin: EdgeInsets.only(
                                    top: footerBTMargins * 1.25),
                                decoration: BoxDecoration(
                                    color: Colorz.WhiteGlass,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            logoRoundCorners * 0.6))),
                              ),
                            ],
                          ),
                        ),

                        Center(
                          child: SuperVerse(
                            verse: 'Add\nFlyer',
                            color: Colorz.WhiteZircon,
                            designMode: false,
                            centered: true,
                            size: 8,
                            weight: VerseWeight.black,
                            shadow: false,
                            italic: true,
                            maxLines: 3,
                          ),
                        ),

                        // --- FLYER FOOTER
                        Positioned(
                          bottom: 0,
                          left: 0,
                          // --- FLYER FOOTER BOX
                          child: Container(
                            width: flyerFooterWidth,
                            height: flyerFooterHeight,
                            color: flyerFooterColor,

                            // --- FLYER FOOTER COMPONENTS
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                // --- BOTTOM SHADOW
                                Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft:
                                            Radius.circular(flyerBottomCorners),
                                        bottomRight:
                                            Radius.circular(flyerBottomCorners),
                                      ),
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colorz.Nothing,
                                            Colorz.WhiteAir,
                                            Colorz.WhiteAir
                                          ],
                                          stops: [
                                            0.35,
                                            0.85,
                                            1
                                          ])),
                                ),

                                // --- SAVE BUTTON
                                Positioned(
                                  left: Wordz.textDirection(context) == 'ltr' ? null : 0,
                                  right: Wordz.textDirection(context) == 'ltr' ? 0 : null,
                                  bottom: 0,
                                  child: Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(
                                        left: footerBTMargins,
                                        top: footerBTMargins,
                                        right: footerBTMargins,
                                        bottom: footerBTMargins,
                                      ),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            CustomBoxShadow(
                                                color: Colorz.BlackSmoke,
                                                offset: new Offset(
                                                    0, footerBTMargins * -0.12),
                                                blurRadius:
                                                    footerBTMargins * 1.5,
                                                blurStyle: BlurStyle.outer),
                                          ]),

                                      // --- SHARE BUTTON CIRCLE
                                      child: CircleAvatar(
                                        radius: footerBTRadius,
                                        backgroundColor: Colorz.WhiteAir,
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            // --- BUTTON OVAL HIGHLIGHT
                                            Container(
                                              width: 2 *
                                                  footerBTRadius *
                                                  btOvalSizeFactor,
                                              height: 1.4 *
                                                  footerBTRadius *
                                                  btOvalSizeFactor,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .all(Radius.elliptical(
                                                          footerBTRadius *
                                                              btOvalSizeFactor,
                                                          footerBTRadius *
                                                              0.7 *
                                                              btOvalSizeFactor)),
                                                  color: Colorz.Nothing,
                                                  boxShadow: [
                                                    CustomBoxShadow(
                                                        color: Colorz.WhiteAir,
                                                        offset: new Offset(
                                                            0,
                                                            footerBTRadius *
                                                                -0.3),
                                                        blurRadius:
                                                            footerBTRadius *
                                                                0.4,
                                                        blurStyle:
                                                            BlurStyle.normal),
                                                  ]),
                                            ),

                                            // --- BUTTON GRADIENT
                                            Container(
                                              width: footerBTRadius * 2,
                                              height: footerBTRadius * 2,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Colorz.BlackNothing,
                                                      Colorz.BlackAir
                                                    ],
                                                    stops: [
                                                      0.3,
                                                      1
                                                    ]),
                                              ),
                                            ),

                                            // -- BUTTON COMPONENTS : ICON & VERSE
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                // --- BUTTON ICON
                                                Container(
                                                  width: iconWidth,
                                                  height: iconHeight,
                                                  color:
                                                      iconTestBoxColor, // for designing
                                                  child: WebsafeSvg.asset(
                                                      Iconz.Save,
                                                      color: Colorz.WhiteGlass),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
