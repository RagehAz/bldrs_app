import 'package:bldrs/controllers/drafters/numberers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class BzPgCounter extends StatelessWidget {
  final double flyerZoneWidth;
  final bool bzPageIsOn;
  final int count;
  final String verse;
  final String icon;
  final double iconSizeFactor;

  BzPgCounter({
    @required this.flyerZoneWidth,
    this.bzPageIsOn = true,
    @required this.count,
    @required this.verse,
    this.icon,
    this.iconSizeFactor = 1,
});

  @override
  Widget build(BuildContext context) {


    const Color bzPageBGColor = Colorz.Black80;
    double bzPageDividers = flyerZoneWidth * Ratioz.xxbzPageSpacing;

    double iconBoxHeight = flyerZoneWidth * 0.08;
    double iconHeight = iconBoxHeight * iconSizeFactor;
    double bzPageStripSideMargin = flyerZoneWidth * 0.05;

    double iconMargin = iconBoxHeight - iconHeight;

    return
      bzPageIsOn == false ? Container() :
      Padding(
        padding: EdgeInsets.only(top: bzPageDividers),
        child: Container(
          width: flyerZoneWidth,
          color: bzPageBGColor,
          padding: EdgeInsets.symmetric(vertical: flyerZoneWidth * 0.02),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: bzPageStripSideMargin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                // ---  ICON
                Container(
                  width: iconBoxHeight,
                  height: iconBoxHeight,
                  margin: EdgeInsets.symmetric(horizontal: flyerZoneWidth * 0.01),
                  // color: Colorz.BloodTest,
                  child: Padding(
                    padding: EdgeInsets.all(iconMargin),
                    child: WebsafeSvg.asset(icon),
                  ),
                ),

                SuperVerse(
                  verse: Numberers.separateKilos(count),//formatDecimal(count),
                  size: 2,
                  weight: VerseWeight.bold,
                  margin: bzPageStripSideMargin * 0.1,
                ),

                // --- VERSE
                SuperVerse(
                  verse: verse,
                  color: Colorz.White200,
                  size: 2,
                  weight: VerseWeight.thin,
                  italic: true,
                  margin: bzPageStripSideMargin*0.1,
                ),
              ],
            ),
          ),
        ),
      );
  }
}
