import 'package:bldrs/controllers/drafters/numeric.dart';
import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class SlideCounters extends StatelessWidget {
  final double flyerBoxWidth;
  final int shares;
  final int views;
  final int saves;
  final Function onCountersTap;

  const SlideCounters({
    @required this.flyerBoxWidth,
    this.shares = 0,
    this.views = 0,
    this.saves = 0,
    @required this.onCountersTap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------

    /// --- SCREEN
    // double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double verseScaleFactor = flyerBoxWidth/screenWidth;
    /// --- SHARE & SAVE BUTTONS
    final double footerBTMargins = flyerBoxWidth * Ratioz.xxfooterBTMargins;

    /// --- FLYER STATES
    final double flyerStateBoxCorner = flyerBoxWidth * 0.021;
    const double singleCounterPaddingRatio = 0.5;

    return Positioned(
      bottom: 0,
      child: GestureDetector(
        onTap: onCountersTap,
        child: Padding(
          padding: EdgeInsets.only(bottom: footerBTMargins),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              /// COUNTERS
              Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(footerBTMargins * 0.15),
                decoration: BoxDecoration(
                    color: Colorz.white20,
                    borderRadius: BorderRadius.all(
                      Radius.circular(flyerStateBoxCorner),
                    ),
                    boxShadow: <BoxShadow>[
                      CustomBoxShadow(
                          color: Colorz.black50,
                          offset: const Offset(0, 0),
                          blurRadius: footerBTMargins * 0.7,
                          blurStyle: BlurStyle.outer
                      ),
                      CustomBoxShadow(
                          color: Colorz.white20,
                          offset: const Offset(0, 0),
                          blurRadius: footerBTMargins * 0.7,
                          blurStyle: BlurStyle.outer
                      ),

                    ]
                ),
                child: Container(

                  /// GRADIENT
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(flyerStateBoxCorner),
                    ),
                    gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[Colorz.nothing, Colorz.black50],
                        stops: <double>[0.3,1]
                    ),
                  ),

                  child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                          /// NUMBER OF SHARES
                          Padding(
                            padding: EdgeInsets.only(
                              right: footerBTMargins * singleCounterPaddingRatio,
                              left: footerBTMargins * singleCounterPaddingRatio,
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  color: Colorz.nothing,
                                  margin: EdgeInsets.only(
                                    left: footerBTMargins * 0.25,
                                    right: footerBTMargins * 0.25,
                                  ),
                                  child: WebsafeSvg.asset(Iconz.Share),
                                ),
                                SuperVerse(
                                  verse: Numeric.counterCaliber(context, shares),
                                  color: Colorz.white255,
                                  size: 1,
                                  weight: VerseWeight.regular,
                                  centered: true,
                                  shadow: false,
                                  italic: false,
                                  scaleFactor: verseScaleFactor,
                                ),
                              ],
                            ),
                          ),

                          /// NUMBER OF VIEWS
                          Padding(
                            padding: EdgeInsets.only(
                              right: footerBTMargins * singleCounterPaddingRatio * 1.2,
                              left: footerBTMargins * singleCounterPaddingRatio * 1.2,
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                    color: Colorz.nothing,
                                    margin: EdgeInsets.only(
                                      left: footerBTMargins * 0.5,
                                      right: footerBTMargins * 0.5,
                                    ),
                                    child: WebsafeSvg.asset(Iconz.Views)),
                                SuperVerse(
                                  verse: Numeric.counterCaliber(context, views),
                                  color: Colorz.white255,
                                  size: 1,
                                  weight: VerseWeight.regular,
                                  centered: true,
                                  shadow: false,
                                  italic: false,
                                  scaleFactor: verseScaleFactor,
                                ),
                              ],
                            ),
                          ),

                          /// NUMBER OF SAVES
                          Padding(
                            padding: EdgeInsets.only(
                              right: footerBTMargins * singleCounterPaddingRatio,
                              left: footerBTMargins * singleCounterPaddingRatio,
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  color: Colorz.nothing,
                                  // margin: EdgeInsets.only(
                                  //   left: footerBTMargins * 0,
                                  //   right: footerBTMargins * 0,
                                  // ),
                                  child: WebsafeSvg.asset(
                                    Iconz.Save,
                                  ),
                                ),
                                SuperVerse(
                                  verse: Numeric.counterCaliber(context, saves),
                                  color: Colorz.white255,
                                  size: 1,
                                  weight: VerseWeight.regular,
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
              ),

            ],
          ),
        ),
      ),
    );
  }
}
