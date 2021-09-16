import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/views/widgets/flyer/final_flyer.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone_box.dart';
import 'package:flutter/material.dart';

class NotificationFlyers extends StatelessWidget {
  final double bodyWidth;
  final dynamic flyers;


  const NotificationFlyers({
    @required this.bodyWidth,
    @required this.flyers,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: bodyWidth,
      height: 20 + 200.0,
      decoration: BoxDecoration(
        color: Colorz.White10,
        borderRadius: Borderers.superFlyerCorners(context, FlyerBox.width(context, FlyerBox.sizeFactorByHeight(context, 220)),
        ),
      ),
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: false,
          itemCount: flyers.length,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          itemBuilder: (ctx, index){

            return
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: FinalFlyer(
                  flyerBoxWidth: FlyerBox.width(context, FlyerBox.sizeFactorByHeight(context, 200)),
                  tinyFlyer: flyers[index],
                ),
              );

          }
      ),
    );
  }
}
