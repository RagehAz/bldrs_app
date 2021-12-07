import 'package:bldrs/controllers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class BzPgCounter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzPgCounter({
    @required this.flyerBoxWidth,
    @required this.count,
    @required this.verse,
    this.bzPageIsOn = true,
    this.icon,
    this.iconSizeFactor = 1,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final bool bzPageIsOn;
  final int count;
  final String verse;
  final String icon;
  final double iconSizeFactor;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {


    const Color bzPageBGColor = Colorz.black80;
    final double bzPageDividers = flyerBoxWidth * Ratioz.xxbzPageSpacing;

    final double iconBoxHeight = flyerBoxWidth * 0.08;
    final double iconHeight = iconBoxHeight * iconSizeFactor;
    final double bzPageStripSideMargin = flyerBoxWidth * 0.05;

    final double iconMargin = iconBoxHeight - iconHeight;

    return
      bzPageIsOn == false ? Container() :
      Padding(
        padding: EdgeInsets.only(top: bzPageDividers),
        child: Container(
          width: flyerBoxWidth,
          color: bzPageBGColor,
          padding: EdgeInsets.symmetric(vertical: flyerBoxWidth * 0.02),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: bzPageStripSideMargin),
            child: Row(
              children: <Widget>[

                ///  ICON
                Container(
                  width: iconBoxHeight,
                  height: iconBoxHeight,
                  margin: EdgeInsets.symmetric(horizontal: flyerBoxWidth * 0.01),
                  // color: Colorz.BloodTest,
                  child: Padding(
                    padding: EdgeInsets.all(iconMargin),
                    child: WebsafeSvg.asset(icon),
                  ),
                ),

                SuperVerse(
                  verse: Numeric.separateKilos(number: count),
                  margin: bzPageStripSideMargin * 0.1,
                ),

                /// VERSE
                SuperVerse(
                  verse: verse,
                  color: Colorz.white200,
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
