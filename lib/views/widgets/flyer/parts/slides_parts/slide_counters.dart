import 'package:bldrs/controllers/drafters/numberers.dart';
import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class SlideCounters extends StatelessWidget {
  final double flyerZoneWidth;
  final int shares;
  final int views;
  final int saves;

  SlideCounters({
    @required this.flyerZoneWidth,
    this.shares = 0,
    this.views = 0,
    this.saves = 0,
  });

  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------

    // --- SCREEN
    // double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double verseScaleFactor = flyerZoneWidth/screenWidth;
    // --- SHARE & SAVE BUTTONS
    double footerBTMargins = flyerZoneWidth * Ratioz.xxfooterBTMargins;
    void tappingCounters() {
      print('Counters are counting');
    }

    // --- FLYER STATES
    double flyerStateBoxCorner = flyerZoneWidth * 0.021;

    double singleCounterPaddingRatio = 0.5;

    return GestureDetector(
      onTap: tappingCounters,
      child: Padding(
        padding: EdgeInsets.only(bottom: footerBTMargins),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            // --- COUNTERS
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.all(footerBTMargins * 0.15),
              decoration: BoxDecoration(
                  color: Colorz.WhiteGlass,
                  borderRadius: BorderRadius.all(
                    Radius.circular(flyerStateBoxCorner),
                  ),
                  boxShadow: <BoxShadow>[
                    CustomBoxShadow(
                        color: Colorz.BlackZircon,
                        offset: new Offset(0, 0),
                        blurRadius: footerBTMargins * 0.7,
                        blurStyle: BlurStyle.outer),
                    CustomBoxShadow(
                        color: Colorz.WhiteGlass,
                        offset: new Offset(0, 0),
                        blurRadius: footerBTMargins * 0.7,
                        blurStyle: BlurStyle.outer),

                  ]
              ),
              child: Container(

                // --- GRADIENT
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(flyerStateBoxCorner),
                  ),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colorz.Nothing, Colorz.BlackZircon],
                      stops: [0.3,1]
                  ),
                ),

                child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // --- NUMBER OF SHARES
                        Padding(
                          padding: EdgeInsets.only(
                            right: footerBTMargins * singleCounterPaddingRatio,
                            left: footerBTMargins * singleCounterPaddingRatio,
                          ),
                          child: Row(
                            children: [
                              Container(
                                color: Colorz.Nothing,
                                margin: EdgeInsets.only(
                                  left: footerBTMargins * 0.25,
                                  right: footerBTMargins * 0.25,
                                ),
                                child: WebsafeSvg.asset(Iconz.Share),
                              ),
                              SuperVerse(
                                verse: counterCaliber(context, shares),
                                color: Colorz.White,
                                size: 1,
                                weight: VerseWeight.regular,
                                designMode: false,
                                centered: true,
                                shadow: false,
                                italic: false,
                                scaleFactor: verseScaleFactor,
                              ),
                            ],
                          ),
                        ),

                        // --- NUMBER OF VIEWS
                        Padding(
                          padding: EdgeInsets.only(
                            right: footerBTMargins * singleCounterPaddingRatio*1.2,
                            left: footerBTMargins * singleCounterPaddingRatio*1.2,
                          ),
                          child: Row(
                            children: [
                              Container(
                                  color: Colorz.Nothing,
                                  margin: EdgeInsets.only(
                                    left: footerBTMargins * 0.5,
                                    right: footerBTMargins * 0.5,
                                  ),
                                  child: WebsafeSvg.asset(Iconz.Views)),
                              SuperVerse(
                                verse: counterCaliber(context, views),
                                color: Colorz.White,
                                size: 1,
                                weight: VerseWeight.regular,
                                designMode: false,
                                centered: true,
                                shadow: false,
                                italic: false,
                                scaleFactor: verseScaleFactor,
                              ),
                            ],
                          ),
                        ),

                        // --- NUMBER OF SAVES
                        Padding(
                          padding: EdgeInsets.only(
                            right: footerBTMargins * singleCounterPaddingRatio,
                            left: footerBTMargins * singleCounterPaddingRatio,
                          ),
                          child: Row(
                            children: [
                              Container(
                                color: Colorz.Nothing,
                                margin: EdgeInsets.only(
                                  left: footerBTMargins * 0,
                                  right: footerBTMargins * 0,
                                ),
                                child: WebsafeSvg.asset(
                                  Iconz.Save,
                                ),
                              ),
                              SuperVerse(
                                verse: counterCaliber(context, saves),
                                color: Colorz.White,
                                size: 1,
                                weight: VerseWeight.regular,
                                designMode: false,
                                centered: true,
                                shadow: false,
                                italic: false,
                                scaleFactor: verseScaleFactor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
