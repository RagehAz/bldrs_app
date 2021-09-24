import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/numberers.dart';
import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/footer.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  final double flyerBoxWidth;
  final SuperFlyer superFlyer;

  const PriceTag({
    @required this.flyerBoxWidth,
    @required this.superFlyer,
  });

  @override
  Widget build(BuildContext context) {

    double _footerHeight = FlyerFooter.boxHeight(context: context, flyerBoxWidth: flyerBoxWidth);

    double _currentPrice = 5199.99;
    String _currency = '\$';
    double _oldPrice = 15000;
    double _discountPercentage = (_oldPrice / _currentPrice) * 100;

    return Container(
      width: flyerBoxWidth,
      height: FlyerBox.height(context, flyerBoxWidth),
      alignment: Aligners.superBottomAlignment(context),
      child: Container(
        width: flyerBoxWidth * 0.45,
        height: flyerBoxWidth * 0.15,
        margin: EdgeInsets.only(bottom: _footerHeight),
        decoration: BoxDecoration(
          color: Colorz.White200,
          borderRadius: Borderers.superPriceTagCorners(context, flyerBoxWidth),
          boxShadow: Shadowz.appBarShadow,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            SuperVerse(
              verse: '${Numberers.separateKilos(number: _currentPrice, fractions: 3)} $_currency',
              color: Colorz.Black255,
              weight: VerseWeight.black,
              scaleFactor: FlyerBox.sizeFactorByWidth(context, flyerBoxWidth),
            ),

            priceTageSecondLine(
                context: context,
                verse: '${_discountPercentage.round()} % OFF',
                color: Colorz.BloodTest
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                priceTageSecondLine(
                  context: context,
                  verse: 'was',
                ),

                priceTageSecondLine(
                  context: context,
                  verse: '${Numberers.separateKilos(number: _oldPrice)} $_currency',
                  strikeThrough: true,
                ),

              ],
            ),


          ],
        ),
      ),
    );
  }

  Widget priceTageSecondLine({BuildContext context, String verse, bool strikeThrough = false, Color color = Colorz.Black125}){
    return
      SuperVerse(
        verse: verse,
        color: color,
        scaleFactor: FlyerBox.sizeFactorByWidth(context, flyerBoxWidth),
        size: 1,
        strikethrough: strikeThrough,
      );
  }

}
